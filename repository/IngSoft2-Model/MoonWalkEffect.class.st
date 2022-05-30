Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
MoonWalkEffect class >> assertNIsANegativeNumber: aN [

	aN > 0 ifTrue: [ 
		Error signal: 'MoonWalk effect N must be a negative number' ]
]

{ #category : #private }
MoonWalkEffect class >> withN: aN [

	self assertNIsANegativeNumber: aN.
	^ self new initializeWith: aN
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: aN [
	
	n := aN.
]

{ #category : #private }
MoonWalkEffect >> moveSpaceShip: aSpaceShips for: aGame [

	^ aSpaceShips allButFirst do: [ :spaceShip | 
		  aGame moveSpaceShip: spaceShip withRollingResult: self n ]
]

{ #category : #accessing }
MoonWalkEffect >> n [

	^ n
]
