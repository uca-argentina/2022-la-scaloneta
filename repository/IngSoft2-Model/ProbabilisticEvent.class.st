Class {
	#name : #ProbabilisticEvent,
	#superclass : #Object,
	#instVars : [
		'event',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ProbabilisticEvent class >> assertProbabilitiesAreBetwenZeroAndOne: probability [

	(probability  between: 0 and: 1) ifFalse: [ 
			Error signal: 'Probabilities must be betwen 0 and 1!' ].
]

{ #category : #initialize }
ProbabilisticEvent class >> with: event and: probability [

	self assertProbabilitiesAreBetwenZeroAndOne: probability.

	^ self new
		  initializeWith: event
		  and: probability
]

{ #category : #accessing }
ProbabilisticEvent >> event [

	^ event
]

{ #category : #initialization }
ProbabilisticEvent >> initializeWith: aEvent and: aProbability [

	event := aEvent.
	probability := aProbability
]

{ #category : #accessing }
ProbabilisticEvent >> probability [

	^ probability
]
