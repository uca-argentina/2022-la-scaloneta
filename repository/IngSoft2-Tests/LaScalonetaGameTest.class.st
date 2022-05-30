Class {
	#name : #LaScalonetaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
LaScalonetaGameTest >> assert: aSpaceship isAt: aPostion with: aLap in: aGame [

	self assert: (aGame positionOf: aSpaceship) tileNumber equals: aPostion .
	self assert: (aGame positionOf: aSpaceship) lap equals: aLap.
]

{ #category : #creating }
LaScalonetaGameTest >> laScalonetaGamePlayedByJorgeAndJulianWithALoadedDieWithOneOnABoardOfFourNoEffectTilesAndTwoParsecsDuringTwoLaps [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 2.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.
	^ aGame
]

{ #category : #playing }
LaScalonetaGameTest >> playUntilFinished: aGame [

	[ aGame hasEnded ] whileFalse: [ aGame playNextTurn ]
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
LaScalonetaGameTest >> testAskingForTheWinnerWhenTheGameHasNotEndedThrowsAnErrorMessage [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 4.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	self deny: aGame hasEnded.

	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner as the game has not ended yet.'
]

{ #category : #tests }
LaScalonetaGameTest >> testEffectPoolProbabilitiesMustBeBetwenZeroAndOneHundred [

	| pool |
	self
		should: [ 
			pool := EffectPool
				        with: { 
						        NoEffect new.
						        (MoonWalkEffect with: -2).
						        (HyperJumpEffect with: #( 1 2 3 )).
						        AtomicBombEffect new.
						        WormHoleEffect new }
				        and: { 40. -50. 8. 20. 2. -20 } ]
		raise: Error
		withMessage: 'Probabilities must be betwen 0 and 100!' 
]

{ #category : #tests }
LaScalonetaGameTest >> testEffectPoolSumOfProbabilitiesMustBeEqualsToOneHundred [

	| pool |
	self
		should: [ 
			pool := EffectPool
				        with: { 
						        NoEffect new.
						        (MoonWalkEffect with: -2).
						        (HyperJumpEffect with: #( 1 2 3 )).
						        AtomicBombEffect new.
						        WormHoleEffect new }
				        and: { 40. 10. 8. 20. 2. 10 } ]
		raise: Error
		withMessage: 'The sum of the probabilities must be equal to 100!'
]

{ #category : #tests }
LaScalonetaGameTest >> testEveryoneGoesBackToTheFirstPositionOnTheSameLapWhenJorgeLandsOnAnAtomicBombEffect [

	| aGame aBoard aDie1 aDie2 aDiceCup |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          AtomicBombEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 5.

	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Hernan'. 'Tomas' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Jorge' isAt: 1 with: 2 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	self assert: 'Hernan' isAt: 1 with: 1 in: aGame.
	self assert: 'Tomas' isAt: 1 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testFinalPositionOfSpaceShipsCorrespondsWithTheActualFinalPositions [

	| aGame aDiceCup aBoard aDie1 aDie2 aDie3 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: 'Jorge' isAt: 1 with: 2 in: aGame.
	self assert: 'Julian' isAt: 1 with: 2 in: aGame.

	aGame playNextTurn.


	self assert: 'Jorge' isAt: 3 with: 2 in: aGame.
	self assert: 'Julian' isAt: 1 with: 2 in: aGame.
	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasEndedAsOneSpaceShipReachedTheEnd [

	| aGame aDiceCup aBoard aDie1 aDie2 aDie3 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	self deny: aGame hasEnded.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: aGame hasEnded.
	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 3.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2
]

{ #category : #tests }
LaScalonetaGameTest >> testHyperJumpEffectMValuesCollectionCanNotBeEmpty [

	self
		should: [ HyperJumpEffect with: #(  ) ]
		raise: Error
		withMessage:
		'HyperJumpEffect can not be initalize with empty collection!'
]

{ #category : #tests }
LaScalonetaGameTest >> testHyperJumpEffectMValuesCollectionCanNotContainsNegativeValues [

	self
		should: [ HyperJumpEffect with: #( 1 -3 4 ) ]
		raise: Error
		withMessage: 'Values of the collection must be positive!'
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeDoesNotMoveFowardAsTheNumberOfParsecsIsNotEnoughToMoveOneTile [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 1 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 2 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeIsNotTheWinnerOfLaScalonetaGameWhenJulianReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup aDie2 aDie3 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 4.
		
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Julian'. 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 1.

	aGame playNextTurn.

	self deny: aGame winner equals: 'Jorge'
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeIsTheFirstSpaceShipAtSpaceShipsRankingAsHisPositionIsTheClosestToTheGoal [

	| aGame aDiceCup aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Lucas' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: aGame positionsRanking first spaceShip equals: 'Jorge'.
	self assert: aGame positionsRanking first tileNumber equals: 1.
	self assert: aGame positionsRanking first lap equals: 2.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesBackFourTilesWhenLandingOnAWormholeEffect [

	| aGame aBoard aDie1 aDie2 aDiceCup |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          WormHoleEffect new.
				          NoEffect new }
		          and: 6.

	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 2.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 1 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesBackTwoPositionsAndBacksALapWhenJorgeLandsOnAMoonWalkEffect [

	| aGame aBoard aDie1 aDie2 aDiceCup |
	aBoard := Board
		          with: { 
				          (MoonWalkEffect with: -2).
				          NoEffect new.
				          NoEffect new }
		          and: 4.

	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 1 with: 2 in: aGame.

	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 2 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 2 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForwardFourTilesWhenLandingOnASpeedUpEffect [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          SpeedUpEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 6.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 6 with: 1 in: aGame.

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForwardOneParsecWhenLandingOnAHyperJumpEffectWithMValueEqualsToOneParsec [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 1 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 2 with: 2 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesFowardOneParsecAndThenJulianMovesFowardTwoParsecsSinceTheyBothLandedOnAHyperJumpEffectAndOneAndTwoWhereTheFirstValuesOfTheMValuesList [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 1 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 2 with: 2 in: aGame.

	aGame playNextTurn.

	self assert: 'Julian' isAt: 6 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesFowardOneParsecThenJulianMovesFowardTwoParsecsAndFinallyHernanMovesFowardOneParsecAgainWhenLadingOnAHyperJumpEffectInitializeWithATwoMValuesList [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Hernan' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 2 with: 2 in: aGame.

	aGame playNextTurn.

	self assert: 'Julian' isAt: 6 with: 1 in: aGame.
	
	aGame playNextTurn.

	self assert: 'Hernan' isAt: 2 with: 2 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeWinsLaScalonetaGameWhenJorgeReachesTheEndFirst [

	| aGame aBoard aDie1 aDie2 aDie3 aDiceCup |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 4.

	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 1.

	aGame playNextTurn.

	self assert: aGame winner equals: 'Jorge'
]

{ #category : #tests }
LaScalonetaGameTest >> testJulianIsTheThirdSpaceShipAtSpaceShipsRankingAsHisPositionIsTheThirdClosestToTheGoal [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Lucas' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: aGame positionsRanking third spaceShip equals: 'Julian'.
	self assert: aGame positionsRanking third tileNumber equals: 2.
	self assert: aGame positionsRanking third lap equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameEndWhenPlayingWithARandomDie [

	| aGame aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 2.

	aDie1 := RandomDie with: 3.

	aGame := LaScalonetaGame
		         playedBy: { 'Julian'. 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         withNumberOfLaps: 2.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveAtLeastOneSpaceShip [

	| aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.

	self
		should: [ 
			LaScalonetaGame
				playedBy: {  }
				on: aBoard
				rolling: aDie1
				withNumberOfLaps: 2 ]
		raise: Error
		withMessage: 'La Scaloneta Game must have at least one spaceship!'
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveOneOrMoreLaps [

	| aBoard aDie1 |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.

	self
		should: [ 
			LaScalonetaGame
				playedBy: { 'Player1'. 'Player2' }
				on: aBoard
				rolling: aDie1
				withNumberOfLaps: 0 ]
		raise: Error
		withMessage: 'La Scaloneta Game must have one or more laps!'
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayingAfterWinningIsNotAllowed [

	| aGame aBoard aDie1 aDie2 aDie3 aDiceCup |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3.

	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1. aDie2. aDie3 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	self deny: aGame hasEnded.
	self assert: 'Jorge' isAt: 1 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 1 with: 2 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: aGame hasEnded.

	self
		should: [ aGame playNextTurn ]
		raise: Error
		withMessage: 'La Scaloneta Game has already ended!'
]

{ #category : #tests }
LaScalonetaGameTest >> testScalonetaGamePlayedWithRandomBoard [

	| tilesCollection board aGame pool aDie1 aDie2 aDiceCup |
	pool := EffectPool
		        with: { 
				        NoEffect new.
				        (MoonWalkEffect with: -2).
				        (HyperJumpEffect with: #( 1 2 3 )).
				        AtomicBombEffect new.
				        WormHoleEffect new }
		        and: { 40. 10. 8. 20. 2. 20 }.
	tilesCollection := pool randomCollectionOfEffectsWith: 5.

	board := Board with: tilesCollection and: 2.

	aDie1 := LoadedDie with: 3.
	aDie2 := LoadedDie with: 4.
	aDiceCup := DiceCup withAll: { aDie1. aDie2 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: board
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testSpaceShipMovesThreeTilesFowardWhenRollingResultEqualsToThree [

	| aGame aBoard aDie1 aDie2 aDiceCup |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 4.

	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1. aDie2 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 4 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testSpaceShipStartsAtTileNumberOneAndLapNumberOne [

	| aGame |
	aGame := self laScalonetaGamePlayedByJorgeAndJulianWithALoadedDieWithOneOnABoardOfFourNoEffectTilesAndTwoParsecsDuringTwoLaps.

	self assert: 'Jorge' isAt: 1 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
]
