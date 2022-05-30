Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
AtomicBombEffect >> move: aSpaceShips for: aGame [

	^ aSpaceShips do: [ :spaceShip | 
		  aGame moveToFirstPositionOnSameLap: spaceShip ]
]
