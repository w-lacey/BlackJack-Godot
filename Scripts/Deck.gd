
extends Node

class_name Deck

var cardInstance = preload("res://Scripts/Card.gd")
var cardscene = preload('res://scenes/Card.tscn')

var deckList = []

func _init() -> void:
	for suit in cardInstance.Suit:
		for rank in cardInstance.Rank:
			var card = cardInstance.new(suit, rank);
			#print(card.getSuit(), " of ", card.getRank())
			deckList.append(card)
		self.deckList.shuffle()		
		cardTextures()
	
func getDeck():
	return deckList

func drawCard():
	
	var card = cardInstance.new(deckList[0].getSuit(), deckList[0].getRank())
	card = deckList[0]
	self.deckList.remove_at(0)
	return card

func cardTextures():
	var cardList = []
	for suit in cardInstance.Suit:
		for rank in cardInstance.Rank:
			var card = cardInstance.new(suit, rank);
			#print(card.getSuit(), " of ", card.getRank())
			cardList.append(card)
