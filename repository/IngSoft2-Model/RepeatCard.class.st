Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
RepeatCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsARepeatCardPlay.
]
