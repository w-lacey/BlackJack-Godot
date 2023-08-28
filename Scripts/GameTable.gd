extends Control


@onready var deck_instance = preload("res://Scripts/Deck.gd")
@onready var player_instance = preload("res://Scripts/Player.gd")
@onready var cardInstance = preload("res://Scripts/Card.gd")
@onready var card_scene = preload('res://scenes/Card.tscn')
@onready var menu_bar: ColorRect = $MenuBar
@onready var stay_button: Button = $MenuBar/StayButton
@onready var hand_value: Label = $MenuBar/HandValue
@onready var game_board: ColorRect = $GameBoard
@onready var play_area: VBoxContainer = $GameBoard/PlayArea
@onready var dealer_space: GridContainer = $GameBoard/PlayArea/DealerSpace
@onready var player_space: GridContainer = $GameBoard/PlayArea/PlayerSpace
@onready var hit_button: TextureButton = $GameBoard/HitButton
@onready var new_game_window: Window = $NewGameWindow
@onready var new_game_window_label: Label = $NewGameWindow/NewGameWindowLabel
@onready var new_game_yes_button: Button = $NewGameWindow/NewGameYesButton
@onready var new_game_no_button: Button = $NewGameWindow/NewGameNoButton
@onready var restart_button: Button = $GameBoard/RestartButton
@onready var action: Label = $MenuBar/Action

var deckList = []
var playerHand = []
var dealerHand = []
var player
var deck
var dealer
var person


func _ready() -> void:
	
	new_game_yes_button.pressed.connect(self.gameSetup)
	new_game_no_button.pressed.connect(self.quit)
	hit_button.pressed.connect(self._button_pressed)
	
	stay_button.pressed.connect(self._stay)
	restart_button.pressed.connect(self.gameSetup)
	gameSetup()
	
func _process(delta):
	resetState()
	printHand()
	
func gameSetup():
	
	hit_button.disabled = false
	new_game_window.visible = false
	self.deck = deck_instance.new()
	self.player = player_instance.new()
	self.dealer = player_instance.new()
	self.person = player_instance.new()
	
	player.setPlayerName("Player")
	dealer.setPlayerName("Dealer")
	
	player.setStaying(false)
	dealer.setStaying(false)
	
	self.playerHand = player.getPlayerHand()
	self.dealerHand = dealer.getPlayerHand()
	self.deckList = deck.getDeck()
	
	player.setPlayerHand(deck.drawCard())
	player.setPlayerHand(deck.drawCard())
	dealer.setPlayerHand(deck.drawCard())
	dealer.setPlayerHand(deck.drawCard())
	person = player

	hand_value.text = "Hand Value = " + str(player.getHandValue())

	gameLoop()
	
func gameLoop():
	
	await get_tree().create_timer(1).timeout
	hand_value.text = "Hand Value = " + str(player.getHandValue())
	action.text = person.getPlayerName() + "'s turn!"
	
	if player.getStaying() == true && dealer.getStaying() == true:
		action.text = "Checking for winner!"
		checkWinner()
	elif dealer.getStaying() == true && player.getStaying() == false:
		person = player
	elif player.getStaying() == true && dealer.getStaying() == false:
		dealerTurn()
					
func printHand():

	var playerGrid: GridContainer = player_space
	playerGrid.columns = playerHand.size()
	
	var dealerGrid: GridContainer = dealer_space
	dealerGrid.columns = dealerHand.size()
	
	for i in range(playerHand.size()):
		var card = cardInstance.new(playerHand[i].getSuit(), playerHand[i].getRank())		
		var cardS = card_scene.instantiate()	
		playerGrid.add_child(cardS)
		cardS.get_node("CardBody/CardSymbol").texture = card.getTexture()
		cardS.get_node("CardBody/CardSymbol2").texture = card.getTexture()
		cardS.get_node("CardBody/rankSymbol").texture = card.getRankSymbol()
		cardS.get_node("CardBody/rankSymbol2").texture = card.getRankSymbol()
		playerGrid.move_child(cardS, i)

	for i in range(dealerHand.size()):
		var card = cardInstance.new(dealerHand[i].getSuit(), dealerHand[i].getRank())	
		var cardS = card_scene.instantiate()
		if(i == 0):
			cardS.get_node("CardBody/CardSymbol").texture = card.getTexture()
			cardS.get_node("CardBody/CardSymbol2").texture = card.getTexture()
			cardS.get_node("CardBody/rankSymbol").texture = card.getRankSymbol()
			cardS.get_node("CardBody/rankSymbol2").texture = card.getRankSymbol()
		else:
			cardS.get_node("CardBody").texture = load("res://Assets/card-back1.png")	
		dealerGrid.add_child(cardS)
		dealerGrid.move_child(cardS, i)
	
	
	
func btn():
	new_game_window.visible = true
	hit_button.disabled = true		

func checkWinner():
	if dealer.getHandValue() > 21 || player.getHandValue() > dealer.getHandValue():
		if player.getHandValue() < 21:
			win()
		else:
			lose()
	elif dealer.getHandValue() > player.getHandValue():
		lose()
	else:
		print("DRAW!")
		
func _stay():
	print("You stay!")
	player.setStaying(true)
	hit_button.disabled = true	
	person = dealer
	gameLoop()
	
func _button_pressed():
	
	player.setPlayerHand(deck.drawCard())
	
	self.person = dealer
	hand_value.text = "Hand Value = " + str(player.getHandValue())

	dealerTurn()
	
func win():
	action.text = "You Win!"	
	btn()
	
func lose():
	action.text = "You lose!"
	btn()	
	
		
func dealerTurn():
	action.text = "Dealer's Turn!"
	await get_tree().create_timer(1).timeout
	print(person.getPlayerName(),"'s turn!")
	hit_button.disabled = true
	
	print("dealer: ",dealer.getHandValue())	
	if dealer.getHandValue() <= 15 :
		
		action.text = "Dealer Draws a card!"
		await get_tree().create_timer(.5).timeout
		dealer.setPlayerHand(deck.drawCard())
		gameLoop()
	else:
		action.text = "Dealer's Stays!"
		await get_tree().create_timer(1).timeout
		dealer.setStaying(true)
		print("Dealer stays")
	if(player.getStaying() == false):
		hit_button.disabled = false
		person = player
		
	gameLoop()
	
func resetState():
	
	var childNodes = []
	for i in player_space.get_children():
		childNodes.append(i)
	for j in childNodes:
		j.queue_free()
	var childNodes2 = []
	for x in dealer_space.get_children():
		childNodes2.append(x)
	for o in childNodes2:
		o.queue_free()	
	
func quit():
	get_tree().quit()
