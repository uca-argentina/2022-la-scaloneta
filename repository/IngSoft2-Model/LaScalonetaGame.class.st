Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'hasEnded',
		'spaceShipPositions',
		'cardHands',
		'turnsSequence',
		'lastTilePlayed',
		'cardPlayResolver',
		'mainDeck',
		'discardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfSpaceShips: aSpaceShipsCollection [

	aSpaceShipsCollection isEmpty ifTrue: [ 
		Error signal: 'La Scaloneta Game must have at least one spaceship!' ]
]

{ #category : #'instance creation' }
LaScalonetaGame class >> playedBy: spaceShips on: board rolling: dice usingCardsFrom: aDeck [

	self assertValidNumberOfSpaceShips: spaceShips.

	^ self new
		  initializeWith: board
		  rolling: dice
		  playedBy: spaceShips
		  usingCardsFrom: aDeck.
]

{ #category : #'target resize' }
LaScalonetaGame >> apply: aCardPlay [

	^ cardPlayResolver resolve: aCardPlay
]

{ #category : #private }
LaScalonetaGame >> applyEffectDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip [

	(board spaceShipPositionIsTheLastOne: (self positionOf: aSpaceShip))
		ifTrue: [ hasEnded := true ]
		ifFalse: [ 
			self applyTileEffectTo: self spaceShips.
			turnsSequence next ]
]

{ #category : #private }
LaScalonetaGame >> applyTileEffectTo: aSpaceShips [

	lastTilePlayed := board effectAt: (self positionOf: turnsSequence spaceShipPlaying).
	lastTilePlayed applyTo: aSpaceShips for: self
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	self hasEnded ifTrue: [ 
		Error signal: 'La Scaloneta Game has already ended!' ]
]

{ #category : #asserting }
LaScalonetaGame >> assertIsTurnOf: aSpaceShip [

	^ turnsSequence assertSpaceShipTurn: aSpaceShip.
]

{ #category : #accessing }
LaScalonetaGame >> cardsHandOf: aSpaceShip [

	| spaceShipCardsHand |
	spaceShipCardsHand := cardHands
		detect: [ :handler | handler spaceShip = aSpaceShip ].
	^ spaceShipCardsHand
]

{ #category : #accessing }
LaScalonetaGame >> cardsHands [

	^ cardHands
]

{ #category : #asserting }
LaScalonetaGame >> decksHasToBeRedistributed [
	
	^ mainDeck isEmpty
]

{ #category : #action }
LaScalonetaGame >> giveCardFromDeckTo: aSpaceShip [

	discardDeck
		ifNotEmpty: [ (self cardsHandOf: aSpaceShip) addToHand: mainDeck pick]
		ifEmpty: [ Error signal: 'It is not possible to pick a card until DiscardDeck it is not empty!' ].
		
	self redistributeDecks
]

{ #category : #testing }
LaScalonetaGame >> hasEnded [

	^ hasEnded 
]

{ #category : #initialization }
LaScalonetaGame >> initializeWith: aBoard rolling: aDiceCollection playedBy: aSpaceShips usingCardsFrom: aDeck [

	board := aBoard.
	diceCollection := aDiceCollection.
	hasEnded := false.
	spaceShipPositions := board startingPositionsForAll: aSpaceShips.
	turnsSequence := TurnsSequence with: aSpaceShips.
	discardDeck := OrderedCollection new.
	mainDeck := aDeck.
	cardHands := aSpaceShips collect: [ :spaceShip | 
		             CardsHand with: spaceShip using: aDeck ].
	lastTilePlayed := NoEffect new.
	cardPlayResolver := CardPlayResolver with: self.
]

{ #category : #accessing }
LaScalonetaGame >> lastTilePlayed [

	^ lastTilePlayed
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip by: aDistance [

	| oldPosition newPosition |
	oldPosition := self positionOf: aSpaceShip.
	newPosition := board move: aDistance from: oldPosition.
	spaceShipPositions add: newPosition
]

{ #category : #private }
LaScalonetaGame >> moveToFirstPositionOnSameLap: aSpaceShip [

	| oldPosition newPosition |
	oldPosition := self positionOf: aSpaceShip.
	newPosition := board moveToFirstPositionOnSameLapFrom: oldPosition.
	spaceShipPositions add: newPosition
]

{ #category : #playing }
LaScalonetaGame >> playNextTurn [

	self playTurnFor: turnsSequence spaceShipPlaying
]

{ #category : #private }
LaScalonetaGame >> playTurnFor: aSpaceShip [

	| rollingResult distance rollModifier |
	turnsSequence assertSpaceShipTurn: aSpaceShip.
	self assertGameHasNotEnded.
	rollingResult := diceCollection roll.
	rollModifier := self rollModifierFor: aSpaceShip.
	distance := DistanceInTiles with: rollingResult + rollModifier.
	self move: aSpaceShip by: distance.
	self applyEffectDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | 
		   position spaceShip = aSpaceShip ]) last
]

{ #category : #action }
LaScalonetaGame >> redistributeDecks [

	self decksHasToBeRedistributed
		ifFalse: [ ^ self ].
	
	mainDeck := Deck with: discardDeck.
	discardDeck := OrderedCollection new
]

{ #category : #removing }
LaScalonetaGame >> removeFromHand: aCard to: aSpaceShip [

	(self cardsHandOf: aSpaceShip) removeFromHand: aCard.
	discardDeck add: aCard.
	self redistributeDecks
	
]

{ #category : #private }
LaScalonetaGame >> rollModifierFor: aSpaceShip [

	^ (self cardsHandOf: aSpaceShip) totalEffectsOnSpaceShip
]

{ #category : #accessing }
LaScalonetaGame >> spaceShips [

	^ turnsSequence spaceShips
]

{ #category : #classification }
LaScalonetaGame >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := (self spaceShips) collect: [ :aSpaceShip | 
		                       self positionOf: aSpaceShip ].

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA >= spaceShipB ]
]

{ #category : #accessing }
LaScalonetaGame >> winner [

	self hasEnded
		ifFalse: [ Error signal: 'There is no winner as the game has not ended yet.' ]
		ifTrue: [ ^ self spaceShipsPositionsRanking first spaceShip ]
]
