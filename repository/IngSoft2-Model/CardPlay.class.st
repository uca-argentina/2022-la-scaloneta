Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'target',
		'playedBy'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlay class >> with: aCard appliedBy: aSpaceShip [

	^ self new initializeWith: aCard appliedBy: aSpaceShip.
]

{ #category : #'instance creation' }
CardPlay class >> with: aCard appliedTo: aTarget by: aSpaceShip [

	^ self new initializeWith: aCard appliedTo: aTarget by: aSpaceShip.
]

{ #category : #accessing }
CardPlay >> card [

	^ card
]

{ #category : #initialization }
CardPlay >> initializeWith: aCard appliedBy: aSpaceShip [

	card := aCard.
	playedBy := aSpaceShip
]

{ #category : #initialization }
CardPlay >> initializeWith: aCard appliedTo: aTarget by: aSpaceShip [

	card := aCard.
	target := aTarget.
	playedBy := aSpaceShip
]

{ #category : #accessing }
CardPlay >> playedBy [

	^ playedBy
]

{ #category : #accessing }
CardPlay >> target [

	^ target
]
