Class {
	#name : #SpaceShipPosition,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'tileNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceShipPosition class >> ofSpaceShip: aSpaceSip tileNumber: aTileNumber [ 

	^ self new initializeOfSpaceShip: aSpaceSip tileNumber: aTileNumber

]

{ #category : #'instance creation' }
SpaceShipPosition class >> startingOfSpaceShip: aSpaceShip forBoard: aBoard [

	^ self ofSpaceShip: aSpaceShip tileNumber: (aBoard firstPosition)

]

{ #category : #initialization }
SpaceShipPosition >> initializeOfSpaceShip: aSpaceShip tileNumber: aTileNumber [

	spaceShip := aSpaceShip.
	tileNumber := aTileNumber
]

{ #category : #accessing }
SpaceShipPosition >> spaceShip [

	^ spaceShip
]

{ #category : #accessing }
SpaceShipPosition >> tileNumber [ 

	^ tileNumber
]
