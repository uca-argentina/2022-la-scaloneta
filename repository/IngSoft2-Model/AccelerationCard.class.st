Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyIn: aGame from: aSpaceShip [ 

	aGame validateThrowOfAPermanent: self  from: aSpaceShip.
	aGame addToAllEffectOf:self.
]

{ #category : #accessing }
AccelerationCard >> effect [

	^ 1.
]
