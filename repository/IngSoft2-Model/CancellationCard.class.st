Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
CancellationCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsACancellationCardPlay.
]
