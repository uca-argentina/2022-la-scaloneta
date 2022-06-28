Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'spaceShipPlaying',
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

	spaceShipPlaying = aSpaceShip ifFalse: [ Error signal: 'Its not your turn!' ]
]

{ #category : #playing }
TurnHandler >> initializeWith: aSpaceShips [

	spaceShips := aSpaceShips.
	spaceShipPlaying := aSpaceShips first
]

{ #category : #playing }
TurnHandler >> next [

	spaceShips := (spaceShips reject: [ :each | each = spaceShipPlaying ]), { spaceShipPlaying }.
	spaceShipPlaying := spaceShips first.
]

{ #category : #accessing }
TurnHandler >> spaceShipPlaying [

	^ spaceShipPlaying
]

{ #category : #accessing }
TurnHandler >> spaceShips [

	^ spaceShips
]
