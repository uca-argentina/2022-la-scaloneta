Class {
	#name : #ErrorThrowerCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
ErrorThrowerCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsAnErrorThrowerCardPlay.
]
