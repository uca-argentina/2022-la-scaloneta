Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'collectionOfM'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertValidCollection: aCollecrtionOfM [
	
	aCollecrtionOfM do: [ : m | m<0 ifTrue:[Error signal: 'Values of the collection must be positive!' ]]
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: aCollectionOfM [
	
	self assertValidCollection: aCollectionOfM.
	^self new initializeWith: aCollectionOfM. 
	
]

{ #category : #private }
HyperJumpEffect >> collectionOfM [
	^collectionOfM 
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfM [

	collectionOfM := aCollectionOfM sorted reverse.
	
	
	
]

{ #category : #private }
HyperJumpEffect >> moveSpaceShip: aSpaceShips for: aGame [
		
		|value_MCollection|
		
		value_MCollection := self collectionOfM first.
		
		collectionOfM  := ((self collectionOfM) reject: [ :each | each = value_MCollection ]) , { value_MCollection }.
	
		^ aGame moveSpaceShip: (aSpaceShips first) withRollingResult: (value_MCollection / (aGame board parsecs / aGame board tiles size )) floor 
]
