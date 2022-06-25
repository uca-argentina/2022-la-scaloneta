Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aCard in: aGame from: aSpaceShip [

	aGame removeToAllSpaceShipsPermanent: aCard from: aSpaceShip using: self.
]
