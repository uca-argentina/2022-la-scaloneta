Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
SpeedUpEffect >> applyTo: aSpaceShips for: aGame [

	^ aGame move: aSpaceShips first during: (DistanceInTiles with: 4)
]
