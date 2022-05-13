Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
WormHoleEffect >> moveSpaceShip: aSpaceShip for: aGame [
		
		^ aGame movePlayer: aSpaceShip  withRollingResult: -4
]
