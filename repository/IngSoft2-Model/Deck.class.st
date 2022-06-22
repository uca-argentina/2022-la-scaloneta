Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: cards [

	cards isEmpty ifTrue: [ Error signal: 'Deck must have at least one card!'  ].

	^ self new initializeWith: cards.
]

{ #category : #initialization }
Deck >> initializeWith: aGroupOfCards [

	cards := aGroupOfCards.
]

{ #category : #actions }
Deck >> pick [ 

	^ cards atRandom.
]
