Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'diceCollection',
		'playersCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withBoard: aBoard diceCollection: aDiceCollection playerCollection: aPlayerCollection [

	^ self new 
				initializeWithBoard: aBoard 
				diceCollection: aDiceCollection
				playerCollection: aPlayerCollection
			
]

{ #category : #initialization }
Game >> initializeWithBoard: aBoard diceCollection: aDiceCollection playerCollection: aPlayerCollection [

		board := aBoard.
		diceCollection := aDiceCollection.
		playersCollection := aPlayerCollection
]

{ #category : #accessing }
Game >> players [

	^ playersCollection 
]
