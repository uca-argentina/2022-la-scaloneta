Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'hasEnded',
		'spaceShipPositions',
		'deck',
		'lastCardPlayed',
		'lastTilePlayed',
		'cardHands',
		'turnsSequence'
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

	^ (CardPlayResolver from: aCardPlay in: self) resolve
]

{ #category : #private }
LaScalonetaGame >> applyEffectDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip [

	(board spaceShipPositionIsTheLastOne: (self positionOf: aSpaceShip))
		ifTrue: [ hasEnded := true ]
		ifFalse: [ 
			self applyTileEffectTo: turnsSequence spaceShips.
			turnsSequence next ]
]

{ #category : #private }
LaScalonetaGame >> applyTileEffectTo: aSpaceShips [

	lastTilePlayed := board effectAt:
		                  (self positionOf: turnsSequence spaceShipPlaying).
	lastTilePlayed applyTo: aSpaceShips for: self
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	self hasEnded ifTrue: [ 
		Error signal: 'La Scaloneta Game has already ended!' ]
]

{ #category : #accessing }
LaScalonetaGame >> cardsHandOf: aSpaceShip [

	| spaceShipCardHandler |
	spaceShipCardHandler := cardHands
		detect: [ :handler | handler spaceShip = aSpaceShip ].
	^ spaceShipCardHandler
]

{ #category : #accessing }
LaScalonetaGame >> cardsHands [

	^ cardHands
]

{ #category : #action }
LaScalonetaGame >> giveCardFromDeckTo: aSpaceShip [

	| card |
	card := deck pick.
	(self cardsHandOf: aSpaceShip) addToHand: card
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
	deck := aDeck.
	cardHands := aSpaceShips collect: [ :spaceShip | 
		             CardsHand with: spaceShip using: aDeck ].
	lastCardPlayed := ErrorThrowerCard new.
	lastTilePlayed := NoEffect new
]

{ #category : #accessing }
LaScalonetaGame >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #accessing }
LaScalonetaGame >> lastTilePlayed [

	^ lastTilePlayed
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip during: aDistance [

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

	| rollingResult |
	turnsSequence assertSpaceShipTurn: aSpaceShip.
	self assertGameHasNotEnded.
	rollingResult := diceCollection roll.
	self move: aSpaceShip during: (DistanceInTiles with: (rollingResult + (self cardsHandOf: aSpaceShip) totalEffectsOnSpaceShip)).
	self applyEffectDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | 
		   position spaceShip = aSpaceShip ]) last
]

{ #category : #classification }
LaScalonetaGame >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := (turnsSequence spaceShips) collect: [ :aSpaceShip | 
		                       self positionOf: aSpaceShip ].

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA >= spaceShipB ]
]

{ #category : #accessing }
LaScalonetaGame >> turnsSequence [

	^ turnsSequence
]

{ #category : #updating }
LaScalonetaGame >> updateLastCardPlayed: aCard [

	lastCardPlayed := aCard
]

{ #category : #accessing }
LaScalonetaGame >> winner [

	self hasEnded
		ifFalse: [ Error signal: 'There is no winner as the game has not ended yet.' ]
		ifTrue: [ ^ self spaceShipsPositionsRanking first spaceShip ]
]
