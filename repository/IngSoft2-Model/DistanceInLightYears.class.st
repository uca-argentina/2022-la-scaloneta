Class {
	#name : #DistanceInLightYears,
	#superclass : #Object,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DistanceInLightYears class >> assertAmountIsHigherThanZero: amount [

	amount > 0 ifFalse: [ 
		Error signal: 'Light Years amount should be greater than zero' ]
]

{ #category : #'instance creation' }
DistanceInLightYears class >> with: amount [

	self assertAmountIsHigherThanZero:  amount.
	^ self new initializeWith: amount
]

{ #category : #comparing }
DistanceInLightYears >> <= aLightYear [

	^ self valueAsParsec <= aLightYear valueAsParsec.
]

{ #category : #accessing }
DistanceInLightYears >> amount [

	^ amount
]

{ #category : #initialization }
DistanceInLightYears >> initializeWith: amountInLightYears [

	amount := amountInLightYears
]

{ #category : #action }
DistanceInLightYears >> valueAsParsec [

	^ amount / 3
]
