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
									          (LightYears with: 12).
									          (Parsecs with: 2).
									          (Parsecs with: 3) })
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

{ #category : #running }
EffectPoolTest >> testThatIfNoEffectHasPointFourProbabilityWhenCreatingEffectPoolThatItHasBetweenPointhirtyFiveAndPointFourtyFiveInAOneHundredPool [

	| pool count effectCollection |
	pool := EffectPool with: { 
			        (ProbabilisticEvent with: NoEffect new and: 0.40).
			        (ProbabilisticEvent
				         with: (MoonWalkEffect with: -2)
				         and: 0.10).
			        (ProbabilisticEvent
				         with: (HyperJumpEffect with: { 
							          (LightYears with: 12).
							          (Parsecs with: 2).
							          (Parsecs with: 3) })
				         and: 0.08).
			        (ProbabilisticEvent with: AtomicBombEffect new and: 0.02).
			        (ProbabilisticEvent with: WormHoleEffect new and: 0.2).
			        (ProbabilisticEvent with: SpeedUpEffect new and: 0.2) }.

	effectCollection := pool randomCollectionOfEffectsWith: 100.

	count := 0.

	effectCollection do: [ :effect | 
		100 timesRepeat:
			((effect isMemberOf: NoEffect) ifTrue: [ count := count + 1 ]) ].

	self assert: (count between: 35 and: 45)
]
