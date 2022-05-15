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
		
		|aux|
		aux:= self collectionOfM first.
		collectionOfM  := ((self collectionOfM) reject: [ :each | each = aux ]) , { aux }.

		^ aGame movePlayer: aSpaceShips  withRollingResult: self n 
]
