Class {
	#name : #BoardDistanceInTileResolver,
	#superclass : #Object,
	#instVars : [
		'boardSize',
		'parsecs',
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardDistanceInTileResolver class >> from: aDistance with: aBoardSize and: aParsecs [
	
	^ self new initializeFrom: aDistance with: aBoardSize and: aParsecs.
]

{ #category : #initialization }
BoardDistanceInTileResolver >> initializeFrom: aDistance with: aBoardSize and: aParsecs [

	distance := aDistance.
	boardSize := aBoardSize.
	parsecs := aParsecs
]

{ #category : #resolving }
BoardDistanceInTileResolver >> resolve [

	^ distance accept: self
]

{ #category : #private }
BoardDistanceInTileResolver >> visitAsDistanceInParsecs: aDistance [

	^ (aDistance amount / (parsecs / boardSize)) floor
]

{ #category : #private }
BoardDistanceInTileResolver >> visitAsDistanceInTiles: aDistance [

	^ aDistance amount
]
