Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'currentTurn',
		'spaceShips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnHandler class >> with: aSpaceShips [

	^ self new initializeWith: aSpaceShips.
]

{ #category : #asserting }
TurnHandler >> assertSpaceShipTurn: aSpaceShip [

	currentTurn = aSpaceShip ifFalse: [ Error signal: 'Its not your turn!' ]
]

{ #category : #accessing }
TurnHandler >> currentTurn [

	^ currentTurn.
]

{ #category : #playing }
TurnHandler >> initializeWith: aSpaceShips [

	spaceShips := aSpaceShips.
	currentTurn := aSpaceShips first.
]

{ #category : #playing }
TurnHandler >> nextSpaceShipTurn: aSpaceShip [

	spaceShips := (spaceShips reject: [ :each | each = aSpaceShip ]), { aSpaceShip }.
	currentTurn := spaceShips first.
]

{ #category : #accessing }
TurnHandler >> spaceShips [

	^ spaceShips
]
