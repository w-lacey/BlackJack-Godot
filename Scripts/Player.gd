extends Node

class_name Player

var playerHand = []
var playerName
var staying

func setStaying(staying):
	self.staying = staying

func getStaying():
	return staying

func setPlayerName(playerName):
	self.playerName = playerName
	
func getPlayerName():
	return playerName

func setPlayerHand(card):
	self.playerHand.append(card)

func getPlayerHand():
	return playerHand

func getHandValue():
	var cardInstance = load("res://Scripts/Card.gd")
	var handValue = 0
	for i in range(playerHand.size()):
		var card = cardInstance.new(self.playerHand[i].getSuit(), self.playerHand[i].getRank())	
		handValue += card.getCardValue()
	return handValue	
