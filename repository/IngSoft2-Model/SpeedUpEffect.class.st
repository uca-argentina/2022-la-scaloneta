Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
SpeedUpEffect >> moveSpaceShip: aSpaceShips for: aGame [
		
		^ aGame movePlayer: (aSpaceShips first) withRollingResult: 4
]
