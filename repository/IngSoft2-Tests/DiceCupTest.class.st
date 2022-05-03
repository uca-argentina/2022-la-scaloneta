Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DiceCupTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
DiceCupTest >> testDiceCupCanNotInitializeIfEmpty [
	
	
	self
		should: [ 
				DiceCup withAll: {  }
			]
		raise: Error
		withMessage: 'A DiceCup should have at least one die.'
]
