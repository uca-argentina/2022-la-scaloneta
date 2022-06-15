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

	| aGame aBoard aDie1 aDeck anAccelerationCard |

	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 2
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	^ aGame
]

{ #category : #playing }
LaScalonetaGameTest >> playUntilFinished: aGame [

	[ aGame hasEnded ] whileFalse: [ aGame playNextTurn ]
]

{ #category : #tests }
LaScalonetaGameTest >> testAJorgeAndJulianHaveTwoCardsInHandWhenTheGameStarts [


	| aGame aBoard aDie1 aDie2 aDiceCup anAccelerationCard aDeck |

	anAccelerationCard := AccelerationCard new.
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2}.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.
	
	self assert: (aGame quantityOfCardInHandOf: 'Jorge') equals: 2.
	self assert: (aGame quantityOfCardInHandOf: 'Julian') equals: 2.
]

{ #category : #tests }
LaScalonetaGameTest >> testAskingForTheWinnerWhenTheGameHasNotEndedThrowsAnErrorMessage [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
				    and: 4 finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
					usingCardsFrom: aDeck.

	self deny: aGame hasEnded.

	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner as the game has not ended yet.'
]

{ #category : #tests }
LaScalonetaGameTest >> testEveryoneGoesBackToTheFirstPositionOnTheSameLapWhenJorgeLandsOnAnAtomicBombEffect [

	| aGame aBoard aDie1 aDie2 aDiceCup aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          AtomicBombEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 5
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2 }.
			
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Hernan'. 'Tomas' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self
		assert: 'Jorge'
		isAt: 1
		with: 2
		in: aGame.
	self
		assert: 'Julian'
		isAt: 1
		with: 1
		in: aGame.
	self
		assert: 'Hernan'
		isAt: 1
		with: 1
		in: aGame.
	self
		assert: 'Tomas'
		isAt: 1
		with: 1
		in: aGame
]

{ #category : #tests }
LaScalonetaGameTest >> testFinalPositionOfSpaceShipsCorrespondsWithTheActualFinalPositions [

	| aGame aDiceCup aBoard aDie1 aDie2 aDie3 aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

	aGame playNextTurn.
	aGame playNextTurn.

	self
		assert: 'Jorge'
		isAt: 1
		with: 2
		in: aGame.
	self
		assert: 'Julian'
		isAt: 1
		with: 2
		in: aGame.

	aGame playNextTurn.


	self
		assert: 'Jorge'
		isAt: 3
		with: 2
		in: aGame.
	self
		assert: 'Julian'
		isAt: 1
		with: 2
		in: aGame.
	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testGameHasEndedAsOneSpaceShipReachedTheEnd [

	| aGame aDiceCup aBoard aDie1 aDie2 aDie3 aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

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
LaScalonetaGameTest >> testJorgeCannotThrowAnAccelerationCardThatHeDoesNotHaveInHisHand [

	| aGame aBoard aDie1 aDie2 aDiceCup anAccelerationCard aSpeedCard aDeck |

	anAccelerationCard := AccelerationCard new.
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2}.
	
	anAccelerationCard := AccelerationCard new.

	aSpeedCard := SpeedCard new.

	aDeck := Deck with: {aSpeedCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.
	
	self assert: 'Jorge' isAt: 1 with: 1 in: aGame. 
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	
	aGame playNextTurn.
	
	self
		should: [ aGame affect: { 'Jorge'. 'Julian' } using: anAccelerationCard by: 'Julian' ]
		raise: Error
		withMessage:
		'The SpaceShip cannot throw this card because he does not have it'
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeCannotThrowAnOverloadCardWhenItIsNotHisTurn [

	| aGame aBoard aDie1 aDie2 aDiceCup anAccelerationCard aDeck |

	anAccelerationCard := AccelerationCard new.
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2}.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.
	
	self assert: 'Jorge' isAt: 1 with: 1 in: aGame. 
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	
	aGame playNextTurn.
	
	self
		should: [ aGame affect: { 'Jorge'. 'Julian' } using: anAccelerationCard by: 'Jorge' ]
		raise: Error
		withMessage:
		'Its not your turn!'
	
	


	
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeDoesNotMoveFowardAsTheNumberOfParsecsIsNotEnoughToMoveOneTile [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 1 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame playNextTurn.

	self
		assert: 'Jorge'
		isAt: 2
		with: 1
		in: aGame
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeGetsAndThrowsAnAccelerationAffectingAllSpaceShipsSoThenAllMovesOneMoreTile [

	| aGame aBoard aDie1 aDie2 aDiceCup anAccelerationCard aDeck |

	anAccelerationCard := AccelerationCard new.
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2}.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.
	
	self assert: 'Jorge' isAt: 1 with: 1 in: aGame. 
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	
	aGame affect: { 'Jorge'. 'Julian' } using: anAccelerationCard by: 'Jorge'.
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 4 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	
	aGame playNextTurn.
	self assert: 'Jorge' isAt: 4 with: 1 in: aGame.
	self assert: 'Julian' isAt: 4 with: 1 in: aGame.	

	
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeGetsAndThrowsAnOverloadCardAffectingJulianSoJuliaStaysAtTheFirstPositionWhenHisRollingResultIsOneAsHeCanNotMoveFurtherBackThanFirstPosition [

	| aGame aBoard aDie1 aOverloadCard aDeck |

	aOverloadCard := OverloadCard new.
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	
	aOverloadCard := OverloadCard new.

	aDeck := Deck with: {aOverloadCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
	self assert: 'Jorge' isAt: 1 with: 1 in: aGame. 
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	
	aGame affect: 'Julian' using: aOverloadCard by: 'Jorge'.
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 2 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeGetsAndThrowsAnOverloadCardAffectingJulianSoJulianMovesOneTileBackwardsWhenHisRollingResultIsOne [

	| aGame aBoard aDie1 aOverloadCard aDeck |

	aOverloadCard := OverloadCard new.
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	
	aOverloadCard := OverloadCard new.

	aDeck := Deck with: {aOverloadCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
	aGame playNextTurn.
	aGame playNextTurn.
		
	aGame affect: 'Julian' using: aOverloadCard by: 'Jorge'.
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 3 with: 1 in: aGame.
	self assert: 'Julian' isAt: 2 with: 1 in: aGame.
	
	aGame playNextTurn. 
	
	self assert: 'Jorge' isAt: 3 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeGetsAndThrowsAnOverloadCardAffectingJulianSoJulianMovesOneTileFowardWhenHisRollingResultIsThree [

	| aGame aBoard aDie1 aOverloadCard aDeck aDie2 aDiceCup |

	aOverloadCard := OverloadCard new.
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 2.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2}.
	
	aOverloadCard := OverloadCard new.

	aDeck := Deck with: {aOverloadCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.
	
	aGame playNextTurn.
	aGame playNextTurn.
		
	aGame affect: 'Julian' using: aOverloadCard by: 'Jorge'.
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 2 with: 2 in: aGame.
	self assert: 'Julian' isAt: 4 with: 1 in: aGame.
	
	aGame playNextTurn. 
	
	self assert: 'Jorge' isAt: 2 with: 2 in: aGame.
	self assert: 'Julian' isAt: 5 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeGetsAndThrowsAnSpeedCardAffectingJulianSoJulianMovesThreeTileWhenHisRollingResultIsTwo [

	| aGame aBoard aDie1 aDie2 aDiceCup aSpeedCard aDeck |

	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          DeliveryCardEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 12
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2}.

	aSpeedCard := SpeedCard new.

	aDeck := Deck with: {aSpeedCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.
	
	self assert: 'Jorge' isAt: 1 with: 1 in: aGame. 
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	
	aGame affect: 'Julian' using: aSpeedCard by: 'Jorge'.
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 3 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 1 in: aGame.
	
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 3 with: 1 in: aGame.
	self assert: 'Julian' isAt: 4 with: 1 in: aGame.
	
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 5 with: 1 in: aGame.
	self assert: 'Julian' isAt: 4 with: 1 in: aGame.		


]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeIsNotTheWinnerOfLaScalonetaGameWhenJulianReachesTheEndFirst [

	| aGame aBoard aDie1 aDiceCup aDie2 aDie3 aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 4
		          finishingAfter: 1.

	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.
			
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Julian'. 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

	aGame playNextTurn.

	self deny: aGame winner equals: 'Jorge'
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeIsTheFirstSpaceShipAtSpaceShipsRankingAsHisPositionIsTheClosestToTheGoal [

	| aGame aDiceCup aBoard aDie1 aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1 }.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Lucas' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self
		assert: aGame spaceShipsPositionsRanking first spaceShip
		equals: 'Jorge'.
	self
		assert: aGame spaceShipsPositionsRanking first tileNumber
		equals: 1.
	self assert: aGame spaceShipsPositionsRanking first lap equals: 2
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesBackFourTilesWhenLandingOnAWormholeEffect [

	| aGame aBoard aDie1 aDie2 aDiceCup aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          WormHoleEffect new.
				          NoEffect new }
		          and: 6
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 2.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2 }.
			
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

	aGame playNextTurn.

	self
		assert: 'Jorge'
		isAt: 1
		with: 1
		in: aGame
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesBackTwoPositionsAndBacksALapWhenJorgeLandsOnAMoonWalkEffect [

	| aGame aBoard aDie1 aDie2 aDiceCup aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          (MoonWalkEffect with: -2).
				          NoEffect new.
				          NoEffect new }
		          and: 4
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2 }.
			
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 1 with: 2 in: aGame.

	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 2 with: 1 in: aGame.
	self assert: 'Julian' isAt: 1 with: 2 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForwardFourTilesWhenLandingOnASpeedUpEffect [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          SpeedUpEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 6
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 6 with: 1 in: aGame.

]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesForwardOneParsecWhenLandingOnAHyperJumpEffectWithMValueEqualsToOneParsec [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 1 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 2 with: 2 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesFowardOneParsecAndThenJulianMovesFowardTwoParsecsSinceTheyBothLandedOnAHyperJumpEffectAndOneAndTwoWhereTheFirstValuesOfTheMValuesList [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 1 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.
		
	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDie1
					usingCardsFrom: aDeck.

	aGame playNextTurn.

	self assert: 'Jorge' isAt: 2 with: 2 in: aGame.

	aGame playNextTurn.

	self assert: 'Julian' isAt: 6 with: 1 in: aGame.
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeMovesFowardOneParsecThenJulianMovesFowardTwoParsecsAndFinallyHernanMovesFowardOneParsecAgainWhenLadingOnAHyperJumpEffectInitializeWithATwoMValuesList [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	aBoard := Board
		          with: { 
				          NoEffect new.
				          (HyperJumpEffect with: #( 2 3 )).
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Hernan' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame playNextTurn.

	self
		assert: 'Jorge'
		isAt: 2
		with: 2
		in: aGame.

	aGame playNextTurn.

	self
		assert: 'Julian'
		isAt: 6
		with: 1
		in: aGame.

	aGame playNextTurn.

	self
		assert: 'Hernan'
		isAt: 2
		with: 2
		in: aGame
]

{ #category : #tests }
LaScalonetaGameTest >> testJorgeWinsLaScalonetaGameWhenJorgeReachesTheEndFirst [

	| aGame aBoard aDie1 aDie2 aDie3 aDiceCup aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 4
		          finishingAfter: 1.
	
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.

	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2.
			            aDie3 }.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
					usingCardsFrom: aDeck.

	aGame playNextTurn.

	self assert: aGame winner equals: 'Jorge'
]

{ #category : #tests }
LaScalonetaGameTest >> testJulianDoesNotGoBackFurtherThanFirstPositionOfFirstLapWhenAffectedByAWormholeOnSecondPositionOfFirstLap [

| aGame aBoard aDie1 aDeck anAccelerationCard |

	aBoard := Board
		          with: { 
				          NoEffect new.
				          WormHoleEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 6
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.
		
	aGame playNextTurn.
	
	self assert: 'Jorge' isAt: 1 with: 1 in: aGame
]

{ #category : #tests }
LaScalonetaGameTest >> testJulianIsTheThirdSpaceShipAtSpaceShipsRankingAsHisPositionIsTheThirdClosestToTheGoal [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.

	aDie1 := LoadedDie with: 1.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian'. 'Lucas' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: aGame spaceShipsPositionsRanking third spaceShip equals: 'Julian'.
	self assert: aGame spaceShipsPositionsRanking third tileNumber equals: 2.
	self assert: aGame spaceShipsPositionsRanking third lap equals: 1
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameEndWhenPlayingWithARandomDie [

	| aGame aBoard aDie1 aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 2
		          finishingAfter: 2.

	aDie1 := RandomDie with: 3.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Julian'. 'Jorge' }
		         on: aBoard
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self deny: aGame hasEnded.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveAtLeastOneSpaceShip [

	| aBoard aDie1 aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.
	
	aDie1 := LoadedDie with: 1.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	self
		should: [ 
			LaScalonetaGame
				playedBy: {  }
				on: aBoard
				rolling: aDie1
				usingCardsFrom: aDeck ]
		raise: Error
		withMessage: 'La Scaloneta Game must have at least one spaceship!'
]

{ #category : #tests }
LaScalonetaGameTest >> testLaScalonetaGameMustHaveOneOrMoreLaps [

	self
		should: [
			Board
		          with: { 
						NoEffect new.
						NoEffect new.
						NoEffect new }
		          and: 3
		          finishingAfter: 0. ]
		raise: Error
		withMessage: 'La Scaloneta Game must have one or more laps!'
]

{ #category : #tests }
LaScalonetaGameTest >> testPlayingAfterWinningIsNotAllowed [

	| aGame aBoard aDie1 aDie2 aDie3 aDiceCup aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 3
		          finishingAfter: 2.
	
	aDie1 := LoadedDie with: 1.
	aDie2 := LoadedDie with: 1.
	aDie3 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1. aDie2. aDie3 }.

	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

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

	| tilesCollection board aGame pool aDie1 aDie2 aDiceCup aDeck anAccelerationCard |
	pool := EffectPool
		        with: { 
				        NoEffect new.
				        (MoonWalkEffect with: -2).
				        (HyperJumpEffect with: #( 1 2 3 )).
				        SpeedUpEffect new.
				        AtomicBombEffect new.
				        WormHoleEffect new }
		        and: { 40. 10. 8. 20. 2. 20 }.
	tilesCollection := pool randomCollectionOfEffectsWith: 5.

	board := Board with: tilesCollection and: 2 finishingAfter: 2.

	aDie1 := LoadedDie with: 3.
	aDie2 := LoadedDie with: 4.
	aDiceCup := DiceCup withAll: { 
			            aDie1.
			            aDie2 }.
			
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: board
		         rolling: aDiceCup
		         usingCardsFrom: aDeck.

	self playUntilFinished: aGame.

	self assert: aGame hasEnded
]

{ #category : #tests }
LaScalonetaGameTest >> testSpaceShipMovesThreeTilesFowardWhenRollingResultEqualsToThree [

	| aGame aBoard aDie1 aDie2 aDiceCup aDeck anAccelerationCard |
	
	aBoard := Board
		          with: { 
				          NoEffect new.
				          NoEffect new.
				          NoEffect new.
				          NoEffect new }
		          and: 4
		          finishingAfter: 2.
	
	aDie1 := LoadedDie with: 2.
	aDie2 := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { aDie1. aDie2 }.
	
	anAccelerationCard := AccelerationCard new.

	aDeck := Deck with: {anAccelerationCard}.

	aGame := LaScalonetaGame
		         playedBy: { 'Jorge'. 'Julian' }
		         on: aBoard
		         rolling: aDiceCup
				   usingCardsFrom: aDeck.

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
