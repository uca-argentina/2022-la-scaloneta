Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'backwardsDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
MoonWalkEffect class >> assertaBackwardsDistanceIsANegativeNumber: aBackwardsDistance [

	aBackwardsDistance > 0 ifTrue: [ 
		Error signal: 'aBackwardsDistance must be a negative number' ]
]

{ #category : #private }
MoonWalkEffect class >> with: aBackwardsDistance [

	self assertaBackwardsDistanceIsANegativeNumber: aBackwardsDistance.
	^ self new initializeWith: aBackwardsDistance
]

{ #category : #private }
MoonWalkEffect >> applyTo: aSpaceShips for: aGame [

	^ aSpaceShips allButFirst do: [ :spaceShip | 
		  aGame move: spaceShip by: (DistanceInTiles  with: backwardsDistance)  ]
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: aBackwardsDistance [
	
	backwardsDistance := aBackwardsDistance.
]
