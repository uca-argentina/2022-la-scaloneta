Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'spaceShips',
		'hasEnded',
		'spaceShipPositions',
		'spaceShipCurrentTurn',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfLaps: aLaps [

	aLaps > 0 ifFalse: [ 
		Error signal: 'La Scaloneta Game must have one or more laps!' ]
]

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfSpaceShips: aSpaceShipsCollection [

	aSpaceShipsCollection isEmpty ifTrue: [ 
		Error signal: 'La Scaloneta Game must have at least one spaceship!' ]
]

{ #category : #'instance creation' }
LaScalonetaGame class >> playedBy: spaceShips on: board rolling: dice withNumberOfLaps: laps [

	self assertValidNumberOfSpaceShips: spaceShips.
	self assertValidNumberOfLaps: laps.

	^ self new
		  initializeWith: board
		  rolling: dice
		  playedBy: spaceShips
		  numberOfLaps: laps
]

{ #category : #adding }
LaScalonetaGame >> add: aSpaceShipPosition [

	spaceShipPositions add: aSpaceShipPosition
]

{ #category : #private }
LaScalonetaGame >> applyEffectTo: aSpaceShips [

	(self board tiles at: (self positionOf: aSpaceShips first) tileNumber)
		move: aSpaceShips
		for: self
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	self hasEnded ifTrue: [ 
		Error signal: 'La Scaloneta Game has already ended!' ]
]

{ #category : #private }
LaScalonetaGame >> assertSpaceShipHasNotReachedTheEndSoLaScalonetaGameContinue: aSpaceShip [

	((board isTheLastOnePosition:
		  (self positionOf: aSpaceShip) tileNumber) and: [ 
		 (self positionOf: aSpaceShip) lap = self laps ])
		ifTrue: [ hasEnded := true ]
		ifFalse: [ 
			self applyEffectTo: self spaceShips.
			self nextSpaceShipTurn: aSpaceShip ]
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
LaScalonetaGame >> initializeWith: aBoard rolling: aDiceCollection playedBy: aSpaceShip numberOfLaps: aLaps [

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
	laps := aLaps
]

{ #category : #accessing }
LaScalonetaGame >> laps [

	^ laps
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip withRolling: aResult [

	| quantityOfSquaresAdvanced auxLap newLap newPosition oldPosition boardSize |
	oldPosition := self positionOf: aSpaceShip.
	boardSize := self board size.

	quantityOfSquaresAdvanced := (oldPosition lap - 1) * boardSize
	                             + aResult + oldPosition tileNumber.

	quantityOfSquaresAdvanced <= 0 ifTrue: [ 
		quantityOfSquaresAdvanced := 1 ].

	auxLap := quantityOfSquaresAdvanced - 1 // boardSize + 1.

	newLap := auxLap min: self laps.

	newPosition := quantityOfSquaresAdvanced % boardSize.

	(newPosition = 0 or: [ auxLap > self laps ]) ifTrue: [ 
		newPosition := boardSize ].

	self add: (SpaceShipPosition
			 ofSpaceShip: oldPosition spaceShip
			 tileNumber: newPosition
			 lap: newLap)
]

{ #category : #private }
LaScalonetaGame >> moveToFirstPositionOnSameLap: aSpaceShip [

	self add: (SpaceShipPosition
			 ofSpaceShip: (self positionOf: aSpaceShip) spaceShip
			 tileNumber: board firstPosition
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
	self assertSpaceShipHasNotReachedTheEndSoLaScalonetaGameContinue: aSpaceShip
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | 
		   position spaceShip = aSpaceShip ]) last
]

{ #category : #classification }
LaScalonetaGame >> positionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := self spaceShips collect: [ :aSpaceShip | 
		                       self positionOf: aSpaceShip ].

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA >= spaceShipB ]
]

{ #category : #accessing }
LaScalonetaGame >> spaceShips [

	^ spaceShips

]

{ #category : #accessing }
LaScalonetaGame >> winner [

	self hasEnded
		ifFalse: [ 
		Error signal: 'There is no winner as the game has not ended yet.' ]
		ifTrue: [ ^ self positionsRanking first spaceShip ]
]
