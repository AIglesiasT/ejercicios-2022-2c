!classDefinition: #TestMarsRoVerFunctions category: 'MarsRover'!
TestCase subclass: #TestMarsRoVerFunctions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRoVerFunctions methodsFor: 'Tests' stamp: 'AMIT 11/4/2022 16:26:13'!
test01AnEmptyCommandProduecesNoMovementFromTheRover

	self assertMarsRoverThatStartedFacing:#North withInitialPosition:0@0 respondsToCommands:'' andEndsfacing:#North andInPosition: 0@0.! !

!TestMarsRoVerFunctions methodsFor: 'Tests' stamp: 'AMIT 11/4/2022 16:26:13'!
test02TheRoverCanChangeDirections
	
	self assertMarsRoverThatStartedFacing:#North withInitialPosition: 0@0 respondsToCommands:'l' andEndsfacing:#West andInPosition: 0@0.! !

!TestMarsRoVerFunctions methodsFor: 'Tests' stamp: 'AMIT 11/4/2022 16:28:19'!
test03TheRoverCanMove

	self assertMarsRoverThatStartedFacing:#North withInitialPosition: 0@0 respondsToCommands:'f' andEndsfacing:#North andInPosition: 0@1.! !

!TestMarsRoVerFunctions methodsFor: 'Tests' stamp: 'AMIT 11/4/2022 16:28:39'!
test04TheRoverThrowsErrorAndDoesntMoveIfCommandIsNotUnderstoodWithoutAnyOtherCommands
	| aMarsRover |
	aMarsRover _ MarsRover withInitialDirection:#North andPosition: 0@0.
	
	self should: [ aMarsRover processCommands: '�' ] 
		raise: Error
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: MarsRover invalidCommandErrorMessage.
			self assert: (aMarsRover isFacing:#North at: 0@0).
		].! !

!TestMarsRoVerFunctions methodsFor: 'Tests' stamp: 'AMIT 11/4/2022 16:31:40'!
test05TheRoverCanMoveAndChangeDirections
	
	self assertMarsRoverThatStartedFacing:#North withInitialPosition: 0@0 respondsToCommands:'rb' andEndsfacing:#East andInPosition: -1@0.! !

!TestMarsRoVerFunctions methodsFor: 'Tests' stamp: 'AMIT 11/4/2022 16:37:06'!
test06TheRoverFollowsCommandIsUntilItDosntUnderstandIt
	| aMarsRover |
	aMarsRover _ MarsRover withInitialDirection:#North andPosition: 0@0.
	
	self should: [ aMarsRover processCommands: 'fff�' ] 
		raise: Error
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: MarsRover invalidCommandErrorMessage.
			self assert: (aMarsRover isFacing:#North at: 0@3).
		].! !

!TestMarsRoVerFunctions methodsFor: 'Tests' stamp: 'AMIT 11/4/2022 16:34:48'!
test07TheRoverCanStartAtAnyPositionAndAnyOrientation
	
	self assertMarsRoverThatStartedFacing:#South withInitialPosition: 0@1 respondsToCommands:'ffrrflfrb' andEndsfacing:#North andInPosition: -1@-1.! !


!TestMarsRoVerFunctions methodsFor: 'assertions' stamp: 'AMIT 11/4/2022 16:27:23'!
assertMarsRoverThatStartedFacing: anInitialCardinalPoint  withInitialPosition: anInitialPosition respondsToCommands:aCommandSequence andEndsfacing:aFinalCardinalPoint andInPosition: aFinalPosition
	
	| aMarsRover |
	aMarsRover _ MarsRover withInitialDirection: anInitialCardinalPoint andPosition: anInitialPosition .

	aMarsRover processCommands: aCommandSequence .
	
	self assert: (aMarsRover isFacing: aFinalCardinalPoint at: aFinalPosition).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'direction position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'ttt' stamp: 'AMIT 11/4/2022 14:35:34'!
processCommands: aCommandSequence
	(aCommandSequence isEmpty) ifTrue: [^self].
	aCommandSequence do:[:aCommandKey|
		(self isValidCommand:aCommandKey)
		ifTrue:[self move:aCommandKey]
		ifFalse:[self error: self class invalidCommandErrorMessage].]
	! !


!MarsRover methodsFor: 'testing-position' stamp: 'AMIT 11/4/2022 16:23:12'!
isFacing: aCardinalPoint at: aPoint

	^(position = aPoint) and: [direction isCardinalPoint: aCardinalPoint].
	! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:11:36'!
faceEast
	direction _ MarsRoverFacingEast of:self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:10:01'!
faceNorth
	direction _ MarsRoverFacingNorth of:self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:11:26'!
faceSouth
	direction _ MarsRoverFacingSouth of:self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:11:47'!
faceWest
	direction _ MarsRoverFacingWest of:self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:04:47'!
initializationWithStatringDirection:anInitialCardinalPoint andPosition: anInitialPosition.
	position _ anInitialPosition.
	direction _ MarsRoverDirection of: self facing: anInitialCardinalPoint! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 13:52:51'!
isValidCommand:aCommandKey
 ^(aCommandKey=$f or:aCommandKey=$b or:aCommandKey=$l or: aCommandKey=$r).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:46:10'!
