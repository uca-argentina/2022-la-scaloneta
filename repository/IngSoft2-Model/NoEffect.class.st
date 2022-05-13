Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
NoEffect >> moveSpaceShip: aSpaceShip for: aGame [
		
		^ aGame movePlayer: aSpaceShip withRollingResult: 0
]
