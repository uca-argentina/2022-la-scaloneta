Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
WormHoleEffect >> applyTo: aSpaceShips for: aGame [

	^ aGame move: aSpaceShips first withoutCardsEffect: -4
]
