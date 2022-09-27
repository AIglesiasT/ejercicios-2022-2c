!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 18:56:12'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (customerBook time: [customerBook addCustomerNamed: 'John Lennon']) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 19:25:53'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook newWithActiveCustomer: paulMcCartney.

	self assert: (customerBook time: [customerBook removeCustomerNamed: paulMcCartney]) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 17:50:33'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook anError|
			
	customerBook := CustomerBook new.
	
	self assertif: [customerBook addCustomerNamed: ''] hasError: Error thenDo: [customerBook isEmpty] andComapre: [anError messageText] with: CustomerBook customerCanNotBeEmptyErrorMessage! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 19:26:10'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithActiveCustomer: johnLennon.
	
	self assertif: [customerBook removeCustomerNamed: 'Paul McCartney'.] hasError: NotFound thenDo: [customerBook includesCustomerNamed: johnLennon] andComapre: [customerBook numberOfCustomers] with: 1.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 19:59:27'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := CustomerBook newWithSuspendedCustomer: paulMcCartney.
	
	self assertIfCuantities:0 and:1 and:1 equalsParametersOf: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 20:00:31'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := CustomerBook newWithSuspendedCustomer: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertIfCuantities:0 and: 0 and: 0 equalsParametersOf: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 19:26:34'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := CustomerBook newWithActiveCustomer: johnLennon.
	
	self assertif: [customerBook suspendCustomerNamed: 'Ringo Starr'] hasError: CantSuspend thenDo: [customerBook includesCustomerNamed: johnLennon] andComapre: customerBook numberOfCustomers with: 1.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AMIT 9/26/2022 20:00:49'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithSuspendedCustomer: johnLennon.
	
	self assertif: [customerBook suspendCustomerNamed: johnLennon] hasError: CantSuspend thenDo: [customerBook includesCustomerNamed: johnLennon] andComapre: customerBook numberOfCustomers with: 1.
! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AMIT 9/26/2022 19:04:13'!
assertIfCuantities:aCuantity1 and: aCuantity2 and: aCuantity3 equalsParametersOf: aCustomerBook.
 	self assert: aCuantity1 = aCustomerBook numberOfActiveCustomers.
	self assert: aCuantity2 = aCustomerBook numberOfSuspendedCustomers.
	self assert: aCuantity3 = aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AMIT 9/26/2022 17:30:25'!
assertIfCuantities:aCuantity equals: aBlock.
 	self assert: aCuantity = aBlock value.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AMIT 9/26/2022 17:53:04'!
assertif: aBlock equals: aParameter andif: anotherBlock
	self assert:  ( aBlock value)= aParameter.
	self assert: (anotherBlock value).! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AMIT 9/26/2022 17:49:58'!
assertif: aBlock hasError: aGeneralError thenDo: anotherBlock andComapre: lastBlock with: parameter
[ aBlock value. self fail ]
		on: aGeneralError
		do: [:anError |  [self assertif: lastBlock equals: parameter andif: anotherBlock].].! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !

!CustomerBook methodsFor: 'initialization' stamp: 'AMIT 9/26/2022 19:28:08'!
initializeInActive:aCustomer

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.
	active add: aCustomer.! !

!CustomerBook methodsFor: 'initialization' stamp: 'AMIT 9/26/2022 19:59:46'!
initializeInSuspended:aCustomer

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.
	suspended add: aCustomer.! !


!CustomerBook methodsFor: 'customer management' stamp: 'AMIT 9/26/2022 20:06:17'!
addCustomerNamed: aName
	"Aca cambiamos las signalCustomer por una sola, pero no entendemos hasta que punto es productivo. En este caso oscurece bastante la sitaxis y claridad del codigo. No seria mejor dejarlo como estaba?"
	aName isEmpty ifTrue: [(self signalCustomer:[self class customerCanNotBeEmptyErrorMessage])]. 
	(self includesCustomerNamed: aName)  ifTrue: [ (self signalCustomer:[self class customerAlreadyExistsErrorMessage])].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AMIT 9/26/2022 18:48:54'!
removeCustomerNamed: aName 
 	
	((self removeCustomer:aName fromList: active)=aName) ifTrue:[^aName].
	((self removeCustomer:aName fromList: suspended)=aName)ifTrue:[^aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'AMIT 9/26/2022 18:43:44'!
signalCustomer: aBlock

	self error: aBlock value. ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'as yet unclassified' stamp: 'AMIT 9/26/2022 18:39:23'!
removeCustomer:aName fromList: aList
	1 to: (aList size) do: 
	[ :index |
		aName = (aList at: index)
			ifTrue: [
				aList removeAt: index.
				^ aName 
			] 
	].
	^self.! !

!CustomerBook methodsFor: 'as yet unclassified' stamp: 'AMIT 9/26/2022 18:55:57'!
time: aBlock
 	| millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	^(millisecondsAfterRunning-millisecondsBeforeRunning)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !


!CustomerBook class methodsFor: 'creation' stamp: 'AMIT 9/26/2022 19:29:27'!
newWithActiveCustomer:aCustomer
	^self new initializeInActive: aCustomer.! !

!CustomerBook class methodsFor: 'creation' stamp: 'AMIT 9/26/2022 20:00:07'!
newWithSuspendedCustomer:aCustomer
	^self new initializeInSuspended: aCustomer.! !
