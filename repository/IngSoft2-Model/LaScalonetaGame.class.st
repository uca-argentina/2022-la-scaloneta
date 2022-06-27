Class {
	#name : #LaScalonetaGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'hasEnded',
		'spaceShipPositions',
		'turnHandler',
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
LaScalonetaGame >> addEffectOf: aCard to: aSpaceShip from: spaceShip [

	self validateThrowOfAPermanent: aCard from: spaceShip.
	(self cardHandlerOf: aSpaceShip) addEffectOf: aCard.
	lastCardPlayed := aCard
]

{ #category : #adding }
LaScalonetaGame >> addInHand: aCard to: aSpaceShip [

	(self cardHandlerOf: aSpaceShip) addToHand: aCard
]

{ #category : #adding }
LaScalonetaGame >> addToAllEffectOf: aCard from: spaceShip [

	turnHandler spaceShips do: [ :aSpaceship | 
		self addEffectOf: aCard to: aSpaceship from: spaceShip]
]

{ #category : #action }
LaScalonetaGame >> affect: aTarget using: aCard by: aSpaceShip [

	aCard applyTo: aTarget in: self from: aSpaceShip.
	(self cardHandlerOf: aSpaceShip) removeFromHand: aCard.
]

{ #category : #action }
LaScalonetaGame >> apply: aCard by: aSpaceShip [

	aCard applyIn: self from: aSpaceShip.
	(self cardHandlerOf: aSpaceShip) removeFromHand: aCard.
]

{ #category : #action }
LaScalonetaGame >> applyEffectOfTheLastPlayedTileUsing: aCard from: aSpaceShip [

	self validate: aSpaceShip has: aCard.
	lastTilePlayed applyTo: (turnHandler spaceShips) for: self.
	lastCardPlayed := aCard
]

{ #category : #private }
LaScalonetaGame >> applyEffectTo: aSpaceShips [

	lastTilePlayed := (self board tiles at: (self positionOf: turnHandler currentTurn) tileNumber).
	lastTilePlayed applyTo: aSpaceShips for: self.
]

{ #category : #asserting }
LaScalonetaGame >> assertGameHasNotEnded [

	self hasEnded ifTrue: [ 
		Error signal: 'La Scaloneta Game has already ended!' ]
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
	(self cardHandlerOf: aSpaceShip) addToHand: card
]

{ #category : #testing }
LaScalonetaGame >> hasEnded [

	^ hasEnded 
]

{ #category : #initialization }
LaScalonetaGame >> initializeWith: aBoard rolling: aDiceCollection playedBy: aSpaceShips usingCardsFrom: aDeck [

	board := aBoard.
	diceCollection := aDiceCollection.
	hasEnded := false.
	spaceShipPositions := board startingPositionsForAll: aSpaceShips.
	turnHandler := TurnHandler with: aSpaceShips.
	deck := aDeck.
	cardHandlers := aSpaceShips
		collect: [ :spaceShip | CardHandler with: spaceShip ].
	lastCardPlayed := nil.
	lastTilePlayed := NoEffect new.
	self distributeCardsFrom: aDeck.
]

{ #category : #accessing }
LaScalonetaGame >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #private }
LaScalonetaGame >> move: aSpaceShip during: aDistance [

	| oldPosition newPosition |
	oldPosition := self positionOf: aSpaceShip.
	newPosition := board move: aDistance from: oldPosition.
	spaceShipPositions add: newPosition
]

{ #category : #private }
LaScalonetaGame >> moveToFirstPositionOnSameLap: aSpaceShip [

	| oldPosition newPosition |
	oldPosition := self positionOf: aSpaceShip.
	newPosition := board moveToFirstPositionOnSameLapFrom: oldPosition.
	spaceShipPositions add: newPosition
]

{ #category : #playing }
LaScalonetaGame >> playNextTurn [

	self playTurnFor: turnHandler currentTurn.
]

{ #category : #private }
LaScalonetaGame >> playTurnFor: aSpaceShip [

	| rollingResult |
	turnHandler assertSpaceShipTurn: aSpaceShip.
	self assertGameHasNotEnded.
	rollingResult := diceCollection roll.
	self move: aSpaceShip during: (DistanceInTiles with: (rollingResult + (self cardHandlerOf: aSpaceShip) totalEffectsOnSpaceShip)).
	self selfContinuesDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip
]

{ #category : #accessing }
LaScalonetaGame >> positionOf: aSpaceShip [

	^ (spaceShipPositions select: [ :position | 
		   position spaceShip = aSpaceShip ]) last
]

{ #category : #removing }
LaScalonetaGame >> removeToAllSpaceShipsPermanent: card from: aSpaceShip using: aCard [

	| handlersWithCardToBeRemoved |
	
	self validate: aSpaceShip has: aCard.
	
	handlersWithCardToBeRemoved := cardHandlers
		select: [ :cardHandler | cardHandler affectsSpaceShip: card ].
	
	(handlersWithCardToBeRemoved isEmpty) ifTrue: [ Error signal: 'There is no Card Handler with the card to be removed' ].
	
	handlersWithCardToBeRemoved
		do: [ :cardHandler | cardHandler removeEffectOf: card ].
		lastCardPlayed := CancellationCard  new.
]

{ #category : #private }
LaScalonetaGame >> selfContinuesDependingOnWhetherTheSpaceShipWonOrNot: aSpaceShip [

	(board spaceShipPositionIsTheLastOne: (self positionOf: aSpaceShip))
		ifTrue: [ hasEnded := true ]
		ifFalse: [ 
			self applyEffectTo: (turnHandler spaceShips).
			turnHandler nextSpaceShipTurn: aSpaceShip ]
]

{ #category : #classification }
LaScalonetaGame >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := (turnHandler spaceShips) collect: [ :aSpaceShip | 
		                       self positionOf: aSpaceShip ].

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB | 
		  spaceShipA >= spaceShipB ]
]

{ #category : #asserting }
LaScalonetaGame >> validate: aSpaceShip has: aCard [

	| spaceShipCardHandler |
	spaceShipCardHandler := self cardHandlerOf: aSpaceShip.
	(spaceShipCardHandler hasInHand: aCard) ifFalse: [ 
		Error signal:'The SpaceShip cannot throw this card because he does not have it' ]
]

{ #category : #asserting }
LaScalonetaGame >> validateThrowOfAPermanent: aCard from: aSpaceShip [

	turnHandler assertSpaceShipTurn: aSpaceShip.
	self validate: aSpaceShip has: aCard.
]

{ #category : #accessing }
LaScalonetaGame >> winner [

	self hasEnded
		ifFalse: [ Error signal: 'There is no winner as the game has not ended yet.' ]
		ifTrue: [ ^ self spaceShipsPositionsRanking first spaceShip ]
]
