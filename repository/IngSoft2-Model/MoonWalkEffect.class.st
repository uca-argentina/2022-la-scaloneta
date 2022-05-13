Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
MoonWalkEffect >> moveSpaceShip: aSpaceShips for: aGame with: n [
		
		^ aGame movePlayer: aSpaceShips allButFirst withRollingResult: n
]
