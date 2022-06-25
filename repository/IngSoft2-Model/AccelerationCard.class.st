Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyIn: aGame from: aSpaceShip [ 

	aGame addToAllEffectOf: self from: aSpaceShip.
]

{ #category : #accessing }
AccelerationCard >> effect [

	^ 1.
]
