Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aTarget in: aGame from: aSpaceShip [

	aGame validateThrowOfAnInstantaneous: self from: aSpaceShip.
	aGame removeToAllSpaceShipsPermanent: aTarget.
]
