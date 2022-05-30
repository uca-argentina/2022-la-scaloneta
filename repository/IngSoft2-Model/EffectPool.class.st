Class {
	#name : #EffectPool,
	#superclass : #Object,
	#instVars : [
		'effectPoolCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
EffectPool class >> assertProbabilitiesAreBetwenZeroAndOneHoundred: probabilities [

	probabilities do: [ :proba | 
		(proba between: 0 and: 100) ifFalse: [ 
			Error signal: 'Probabilities must be betwen 0 and 100!' ] ]
]

{ #category : #asserting }
EffectPool class >> assertSumOfProbabilitiesEqualsToOneHoundred: probabilities [

	((probabilities inject: 0 into: [:inicial :aux | inicial + aux]) = 100) ifFalse: [Error signal: 'The sum of the probabilities must be equal to 100!'].
]

{ #category : #initialize }
EffectPool class >> with: effects and: probabilities [

	self assertProbabilitiesAreBetwenZeroAndOneHoundred: probabilities.
	self assertSumOfProbabilitiesEqualsToOneHoundred: probabilities.

	^ self new
		  initializeWith: effects
		  and: probabilities
]

{ #category : #accessing }
EffectPool >> effectPoolCollection [

      ^  effectPoolCollection 
]

{ #category : #initialization }
EffectPool >> initializeWith: effects and: probabilities [

	| effect probability |
	effectPoolCollection := {  }.

	1 to: effects size do: [ :i | 
		effect := effects at: i.
		probability := probabilities at: i.

		probability + 1 timesRepeat: [ 
			effectPoolCollection := effectPoolCollection copyWith: effect ] ]

]

{ #category : #accessing }
EffectPool >> randomCollectionOfEffectsWith: length [

	| randomEffectsCollection |
	randomEffectsCollection := {  }.

	1 to: length do: [ :i | 
		randomEffectsCollection := randomEffectsCollection copyWith:
			                           self randomEffect ].

	^ randomEffectsCollection
]

{ #category : #accessing }
EffectPool >> randomEffect [

	| effectIndex |
	effectIndex := effectPoolCollection size atRandom.
	^ self effectPoolCollection at: effectIndex
]
