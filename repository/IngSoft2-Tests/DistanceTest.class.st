Class {
	#name : #DistanceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DistanceTest >> testLightYearsValueCannotBeLowerThanZero [
	self
		should: [ LightYears with: -1 ]
		raise: Error
		withMessage: 'Light Years value should be greater than zero'
]

{ #category : #running }
DistanceTest >> testParsecsCannotBeLowerThanZero [

	self
		should: [ Parsecs with: -1 ]
		raise: Error
		withMessage: 'Parsecs value should be greater than zero'
]
