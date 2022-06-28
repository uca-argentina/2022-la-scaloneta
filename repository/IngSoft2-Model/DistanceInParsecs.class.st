Class {
	#name : #DistanceInParsecs,
	#superclass : #Object,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DistanceInParsecs class >> assertAmountIsHigherThanZero: amount [

	amount > 0 ifFalse: [ 
		Error signal: 'Parsecs amount should be greater than zero' ]
]

{ #category : #'instance creation' }
DistanceInParsecs class >> with: amount [

	self assertAmountIsHigherThanZero:  amount.
	^ self new initializeWith: amount
]

{ #category : #comparing }
DistanceInParsecs >> <= aParsec [

	^ self valueAsParsec <= aParsec valueAsParsec
]

{ #category : #visiting }
DistanceInParsecs >> accept: aVisitor [ 
	
	^ aVisitor visitAsDistanceInParsecs: self
]

{ #category : #accessing }
DistanceInParsecs >> amount [

	^ amount
]

{ #category : #initialization }
DistanceInParsecs >> initializeWith: valueInParsecs [

	amount := valueInParsecs
]

{ #category : #action }
DistanceInParsecs >> valueAsParsec [

	^ amount
]
