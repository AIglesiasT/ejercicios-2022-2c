!classDefinition: #Stack category: 'StackPrimeraParte'!
OrderedCollection subclass: #Stack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'accesing' stamp: 'AMIT 10/14/2022 12:09:28'!
top
 ^self first.! !


!Stack methodsFor: 'removing' stamp: 'AMIT 10/14/2022 12:09:22'!
pop
	^self removeFirst.! !


!Stack methodsFor: 'adding' stamp: 'AMIT 10/14/2022 11:41:41'!
push: anElementToAdd
	self addFirst:anElementToAdd.! !


!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'as yet unclassified' stamp: 'IL 10/1/2022 19:24:17'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack new.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AMIT 10/14/2022 11:51:29'!
test02AnElementCanBeAddedToStack

	| stack |
	
	stack := Stack new.
	stack push:5.
	self deny: stack isEmpty! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AMIT 10/14/2022 12:06:29'!
test03AnElementCanBeRemovedFromStack

	| stack|
	
	stack := Stack new.
	stack push:'Chau'.
	stack pop.
	self assert: stack isEmpty! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AMIT 10/14/2022 12:09:48'!
test04TheElementRemovedFromStackIsTheLastOneAdded

	| stack|
	
	stack := Stack new.
	stack push:'Chau'.
	stack push:'Hola'.
	stack push:'cosas'.
	self assert: stack pop equals:'cosas'.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AMIT 10/14/2022 12:14:00'!
test05StackIsTypeLIFO

	| stack lastElementIn|
	
	stack := Stack new.
	stack push:'Chau'.
	stack push:'Hola'.
	stack push:'como'.
	lastElementIn:='cuando'.
	stack push:lastElementIn.
	self assert: (lastElementIn) equals: stack pop.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AMIT 10/14/2022 12:19:27'!
test06TheLastElementFromAStackCanBeObteindWithoutRemovingIt

	| stack lastElementIn|
	
	stack := Stack new.
	stack push:'Chau'.
	stack push:'Hola'.
	stack push:'como'.
	lastElementIn:='cuando'.
	stack push:lastElementIn.
	self assert: stack includes: stack top.! !
