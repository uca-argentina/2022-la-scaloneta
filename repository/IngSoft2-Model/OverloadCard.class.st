Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> applyTo: aTarget in: aGame from: aPlayer [

	aGame validateThrowOfAPermanent: self from: aPlayer.
	aGame addEffectOf: self to: aTarget. 
]

{ #category : #accessing }
OverloadCard >> effect [

	^-2.
]
