extends Node

class_name Player

var player_hand = []
var player_name
var staying

func setStaying(staying):
	self.staying = staying

func getStaying():
	return staying

func setPlayerName(player_name):
	self.player_name = player_name
	
func getPlayerName():
	return player_name

func setPlayerHand(card):
	self.player_hand.append(card)

func getPlayerHand():
	return player_hand

func getHandValue():
	var card_instance = load("res://Scripts/Card.gd")
	var hand_value = 0
	for i in range(player_hand.size()):
		var card = card_instance.new(self.player_hand[i].getSuit(), self.player_hand[i].getRank())	
		hand_value += card.getCardValue()
	return hand_value	
