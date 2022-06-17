Class {
	#name : #EffectPool,
	#superclass : #Object,
	#instVars : [
		'effectPoolCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
EffectPool class >> assertSumOfProbabilitiesEqualsToOne: probabilisticEventList [

	((probabilisticEventList inject: 0 into: [:inicial :probabilisticEvent | inicial + probabilisticEvent probability]) = 1) ifFalse: [Error signal: 'The sum of the probabilities must be equal to 1!'].
]

{ #category : #initialize }
EffectPool class >> with: probabilisticEventList [

	self assertSumOfProbabilitiesEqualsToOne: probabilisticEventList.

	^ self new
		  initializeWith: probabilisticEventList 
]

{ #category : #accessing }
EffectPool >> effectPoolCollection [

      ^  effectPoolCollection 
]

{ #category : #initialization }
EffectPool >> initializeWith: probabilityEventList [

	effectPoolCollection := {  }.

	probabilityEventList do: [ :probabilisticEvent | ((probabilisticEvent probability) *100) asInteger timesRepeat:[ effectPoolCollection := effectPoolCollection copyWith: (probabilisticEvent event)] ]
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
