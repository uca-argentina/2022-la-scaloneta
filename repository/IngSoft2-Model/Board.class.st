Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'parsecs',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValidNumberOfLaps: aLaps [

	aLaps > 0 ifFalse: [ 
		Error signal: 'La Scaloneta Game must have one or more laps!' ]
]

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
Board class >> with: tiles numberOfLaps: laps and: parsecs [

	self assertValidNumberOfTiles: tiles.
	self assertValidNumberOfLaps: laps.
	self assertValidParsecs: parsecs.
	^ self new initializeWith: tiles numberOfLaps: laps and: parsecs
]

{ #category : #accessing }
Board >> firstTileNumber [

	^ 1
]

{ #category : #initialization }
Board >> initializeWith: aTileCollection numberOfLaps: aLaps and: aParsecs [

	tiles := aTileCollection.
	laps := aLaps.
	parsecs := aParsecs
]

{ #category : #accessing }
Board >> laps [

	^ laps
]

{ #category : #private }
Board >> move: aResult from: oldPosition [

	| boardSize quantityOfSquaresAdvanced auxLap newLap newPosition |
	boardSize := self size.

	quantityOfSquaresAdvanced := (oldPosition lap - 1) * boardSize
	                             + aResult + oldPosition tileNumber.

	quantityOfSquaresAdvanced <= 0 ifTrue: [ 
		quantityOfSquaresAdvanced := 1 ].

	auxLap := quantityOfSquaresAdvanced - 1 // boardSize + 1.

	newLap := auxLap min: laps.

	newPosition := quantityOfSquaresAdvanced % boardSize.

	(newPosition = 0 or: [ auxLap > laps ]) ifTrue: [ 
		newPosition := boardSize ].
	
	^ (SpaceShipPosition
			 ofSpaceShip: oldPosition spaceShip
			 tileNumber: newPosition
			 lap: newLap)
]

{ #category : #accessing }
Board >> parsecs [

	^ parsecs
]

{ #category : #accessing }
Board >> size [ 
	
	^ self tiles size
]

{ #category : #asserting }
Board >> spaceShipPositionIsTheLastOne: aSpaceShipPosition [

	(laps = aSpaceShipPosition lap and: [ 
		 self size = aSpaceShipPosition tileNumber ]) ifTrue: [ ^ true ]
																	ifFalse: [ ^ false ]
]

{ #category : #accessing }
Board >> tiles [

	^ tiles
]
