Class {
	#name : #EffectPoolTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectPoolTest >> testEffectPoolProbabilitiesMustBeBetwenZeroAndOneHundred [

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
EffectPoolTest >> testEffectPoolSumOfProbabilitiesMustBeEqualsToOneHundred [

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
