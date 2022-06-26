Class {
	#name : #DistanceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DistanceTest >> testLightYearsValueCannotBeLowerThanZero [

	self
		should: [ DistanceInLightYears with: -1 ]
		raise: Error
		withMessage: 'Light Years amount should be greater than zero'
]

{ #category : #running }
DistanceTest >> testParsecsCannotBeLowerThanZero [

	self
		should: [ DistanceInParsecs with: -1 ]
		raise: Error
		withMessage: 'Parsecs amount should be greater than zero'
]
