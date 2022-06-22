Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceCupTest >> testDiceCupShouldHaveAtLeastOneDie [

	self
		should: [ DiceCup withAll: {  } ]
		raise: Error
		withMessage: 'A DiceCup should have at least one die.'
]
