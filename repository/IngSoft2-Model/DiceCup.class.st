Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
DiceCup class >> assertValid: aDiceCollection [

	aDiceCollection size < 1 ifTrue: [ Error signal: 'Number of dice should be 1 or more' ]
]

{ #category : #'instance creation' }
DiceCup class >> withAll: dice [

		self assertValid: dice.
      ^ self new initializeWithAll: dice
]

{ #category : #initialization }
DiceCup >> initializeWithAll: aDice [

      dice := aDice
]

{ #category : #rolling }
DiceCup >> roll [

      ^ dice sum: [:die | die roll ]

]
