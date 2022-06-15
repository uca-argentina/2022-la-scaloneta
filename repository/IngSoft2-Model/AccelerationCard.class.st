Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyTo: aTarget in: aGame from: aSpaceShip [ 

	aGame validateThrowOfAPermanent: self  from: aSpaceShip.
	aGame addToAllEffectOf:self.
]

{ #category : #accessing }
AccelerationCard >> effect [

	^ 1.
]
