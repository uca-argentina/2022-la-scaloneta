Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'numberOfSquaresToMoveBackwards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
MoonWalkEffect class >> assertNumberOfSquaresToMoveBackwardsIsANegativeNumber: aN [

	aN > 0 ifTrue: [ 
		Error signal: 'MoonWalk effect N must be a negative number' ]
]

{ #category : #private }
MoonWalkEffect class >> with: aNumberOfSquaresToMoveBackwards [

	self assertNumberOfSquaresToMoveBackwardsIsANegativeNumber: aNumberOfSquaresToMoveBackwards.
	^ self new initializeWith: aNumberOfSquaresToMoveBackwards
]

{ #category : #private }
MoonWalkEffect >> applyTo: aSpaceShips for: aGame [

	^ aSpaceShips allButFirst do: [ :spaceShip | 
		  aGame move: spaceShip withRolling: numberOfSquaresToMoveBackwards ]
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: aNumberOfSquaresToMoveBackwards [
	
	numberOfSquaresToMoveBackwards := aNumberOfSquaresToMoveBackwards.
]
