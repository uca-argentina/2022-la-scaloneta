Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
WormHoleEffect >> move: aSpaceShips for: aGame [

	^ aGame move: aSpaceShips first withRolling: -4
]
