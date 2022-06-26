Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RepeatCard >> applyIn: aGame from: aSpaceShip [

	aGame applyEffectOfTheLastPlayedTileUsing: self from: aSpaceShip
]
