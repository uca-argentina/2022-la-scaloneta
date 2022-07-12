Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> assertCardsIsNotEmpty: cards [

	cards ifEmpty: [ Error signal: 'Deck must have at least one card!' ]
]

{ #category : #'instance creation' }
Deck class >> with: cards [

	self assertCardsIsNotEmpty: cards.

	^ self new initializeWith: cards
]

{ #category : #initialization }
Deck >> initializeWith: aGroupOfCards [

	cards := aGroupOfCards asOrderedCollection shuffled
]

{ #category : #testing }
Deck >> isEmpty [

	^ cards isEmpty
]

{ #category : #actions }
Deck >> pick [

	| cardToPick |
	cardToPick := cards at: 1 ifAbsent: [Error signal: 'No cards to pick'].
	cards remove: cardToPick.

	^ cardToPick
]
