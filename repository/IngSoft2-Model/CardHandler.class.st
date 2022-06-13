Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'cardsInHand',
		'cardsThatAffect',
		'spaceShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardHandler class >> with: aSpaceShip [
 
	^ self new initializeWith: aSpaceShip
]

{ #category : #adding }
CardHandler >> addToHand: aCard [

	cardsInHand add: aCard.
]

{ #category : #initialization }
CardHandler >> initializeWith: aSpaceShip [

	spaceShip := aSpaceShip.
	cardsInHand := OrderedCollection new.
	cardsThatAffect := OrderedCollection new.
]

{ #category : #accessing }
CardHandler >> spaceShip [

	^spaceShip 
]
