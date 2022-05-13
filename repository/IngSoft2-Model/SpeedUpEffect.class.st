Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
SpeedUpEffect >> moveSpaceShip: aSpaceShip for: aGame [
		
		^ aGame movePlayer: aSpaceShip  withRollingResult: 4
]
