Class {
	#name : #LaScalonetaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LaScalonetaGameTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasEndedAsOnePlayerReachedTheEnd [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceCup |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aBoard := Board withTiles: { aTile1. aTile2. aTile3 }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				withBoard: aBoard
				diceCollection: aDiceCup
				players: ( {'Jorge'. 'Julian'} ).
				
	self deny: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.	
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.	
			
	aGame rollDiceCupFor: 'Jorge'. 	
		
	self deny: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 2.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.
	
	aGame rollDiceCupFor: 'Jorge'.
	
	self assert: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 3.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.
	

]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasNotEndedAsNoPlayerReachedTheEnd [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceCup |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aBoard := Board withTiles: { aTile1. aTile2. aTile3 }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				withBoard: aBoard
				diceCollection: aDiceCup
				players: ( {'Jorge'. 'Julian'} ).
				
	self deny: (aGame hasEnded).
	
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.	
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.	
			
	aGame rollDiceCupFor: 'Jorge'. 	
		
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 2.
	
	self deny: (aGame hasEnded).
	

]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveAtLeastOnePlayer [

	| aTile1 aTile2 aTile3 aBoard aDie1 aDiceCup |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aBoard := Board withTiles: { aTile1. aTile2. aTile3 }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	self
		should: [ LaScalonetaGame
				withBoard: aBoard
				diceCollection: aDiceCup
				players: {}
			]
		raise: Error
		withMessage: 'La Scaloneta Game must have at least one player'

]

{ #category : #tests }
LaScalonetaGameTest >> testPlayerStartsAtTileNumberOne [

	| aGame aTile1 aTile2 aTile3 aBoard aDie1 aDiceCup |

	aTile1 := Tile new.
	aTile2 := Tile new.
	aTile3 := Tile new.
	aBoard := Board withTiles: { aTile1. aTile2. aTile3 }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				withBoard: aBoard
				diceCollection: aDiceCup
				players: ( {'Jorge'. 'Julian'} ).

	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1
]
