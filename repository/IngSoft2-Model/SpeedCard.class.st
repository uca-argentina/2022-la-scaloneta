Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyTo: aTarget in: aGame from: aSpaceShip [

	aGame validateThrowOfAPermanent: self from: aSpaceShip.
	aGame addEffectOf: self to: aTarget.
]

{ #category : #accessing }
SpeedCard >> effect [

	^1.
]
