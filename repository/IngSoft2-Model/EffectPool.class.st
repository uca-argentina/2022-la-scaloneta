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

{ #category : #initialization }
EffectPool >> initializeWith: probabilityEventList [

	effectPoolCollection := OrderedCollection new.

	probabilityEventList do: [ :probabilisticEvent | ((probabilisticEvent probability) *100) asInteger timesRepeat:[ effectPoolCollection add: (probabilisticEvent event)] ]
]

{ #category : #accessing }
EffectPool >> randomCollectionOfEffectsWith: length [

	| randomEffectsCollection |
	randomEffectsCollection := OrderedCollection new.

	1 to: length do: [ :i | 
	randomEffectsCollection add: self randomEffect ].

	^ randomEffectsCollection
]

{ #category : #accessing }
EffectPool >> randomEffect [

	^ effectPoolCollection atRandom.
]
