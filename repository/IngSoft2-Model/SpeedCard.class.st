Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
SpeedCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsASpeedUpCardPlay.
]

{ #category : #action }
SpeedCard >> applyTo: aTarget in: aGame from: aSpaceShip [

	aGame addEffectOf: self to: aTarget from: aSpaceShip.
]

{ #category : #accessing }
SpeedCard >> effect [

	^ 1
]
