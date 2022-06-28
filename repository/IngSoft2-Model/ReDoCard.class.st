Class {
	#name : #ReDoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
ReDoCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsAReDoCardPlay.
]
