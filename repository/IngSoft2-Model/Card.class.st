Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #visiting }
Card >> accept: aVisitor [

	self subclassResponsibility.
]
