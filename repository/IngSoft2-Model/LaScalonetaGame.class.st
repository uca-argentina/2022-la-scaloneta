Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'players',
		'hasEnded',
		'playerPositions',
		'playerTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfPlayers: aPlayers [

		aPlayers isEmpty ifTrue: [ Error signal: 'La Scaloneta Game must have at least one player' ]
]

{ #category : #'instance creation' }
LaScalonetaGame class >> playedBy: aPlayers on: aBoard rolling: aDiceCollection [ 

	self assertValidNumberOfPlayers: aPlayers.

	^ self new
				initializeWithBoard: aBoard
				diceCollection: aDiceCollection
				players: aPlayers

				
]

{ #category : #adding }
LaScalonetaGame >> addPosition: aPlayerPosition [

	playerPositions add: aPlayerPosition
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
LaScalonetaGame >> initializeWithBoard: aBoard diceCollection: aDiceCollection players: aPlayers [

	board := aBoard.
	diceCollection := aDiceCollection.
	players := aPlayers.
	hasEnded := false.
	playerPositions := ( players collect: [ :player | (SpaceShipPosition startingOfPlayer: player forBoard: board) ] ) asOrderedCollection.
	playerTurn := (players first)
]

{ #category : #playing }
LaScalonetaGame >> itsMyTurn: aPlayer [

	(playerTurn = aPlayer) ifTrue: [ ^ true ]
	                       ifFalse: [ ^ false ]
]

{ #category : #private }
LaScalonetaGame >> movePlayer: aPlayer withRollingResult: aResult [

	| aNewPosition |
	
	aNewPosition :=  ((self positionOf: aPlayer) tileNumber) + aResult min: (self board) lastPosition.
	
 	self addPosition: ( SpaceShipPosition
								ofPlayer: ( (self positionOf: aPlayer) player )
								tileNumber: aNewPosition
							) 
]

{ #category : #playing }
LaScalonetaGame >> nextPlayerTurn: aPlayer [

	players := (players reject: [ :each | each = aPlayer ]) , { aPlayer }.

	playerTurn := (players first)
]

{ #category : #accessing }
LaScalonetaGame >> playerTurn [
	
	^ playerTurn
]

{ #category : #accessing }
LaScalonetaGame >> players [

	^ players

]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aPlayer [

	^ (playerPositions select: [ :position | position player = aPlayer ]) last
]

{ #category : #private }
LaScalonetaGame >> rollDiceCupFor: aPlayer [

	| rollingResult |
	
	self assertItsMyTurn: aPlayer.
	self assertGameHasNotEnded.
	
	rollingResult := diceCollection roll.
	
	self movePlayer: aPlayer withRollingResult: rollingResult.
	
	(board isTheLastOnePosition:( (self positionOf: aPlayer) tileNumber ) ) ifTrue: [ hasEnded := true ].
													
	(self nextPlayerTurn: aPlayer).
							


]

{ #category : #accessing }
LaScalonetaGame >> winner [

	| aWinner |
	
	aWinner:= (players select: [ :player | (self positionOf: player)tileNumber >= (self board lastPosition) ]).
	
	aWinner size < 1 ifTrue: [ Error signal: 'There is no winner as the game has not ended yet.' ]
	
	ifFalse: [^ aWinner last ]
	
]
