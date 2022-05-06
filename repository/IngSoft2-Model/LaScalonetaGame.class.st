Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'spaceShips',
		'hasEnded',
		'spaceShipPositions',
		'spaceShipTurn',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfLaps: aLaps [

		(aLaps <= 1) ifTrue: [ Error signal: 'La Scaloneta Game must have two or more laps!' ]
]

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfSpaceShips: aSpaceShipsCollection [

		aSpaceShipsCollection isEmpty ifTrue: [ Error signal: 'La Scaloneta Game must have at least one spaceship!' ]
]

{ #category : #'instance creation' }
LaScalonetaGame class >> playedBy: aSpaceShips on: aBoard rolling: aDiceCollection numberOfLaps: aLaps [

	self assertValidNumberOfSpaceShips: aSpaceShips.
	self assertValidNumberOfLaps: aLaps.

	^ self new
				initializeWithBoard: aBoard
				diceCollection: aDiceCollection
				spaceShips: aSpaceShips
				numberOfLaps: aLaps

				
]

{ #category : #adding }
LaScalonetaGame >> addPosition: aSpaceShipPosition [

	spaceShipPositions add: aSpaceShipPosition
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	(self hasEnded) ifTrue: [ Error signal: 'La Scaloneta Game has already ended!' ]
]

{ #category : #asserting }
LaScalonetaGame >> assertItsMyTurn: aPlayer [

	(self itsMyTurn: aPlayer) ifFalse: [ Error signal: 'Its not your turn!' ]
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
LaScalonetaGame >> initializeWithBoard: aBoard diceCollection: aDiceCollection spaceShips: aSpaceShip numberOfLaps: aLaps [

	board := aBoard.
	diceCollection := aDiceCollection.
	spaceShips := aSpaceShip.
	hasEnded := false.
	spaceShipPositions := ( spaceShips collect: [ :player | (SpaceShipPosition startingOfSpaceShip: player forBoard: board lap: 1) ] ) asOrderedCollection.
	spaceShipTurn := (spaceShips first).
	laps := aLaps
]

{ #category : #playing }
LaScalonetaGame >> itsMyTurn: aSpaceShip [

	(spaceShipTurn = aSpaceShip) ifTrue: [ ^ true ]
	                       ifFalse: [ ^ false ]
]

{ #category : #accessing }
LaScalonetaGame >> lap [

	^ laps
]

{ #category : #private }
LaScalonetaGame >> movePlayer: aSpaceShip withRollingResult: aResult [

	| aNewPosition |
	
	aNewPosition :=  ((self positionOf: aSpaceShip) tileNumber) + aResult min: (self board) lastPosition.
	
 	self addPosition: ( SpaceShipPosition
								ofSpaceShip: ( (self positionOf: aSpaceShip) spaceShip )
								tileNumber: aNewPosition
								lap: ( (self positionOf: aSpaceShip) lap)
							) 
]

{ #category : #playing }
LaScalonetaGame >> nextSpaceShipTurn: aSpaceShip [

	spaceShips := (spaceShips reject: [ :each | each = aSpaceShip ]) , { aSpaceShip }.

	spaceShipTurn := (spaceShips  first)
]

{ #category : #playing }
LaScalonetaGame >> playNextTurn [

	self rollDiceCupFor: (self spaceShipTurn)
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | position spaceShip = aSpaceShip ]) last
]

{ #category : #private }
LaScalonetaGame >> rollDiceCupFor: aPlayer [

	| rollingResult |
	
	self assertItsMyTurn: aPlayer.
	self assertGameHasNotEnded.
	
	rollingResult := diceCollection roll.
	
	self movePlayer: aPlayer withRollingResult: rollingResult.
	
	(board isTheLastOnePosition:( (self positionOf: aPlayer) tileNumber ) ) ifTrue: [ hasEnded := true ].
													
	(self nextSpaceShipTurn: aPlayer).
							


]

{ #category : #accessing }
LaScalonetaGame >> spaceShipTurn [
	
	^ spaceShipTurn
]

{ #category : #accessing }
LaScalonetaGame >> spaceShips [

	^ spaceShips

]

{ #category : #accessing }
LaScalonetaGame >> winner [

	| aWinner |
	
	aWinner:= (spaceShips select: [ :spaceShip | (self positionOf: spaceShip)tileNumber >= (self board lastPosition) ]).
	
	aWinner size < 1 ifTrue: [ Error signal: 'There is no winner as the game has not ended yet.' ]
	
	ifFalse: [^ aWinner last ]
	
]
