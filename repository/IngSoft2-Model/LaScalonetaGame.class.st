Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'players',
		'status',
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
LaScalonetaGame class >> withBoard: aBoard diceCollection: aDiceCollection players: aPlayers [

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

{ #category : #accessing }
LaScalonetaGame >> board [

	^ board

]

{ #category : #testing }
LaScalonetaGame >> hasEnded [

	^ status
]

{ #category : #initialization }
LaScalonetaGame >> initializeWithBoard: aBoard diceCollection: aDiceCollection players: aPlayers [

	board := aBoard.
	diceCollection := aDiceCollection.
	players := aPlayers.
	status := false.
	playerPositions := ( players collect: [ :player | SpaceShipPosition startingOfPlayer: player ] ) asOrderedCollection.
	playerTurn := (players at: 1)
]

{ #category : #playing }
LaScalonetaGame >> itsMyTurn: aPlayer [

	(playerTurn = aPlayer) ifTrue: [ ^ true ]
	
								  ifFalse: [ ^ false ]
]

{ #category : #playing }
LaScalonetaGame >> movePlayer: aPlayer withRollingResult: aResult [

	self addPosition: ( SpaceShipPosition
									ofPlayer: ( (self positionOf: aPlayer) player )
									tileNumber: ( ((self positionOf: aPlayer) tileNumber) + aResult )
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
	
	status ifFalse:  [ 
		
						(self itsMyTurn: aPlayer) ifTrue: [ 
							
							 						rollingResult := diceCollection roll.
	
													self movePlayer: aPlayer withRollingResult: rollingResult.
	
													(self positionOf: aPlayer) tileNumber >= (board tiles) size ifTrue: [ status := true ].
													
													(self nextPlayerTurn: aPlayer).
							
						] 
					
						ifFalse: [ Error signal: 'Its not your turn!' ]
			]
		
			ifTrue: [ Error signal: 'La Scaloneta Game has already ended!' ]


]

{ #category : #accessing }
LaScalonetaGame >> winner [

	^ players select: [ :player | (self positionOf: player)tileNumber >= (board tiles)size ].

]
