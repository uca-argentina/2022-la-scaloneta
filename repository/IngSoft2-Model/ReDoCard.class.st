Class {
	#name : #ReDoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
ReDoCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsAReDoCardPlay.
]
