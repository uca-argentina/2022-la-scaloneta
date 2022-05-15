Class {
	#name : #LaScalonetaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LaScalonetaGameTest >> initializeLaScalonetaGame [

	| aGame aDiceCup aBoard aDie1 |
	
	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new. NoEffect new} andParsecs: 2.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
					numberOfLaps: 2.
	^ aGame
]

{ #category : #asserting }
LaScalonetaGameTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
LaScalonetaGameTest >> testEveryoneGoesBackToTile1WhenJorgeLandsOnAnAtomicBombEffect [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { NoEffect new. AtomicBombEffect new. NoEffect new. NoEffect new. NoEffect new  } andParsecs: 5.

   aDie1 := LoadedDie with: 2.

   aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	 aGame playNextTurn.
	 aGame playNextTurn.
	 aGame playNextTurn.
	 aGame playNextTurn.
	 aGame playNextTurn.
	
	 self assert: (aGame positionOf:'Julian')tileNumber equals: 1.
	 self assert: (aGame positionOf:'Julian')lap equals: 1.
	 self assert: (aGame positionOf:'Julian')tileNumber equals: 1.
	 self assert: (aGame positionOf:'Jorge')lap equals: 2.
	
	
	
	
	
	
	

]

{ #category : #running }
LaScalonetaGameTest >> testFinalPositionOfPlayersCorrespondsWithTheActualFinalPositions [

	| aGame aDiceCup aBoard aDie1 |
	
	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new } andParsecs: 3.

	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
					numberOfLaps: 2.

	aGame playNextTurn. 
	aGame playNextTurn. 
	
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Jorge' ) lap equals: 2.
	self assert: ( aGame positionOf: 'Julian' ) lap equals: 2.

	aGame playNextTurn. 

	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 3.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Jorge' ) lap equals: 2.
	self assert: ( aGame positionOf: 'Julian' ) lap equals: 2.
	
	self assert: aGame hasEnded

]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasEndedAsOnePlayerReachedTheEnd [

	| aGame aDiceCup aBoard aDie1 |
	
	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new } andParsecs: 3.

	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
					numberOfLaps: 2.

	self deny: (aGame hasEnded).
	
	aGame playNextTurn. 
	aGame playNextTurn. 	
	aGame playNextTurn.
			
	self assert: aGame hasEnded.
	self assert: ((aGame positionOf: 'Jorge') tileNumber) equals: aGame board tiles size
	

]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasNotEndedAsNoPlayerReachedTheEnd [
	"
	| aGame |
	
	aGame := self initializeLaScalonetaGame.
	
	self deny: aGame hasEnded.
	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	
	aGame playNextTurn. 
	
	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 2.
	self deny: aGame hasEnded
	"

	| aGame aDiceCup aBoard aDie1 |
	
	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new. NoEffect new  }andParsecs: 4.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
					numberOfLaps: 2.

	self deny: (aGame hasEnded).
	
	aGame playNextTurn. 
	aGame playNextTurn. 	
	aGame playNextTurn.
			
	self deny: aGame hasEnded.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeAndJulianArePlayersOfLaScalonetaGame [

	| aGame |

	aGame := self initializeLaScalonetaGame.
				
	self assert: aGame spaceShips equals: {'Jorge'. 'Julian'}
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeIsNotTheWinnerOfLaScalonetaGameWhenJulianReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new. NoEffect new }andParsecs: 4.

    aDie1 := LoadedDie with: 3.
    aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Julian'. 'Jorge'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.

	 aGame playNextTurn. 
	
	 self deny: aGame winner equals: 'Jorge'
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesBack4TilesWhenLandingOnAWormholeEffect [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new. NoEffect new. WormHoleEffect new. NoEffect new }andParsecs: 6.

    aDie1 := LoadedDie with: 4.
    aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.

	 aGame playNextTurn. 
	
	 self assert: (aGame positionOf: 'Jorge') tileNumber equals: 1.
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForward4TilesWhenLandingOnASppedUpEffect [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { NoEffect new. SpeedUpEffect new. NoEffect new. NoEffect new. NoEffect new. NoEffect new }andParsecs: 6.

    aDie1 := LoadedDie with: 1.
    aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.

	 aGame playNextTurn. 
	
	 self assert: (aGame positionOf: 'Jorge') tileNumber equals: 6.
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForwardAccordinglyWhenLandingOnAHyperJumpEffect [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { NoEffect new. HyperJumpEffect new. NoEffect new. NoEffect new. NoEffect new. NoEffect new. NoEffect new. NoEffect new. NoEffect new. NoEffect new }andParsecs: 10.
	"Board de 10 casilleros y 2 vueltas, cada casillero equivale a 10 parsecs."
   aDie1 := LoadedDie with: 1.

   aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	aGame playNextTurn.
	
	self assert: (aGame positionOf:'Jorge')tileNumber equals: 6.
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeWinsLaScalonetaGameWhenJorgeReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: {  NoEffect new. NoEffect new. NoEffect new. NoEffect new }andParsecs: 4.

    aDie1 := LoadedDie with: 3.
    aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.

	 aGame playNextTurn.
	
	 self assert: aGame winner equals: 'Jorge'
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJulianMovesBack2PositionsAndBacksAlapWhenJorgeLandsOnAMoonWalkEffect [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { MoonWalkEffect withN: -2. NoEffect new. NoEffect new. NoEffect new }andParsecs: 4.

   aDie1 := LoadedDie with: 2.

   aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	 aGame playNextTurn.
	 aGame playNextTurn.
	 aGame playNextTurn.
	
	 self assert: (aGame positionOf:'Julian')tileNumber equals: 1.
	 self assert: (aGame positionOf:'Julian')lap equals: 1.
	 self assert: (aGame positionOf:'Julian')tileNumber equals: 1.
	 self assert: (aGame positionOf:'Jorge')lap equals: 2.
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testJulianMovesBack3PositionsWhenJorgeLandsOnAMoonWalkEffect [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { MoonWalkEffect withN: -2. NoEffect new. NoEffect new. NoEffect new }andParsecs: 4.

   aDie1 := LoadedDie with: 2.

   aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	 aGame playNextTurn.
	 aGame playNextTurn.
	 aGame playNextTurn.
	
	 self assert: (aGame positionOf:'Julian')tileNumber equals: 1.
	 self assert: (aGame positionOf:'Julian')lap equals: 1.
	 self assert: (aGame positionOf:'Julian')tileNumber equals: 1.
	 self assert: (aGame positionOf:'Jorge')lap equals: 2.
	
	
	
	
	
	
	

]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveAtLeastOnePlayer [

	| aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: {NoEffect new. NoEffect new. NoEffect new}andParsecs: 3.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	self
		should: [ LaScalonetaGame 
				playedBy: ( {} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
			]
		raise: Error
		withMessage: 'La Scaloneta Game must have at least one spaceship!'

]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveTwoOrMoreLaps [
	| aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: {NoEffect new. NoEffect new. NoEffect new} andParsecs: 3.
	
	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	self
		should: [ LaScalonetaGame 
				playedBy: ( {'Player1'. 'Player2'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 1.
			]
		raise: Error
		withMessage: 'La Scaloneta Game must have two or more laps!'

]

{ #category : #tests }
LaScalonetaGameTest >> testPlayerMovesThreeTilesFowardWhenRollingResultEqualsToThree [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: {  NoEffect new. NoEffect new. NoEffect new. NoEffect new } andParsecs: 4.
	
	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.
	
	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	aGame playNextTurn.  	

	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 4.	
				
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayerStartsAtLapOne [

	| aGame |

	aGame := self initializeLaScalonetaGame.

	self assert: ( aGame positionOf: 'Jorge' ) lap equals: 1.
	self assert: ( aGame positionOf: 'Julian' ) lap equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayerStartsAtTileNumberOne [

	| aGame |

	aGame := self initializeLaScalonetaGame.

	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayingAfterWinningIsNotAllowed [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new } andParsecs: 3.
	
	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	self deny: (aGame hasEnded).
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.	
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.	
			
	aGame playNextTurn. 	
		
	self assert: ( aGame positionOf: 'Jorge' ) tileNumber equals: 1.	
	self assert: ( aGame positionOf: 'Julian' ) tileNumber equals: 1.
	
	aGame playNextTurn. 
	aGame playNextTurn. 
	
	self assert: (aGame hasEnded).
	
	self
		should: [aGame playNextTurn]
		raise: Error
		withMessage: 'La Scaloneta Game has already ended!'
]

{ #category : #tests }
LaScalonetaGameTest >> testThereIsNoWinnerAsTheGameHasNotEnded [

	| aGame aDiceCup aBoard aDie1 |
	
	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new. NoEffect new  } andParsecs: 4.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
					numberOfLaps: 2.

	self deny: (aGame hasEnded).
	
	aGame playNextTurn. 
	aGame playNextTurn. 	
	aGame playNextTurn.
	
	self
		should: [ 
				aGame winner
				]
		raise: Error
		withMessage: 'There is no winner as the game has not ended yet.'
]
