Class {
	#name : #DeliveryCardEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
DeliveryCardEffect >> applyTo: aSpaceShips for: aGame [

	aGame board giveCardFromDeckTo: aSpaceShips.

	
]
