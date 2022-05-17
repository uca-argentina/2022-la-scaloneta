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

{ #category : #playing }
LaScalonetaGameTest >> playUntilFinished: aGame [

	[ aGame hasEnded ] whileFalse: [ aGame playNextTurn ].
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

	aBoard := Board withTiles: { NoEffect new. AtomicBombEffect new. NoEffect new. NoEffect new. NoEffect new } andParsecs: 5.

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
LaScalonetaGameTest >> testHyperJumpEffectListIsIteratedCorrectly [

	| aGame aBoard aDie1 aDiceCup |

	aBoard := Board withTiles: { NoEffect new. HyperJumpEffect with: #(1 2 3).  NoEffect new. NoEffect new. NoEffect new. NoEffect new } andParsecs: 3.
	
   aDie1 := LoadedDie with: 1.

   aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'. 'Julian'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	aGame playNextTurn.
	
	self assert: (aGame positionOf:'Jorge')tileNumber equals: 2.
	self assert: (aGame positionOf:'Jorge')lap equals: 2.
	
	aGame playNextTurn.

	self assert: (aGame positionOf:'Julian')tileNumber equals: 6.
	self assert: (aGame positionOf:'Julian')lap equals: 1.	
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

	aBoard := Board withTiles: { NoEffect new. HyperJumpEffect with: #(1 2 3).  NoEffect new. NoEffect new. NoEffect new. NoEffect new } andParsecs: 3.
	
   aDie1 := LoadedDie with: 1.

   aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Jorge'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.
				
	aGame playNextTurn.
	
	self assert: (aGame positionOf:'Jorge')tileNumber equals: 2.
	self assert: (aGame positionOf:'Jorge')lap equals: 2.
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
LaScalonetaGameTest >> testLaScalonetaGameEndWhenPlayingWithARandomDie [

	| aGame aDiceCup aBoard aDie1 |

	aBoard := Board withTiles: { NoEffect new. NoEffect new. NoEffect new. NoEffect new } andParsecs: 2.

   aDie1 := RandomDie with: 3.
   aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame 
				playedBy: ( {'Julian'. 'Jorge'} )
				on: aBoard
				rolling: aDiceCup
				numberOfLaps: 2.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.
	
	self assert: aGame hasEnded
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
LaScalonetaGameTest >> testScalonetaGamePlayedWithRandomBoard [
	|tilesCollection board aGame pool aDie1 aDiceCup|
	
	pool := EffectPool withEffects: {NoEffect new. MoonWalkEffect withN: -2. HyperJumpEffect with: #(1 2 3). AtomicBombEffect new. WormHoleEffect new. } andProbabilities: {40. 10. 8. 20. 2. 20.}.
	tilesCollection := pool randomCollectionOfEffectsWithLength: 5.
	
	board := Board withTiles: tilesCollection andParsecs: 2.
	
	aDie1 := LoadedDie with: 7.
   aDiceCup := DiceCup withAll: { aDie1 }.

   aGame := LaScalonetaGame
                 playedBy: { 'Jorge'. 'Julian' }
                 on: board
                 rolling: aDiceCup
                    numberOfLaps: 2.

	self playUntilFinished: aGame.	
	
	self assert: aGame hasEnded.


	
	
	
]

{ #category : #tests }
LaScalonetaGameTest >> testSpaceShipsRanking [

	| aGame aDiceCup aBoard aDie1 |
	
	aBoard := Board withTiles: { NoEffect new. NoEffect new. } andParsecs: 3.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Lucas'. }
		         on: aBoard
		         rolling: aDiceCup
					numberOfLaps: 2.
					
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame positionsRanking at: 1)spaceShip equals: 'Jorge'.
	self assert: (aGame positionsRanking at: 1)tileNumber equals: 1.
	self assert: (aGame positionsRanking at: 1)lap equals: 2.
	
	self assert: (aGame positionsRanking at: 2)spaceShip equals: 'Lucas'.
	self assert: (aGame positionsRanking at: 2)tileNumber equals: 2.
	self assert: (aGame positionsRanking at: 2)lap equals: 1.
	
	self assert: (aGame positionsRanking at: 3)spaceShip equals: 'Julian'.
	self assert: (aGame positionsRanking at: 3)tileNumber equals: 2.
	self assert: (aGame positionsRanking at: 3)lap equals: 1.
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
