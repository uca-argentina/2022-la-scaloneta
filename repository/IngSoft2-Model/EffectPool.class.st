Class {
	#name : #EffectPool,
	#superclass : #Object,
	#instVars : [
		'effectPoolCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
EffectPool class >> withEffects: effectsCollection andProbabilities: probabilitiesCollection [
	^self new initializeWithEffect: effectsCollection andProbabilities: probabilitiesCollection.
]

{ #category : #accessing }
EffectPool >> effectPoolCollection [

      ^  effectPoolCollection 
]

{ #category : #initialization }
EffectPool >> initializeWithEffect: effects andProbabilities: probabilities [ 
		|i j effect probability |

      effectPoolCollection := {}.
		i := 1.
		j := 1.

		
		[(i <= (effects size))] whileTrue:
			[
				effect := effects at: i.
				probability := probabilities at: i.
				[(j < (probability + 1) )] whileTrue:[
						
						effectPoolCollection := effectPoolCollection, { effect }.
						j := j+1.
					].
				i := i+1.
				j := 1.
			]
		
]

{ #category : #accessing }
EffectPool >> randomCollectionOfEffectsWithLength: length [

	|randomEffectsCollection|

	randomEffectsCollection :=  { }.
	
	(1 to: length) do: [ :i | randomEffectsCollection :=  randomEffectsCollection, { self randomEffect}].
	
	^randomEffectsCollection.
	
]

{ #category : #accessing }
EffectPool >> randomEffect [
	|effectIndex|
       
		effectIndex := (effectPoolCollection size)  atRandom.
		^self effectPoolCollection at: effectIndex .
]
