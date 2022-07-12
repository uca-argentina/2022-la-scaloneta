Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDeck class >> with: cards [

	^self new initializeWith: cards.
]

{ #category : #actions }
LoadedDeck >> initializeWith: aGroupOfCards [

	cards := aGroupOfCards asOrderedCollection
]

{ #category : #testing }
LoadedDeck >> isEmpty [

	^ cards isEmpty
]

{ #category : #actions }
LoadedDeck >> pick [

	| cardToPick |
	cardToPick := cards at: 1 ifAbsent: [Error signal: 'No cards to pick']..
	cards remove: cardToPick.
	^ cardToPick
]
