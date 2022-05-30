Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardLengthEqualsToTileCollectionLength [

	| board tiles |

	tiles := {NoEffect new. NoEffect new.}.

	board := Board with: tiles and: 1.

	self assert: board size equals: tiles size
]

{ #category : #tests }
BoardTest >> testTileNumberedIsCorrect [

	| tile1 tile2 tiles board |
	
	tile1 := NoEffect new.
	tile2 := NoEffect new.
	
	tiles := {tile1. tile2}.

	board := Board with: tiles and: 1.
	
	self assert: board tiles first equals: tile1.
	self assert: board tiles second equals: tile2.

	

]

{ #category : #tests }
BoardTest >> testTilesBoardEqualsToTilesCollection [

| tile1 tile2 tiles board |
	
	tile1 := NoEffect new.
	tile2 := NoEffect new.
	
	tiles := {tile1. tile2}.

	board := Board with: tiles and: 1.
	
	self assert: board tiles equals: tiles.
]
