Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'N'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
MoonWalkEffect class >> assertNIsANegativeNumber: aN [

	aN > 0 ifTrue: [ Error signal: 'MoonWalk effect N must be a negative number' ]
]

{ #category : #private }
MoonWalkEffect class >> withN: aN [
	self assertNIsANegativeNumber: aN.
	^self new initializeWith: aN.
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: aN [
	
	N := aN.
]

{ #category : #private }
MoonWalkEffect >> moveSpaceShip: aSpaceShips for: aGame [
		
		
		^(aSpaceShips allButFirst do: [ :spaceShip | aGame movePlayer: spaceShip  withRollingResult: self n ]) 
]

{ #category : #accessing }
MoonWalkEffect >> n [

	^ N
]
