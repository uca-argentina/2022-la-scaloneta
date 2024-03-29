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
Board class >> with: tiles and: parsecs finishingAfter: laps [

	self assertValidNumberOfTiles: tiles.
	self assertValidNumberOfLaps: laps.
	self assertValidParsecs: parsecs.
	^ self new initializeWith: tiles and: parsecs finishingAfter: laps
]

{ #category : #converting }
Board >> convertDistanceToDistanceInTiles: aDistance [

	^ (BoardDistanceInTileResolver
		   from: aDistance
		   with: self size
		   and: parsecs) resolve
]

{ #category : #accessing }
Board >> effectAt: aSpaceShipPosition [

	^ tiles at: aSpaceShipPosition tileNumber
]

{ #category : #accessing }
Board >> firstTileNumber [

	^ 1
]

{ #category : #initialization }
Board >> initializeWith: aTiles and: aParsecs finishingAfter: aLaps [

	tiles := aTiles.
	parsecs := aParsecs.
	laps := aLaps
]

{ #category : #private }
Board >> move: aDistance from: oldPosition [

	| boardSize quantityOfTilesAdvanced auxLap newLap newPosition |
	
	boardSize := self size.

	quantityOfTilesAdvanced := self quantityOfTilesToMoveFrom: oldPosition with: aDistance.

	auxLap := quantityOfTilesAdvanced - 1 // boardSize + 1.

	newLap := auxLap min: laps.

	newPosition := quantityOfTilesAdvanced % boardSize.

	(newPosition = 0 or: [ auxLap > laps ]) ifTrue: [ 
		newPosition := boardSize ].
	
	^ SpaceShipPosition
			 ofSpaceShip: oldPosition spaceShip
			 tileNumber: newPosition
			 lap: newLap
]

{ #category : #private }
Board >> moveToFirstPositionOnSameLapFrom: aSpaceShipPosition [

	^ SpaceShipPosition
			 ofSpaceShip: aSpaceShipPosition spaceShip
			 tileNumber: self firstTileNumber
			 lap: aSpaceShipPosition lap
]

{ #category : #calculating }
Board >> quantityOfTilesToMoveFrom: aSpaceShipPosition with: aDistance [

	| quantity aResult |
	
	aResult := self convertDistanceToDistanceInTiles: aDistance.

	quantity := (aSpaceShipPosition lap - 1) * self size + aResult + aSpaceShipPosition tileNumber.

	quantity <= 0 ifTrue: [ ^ 1 ].
	
	^ quantity
]

{ #category : #accessing }
Board >> size [ 
	
	^ tiles size.
]

{ #category : #asserting }
Board >> spaceShipPositionIsTheLastOne: aSpaceShipPosition [

	(laps = aSpaceShipPosition lap and: [ 
		 self size = aSpaceShipPosition tileNumber ]) ifTrue: [ ^ true ].
	^ false
]

{ #category : #initialization }
Board >> startingPositionsForAll: aGroupOfSpaceShip [

	^ (aGroupOfSpaceShip collect: [ :spaceShip | 
		   SpaceShipPosition startingOf: spaceShip for: self at: 1 ])
		  asOrderedCollection
]
