Class {
	#name : #SpaceShipPosition,
	#superclass : #Object,
	#instVars : [
		'spaceShip',
		'tileNumber',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceShipPosition class >> ofSpaceShip: aSpaceSip tileNumber: aTileNumber lap: aLap [

	^ self new
		  initializeOfSpaceShip: aSpaceSip
		  tileNumber: aTileNumber
		  lap: aLap
]

{ #category : #'instance creation' }
SpaceShipPosition class >> startingOfSpaceShip: aSpaceShip forBoard: aBoard lap: aLap [

	^ self
		  ofSpaceShip: aSpaceShip
		  tileNumber: aBoard firstPosition
		  lap: aLap
]

{ #category : #comparing }
SpaceShipPosition >> >= aSpaceShipPosition [

	self lap = aSpaceShipPosition lap ifTrue: [ 
		^ self tileNumber >= aSpaceShipPosition tileNumber ].
	^ self lap >= aSpaceShipPosition lap
]

{ #category : #initialization }
SpaceShipPosition >> initializeOfSpaceShip: aSpaceShip tileNumber: aTileNumber lap: aLap [

	spaceShip := aSpaceShip.
	tileNumber := aTileNumber.
	lap := aLap
]

{ #category : #accessing }
SpaceShipPosition >> lap [
	
	^ lap
]

{ #category : #accessing }
SpaceShipPosition >> spaceShip [

	^ spaceShip
]

{ #category : #accessing }
SpaceShipPosition >> tileNumber [ 

	^ tileNumber
]
