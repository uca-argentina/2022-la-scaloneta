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
	playerPositions := ( players collect: [ :player | SpaceShipPosition startingOfPlayer: player ] ) asOrderedCollection.
	playerTurn := (players first)
]

{ #category : #playing }
LaScalonetaGame >> itsMyTurn: aPlayer [

	(playerTurn = aPlayer) ifTrue: [ ^ true ]
	
								  ifFalse: [ ^ false ]
]

{ #category : #playing }
LaScalonetaGame >> movePlayer: aPlayer withRollingResult: aResult [
	|aNewPosition|
	
	aNewPosition:= ( (self positionOf: aPlayer) tileNumber) + aResult.
	aNewPosition > (board tiles)size ifTrue: [ aNewPosition := (board tiles)size ].
	
	self addPosition: ( SpaceShipPosition
	
									ofPlayer: ( (self positionOf: aPlayer) player )
									tileNumber: aNewPosition
							)
]

{ #category : #playing }
LaScalonetaGame >> nextPlayerTurn: aPlayer [

	players := (players reject: [ :each | each = aPlayer ]) , { aPlayer }.

	playerTurn := (players at: 1)
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

{ #category : #playing }
LaScalonetaGame >> rollDiceCupFor: aPlayer [

	| rollingResult |
	
	hasEnded  ifFalse:  [ 
		
						(self itsMyTurn: aPlayer) ifTrue: [ 
							
							 						rollingResult := diceCollection roll.
	
													self movePlayer: aPlayer withRollingResult: rollingResult.
	
													(self positionOf: aPlayer) tileNumber >= (board tiles) size ifTrue: [ hasEnded := true ].
													
													(self nextPlayerTurn: aPlayer).
							
						] 
					
						ifFalse: [ Error signal: 'Its not your turn!' ]
			]
		
			ifTrue: [ Error signal: 'La Scaloneta Game has already ended!' ]


]

{ #category : #accessing }
LaScalonetaGame >> winner [
	| aWinner |
	aWinner:= (players select: [ :player | (self positionOf: player)tileNumber >= (board tiles)size ]).
	aWinner size < 1 ifTrue: [ Error signal: 'There is no winner as the game has not ended yet.' ]
	ifFalse: [^ aWinner last ]
	
]
