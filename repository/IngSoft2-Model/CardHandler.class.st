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
CardHandler class >> with: aSpaceShip using: aDeck [
 
	^ self new initializeWith: aSpaceShip using: aDeck.
]

{ #category : #adding }
CardHandler >> addEffectOf: aCard [

	cardsThatAffect add: aCard.
]

{ #category : #adding }
CardHandler >> addToHand: aCard [

	cardsInHand add: aCard.
]

{ #category : #action }
CardHandler >> affectsSpaceShip: aCard [ 

	^ cardsThatAffect includes: aCard.
]

{ #category : #initialization }
CardHandler >> distributeCardsFrom: aDeck [

	self addToHand: aDeck pick.
	self addToHand: aDeck pick.
]

{ #category : #testing }
CardHandler >> hasInHand: aCard [ 

	^ cardsInHand includes: aCard.
]

{ #category : #initialization }
CardHandler >> initializeWith: aSpaceShip using: aDeck [

	spaceShip := aSpaceShip.
	cardsInHand := OrderedCollection new.
	cardsThatAffect := OrderedCollection new.
	self distributeCardsFrom: aDeck.
]

{ #category : #removing }
CardHandler >> removeEffectOf: aCard [

	cardsThatAffect remove: aCard ifAbsent: [ Error signal: 'There is no card at cardsThatAffect that matches to be removed' ].
]

{ #category : #action }
CardHandler >> removeFromHand: aCard [

	cardsInHand remove: aCard.
]

{ #category : #accessing }
CardHandler >> spaceShip [

	^ spaceShip.
]

{ #category : #accessing }
CardHandler >> totalEffectsOnSpaceShip [

	^ cardsThatAffect sum: [ :card | card effect ]	.
]
