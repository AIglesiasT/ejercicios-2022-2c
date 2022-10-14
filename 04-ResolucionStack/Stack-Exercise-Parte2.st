!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #Elements category: 'Stack-Exercise'!
Object subclass: #Elements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Elements methodsFor: 'accessing-private' stamp: 'AMIT 10/14/2022 15:22:12'!
top
 self subclassResponsibility .! !


!classDefinition: #Base category: 'Stack-Exercise'!
Elements subclass: #Base
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'accessing-private' stamp: 'AMIT 10/14/2022 16:00:37'!
top
	^self error: OOStack stackEmptyErrorDescription .! !


!Base methodsFor: 'initialization' stamp: 'AMIT 10/14/2022 15:59:58'!
initialize
	value:= nil.! !


!classDefinition: #WithValue category: 'Stack-Exercise'!
Elements subclass: #WithValue
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!WithValue methodsFor: 'accessing-private' stamp: 'AMIT 10/14/2022 15:22:37'!
top
	^value.! !


!WithValue methodsFor: 'initialization' stamp: 'AMIT 10/14/2022 14:54:49'!
initializeWith:aString
 value:=aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithValue class' category: 'Stack-Exercise'!
WithValue class
	instanceVariableNames: ''!

!WithValue class methodsFor: 'as yet unclassified' stamp: 'AMIT 10/14/2022 14:54:18'!
with:aString
	^self new initializeWith: aString .! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements last'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'AMIT 10/14/2022 14:52:08'!
isEmpty
	^elements size=1.! !


!OOStack methodsFor: 'adding' stamp: 'AMIT 10/14/2022 15:57:46'!
push: aString
	
	elements addFirst: ( WithValue new initializeWith: aString).! !


!OOStack methodsFor: 'accessing' stamp: 'AMIT 10/14/2022 15:55:51'!
size
 ^(elements size-1).! !

!OOStack methodsFor: 'accessing' stamp: 'AMIT 10/14/2022 15:55:35'!
top
	^(elements first) top.
	! !


!OOStack methodsFor: 'removing' stamp: 'AMIT 10/14/2022 16:04:57'!
pop
	^(elements remove: elements first) top.! !


!OOStack methodsFor: 'initialization' stamp: 'AMIT 10/14/2022 15:53:54'!
initialize
	elements:= OrderedCollection new.
	elements add: Base new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
