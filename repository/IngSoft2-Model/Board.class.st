Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: aTileCollection [ 

	aTileCollection size  < 2 ifTrue: [ Error signal: 'Number of tiles should be 2 or more' ]
]

{ #category : #'instance creation' }
Board class >> withTiles: aTileCollection [

	self assertValid: aTileCollection.
	^ self new initializeWithTiles: aTileCollection 
]

{ #category : #initialization }
Board >> initializeWithTiles: aTileCollection [

	tiles := aTileCollection
]

{ #category : #accessing }
Board >> tileNumbered: aTileNumber [

	^ tiles at: aTileNumber
]

{ #category : #accessing }
Board >> tiles [

	^ tiles
]
