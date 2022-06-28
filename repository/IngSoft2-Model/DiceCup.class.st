Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DiceCup class >> assertValidNumberOfTiles: aDiceCollection [

	aDiceCollection ifEmpty: [ 
		Error signal: 'A DiceCup should have at least one die.' ]
]

{ #category : #'instance creation' }
DiceCup class >> withAll: dice [

	self assertValidNumberOfTiles: dice.
	^ self new initializeWithAll: dice
]

{ #category : #initialization }
DiceCup >> initializeWithAll: aDice [

	dice := aDice
]

{ #category : #rolling }
DiceCup >> roll [

	^ dice sum: [ :die | die roll ]
]
