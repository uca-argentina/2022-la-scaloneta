Class {
	#name : #OverloadCard,
	#superclass : #Card,
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
