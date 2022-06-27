Class {
	#name : #RandomDie,
	#superclass : #Object,
	#instVars : [
		'numberOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
RandomDie class >> assertValidNumberOfTiles: numberOfSides [

	numberOfSides < 3 ifTrue: [ 
		Error signal: 'Number of faces should be greater than 2' ]
]

{ #category : #'instance creation' }
RandomDie class >> with: numberOfSides [

	self assertValidNumberOfTiles: numberOfSides.
	^ self new initializeWith: numberOfSides
]

{ #category : #initialization }
RandomDie >> initializeWith: aNumberOfSides [

	numberOfSides := aNumberOfSides
]

{ #category : #rolling }
RandomDie >> roll [

	^ numberOfSides atRandom
]
