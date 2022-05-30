Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: aTileCollection [

	aTileCollection size < 2 ifTrue: [ 
		Error signal: 'Number of tiles should be 2 or more' ]
]

{ #category : #'instance creation' }
Board class >> withTiles: tiles andParsecs: parsecs [

	self assertValid: tiles.
	^ self new initializeWithTiles: tiles andParsecs: parsecs
]

{ #category : #accessing }
Board >> firstPosition [

	^ 1
]

{ #category : #initialization }
Board >> initializeWithTiles: aTileCollection andParsecs: aParsecs [

	tiles := aTileCollection.
	parsecs := aParsecs
]

{ #category : #asserting }
Board >> isTheLastOnePosition: aPosition [

	self lastPosition = aPosition
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #accessing }
Board >> lastPosition [ 

	^ tiles size
]

{ #category : #accessing }
Board >> parsecs [

	^ parsecs
]

{ #category : #accessing }
Board >> size [ 
	
	^ self tiles size
]

{ #category : #accessing }
Board >> tiles [

	^ tiles
]
