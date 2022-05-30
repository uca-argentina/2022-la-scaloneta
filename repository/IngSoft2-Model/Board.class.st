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
Board class >> assertValidNumberOfTiles: aTileCollection [

	aTileCollection size < 2 ifTrue: [ 
		Error signal: 'Number of tiles should be 2 or more' ]
]

{ #category : #asserting }
Board class >> assertValidParsecs: parsecs [

	parsecs > 0 ifFalse: [ 
		Error signal: 'Parsecs must be greater than 0!' ]
]

{ #category : #'instance creation' }
Board class >> with: tiles and: parsecs [

	self assertValidNumberOfTiles: tiles.
	self assertValidParsecs: parsecs.
	^ self new initializeWith: tiles and: parsecs
]

{ #category : #accessing }
Board >> firstPosition [

	^ 1
]

{ #category : #initialization }
Board >> initializeWith: aTileCollection and: aParsecs [

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
