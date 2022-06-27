Class {
	#name : #DistanceInTiles,
	#superclass : #Object,
	#instVars : [
		'amount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DistanceInTiles class >> with: distanceAmountInTiles [

	^ self new initializeWith: distanceAmountInTiles
]

{ #category : #accessing }
DistanceInTiles >> amount [

	^ amount
]

{ #category : #initialization }
DistanceInTiles >> initializeWith: distanceAmountInTiles [

	amount := distanceAmountInTiles
]
