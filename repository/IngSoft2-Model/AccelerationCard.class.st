Class {
	#name : #AccelerationCard,
	#superclass : #Card,
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
