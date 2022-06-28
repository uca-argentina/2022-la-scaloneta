Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
OverloadCard >> accept: aVisitor [ 
	
	^ aVisitor visitAsAnOverloadCardPlay.
]

{ #category : #accessing }
OverloadCard >> effect [

	^ -2
]
