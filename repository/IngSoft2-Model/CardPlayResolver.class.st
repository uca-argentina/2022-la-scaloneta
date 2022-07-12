Class {
	#name : #CardPlayResolver,
	#superclass : #Object,
	#instVars : [
		'game',
		'lastCardPlayed',
		'cardPlay'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayResolver class >> with: aGame [
	
	^ self new initializeWith: aGame.
]

{ #category : #initialization }
CardPlayResolver >> initializeWith: aGame [

	game := aGame.
	lastCardPlayed := NoCardPlayedYetErrorCard new
]

{ #category : #resolving }
CardPlayResolver >> resolve: aCardPlay [
	
	cardPlay := aCardPlay.

	^ aCardPlay card accept: self
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
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy

]

{ #category : #visiting }
CardPlayResolver >> visitAsAReDoCardPlay [

	| newCardPlay playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	self validate: playedBy has: card.
	newCardPlay := CardPlay with: lastCardPlayed appliedTo: target by: playedBy.
	game apply: newCardPlay.
	game removeFromHand: card to: playedBy
]

{ #category : #visiting }
CardPlayResolver >> visitAsARepeatCardPlay [

	| playedBy card |
	playedBy := cardPlay playedBy.
	card := cardPlay card.

	self validate: playedBy has: card.
	game lastTilePlayed applyTo: game spaceShips for: game.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #visiting }
CardPlayResolver >> visitAsASpeedCardPlay [

	| playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	game assertIsTurnOf: playedBy.
	self validate: playedBy has: card.
	(game cardsHandOf: target) addEffectOf: card.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnAccelerationCardPlay [

	| playedBy card |
	playedBy := cardPlay playedBy.
	card := cardPlay card.

	game assertIsTurnOf: playedBy.
	self validate: playedBy has: card.
	game spaceShips do: [ :aSpaceship | (game cardsHandOf: aSpaceship) addEffectOf: card ].
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnOverloadCardPlay [

	| playedBy target card |
	playedBy := cardPlay playedBy.
	target := cardPlay target.
	card := cardPlay card.

	game assertIsTurnOf: playedBy.
	self validate: playedBy has: card.
	(game cardsHandOf: target) addEffectOf: cardPlay card.
	lastCardPlayed := card.
	game removeFromHand: card to: playedBy
]

{ #category : #visiting }
CardPlayResolver >> visitAsAnvisitAsAnNoCardPlayedYetToApplyReDoCardErrorThrowerCardPlay [

	Error signal:
		'No card played yet!'
]
