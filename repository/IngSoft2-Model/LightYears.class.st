Class {
	#name : #LightYears,
	#superclass : #Object,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LightYears class >> assertAmountIsHigherThanZero: amount [

	amount > 0 ifFalse: [ 
		Error signal: 'Light Years amount should be greater than zero' ]
]

{ #category : #'instance creation' }
LightYears class >> with: amount [

	self assertAmountIsHigherThanZero:  amount.
	^ self new initializeWith: amount
]

{ #category : #comparing }
LightYears >> <= aLightYear [

	^ self valueAsParsec <= aLightYear valueAsParsec
]

{ #category : #accessing }
LightYears >> amount [

	^ amount
]

{ #category : #initialization }
LightYears >> initializeWith: amountInLightYears [

      amount := amountInLightYears
]

{ #category : #action }
LightYears >> valueAsParsec [

	^ amount / 3
]
