Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
AtomicBombEffect >> applyTo: aSpaceShips for: aGame [

	^ aSpaceShips do: [ :spaceShip | 
		  aGame moveToFirstPositionOnSameLap: spaceShip ]
]
