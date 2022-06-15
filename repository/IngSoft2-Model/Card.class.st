Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Card >> applyTo: aTarget in: aGame from: aPlayer [

	self subclassResponsibility.
]
