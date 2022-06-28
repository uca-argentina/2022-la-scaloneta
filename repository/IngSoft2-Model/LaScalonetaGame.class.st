Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'hasEnded',
		'spaceShipPositions',
		'turnHandler',
		'cardHandlers',
		'deck',
		'lastCardPlayed',
		'lastTilePlayed'
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
			self applyTileEffectTo: (turnHandler spaceShips).
			turnHandler next ]
]

{ #category : #private }
LaScalonetaGame >> applyTileEffectTo: aSpaceShips [

	lastTilePlayed := (board effectAt: (self positionOf: turnHandler spaceShipPlaying)).
	lastTilePlayed applyTo: aSpaceShips for: self.
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	self hasEnded ifTrue: [ 
		Error signal: 'La Scaloneta Game has already ended!' ]
]

{ #category : #accessing }
LaScalonetaGame >> cardHandlerOf: aSpaceShip [

	| spaceShipCardHandler |
	spaceShipCardHandler := cardHandlers
		detect: [ :handler | handler spaceShip = aSpaceShip ].
	^ spaceShipCardHandler
]

{ #category : #accessing }
LaScalonetaGame >> cardHandlers [

	^ cardHandlers
]

{ #category : #action }
LaScalonetaGame >> giveCardFromDeckTo: aSpaceShip [

	| card |
	card := deck pick.
	(self cardHandlerOf: aSpaceShip) addToHand: card
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
	turnHandler := TurnHandler with: aSpaceShips.
	deck := aDeck.
	cardHandlers := aSpaceShips
		collect: [ :spaceShip | CardHandler with: spaceShip using: aDeck].
	lastCardPlayed := nil.
	lastTilePlayed := NoEffect new.
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

	self playTurnFor: turnHandler spaceShipPlaying.
]

{ #category : #private }
LaScalonetaGame >> playTurnFor: aSpaceShip [

	| rollingResult |
	turnHandler assertSpaceShipTurn: aSpaceShip.
	self assertGameHasNotEnded.
	rollingResult := diceCollection roll.
	self move: aSpaceShip during: (DistanceInTiles with: (rollingResult + (self cardHandlerOf: aSpaceShip) totalEffectsOnSpaceShip)).
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
	spaceShipsPositions := (turnHandler spaceShips) collect: [ :aSpaceShip | 
		                       self positionOf: aSpaceShip ].

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA >= spaceShipB ]
]

{ #category : #accessing }
LaScalonetaGame >> turnHandler [

	^ turnHandler
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
