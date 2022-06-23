Class {
	#name : #HyperJumpEffect,
	#superclass : #Effect,
	#instVars : [
		'distancies'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertIsNotEmptyFor: aDistanceSequence [

	aDistanceSequence ifEmpty: [ Error signal: 'HyperJumpEffect can not be initalize with empty collection!' ] 
]

{ #category : #asserting }
HyperJumpEffect class >> assertValidValuesFor: aDistanceSequence [

	aDistanceSequence do: [ :distance | 
		(distance amount) < 0 ifTrue: [ 
			Error signal: 'Values of the collection must be positive!' ] ]
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: aDistanceSequence [

	self assertIsNotEmptyFor: aDistanceSequence.
	self assertValidValuesFor: aDistanceSequence.
	^ self new initializeWith: aDistanceSequence
]

{ #category : #private }
HyperJumpEffect >> applyTo: aSpaceShips for: aGame [

	| value valueInParsecs |
	value := distancies first.

	distancies := (distancies reject: [ :each | 
		                  each = value ])
	                 , { value }.
	
	valueInParsecs := value convertToParsecs.

	^ aGame
		  move: aSpaceShips first
		  withParsecs: valueInParsecs 
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aDistanceSequence [

	distancies := aDistanceSequence sorted reverse.
	
	
	
]
