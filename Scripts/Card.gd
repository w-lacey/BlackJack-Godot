extends ColorRect

var cardTexture
var rankSymbol

enum Suit{
	CLUBS, 
	DIAMONDS, 
	HEARTS,
	SPADES
}

enum Rank{
	ACE = 1,
	TWO = 2,
	THREE = 3,
	FOUR = 4,
	FIVE = 5,
	SIX = 6,
	SEVEN = 7,
	EIGHT = 8,
	NINE = 9,
	TEN = 10,
	JACK = 11,
	QUEEN = 12,
	KING = 13
}
var card_suit : String
var card_rank : String

func _init(card_rank = "TWO", card_suit ="HEARTS"):
	
	self.card_rank = card_rank
	self.card_suit = card_suit

func getSuit():
	return card_suit
	
func getRank():
	return card_rank
func getCardValue():
	var cardValue = Rank.get(card_rank)
	return cardValue
	
func getRankSymbol():
	rankSymbol = load("res://Assets/symbols/rankSymbols/%s.png" % card_rank)
	return rankSymbol
	
func getTexture():
	cardTexture = load("res://Assets/symbols/%s.png" % card_suit)
	return cardTexture
	
