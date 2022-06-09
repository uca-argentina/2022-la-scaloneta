Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'parsecs',
		'laps',
		'deck',
		'cardHandlers'
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
Board class >> with: tiles and: parsecs finishingAfter: laps usingCardsFrom: deck [

	self assertValidNumberOfTiles: tiles.
	self assertValidNumberOfLaps: laps.
	self assertValidParsecs: parsecs.
	^ self new initializeWith: tiles and: parsecs finishingAfter: laps usingCardsFrom: deck
]

{ #category : #'as yet unclassified' }
Board >> cardHandlerOf: aSpaceShip [

	| playerCardHandler |
	playerCardHandler := cardHandlers
		detect: [ :handler | handler player = aSpaceShip ].
	^ playerCardHandler
]

{ #category : #accessing }
Board >> firstTileNumber [

	^ 1
]

{ #category : #'as yet unclassified' }
Board >> giveCardFromDeckTo: aSpaceShip [

	(self cardHandlerOf: aSpaceShip) addToHand: (deck pick).
]

{ #category : #initialization }
Board >> initializePositionsFor: aGroupOfSpaceShip [

	^ (aGroupOfSpaceShip collect: [ :spaceShip | 
		                       SpaceShipPosition
			                       startingOf: spaceShip
			                       for: self
			                       at: 1 ]) asOrderedCollection.
]

{ #category : #initialization }
Board >> initializeWith: aTileCollection and: aParsecs finishingAfter: aLaps usingCardsFrom: aDeck [

	tiles := aTileCollection.
	parsecs := aParsecs.
	laps := aLaps.
	deck := aDeck
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

{ #category : #private }
Board >> movePasecs: aParsecs from: oldPosition [

	| boardSize quantityOfSquaresAdvanced auxLap newLap newPosition aResult |
	boardSize := self size.

	aResult := (aParsecs / (self parsecs / boardSize)) floor.

	quantityOfSquaresAdvanced := (oldPosition lap - 1) * boardSize
	                             + aResult + oldPosition tileNumber.

	quantityOfSquaresAdvanced <= 0 ifTrue: [ 
		quantityOfSquaresAdvanced := 1 ].

	auxLap := quantityOfSquaresAdvanced - 1 // boardSize + 1.

	newLap := auxLap min: laps.

	newPosition := quantityOfSquaresAdvanced % boardSize.

	(newPosition = 0 or: [ auxLap > laps ]) ifTrue: [ 
		newPosition := boardSize ].

	^ SpaceShipPosition
		  ofSpaceShip: oldPosition spaceShip
		  tileNumber: newPosition
		  lap: newLap
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
