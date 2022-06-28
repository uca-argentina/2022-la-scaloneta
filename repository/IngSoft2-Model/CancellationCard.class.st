Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
CancellationCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsACancellationCardPlay.
]
