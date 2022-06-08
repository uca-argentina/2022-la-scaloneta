Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'spaceShips',
		'hasEnded',
		'spaceShipPositions',
		'spaceShipCurrentTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfSpaceShips: aSpaceShipsCollection [

	aSpaceShipsCollection isEmpty ifTrue: [ 
		Error signal: 'La Scaloneta Game must have at least one spaceship!' ]
]

{ #category : #'instance creation' }
LaScalonetaGame class >> playedBy: spaceShips on: board rolling: dice [

	self assertValidNumberOfSpaceShips: spaceShips.

	^ self new
		  initializeWith: board
		  rolling: dice
		  playedBy: spaceShips
]

{ #category : #adding }
LaScalonetaGame >> add: aSpaceShipPosition [

	spaceShipPositions add: aSpaceShipPosition
]

{ #category : #private }
LaScalonetaGame >> applyEffectTo: aSpaceShips [

	(self board tiles at: (self positionOf: aSpaceShips first) tileNumber)
		applyTo: aSpaceShips
		for: self
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	self hasEnded ifTrue: [ 
		Error signal: 'La Scaloneta Game has already ended!' ]
]

{ #category : #asserting }
LaScalonetaGame >> assertSpaceShipTurn: aSpaceShip [

	spaceShipCurrentTurn = aSpaceShip ifFalse: [ 
		Error signal: 'Its not your turn!' ]
]

{ #category : #accessing }
LaScalonetaGame >> board [ 

	^ board
]

{ #category : #testing }
LaScalonetaGame >> hasEnded [

	^ hasEnded 
]

{ #category : #initialization }
LaScalonetaGame >> initializeWith: aBoard rolling: aDiceCollection playedBy: aSpaceShip [

	board := aBoard.
	diceCollection := aDiceCollection.
	spaceShips := aSpaceShip.
	hasEnded := false.
	spaceShipPositions := (spaceShips collect: [ :player | 
		                       SpaceShipPosition
			                       startingOf: player
			                       for: board
			                       at: 1 ]) asOrderedCollection.
	spaceShipCurrentTurn := spaceShips first.
]

{ #category : #private }
LaScalonetaGame >> laScalonetaGameContinuesDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip [

	(board spaceShipPositionIsTheLastOne: (self positionOf: aSpaceShip))
		ifTrue: [ hasEnded := true ]
		ifFalse: [ 
			self applyEffectTo: spaceShips.
			self nextSpaceShipTurn: aSpaceShip ]
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip withParsecs: aParsecs [

	| newPosition oldPosition |
	oldPosition := self positionOf: aSpaceShip.

	newPosition := board movePasecs: aParsecs from: oldPosition.

	self add: newPosition
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip withRolling: aResult [

	| newPosition oldPosition |
	oldPosition := self positionOf: aSpaceShip.

	newPosition := board move: aResult from: oldPosition.

	self add: newPosition
]

{ #category : #private }
LaScalonetaGame >> moveToFirstPositionOnSameLap: aSpaceShip [

	self add: (SpaceShipPosition
			 ofSpaceShip: (self positionOf: aSpaceShip) spaceShip
			 tileNumber: board firstTileNumber
			 lap: (self positionOf: aSpaceShip) lap)
]

{ #category : #playing }
LaScalonetaGame >> nextSpaceShipTurn: aSpaceShip [

	spaceShips := (spaceShips reject: [ :each | each = aSpaceShip ])
	              , { aSpaceShip }.

	spaceShipCurrentTurn := spaceShips first
]

{ #category : #playing }
LaScalonetaGame >> playNextTurn [

	self playTurnFor: spaceShipCurrentTurn
]

{ #category : #private }
LaScalonetaGame >> playTurnFor: aSpaceShip [

	| rollingResult |
	self assertSpaceShipTurn: aSpaceShip.
	self assertGameHasNotEnded.

	rollingResult := diceCollection roll.

	self move: aSpaceShip withRolling: rollingResult.
	self laScalonetaGameContinuesDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | 
		   position spaceShip = aSpaceShip ]) last
]

{ #category : #classification }
LaScalonetaGame >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := spaceShips collect: [ :aSpaceShip | 
		                       self positionOf: aSpaceShip ].

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA >= spaceShipB ]
]

{ #category : #accessing }
LaScalonetaGame >> winner [

	self hasEnded
		ifFalse: [ 
		Error signal: 'There is no winner as the game has not ended yet.' ]
		ifTrue: [ ^ self spaceShipsPositionsRanking first spaceShip ]
]
