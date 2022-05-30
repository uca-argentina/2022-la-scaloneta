Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
AtomicBombEffect >> moveSpaceShip: aSpaceShips for: aGame [

	^ aSpaceShips do: [ :spaceShip | 
		  aGame moveSpaceShipToFirstPositionOnSameLap: spaceShip ]
]
