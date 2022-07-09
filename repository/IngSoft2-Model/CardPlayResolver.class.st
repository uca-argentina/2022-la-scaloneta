Class {
	#name : #CardPlayResolver,
	#superclass : #Object,
	#instVars : [
		'cardPlay',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayResolver class >> from: aCardPlay in: aGame [
	
	^ self new initializeFrom: aCardPlay in: aGame.
]

{ #category : #initialization }
CardPlayResolver >> initializeFrom: aCardPlay in: aGame [

	cardPlay := aCardPlay.
	game := aGame
]

{ #category : #resolving }
CardPlayResolver >> resolve [

	^ cardPlay card accept: self
]

{ #category : #asserting }
CardPlayResolver >> validate: aSpaceShip has: aCard [

	| cardsHand |
	cardsHand := game cardsHandOf: aSpaceShip.
	(cardsHand hasInHand: aCard) ifFalse: [ 
		Error signal:
			'The SpaceShip cannot throw this card because he does not have it' ]
]

{ #category : #validating }
CardPlayResolver >> validateIfIsPossibleToCancellACard: cardsHandCollection [

	cardsHandCollection isEmpty ifTrue: [ 
		Error signal: 'There is no CardsHand with the card to be removed' ]
]

{ #category : #visiting }
CardPlayResolver >> visitAsACancellationCardPlay [

	| filteredCardsHandsCollection playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	self validate: playedBy has: card.
	filteredCardsHandsCollection := game cardsHands select: [ :cardsHand | 
		                                cardsHand affectsSpaceShip: target ].
	self validateIfIsPossibleToCancellACard: filteredCardsHandsCollection.
	filteredCardsHandsCollection do: [ :cardsHand | 
		cardsHand removeEffectOf: target ].
	game updateLastCardPlayed: card.
	(game cardsHandOf: playedBy) removeFromHand: card
]

{ #category : #visiting }
CardPlayResolver >> visitAsAReDoCardPlay [

	| newCardPlay playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	self validate: playedBy has: card.
	newCardPlay := CardPlay
		               with: game lastCardPlayed
		               appliedTo: target
		               by: playedBy.
	game apply: newCardPlay.
	(game cardsHandOf: playedBy) removeFromHand: card
]

{ #category : #visiting }
CardPlayResolver >> visitAsARepeatCardPlay [

	| playedBy card |
	playedBy := cardPlay playedBy.
	card := cardPlay card.

	self validate: playedBy has: card.
	game lastTilePlayed applyTo: game turnsSequence spaceShips for: game.
	game updateLastCardPlayed: card.
	(game cardsHandOf: playedBy) removeFromHand: card
]

{ #category : #visiting }
CardPlayResolver >> visitAsASpeedCardPlay [

	| playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	game turnsSequence assertSpaceShipTurn: playedBy.
	self validate: playedBy has: card.
	(game cardsHandOf: target) addEffectOf: card.
	game updateLastCardPlayed: card.
	(game cardsHandOf: playedBy) removeFromHand: card
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnAccelerationCardPlay [

	| playedBy card |
	playedBy := cardPlay playedBy.
	card := cardPlay card.

	game turnsSequence assertSpaceShipTurn: playedBy.
	self validate: playedBy has: card.
	game turnsSequence spaceShips do: [ :aSpaceship | 
		(game cardsHandOf: aSpaceship) addEffectOf: card ].
	game updateLastCardPlayed: card.
	(game cardsHandOf: playedBy) removeFromHand: card
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnOverloadCardPlay [

	| playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	game turnsSequence assertSpaceShipTurn: playedBy.
	self validate: playedBy has: card.
	(game cardsHandOf: target) addEffectOf: cardPlay card.
	game updateLastCardPlayed: card.
	(game cardsHandOf: playedBy) removeFromHand: card
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnvisitAsAnNoCardPlayedYetToApplyReDoCardErrorThrowerCardPlay [

	Error signal:
		'This card cannot be played because there was no card played before'
]
