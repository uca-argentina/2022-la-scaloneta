Class {
	#name : #TurnsSequence,
	#superclass : #Object,
	#instVars : [
		'spaceShipPlaying',
		'spaceShips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnsSequence class >> with: aSpaceShips [

	^ self new initializeWith: aSpaceShips.
]

{ #category : #asserting }
TurnsSequence >> assertSpaceShipTurn: aSpaceShip [

	spaceShipPlaying = aSpaceShip ifFalse: [ 
		Error signal: 'Its not your turn!' ]
]

{ #category : #playing }
TurnsSequence >> initializeWith: aSpaceShips [

	spaceShips := aSpaceShips.
	spaceShipPlaying := aSpaceShips first
]

{ #category : #playing }
TurnsSequence >> next [

	spaceShips := (spaceShips reject: [ :each | each = spaceShipPlaying ])
	              , { spaceShipPlaying }.
	spaceShipPlaying := spaceShips first
]

{ #category : #accessing }
TurnsSequence >> spaceShipPlaying [

	^ spaceShipPlaying
]

{ #category : #accessing }
TurnsSequence >> spaceShips [

	^ spaceShips
]
