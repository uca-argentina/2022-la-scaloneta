Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyTo: aTarget in: aGame from: aSpaceShip [

	aGame addEffectOf: self to: aTarget from: aSpaceShip. 
]

{ #category : #accessing }
OverloadCard >> effect [

	^-2.
]
