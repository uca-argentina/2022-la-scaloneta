Class {
	#name : #EffectPoolTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectPoolTest >> testEffectPoolSumOfProbabilitiesMustBeEqualsToOne [

	| pool |
	self
		should: [ 
			pool := EffectPool with: { 
					        (ProbabilisticEvent with: NoEffect new and: 0.40).
					        (ProbabilisticEvent
						         with: (MoonWalkEffect with: -2)
						         and: 0.10).
					        (ProbabilisticEvent
						         with: (HyperJumpEffect with: { 
									          (DistanceInLightYears with: 12).
									          (DistanceInParsecs with: 2).
									          (DistanceInParsecs with: 3) })
						         and: 0.08).
					        (ProbabilisticEvent with: AtomicBombEffect new and: 0.02).
					        (ProbabilisticEvent with: WormHoleEffect new and: 0.2).
					        (ProbabilisticEvent with: SpeedUpEffect new and: 0.3) } ]
		raise: Error
		withMessage: 'The sum of the probabilities must be equal to 1!'
]

{ #category : #tests }
EffectPoolTest >> testProbabilityEventProbabilityMustBeBetwenZeroAndOne [

	| efect |
	efect := NoEffect new.
	self
		should: [ ProbabilisticEvent with: efect and: 2 ]
		raise: Error
		withMessage: 'Probabilities must be betwen 0 and 1!'
]

{ #category : #tests }
EffectPoolTest >> testThatIfHyperJumpEffectHasPointOneProbabilityWhenCreatingEffectPoolThatItHasBetweenZeroAndEighteenPool [

	| pool count effectCollection noEffect moonWalkEffect hyperJumpEffect atomicBombEffect wormHoleEffect speedUpEffect |
	
	noEffect := NoEffect new.
	moonWalkEffect := MoonWalkEffect with: -2.
	hyperJumpEffect := HyperJumpEffect with: { 
			                   (DistanceInLightYears with: 12).
			                   (DistanceInParsecs with: 2).
			                   (DistanceInParsecs with: 3) }.
	atomicBombEffect := AtomicBombEffect new.
	wormHoleEffect := WormHoleEffect new.
	speedUpEffect := SpeedUpEffect new.


	pool := EffectPool with: { 
			        (ProbabilisticEvent with: noEffect and: 0.40).
			        (ProbabilisticEvent with: moonWalkEffect and: 0.10).
			        (ProbabilisticEvent with: hyperJumpEffect and: 0.08).
			        (ProbabilisticEvent with: atomicBombEffect and: 0.02).
			        (ProbabilisticEvent with: wormHoleEffect and: 0.2).
			        (ProbabilisticEvent with: speedUpEffect and: 0.2) }..

	effectCollection := pool randomCollectionOfEffectsWith: 100.

	count := effectCollection count: [ :effect | effect = hyperJumpEffect ].

	self assert: (count between: 0 and: 18)
]

{ #category : #tests }
EffectPoolTest >> testThatIfMoonWalkEffectHasPointOneProbabilityWhenCreatingEffectPoolThatItHasBetweenZeroAndTwentyPool [

	| pool count effectCollection noEffect moonWalkEffect hyperJumpEffect atomicBombEffect wormHoleEffect speedUpEffect |
	
	noEffect := NoEffect new.
	moonWalkEffect := MoonWalkEffect with: -2.
	hyperJumpEffect := HyperJumpEffect with: { 
			                   (DistanceInLightYears with: 12).
			                   (DistanceInParsecs with: 2).
			                   (DistanceInParsecs with: 3) }.
	atomicBombEffect := AtomicBombEffect new.
	wormHoleEffect := WormHoleEffect new.
	speedUpEffect := SpeedUpEffect new.


	pool := EffectPool with: { 
			        (ProbabilisticEvent with: noEffect and: 0.40).
			        (ProbabilisticEvent with: moonWalkEffect and: 0.10).
			        (ProbabilisticEvent with: hyperJumpEffect and: 0.08).
			        (ProbabilisticEvent with: atomicBombEffect and: 0.02).
			        (ProbabilisticEvent with: wormHoleEffect and: 0.2).
			        (ProbabilisticEvent with: speedUpEffect and: 0.2) }..

	effectCollection := pool randomCollectionOfEffectsWith: 100.

	count := effectCollection count: [ :effect | effect = moonWalkEffect ].

	self assert: (count between: 0 and: 20)
]

{ #category : #running }
EffectPoolTest >> testThatIfNoEffectHasPointFourProbabilityWhenCreatingEffectPoolThatItHasBetweenThirtyAndFiftyPool [

	| pool count effectCollection noEffect moonWalkEffect hyperJumpEffect atomicBombEffect wormHoleEffect speedUpEffect |
	
	noEffect := NoEffect new.
	moonWalkEffect := MoonWalkEffect with: -2.
	hyperJumpEffect := HyperJumpEffect with: { 
			                   (DistanceInLightYears with: 12).
			                   (DistanceInParsecs with: 2).
			                   (DistanceInParsecs with: 3) }.
	atomicBombEffect := AtomicBombEffect new.
	wormHoleEffect := WormHoleEffect new.
	speedUpEffect := SpeedUpEffect new.


	pool := EffectPool with: { 
			        (ProbabilisticEvent with: noEffect and: 0.40).
			        (ProbabilisticEvent with: moonWalkEffect and: 0.10).
			        (ProbabilisticEvent with: hyperJumpEffect and: 0.08).
			        (ProbabilisticEvent with: atomicBombEffect and: 0.02).
			        (ProbabilisticEvent with: wormHoleEffect and: 0.2).
			        (ProbabilisticEvent with: speedUpEffect and: 0.2) }..

	effectCollection := pool randomCollectionOfEffectsWith: 100.

	count := effectCollection count: [ :effect | effect = noEffect ].

	self assert: (count between: 30 and: 50)
]

{ #category : #tests }
EffectPoolTest >> testThatIfSpeedUpEffectHasPointOneProbabilityWhenCreatingEffectPoolThatItHasBetweenTenAndThirtyPool [

	| pool count effectCollection noEffect moonWalkEffect hyperJumpEffect atomicBombEffect wormHoleEffect speedUpEffect |
	
	noEffect := NoEffect new.
	moonWalkEffect := MoonWalkEffect with: -2.
	hyperJumpEffect := HyperJumpEffect with: { 
			                   (DistanceInLightYears with: 12).
			                   (DistanceInParsecs with: 2).
			                   (DistanceInParsecs with: 3) }.
	atomicBombEffect := AtomicBombEffect new.
	wormHoleEffect := WormHoleEffect new.
	speedUpEffect := SpeedUpEffect new.


	pool := EffectPool with: { 
			        (ProbabilisticEvent with: noEffect and: 0.40).
			        (ProbabilisticEvent with: moonWalkEffect and: 0.10).
			        (ProbabilisticEvent with: hyperJumpEffect and: 0.08).
			        (ProbabilisticEvent with: atomicBombEffect and: 0.02).
			        (ProbabilisticEvent with: wormHoleEffect and: 0.2).
			        (ProbabilisticEvent with: speedUpEffect and: 0.2) }..

	effectCollection := pool randomCollectionOfEffectsWith: 100.

	count := effectCollection count: [ :effect | effect = speedUpEffect ].

	self assert: (count between: 10 and: 30)
]
