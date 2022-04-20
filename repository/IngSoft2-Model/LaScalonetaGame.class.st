Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'players',
		'status',
		'playerPositions',
		'playersPositions',
		'aGame',
		'everyPlayerPosition'
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
	^board

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

]

{ #category : #playing }
LaScalonetaGame >> movePlayer: aPlayer withRollingResult: aResult [

	| newPosition |

	newPosition := self positionForPlayer: ( self positionOf: aPlayer ) whenRollingResult: aResult.

	self addPosition: newPosition
]

{ #category : #accessing }
LaScalonetaGame >> players [
	^players

]

{ #category : #initialization }
LaScalonetaGame >> positionForPlayer: aPlayerPosition whenRollingResult: aResult [

	^ SpaceShipPosition
		ofPlayer: aPlayerPosition player
		tileNumber: aPlayerPosition tileNumber + aResult
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aPlayer [

	^ (playerPositions select: [ :position | position player = aPlayer ]) last
]

{ #category : #playing }
LaScalonetaGame >> rollDiceCupFor: aPlayer [

	| rollingResult |
	
	status ifFalse:  [ 
		
							rollingResult := diceCollection roll.
	
							self movePlayer: aPlayer withRollingResult: rollingResult.
	
							(self positionOf: aPlayer) tileNumber >= (board tiles) size ifTrue: [ status := true ] ]
		
			ifTrue: [ Error signal: 'La Scaloneta Game has already ended!' ]


]

{ #category : #accessing }
LaScalonetaGame >> winner [
	^players select: [ :player | (self positionOf: player)tileNumber >= (board tiles)size ].

]
