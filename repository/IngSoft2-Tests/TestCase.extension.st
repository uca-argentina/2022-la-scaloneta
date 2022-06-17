Extension { #name : #TestCase }

{ #category : #'*IngSoft2-Tests' }
TestCase >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]
