Class {
	#name : #LightYears,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LightYears class >> assertValueIsHigherThanZero: value [

	value > 0 ifFalse: [ 
		Error signal: 'Light Years value should be greater than zero' ]
]

{ #category : #'instance creation' }
LightYears class >> with: value [

	self assertValueIsHigherThanZero:  value.
	^ self new initializeWith: value
]

{ #category : #action }
LightYears >> convertToParsecs [ 

      ^ value*3
]

{ #category : #initialization }
LightYears >> initializeWith: valueInLightYears [

      value := valueInLightYears
]
