Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
SpeedUpEffect >> move: aSpaceShips for: aGame [

	^ aGame move: aSpaceShips first withRolling: 4
]
