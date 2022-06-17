Class {
	#name : #Parsecs,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Parsecs class >> assertValueIsHigherThanZero: value [

	value > 0 ifFalse: [ 
		Error signal: 'Parsecs value should be greater than zero' ]
]

{ #category : #'instance creation' }
Parsecs class >> with: value [

	self assertValueIsHigherThanZero:  value.
	^ self new initializeWith: value
]

{ #category : #comparing }
Parsecs >> <= aParsec [

	^self value <= aParsec value
]

{ #category : #action }
Parsecs >> convertToParsecs [

      ^ value
]

{ #category : #initialization }
Parsecs >> initializeWith: valueInParsecs [

      value := valueInParsecs 
]

{ #category : #accessing }
Parsecs >> value [

^value
]
