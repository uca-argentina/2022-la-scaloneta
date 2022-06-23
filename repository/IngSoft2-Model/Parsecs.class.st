Class {
	#name : #Parsecs,
	#superclass : #Object,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Parsecs class >> assertAmountIsHigherThanZero: amount [

	amount > 0 ifFalse: [ 
		Error signal: 'Parsecs amount should be greater than zero' ]
]

{ #category : #'instance creation' }
Parsecs class >> with: amount [

	self assertAmountIsHigherThanZero:  amount.
	^ self new initializeWith: amount
]

{ #category : #comparing }
Parsecs >> <= aParsec [

	^ self amount <= aParsec amount
]

{ #category : #accessing }
Parsecs >> amount [

	^ amount
]

{ #category : #action }
Parsecs >> convertToParsecs [

      ^ amount
]

{ #category : #initialization }
Parsecs >> initializeWith: valueInParsecs [

      amount := valueInParsecs 
]
