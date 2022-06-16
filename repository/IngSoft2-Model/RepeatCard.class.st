Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> applyTo: aTarget in: aGame from: aSpaceship [

	aGame validateThrowOfAnInstantaneous: self from: aSpaceship.
	aGame applyEffectOfTheLastPlayedSquareTo: (aGame spaceShips) from:self.
]
