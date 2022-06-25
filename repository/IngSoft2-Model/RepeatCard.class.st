Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> applyIn: aGame from: aSpaceship [

	aGame validateThrowOfAnInstantaneous: self from: aSpaceship.
	aGame applyEffectOfTheLastPlayedTileTo: (aGame spaceShips) from:self.
]
