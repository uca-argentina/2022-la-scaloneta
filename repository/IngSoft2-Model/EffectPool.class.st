Class {
	#name : #EffectPool,
	#superclass : #Object,
	#instVars : [
		'effectPoolCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
EffectPool class >> withEffects: effects andProbabilities: probabilities [

	^ self new
		  initializeWithEffect: effects
		  andProbabilities: probabilities
]

{ #category : #accessing }
EffectPool >> effectPoolCollection [

      ^  effectPoolCollection 
]

{ #category : #initialization }
EffectPool >> initializeWithEffect: effects andProbabilities: probabilities [

	| effect probability |
	effectPoolCollection := {  }.

	1 to: effects size do: [ :i | 
		effect := effects at: i.
		probability := probabilities at: i.

		probability + 1 timesRepeat: [ 
			effectPoolCollection := effectPoolCollection copyWith: effect ] ]
]

{ #category : #accessing }
EffectPool >> randomCollectionOfEffectsWithLength: length [

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
