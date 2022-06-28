Class {
	#name : #CardsHand,
	#superclass : #Object,
	#instVars : [
		'cardsInHand',
		'spaceShip',
		'cardsAffecting'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsHand class >> with: aSpaceShip using: aDeck [
 
	^ self new initializeWith: aSpaceShip using: aDeck.
]

{ #category : #adding }
CardsHand >> addEffectOf: aCard [

	cardsAffecting add: aCard
]

{ #category : #adding }
CardsHand >> addToHand: aCard [

	cardsInHand add: aCard
]

{ #category : #action }
CardsHand >> affectsSpaceShip: aCard [ 

	^ cardsAffecting includes: aCard
]

{ #category : #initialization }
CardsHand >> distributeCardsFrom: aDeck [

	self addToHand: aDeck pick.
	self addToHand: aDeck pick
]

{ #category : #testing }
CardsHand >> hasInHand: aCard [

	^ cardsInHand includes: aCard
]

{ #category : #initialization }
CardsHand >> initializeWith: aSpaceShip using: aDeck [

	spaceShip := aSpaceShip.
	cardsInHand := OrderedCollection new.
	cardsAffecting := OrderedCollection new.
	self distributeCardsFrom: aDeck
]

{ #category : #removing }
CardsHand >> removeEffectOf: aCard [

	cardsAffecting remove: aCard ifAbsent: [ 
		Error signal:
			'There is no card at cardsThatAffect that matches to be removed' ]
]

{ #category : #action }
CardsHand >> removeFromHand: aCard [

	cardsInHand remove: aCard
]

{ #category : #accessing }
CardsHand >> spaceShip [

	^ spaceShip
]

{ #category : #accessing }
CardsHand >> totalEffectsOnSpaceShip [

	^ cardsAffecting sum: [ :card | card effect ]
]