move:aCommandKey
	(aCommandKey=$f)ifTrue:[self moveFowards].
	(aCommandKey=$b)ifTrue:[self moveBackwards].
	(aCommandKey=$l)ifTrue:[self rotateLeft].
	(aCommandKey=$r)ifTrue:[self rotateRight].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:04'!
moveBackwards
 position _ position + (direction moveBackwards).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:18'!
moveFowards
	
	position _ direction moveFowards + position .! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:05:27'!
moveXNegative
	^(-1@0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:05:31'!
moveXPositive
	^(1@0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:05:36'!
moveYNegative
	^(0@-1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:05:39'!
moveYPositive
	^(0@1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:10:23'!
rotateLeft
  direction rotateAntiClockWise.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:11:14'!
rotateRight

	direction rotateClockWise.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 13:43:03'!
invalidCommandErrorMessage
 ^'Command Not Understood'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:02:37'!
withInitialDirection: anInitialCardinalPoint andPosition: anInitialPosition
^self new initializationWithStatringDirection:anInitialCardinalPoint andPosition: anInitialPosition.! !


!classDefinition: #MarsRoverDirection category: 'MarsRover'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:10:53'!
initializationOfDirectionOf:aMarsRover
	marsRover:=aMarsRover.! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:56:38'!
isCardinalPoint: aCardinalPointToCompare

	^self class isFacing: aCardinalPointToCompare.! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:04'!
moveBackwards
	
	self subclassResponsibility .! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:18'!
moveFowards
	
	self subclassResponsibility .! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:01'!
rotateAntiClockWise

	self subclassResponsibility .! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:15'!
rotateClockWise

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: 'MarsRover'!
MarsRoverDirection class
	instanceVariableNames: ''!

!MarsRoverDirection class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:51:11'!
isFacing: aCardinalPointToCompare

	self subclassResponsibility .! !

!MarsRoverDirection class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:10:53'!
of:aMarsRover 

	^self new initializationOfDirectionOf:aMarsRover! !

!MarsRoverDirection class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:51:11'!
of:aMarsRover facing:aDirection
 
	|aSubclassType|
	aSubclassType:= self subclasses detect: [:aTypeOfSubclass| aTypeOfSubclass isFacing:aDirection].
	
	^aSubclassType new initializationOfDirectionOf:aMarsRover! !


!classDefinition: #MarsRoverFacingEast category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverFacingEast methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:04'!
moveBackwards
	
	^marsRover moveXNegative.! !

!MarsRoverFacingEast methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:18'!
moveFowards
	
	^marsRover moveXPositive .! !

!MarsRoverFacingEast methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:10:02'!
rotateAntiClockWise
	
	^(marsRover faceNorth).! !

!MarsRoverFacingEast methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:15'!
rotateClockWise
	
	^marsRover faceSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingEast class' category: 'MarsRover'!
MarsRoverFacingEast class
	instanceVariableNames: ''!

!MarsRoverFacingEast class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:52:05'!
isFacing: aCardinalPointToCompare

	^aCardinalPointToCompare=#East! !


!classDefinition: #MarsRoverFacingNorth category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverFacingNorth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:04'!
moveBackwards

	^marsRover moveYNegative! !

!MarsRoverFacingNorth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:18'!
moveFowards

	^marsRover moveYPositive .! !

!MarsRoverFacingNorth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:01'!
rotateAntiClockWise
	
	^marsRover faceWest! !

!MarsRoverFacingNorth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:15'!
rotateClockWise
	
	^marsRover faceEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingNorth class' category: 'MarsRover'!
MarsRoverFacingNorth class
	instanceVariableNames: ''!

!MarsRoverFacingNorth class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:52:25'!
isFacing: aCardinalPointToCompare

	^aCardinalPointToCompare=#North! !


!classDefinition: #MarsRoverFacingSouth category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverFacingSouth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:04'!
moveBackwards
	
	^marsRover moveYPositive ! !

!MarsRoverFacingSouth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:18'!
moveFowards
	
	^marsRover moveYNegative.! !

!MarsRoverFacingSouth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:01'!
rotateAntiClockWise
	
	^marsRover faceEast! !

!MarsRoverFacingSouth methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:15'!
rotateClockWise
	
	^marsRover faceWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingSouth class' category: 'MarsRover'!
MarsRoverFacingSouth class
	instanceVariableNames: ''!

!MarsRoverFacingSouth class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:52:25'!
isFacing: aCardinalPointToCompare

	^aCardinalPointToCompare=#South! !


!classDefinition: #MarsRoverFacingWest category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverFacingWest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:04'!
moveBackwards
	
	^marsRover moveXPositive.! !

!MarsRoverFacingWest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 16:12:18'!
moveFowards
	
	^marsRover moveXNegative .! !

!MarsRoverFacingWest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:01'!
rotateAntiClockWise
	
	^marsRover faceSouth! !

!MarsRoverFacingWest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:45:15'!
rotateClockWise
	
	^marsRover faceNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingWest class' category: 'MarsRover'!
MarsRoverFacingWest class
	instanceVariableNames: ''!

!MarsRoverFacingWest class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/4/2022 15:52:25'!
isFacing: aCardinalPointToCompare

	^aCardinalPointToCompare=#West! !