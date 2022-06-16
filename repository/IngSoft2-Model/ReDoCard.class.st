Class {
	#name : #ReDoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
ReDoCard >> applyTo: aTarget in: aGame from: aSpaceShip [

	| newCard |
	self validateIfIsPossibleToPlayReDoCardAt: aGame.
	newCard := aGame lastCardPlayed.
	aGame validate: aSpaceShip has: self.
	aGame addInHand: newCard to: aSpaceShip.
	aGame affect: aTarget using: newCard by: aSpaceShip
]

{ #category : #action }
ReDoCard >> validateIfIsPossibleToPlayReDoCardAt: aGame [

	aGame lastCardPlayed ifNil: [ Error signal: 'This card cannot be played because there was no card played before' ]
]
