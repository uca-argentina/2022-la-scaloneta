Class {
	#name : #HyperJumpEffect,
	#superclass : #Effect,
	#instVars : [
		'parsecsSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertIsNotEmptyFor: aParsecsSequence [

	aParsecsSequence ifEmpty: [ Error signal: 'HyperJumpEffect can not be initalize with empty collection!' ] 
]

{ #category : #asserting }
HyperJumpEffect class >> assertValidValuesFor: aParsecsSequence [

	aParsecsSequence do: [ :m | 
		(m value) < 0 ifTrue: [ 
			Error signal: 'Values of the collection must be positive!' ] ]
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: aParsecsSequence [

	self assertIsNotEmptyFor: aParsecsSequence.
	self assertValidValuesFor: aParsecsSequence.
	^ self new initializeWith: aParsecsSequence
]

{ #category : #private }
HyperJumpEffect >> applyTo: aSpaceShips for: aGame [

	| value_MCollection valueInParsecs |
	value_MCollection := parsecsSequence first.

	parsecsSequence := (parsecsSequence reject: [ :each | 
		                  each = value_MCollection ])
	                 , { value_MCollection }.
	
	valueInParsecs := value_MCollection convertToParsecs.

	^ aGame
		  move: aSpaceShips first
		  withParsecs: valueInParsecs 
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aParsecsSequence [

	parsecsSequence := aParsecsSequence sorted reverse.
	
	
	
]
