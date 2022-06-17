Class {
	#name : #DistanceTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DistanceTests >> testLightYearsValueCannotBeLowerThanZero [
	self
		should: [ LightYears with: -1 ]
		raise: Error
		withMessage: 'Light Years value should be greater than zero'
]

{ #category : #running }
DistanceTests >> testParsecsCannotBeLowerThanZero [

	self
		should: [ Parsecs with: -1 ]
		raise: Error
		withMessage: 'Parsecs value should be greater than zero'
]
