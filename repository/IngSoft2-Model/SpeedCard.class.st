Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
SpeedCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsASpeedCardPlay.
]

{ #category : #accessing }
SpeedCard >> effect [

	^ 1
]
