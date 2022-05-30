Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
WormHoleEffect >> moveSpaceShip: aSpaceShips for: aGame [

	^ aGame moveSpaceShip: aSpaceShips first withRollingResult: -4
]
