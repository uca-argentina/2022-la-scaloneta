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

{ #category : #private }
LaScalonetaGame >> applyEffect: aSpaceShips [

	(self board tiles at:
	      (self positionOf: (aSpaceShips  first)) tileNumber ) moveSpaceShip: aSpaceShips for: self. 
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
LaScalonetaGame >> laps [

	^ laps
]

{ #category : #private }
LaScalonetaGame >> moveSpaceShip: aSpaceShip withRollingResult: aResult [

	| quantityOfSquaresAdvanced auxLap newLap newPosition |
	
	quantityOfSquaresAdvanced  :=  (((self positionOf: aSpaceShip) lap - 1) * (self board tiles size)) + aResult + (self positionOf: aSpaceShip) tileNumber.
	
	quantityOfSquaresAdvanced <= 0 ifTrue:[quantityOfSquaresAdvanced := 1].
	
	auxLap := ((quantityOfSquaresAdvanced - 1)  // (self board tiles size) + 1).
	
	newLap := auxLap min: (self laps).
	
	newPosition := quantityOfSquaresAdvanced % (self board tiles size).
	
	(newPosition = 0 | (auxLap > (self laps))) ifTrue: [ newPosition := (self board tiles size)].
	
 	self addPosition: ( SpaceShipPosition
								ofSpaceShip: ( (self positionOf: aSpaceShip) spaceShip )
								tileNumber: newPosition
								lap: newLap
							) 
							
						
]

{ #category : #private }
LaScalonetaGame >> moveSpaceShipToFirstPositionOnSameLap: aSpaceShip [ 

 	self addPosition: ( SpaceShipPosition
								ofSpaceShip: ( (self positionOf: aSpaceShip) spaceShip )
								tileNumber: board firstPosition 
								lap: (self positionOf: aSpaceShip ) lap
							) 
]

{ #category : #playing }
LaScalonetaGame >> nextSpaceShipTurn: aSpaceShip [

	spaceShips := (spaceShips reject: [ :each | each = aSpaceShip ]) , { aSpaceShip }.

	spaceShipTurn := (spaceShips  first)
]

{ #category : #playing }
LaScalonetaGame >> playNextTurn [

	self playTurnFor: (self spaceShipTurn)
]

{ #category : #private }
LaScalonetaGame >> playTurnFor: aPlayer [

	| rollingResult |
	
	self assertItsMyTurn: aPlayer.
	self assertGameHasNotEnded.
	
	rollingResult := diceCollection roll.
	
	self moveSpaceShip: aPlayer withRollingResult: rollingResult.

	(board isTheLastOnePosition:( (self positionOf: aPlayer) tileNumber )) & ((self positionOf: aPlayer) lap = (self laps)) ifTrue: [ hasEnded := true ]
																																								ifFalse: [ self applyEffect: self spaceShips.
																																									        self nextSpaceShipTurn: aPlayer.]
							
																																												

]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | position spaceShip = aSpaceShip ]) last
]

{ #category : #classification }
LaScalonetaGame >> positionsRanking [

	| spaceShipsPositions |

	spaceShipsPositions := (self spaceShips) collect: [ :aSpaceShip | self positionOf: aSpaceShip].
 
	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | spaceShipA >= spaceShipB ]


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
