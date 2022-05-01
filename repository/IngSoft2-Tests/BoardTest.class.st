Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardLengthEqualsToTileCollectionLength [

	| board tiles |

	tiles := {'tile1'. 'tile2'}.

	board := Board withTiles: tiles.

	self assert: board tiles size equals: tiles size
]

{ #category : #tests }
BoardTest >> testTileNumberedIsCorrect [

	| tileCollection board |
	
	tileCollection := { 'firstTile'. 'secondTile' }.
	
	board := Board withTiles: tileCollection.
	
	self assert: ( board tileNumbered: 1 ) equals: 'firstTile' .
	self assert: ( board tileNumbered: 2 ) equals: 'secondTile'.

	

]

{ #category : #tests }
BoardTest >> testTileNumberedIsNoyCorrect [

	| tileCollection board |
	
	tileCollection := { 'firstTile'. 'secondTile' }.
	
	board := Board withTiles: tileCollection.
	
	self deny: ( board tileNumbered: 1 ) equals: 'secondTile'.
	self deny: ( board tileNumbered: 2 ) equals: 'firstTile'.

]

{ #category : #tests }
BoardTest >> testTilesBoardEqualsToTilesCollection [

	| board tiles |


	tiles := {'tile1'. 'tile2'}.

	board := Board withTiles: tiles.

	self assertCollection: board tiles equals: tiles
]
