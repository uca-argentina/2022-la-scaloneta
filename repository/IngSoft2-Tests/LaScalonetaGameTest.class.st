Class {
	#name : #LaScalonetaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #creating }
LaScalonetaGameTest >> laScalonetaGamePlayedByJorgeAndJulianWithALoadedDieWithOneOnABoardOfFourNoEffectTilesAndTwoParsecsDuringTwoLaps [

	| aGame aDiceCup aBoard aDie1 |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 2.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
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

	| aGame aDiceCup aBoard aDie1 |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 4.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
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
				        withEffects: { 
						        NoEffect new.
						        (MoonWalkEffect withN: -2).
						        (HyperJumpEffect withMValues: #( 1 2 3 )).
						        AtomicBombEffect new.
						        WormHoleEffect new }
				        andProbabilities: { 40. -50. 8. 20. 2. -20 } ]
		raise: Error
		withMessage: 'Probabilities must be betwen 0 and 100!' 
]

{ #category : #tests }
LaScalonetaGameTest >> testEffectPoolSumOfProbabilitiesMustBeEqualsToOneHundred [

	| pool |
	self
		should: [ 
			pool := EffectPool
				        withEffects: { 
						        NoEffect new.
						        (MoonWalkEffect withN: -2).
						        (HyperJumpEffect withMValues: #( 1 2 3 )).
						        AtomicBombEffect new.
						        WormHoleEffect new }
				        andProbabilities: { 40. 10. 8. 20. 2. 10 } ]
		raise: Error
		withMessage: 'The sum of the probabilities must be equal to 100!'
]

{ #category : #tests }
LaScalonetaGameTest >> testEveryoneGoesBackToTheFirstPositionOnTheSameLapWhenJorgeLandsOnAnAtomicBombEffect [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          AtomicBombEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 5.

	aDie1 := LoadedDie with: 2.

	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') lap equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2
]

{ #category : #tests }
LaScalonetaGameTest >> testFinalPositionOfSpaceShipsCorrespondsWithTheActualFinalPositions [

	| aGame aDiceCup aBoard aDie1 |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2.
	self assert: (aGame positionOf: 'Julian') lap equals: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 3.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2.
	self assert: (aGame positionOf: 'Julian') lap equals: 2.

	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasEndedAsOneSpaceShipReachedTheEnd [

	| aGame aDiceCup aBoard aDie1 |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

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
		should: [ HyperJumpEffect withMValues: #(  ) ]
		raise: Error
		withMessage:
		'HyperJumpEffect can not be initalize with empty collection!'
]

{ #category : #tests }
LaScalonetaGameTest >> testHyperJumpEffectMValuesCollectionCanNotContainsNegativeValues [

	self
		should: [ HyperJumpEffect withMValues: #( 1 -3 4 ) ]
		raise: Error
		withMessage: 'Values of the collection must be positive!'
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeDoesNotMoveFowardAsTheNumberOfParsecsIsNotEnoughToMoveOneTile [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          (HyperJumpEffect withMValues: #( 1 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 12.

	aDie1 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 2.
	self assert: (aGame positionOf: 'Jorge') lap equals: 1.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeIsNotTheWinnerOfLaScalonetaGameWhenJulianReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 4.
	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

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
		          withTiles: { 
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

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

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          WormHoleEffect new.
				          NoEffect new }
		          andParsecs: 6.

	aDie1 := LoadedDie with: 4.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForwardFourTilesWhenLandingOnASppedUpEffect [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          SpeedUpEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 6.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 6
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForwardOneParsecWhenLandingOnAHyperJumpEffectWithMValueEqualsToOneParsec [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          (HyperJumpEffect withMValues: #( 1 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 2.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesFowardOneParsecAndThenJulianMovesFowardTwoParsecsSinceTheyBothLandedOnAHyperJumpEffectAndOneAndTwoWhereTheFirstValuesOfTheMValuesList [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          (HyperJumpEffect withMValues: #( 1 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 2.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Julian') tileNumber equals: 6.
	self assert: (aGame positionOf: 'Julian') lap equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesFowardOneParsecThenJulianMovesFowardTwoParsecsAndFinallyHernanMovesFowardOneParsecAgainWhenLadingOnAHyperJumpEffectInitializeWithATwoMValuesList [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          (HyperJumpEffect withMValues: #( 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Hernan' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 2.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Julian') tileNumber equals: 6.
	self assert: (aGame positionOf: 'Julian') lap equals: 1.
	
	aGame playNextTurn.

	self assert: (aGame positionOf: 'Hernan') tileNumber equals: 2.
	self assert: (aGame positionOf: 'Hernan') lap equals: 2
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeWinsLaScalonetaGameWhenJorgeReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 4.

	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

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

	| aGame aDiceCup aBoard aDie1 |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

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

	self assert: aGame positionsRanking third spaceShip equals: 'Julian'.
	self assert: aGame positionsRanking third tileNumber equals: 2.
	self assert: aGame positionsRanking third lap equals: 1.
]

{ #category : #tests }
LaScalonetaGameTest >> testJulianMovesBackThreePositionsWhenJorgeLandsOnAMoonWalkEffect [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          (MoonWalkEffect withN: -2).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 4.

	aDie1 := LoadedDie with: 2.

	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') lap equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2
]

{ #category : #tests }
LaScalonetaGameTest >> testJulianMovesBackTwoPositionsAndBacksALapWhenJorgeLandsOnAMoonWalkEffect [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          (MoonWalkEffect withN: -2).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 4.

	aDie1 := LoadedDie with: 2.

	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') lap equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Jorge') lap equals: 2
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameEndWhenPlayingWithARandomDie [

	| aGame aDiceCup aBoard aDie1 |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 2.

	aDie1 := RandomDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Julian'. 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveAtLeastOneSpaceShip [

	| aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	self
		should: [ 
			LaScalonetaGame
				playedBy: {  }
				on: aBoard
				rolling: aDiceCup
				withNumberOfLaps: 2 ]
		raise: Error
		withMessage: 'La Scaloneta Game must have at least one spaceship!'
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveOneOrMoreLaps [

	| aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	self
		should: [ 
			LaScalonetaGame
				playedBy: { 'Player1'. 'Player2' }
				on: aBoard
				rolling: aDiceCup
				withNumberOfLaps: 0 ]
		raise: Error
		withMessage: 'La Scaloneta Game must have one or more laps!'
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayingAfterWinningIsNotAllowed [

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 3.

	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	self deny: aGame hasEnded.
	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1.

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

	| tilesCollection board aGame pool aDie1 aDiceCup |
	pool := EffectPool
		        withEffects: { 
				        NoEffect new.
				        (MoonWalkEffect withN: -2).
				        (HyperJumpEffect withMValues: #( 1 2 3 )).
				        AtomicBombEffect new.
				        WormHoleEffect new }
		        andProbabilities: { 40. 10. 8. 20. 2. 20 }.
	tilesCollection := pool randomCollectionOfEffectsWithLength: 5.

	board := Board withTiles: tilesCollection andParsecs: 2.

	aDie1 := LoadedDie with: 7.
	aDiceCup := DiceCup withAll: { aDie1 }.

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

	| aGame aBoard aDie1 aDiceCup |
	aBoard := Board
		          withTiles: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          andParsecs: 4.

	aDie1 := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { aDie1 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         withNumberOfLaps: 2.

	aGame playNextTurn.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 4
]

{ #category : #tests }
LaScalonetaGameTest >> testSpaceShipStartsAtLapOne [

	| aGame |
	aGame := self laScalonetaGamePlayedByJorgeAndJulianWithALoadedDieWithOneOnABoardOfFourNoEffectTilesAndTwoParsecsDuringTwoLaps.

	self assert: (aGame positionOf: 'Jorge') lap equals: 1.
	self assert: (aGame positionOf: 'Julian') lap equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testSpaceShipStartsAtTileNumberOne [

	| aGame |
	aGame := self laScalonetaGamePlayedByJorgeAndJulianWithALoadedDieWithOneOnABoardOfFourNoEffectTilesAndTwoParsecsDuringTwoLaps.

	self assert: (aGame positionOf: 'Jorge') tileNumber equals: 1.
	self assert: (aGame positionOf: 'Julian') tileNumber equals: 1
]
