Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
AccelerationCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsAnAccelerationCardPlay.
]

{ #category : #accessing }
AccelerationCard >> effect [

	^ 1.
]
