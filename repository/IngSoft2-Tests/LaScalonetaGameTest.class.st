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

{ #category : #running }
LaScalonetaGameTest >> testAfterLastPlayersTurnItsPlayer1TurnAgain [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Player1'. 'Player2'. 'LastPlayer'} )
				on: aBoard
				rolling: aDiceCup.

	aGame rollDiceCupFor: 'Player1'.
	aGame rollDiceCupFor: 'Player2'.
	aGame rollDiceCupFor: 'LastPlayer'.
	
	self assert: ( aGame positionOf: 'Player1' ) tileNumber equals: 2.
	self assert: ( aGame positionOf: 'Player2' ) tileNumber equals: 2.
	self assert: ( aGame positionOf: 'LastPlayer' ) tileNumber equals: 2.
	self assert:  aGame playerTurn equals: 'Player1'.
	self assert: ( aGame itsMyTurn: 'Player1' )
]

{ #category : #running }
LaScalonetaGameTest >> testAfterPlayer1ItsNotPlayer3Turn [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Player1'. 'Player2'. 'LastPlayer'} )
				on: aBoard
				rolling: aDiceCup.
	
	aGame rollDiceCupFor: 'Player1'.
	
	self assert: ( aGame positionOf: 'Player1' ) tileNumber equals: 2.
	self deny:  aGame playerTurn equals: 'Player3'.
	self assert: ( aGame itsMyTurn: 'Player2' )
]

{ #category : #running }
LaScalonetaGameTest >> testAfterPlayer1ItsPlayer2Turn [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Player1'. 'Player2'. 'LastPlayer'} )
				on: aBoard
				rolling: aDiceCup.
	
	aGame rollDiceCupFor: 'Player1'.
	
	self assert: ( aGame positionOf: 'Player1' ) tileNumber equals: 2.
	self assert:  aGame playerTurn equals: 'Player2'.
	self deny: ( aGame itsMyTurn: 'Player3' )
]

{ #category : #running }
LaScalonetaGameTest >> testFinalPositionOfPlayersCorrespondsWithTheActualFinalPositions [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.
	
	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'. 'Chango'} )
				on: aBoard
				rolling: aDiceCup.

	aGame rollDiceCupFor: 'Jorge'.
	aGame rollDiceCupFor: 'Julian'.
	aGame rollDiceCupFor: 'Chango'.
	aGame rollDiceCupFor: 'Jorge'.

	
	self assert: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 3.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 2.
	self assert: ( aGame positionOf: 'Chango' ) tileNumber equals: 2.
]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasEndedAsOnePlayerReachedTheEnd [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.

				
	self deny: (aGame hasEnded).

			
	aGame rollDiceCupFor: 'Jorge'.
	aGame rollDiceCupFor: 'Julian'. 	
		
	self deny: (aGame hasEnded).

	
	aGame rollDiceCupFor: 'Jorge'.
	
	self assert: (aGame hasEnded).
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasNotEndedAsNoPlayerReachedTheEnd [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.
				
	self deny: (aGame hasEnded).
	
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.	
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.	
			
	aGame rollDiceCupFor: 'Jorge'. 	
		
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 2.
	
	self deny: (aGame hasEnded).
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeAndJulianArePlayersOfLaScalonetaGame [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.
				
	self assert: aGame players equals: {'Jorge'. 'Julian'}
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeIsNotTheWinnerOfLaScalonetaGameWhenJulianReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3'. 'aTile4' }.

    aDie1 := LoadedDie with: 3.
    aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Julian'. 'Jorge'} )
				on: aBoard
				rolling: aDiceCup.

	 aGame rollDiceCupFor: 'Julian'.
	
	 self deny: aGame winner equals: 'Jorge'
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeWinsLaScalonetaGameWhenJorgeReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3'. 'aTile4' }.

    aDie1 := LoadedDie with: 3.
    aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.

	 aGame rollDiceCupFor: 'Jorge'.
	
	 self assert: aGame winner equals: 'Jorge'
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJulianCanNotRollTheDiceWhenIsNotHisTurn [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.
				
	self
		should: [aGame rollDiceCupFor: 'Julian']
		raise: Error
		withMessage: 'Its not your turn!'
]

{ #category : #tests }
LaScalonetaGameTest >> testJulianCanRollTheDiceAfterJorge [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.
	
	aGame rollDiceCupFor: 'Jorge'.
	
	self assert: aGame playerTurn equals: 'Julian'
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveAtLeastOnePlayer [

	| aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	self
		should: [ LaScalonetaGame 
				playedBy: ( {} )
				on: aBoard
				rolling: aDiceCup.
			]
		raise: Error
		withMessage: 'La Scaloneta Game must have at least one player'

]

{ #category : #running }
LaScalonetaGameTest >> testPlayer1StartsTheGame [
	
	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Player1'. 'Player2'. 'Player3'} )
				on: aBoard
				rolling: aDiceCup.
	
	self assert: aGame playerTurn equals: 'Player1'
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayerMovesThreeTilesFowardWhenRollingResultEqualsToThree [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3'. 'aTile4' }.
	
	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.
	
	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.
				
	aGame rollDiceCupFor: 'Jorge'. 	

	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 4.	
				
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayerStartsAtTileNumberOne [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.

	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayingAfterWinningIsNotAllowed [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { 'aTile1'. 'aTile2'. 'aTile3' }.
	
	aDie1 := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup.
				
	self deny: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.	
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.	
			
	aGame rollDiceCupFor: 'Jorge'. 	
		
	self assert: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 3.	
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.
	
	self
		should: [aGame rollDiceCupFor: 'Jorge']
		raise: Error
		withMessage: 'La Scaloneta Game has already ended!'
]
