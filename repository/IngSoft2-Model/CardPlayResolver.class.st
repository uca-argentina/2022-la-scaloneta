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

	| spaceShipCardHandler |
	spaceShipCardHandler := game cardHandlerOf: aSpaceShip.
	(spaceShipCardHandler hasInHand: aCard) ifFalse: [ 
		Error signal:'The SpaceShip cannot throw this card because he does not have it' ]
]

{ #category : #visiting }
CardPlayResolver >> visitAsACancellationCardPlay [

	| handlersWithCardToBeRemoved |
	
	self validate: (cardPlay playedBy) has: (cardPlay card).
	
	handlersWithCardToBeRemoved := (game cardHandlers) select: [ :cardHandler | cardHandler affectsSpaceShip: (cardPlay target) ].
	
	(handlersWithCardToBeRemoved isEmpty) ifTrue: [ Error signal: 'There is no Card Handler with the card to be removed' ].
	
	handlersWithCardToBeRemoved	do: [ :cardHandler | cardHandler removeEffectOf: (cardPlay target) ].
	
	game updateLastCardPlayed: (cardPlay card)
]

{ #category : #visiting }
CardPlayResolver >> visitAsASpeedCardPlay [

	game turnHandler assertSpaceShipTurn: (cardPlay playedBy).
	self validate: (cardPlay playedBy) has: (cardPlay card).
	(game cardHandlerOf: cardPlay target) addEffectOf: cardPlay card.
	game updateLastCardPlayed: (cardPlay card)
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnAccelerationCardPlay [

	game turnHandler assertSpaceShipTurn: cardPlay playedBy.

	self validate: cardPlay playedBy has: cardPlay card.

	game turnHandler spaceShips do: [ :aSpaceship | 
		(game cardHandlerOf: aSpaceship) addEffectOf: cardPlay card ].

	game updateLastCardPlayed: cardPlay card
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnOverloadCardPlay [

	game turnHandler assertSpaceShipTurn: (cardPlay playedBy).
	self validate: (cardPlay playedBy) has: (cardPlay card).
	(game cardHandlerOf: cardPlay target) addEffectOf: cardPlay card.
	game updateLastCardPlayed: (cardPlay card)
]
