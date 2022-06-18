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

{ #category : #testing }
CardHandler >> hasInHand: aCard [ 

	^ cardsInHand includes: aCard
]

{ #category : #initialization }
CardHandler >> initializeWith: aSpaceShip [

	spaceShip := aSpaceShip.
	cardsInHand := OrderedCollection new.
	cardsThatAffect := OrderedCollection new.
]

{ #category : #removing }
CardHandler >> removeEffectOf: aCard [

	cardsThatAffect remove: aCard ifAbsent: [ Error signal: 'There is no card at cardsThatAffect that matches to be removed' ].
]

{ #category : #action }
CardHandler >> removeFromHand: aCard [ 

	cardsInHand remove:aCard.
]

{ #category : #accessing }
CardHandler >> spaceShip [

	^spaceShip 
]

{ #category : #accessing }
CardHandler >> totalEffectsOnSpaceShip [

	cardsThatAffect isEmpty ifTrue:[^0].
	^cardsThatAffect sum:[:card| card effect ].
]
