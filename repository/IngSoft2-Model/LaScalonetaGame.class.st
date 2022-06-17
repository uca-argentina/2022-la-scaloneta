Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'spaceShips',
		'hasEnded',
		'spaceShipPositions',
		'spaceShipCurrentTurn',
		'cardHandlers',
		'deck',
		'lastCardPlayed',
		'lastTilePlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LaScalonetaGame class >> assertValidNumberOfSpaceShips: aSpaceShipsCollection [

	aSpaceShipsCollection isEmpty ifTrue: [ 
		Error signal: 'La Scaloneta Game must have at least one spaceship!' ]
]

{ #category : #'instance creation' }
LaScalonetaGame class >> playedBy: spaceShips on: board rolling: dice usingCardsFrom: aDeck [

	self assertValidNumberOfSpaceShips: spaceShips.

	^ self new
		  initializeWith: board
		  rolling: dice
		  playedBy: spaceShips
		  usingCardsFrom: aDeck.
]

{ #category : #adding }
LaScalonetaGame >> add: aSpaceShipPosition [

	spaceShipPositions add: aSpaceShipPosition
]

{ #category : #adding }
LaScalonetaGame >> addEffectOf: aCard to: aSpaceShip [

	(self cardHandlerOf: aSpaceShip) addEffectOf: aCard.
	lastCardPlayed:= aCard.
]

{ #category : #adding }
LaScalonetaGame >> addInHand: aCard to: aSpaceShip [

	(self cardHandlerOf: aSpaceShip) addToHand: aCard.
]

{ #category : #adding }
LaScalonetaGame >> addToAllEffectOf: aCard [

	spaceShips do:[:aSpaceship | self addEffectOf: aCard to:aSpaceship].
]

{ #category : #'as yet unclassified' }
LaScalonetaGame >> affect: aTarget using: aCard by: aSpaceShip [

	aCard applyTo: aTarget in: self from: aSpaceShip.
	self removeFromHand: aCard of: aSpaceShip.
]

{ #category : #'as yet unclassified' }
LaScalonetaGame >> applyEffectOfTheLastPlayedTileTo: aSpaceship from: aCard [

	lastTilePlayed applyTo: aSpaceship for: self.
	lastCardPlayed:= aCard.
]

{ #category : #private }
LaScalonetaGame >> applyEffectTo: aSpaceShips [

	lastTilePlayed := (self board tiles at: (self positionOf: aSpaceShips first) tileNumber).

	(self board tiles at: (self positionOf: aSpaceShips first) tileNumber)
		applyTo: aSpaceShips
		for: self.
		
	
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	self hasEnded ifTrue: [ 
		Error signal: 'La Scaloneta Game has already ended!' ]
]

{ #category : #asserting }
LaScalonetaGame >> assertSpaceShipTurn: aSpaceShip [

	spaceShipCurrentTurn = aSpaceShip ifFalse: [ 
		Error signal: 'Its not your turn!' ]
]

{ #category : #accessing }
LaScalonetaGame >> board [ 

	^ board
]

{ #category : #accessing }
LaScalonetaGame >> cardHandlerOf: aSpaceShip [

	| spaceShipCardHandler |
	spaceShipCardHandler := cardHandlers
		detect: [ :handler | handler spaceShip = aSpaceShip ].
	^ spaceShipCardHandler
]

{ #category : #initialization }
LaScalonetaGame >> distributeCardsFrom: aDeck [

	cardHandlers
		do: [ :cardHandler | 
			cardHandler addToHand: aDeck pick.
			cardHandler addToHand: aDeck pick ]
]

{ #category : #action }
LaScalonetaGame >> giveCardFromDeckTo: aSpaceShip [

	| card |
	
	card := deck pick.

	(self cardHandlerOf: aSpaceShip) addToHand: card.
]

{ #category : #testing }
LaScalonetaGame >> hasEnded [

	^ hasEnded 
]

{ #category : #initialization }
LaScalonetaGame >> initializeWith: aBoard rolling: aDiceCollection playedBy: aSpaceShips usingCardsFrom: aDeck [

	board := aBoard.
	diceCollection := aDiceCollection.
	spaceShips := aSpaceShips.
	hasEnded := false.
	spaceShipPositions := board initializePositionsFor: aSpaceShips.
	spaceShipCurrentTurn := spaceShips first.
	deck := aDeck.
	cardHandlers := aSpaceShips
		collect: [ :spaceShip | CardHandler with: spaceShip ].
	lastCardPlayed := nil.
	lastTilePlayed := NoEffect new.
	self distributeCardsFrom: aDeck.
]

{ #category : #private }
LaScalonetaGame >> laScalonetaGameContinuesDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip [

	(board spaceShipPositionIsTheLastOne: (self positionOf: aSpaceShip))
		ifTrue: [ hasEnded := true ]
		ifFalse: [ 
			self applyEffectTo: spaceShips.
			self nextSpaceShipTurn: aSpaceShip ]
]

{ #category : #accessing }
LaScalonetaGame >> lastCardPlayed [

	^lastCardPlayed
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip withParsecs: aParsecs [

	| newPosition oldPosition |
	oldPosition := self positionOf: aSpaceShip.

	newPosition := board movePasecs: aParsecs from: oldPosition.

	self add: newPosition
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip withRolling: aResult [

	| newPosition oldPosition tiles |
	
	tiles := aResult + (self cardHandlerOf: aSpaceShip) totalEffectsOnSpaceShip.
	
	oldPosition := self positionOf: aSpaceShip.

	newPosition := board move: tiles from: oldPosition.
	
	self add: newPosition
]

{ #category : #private }
LaScalonetaGame >> moveToFirstPositionOnSameLap: aSpaceShip [

	self add: (SpaceShipPosition
			 ofSpaceShip: (self positionOf: aSpaceShip) spaceShip
			 tileNumber: board firstTileNumber
			 lap: (self positionOf: aSpaceShip) lap)
]

{ #category : #playing }
LaScalonetaGame >> nextSpaceShipTurn: aSpaceShip [

	spaceShips := (spaceShips reject: [ :each | each = aSpaceShip ])
	              , { aSpaceShip }.

	spaceShipCurrentTurn := spaceShips first
]

{ #category : #playing }
LaScalonetaGame >> playNextTurn [

	self playTurnFor: spaceShipCurrentTurn
]

{ #category : #private }
LaScalonetaGame >> playTurnFor: aSpaceShip [

	| rollingResult |
	self assertSpaceShipTurn: aSpaceShip.
	self assertGameHasNotEnded.

	rollingResult := diceCollection roll.

	self move: aSpaceShip withRolling: rollingResult.
	self laScalonetaGameContinuesDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | 
		   position spaceShip = aSpaceShip ]) last
]

{ #category : #'as yet unclassified' }
LaScalonetaGame >> quantityOfCardInHandOf: aSpaceShip [

	^ (self cardHandlerOf: aSpaceShip) quantityOfCardsInHand
]

{ #category : #removing }
LaScalonetaGame >> removeFromHand: aCard of: aSpaceShip [

	(self cardHandlerOf: aSpaceShip ) removeFromHand: aCard.
	
]

{ #category : #removing }
LaScalonetaGame >> removeToAllSpaceShipsPermanent: card [

	| handlersWithCardToBeRemoved |
	
	handlersWithCardToBeRemoved := cardHandlers
		select: [ :cardHandler | cardHandler affectsSpaceShip: card ].
	
	(handlersWithCardToBeRemoved isEmpty) ifTrue: [ Error signal: 'There is no Card Handler with the card to be removed' ].
	
	handlersWithCardToBeRemoved
		do: [ :cardHandler | cardHandler removeEffectOf: card ].
		lastCardPlayed := CancellationCard  new.
]

{ #category : #accessing }
LaScalonetaGame >> spaceShips [

	^spaceShips
]

{ #category : #classification }
LaScalonetaGame >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := spaceShips collect: [ :aSpaceShip | 
		                       self positionOf: aSpaceShip ].

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA >= spaceShipB ]
]

{ #category : #asserting }
LaScalonetaGame >> validate: aSpaceShip has: aCard [ 

		| spaceShipCardHandler |
	spaceShipCardHandler := self cardHandlerOf: aSpaceShip.
	 (spaceShipCardHandler hasInHand: aCard)
        ifFalse: [ Error signal: 'The SpaceShip cannot throw this card because he does not have it'].
]

{ #category : #asserting }
LaScalonetaGame >> validateThrowOfAPermanent: aCard from: aSpaceShip [

	self assertSpaceShipTurn: aSpaceShip.
	self validate: aSpaceShip has: aCard.
]

{ #category : #asserting }
LaScalonetaGame >> validateThrowOfAnInstantaneous: aCard from: aSpaceShip [
		self validate: aSpaceShip has: aCard.
]

{ #category : #accessing }
LaScalonetaGame >> winner [

	self hasEnded
		ifFalse: [ 
		Error signal: 'There is no winner as the game has not ended yet.' ]
		ifTrue: [ ^ self spaceShipsPositionsRanking first spaceShip ]
]
