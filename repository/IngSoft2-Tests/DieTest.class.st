Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DieTest >> testDiceCupRollResultIsTheSumOfTheRollOfEachIndividualDie [

	| die1 die2 die3 diceCup rollResult |
	die1 := LoadedDie with: 4.
	die2 := LoadedDie with: 7.
	die3 := LoadedDie with: 2.

	diceCup := DiceCup withAll: { 
			           die1.
			           die2.
			           die3 }.

	rollResult := diceCup roll.

	self assert: rollResult equals: 13
]

{ #category : #tests }
DieTest >> testDiceCupRollResultIsTheSumOfTheRollOfEachIndividualDieInItself [

	| die1 die2 die3 diceCup rollResult aDiceCup |
	die1 := LoadedDie with: 4.
	die2 := LoadedDie with: 7.
	die3 := LoadedDie with: 2.

	aDiceCup := DiceCup withAll: { 
			            die1.
			            die2 }.
	diceCup := DiceCup withAll: { 
			           die3.
			           aDiceCup }.

	rollResult := diceCup roll.

	self assert: rollResult equals: 13
]

{ #category : #tests }
DieTest >> testDieCannotBeCreatedWithNumberOfSidesMinorThanThree [

	self
		should: [ RandomDie with: 2 ]
		raise: Error
		withMessage: 'Number of faces should be greater than 2'
]

{ #category : #tests }
DieTest >> testDieRollResultIsBetweenOneAndTheNumberOfFaces [

	| numberOfSides die rollResult |
	numberOfSides := 6.
	die := RandomDie with: numberOfSides.

	rollResult := die roll.

	self assert: (rollResult between: 1 and: numberOfSides)
]

{ #category : #tests }
DieTest >> testLoadedDieCannotBeLoadedWithResultLowerThanOne [

	self
		should: [ LoadedDie with: -1 ]
		raise: Error
		withMessage: 'Die should be loaded with result greater than zero'
]

{ #category : #tests }
DieTest >> testLoadedDieRollsFiveWhenLoadedWithFive [

	| die rollResult |
	die := LoadedDie with: 5.

	rollResult := die roll.

	self assert: rollResult equals: 5
]
