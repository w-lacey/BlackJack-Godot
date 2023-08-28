
extends Node

class_name Deck

var card_instance = preload("res://Scripts/Card.gd")

var deck_list = []

func _init() -> void:
	for suit in card_instance.SUIT:
		for rank in card_instance.RANK:
			var card = card_instance.new(suit, rank);
			deck_list.append(card)
		self.deck_list.shuffle()		
		cardTextures()
	
func getDeck():
	return deck_list

func drawCard():
	
	var card = card_instance.new(deck_list[0].getSuit(), deck_list[0].getRank())
	card = deck_list[0]
	self.deck_list.remove_at(0)
	return card

func cardTextures():
	var card_list = []
	for suit in card_instance.SUIT:
		for rank in card_instance.RANK:
			var card = card_instance.new(suit, rank);
			#print(card.getSuit(), " of ", card.getRank())
			card_list.append(card)
