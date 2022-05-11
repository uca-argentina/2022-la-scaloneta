Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #private }
WormHoleEffect >> moveSpaceShip: aSpaceShip for: aGame [

	| quantityOfSquaresAdvanced auxLap newLap newPosition |
	
"	quantityOfSquaresAdvanced  :=  (((aGame positionOf: aSpaceShip) lap - 1) * (aGame board tiles size)) - 4 + (aGame positionOf: aSpaceShip) tileNumber.
	
	auxLap := ((quantityOfSquaresAdvanced - 1)  // (aGame board tiles size) + 1).
	
	newLap := auxLap min: (aGame laps).
	
	newPosition := quantityOfSquaresAdvanced % (aGame board tiles size).
	
	(newPosition = 0 | (auxLap > (aGame laps))) ifTrue: [ newPosition := (aGame board tiles size) ].
	
 	aGame addPosition: ( SpaceShipPosition
								ofSpaceShip: ( (aGame positionOf: aSpaceShip) spaceShip )
								tileNumber: newPosition
								lap: newLap
							) "
							
						^ aGame movePlayer: aSpaceShip  withRollingResult: -4
]
