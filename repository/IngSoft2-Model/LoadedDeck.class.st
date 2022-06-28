Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'nextCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDeck class >> with: cards [

	^self new initializeWith: cards.
]

{ #category : #actions }
LoadedDeck >> initializeWith: aGroupOfCards [

	nextCard := 1.
	cards := aGroupOfCards
]

{ #category : #actions }
LoadedDeck >> pick [

	| card |
	card := cards at: nextCard.
	nextCard := (nextCard rem: cards size) + 1.
	^ card
]
