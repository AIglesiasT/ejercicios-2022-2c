!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 16:37:14'!
test01EmptyPortfolioHasZeroPesos

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 * peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 16:48:46'!
test02PortfolioWithOneAccountKnowsItsBalance

	| portfolio anAccount |
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: anAccount.
	portfolio add: anAccount.
	
	self assert: 100 * peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 16:59:48'!
test03PortfolioWithMultipleAccountsBalanceIsTheSumOfTheIndividualBalances

	| portfolio firstAccount secondAccount |
	
	portfolio := Portfolio new.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: firstAccount.
	Deposit register: 150 * peso on: secondAccount.
	portfolio add: firstAccount.
	portfolio add: secondAccount.

	self assert: 250 * peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:04:16'!
test04PortfolioDoesntRegisterTransactionsInAccountsThatAreNotPartOfIt
	
	| portfolio anAccount deposit |
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 * peso on: anAccount.
	
	self deny: (portfolio hasRegistered: deposit).

	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:04:36'!
test05PortfolioRegisterTransactions

	| portfolio anAccount deposit |
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 * peso on: anAccount.
	portfolio add: anAccount.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:05:36'!
test06PortfolioWithNoComponentsHasNoTransactions

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio transactions isEmpty).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:17:22'!
test07PortfolioWithComponentsHasAllTheirTransactions
	| anAccount aPortfolio deposit  firsWithdraw secondWithdraw|
	
	anAccount _ ReceptiveAccount new.
	aPortfolio _ Portfolio new.
	
	deposit _ Deposit register: 100*peso  on: anAccount.  
	firsWithdraw _ Withdraw register: 10*peso  on: anAccount.
	secondWithdraw _ Withdraw register: 10*peso  on: anAccount.
	
	aPortfolio add: anAccount.
	
	self assert: 3 equals: aPortfolio transactions size.
	self assert: aPortfolio transactions includes: deposit.
	self assert: aPortfolio transactions includes: firsWithdraw.
	self assert: aPortfolio transactions includes: secondWithdraw.! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'senderAccounts receiverAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'tests' stamp: 'AMIT 11/5/2022 16:27:03'!
test01TransferencesAreWithdrawFromThesenderAndDepositIntoRecipient
	
	
	Transference of: 50 * peso from: senderAccounts  to: receiverAccounts .
		
	self assert: 50 * peso equals: receiverAccounts  balance.
	self assert: 50 * peso equals: senderAccounts  balance.! !

!TransferenceTest methodsFor: 'tests' stamp: 'AMIT 11/5/2022 16:26:53'!
test02TransferencesKnowsItsValue

	| transferenceValue transference|
	
	transferenceValue _ 50 * peso.
	transference _ Transference of: transferenceValue from: senderAccounts  to: receiverAccounts .
		
		
	self assert: transferenceValue equals: transference value.
! !

!TransferenceTest methodsFor: 'tests' stamp: 'AMIT 11/5/2022 16:27:39'!
test03TransferencesAccountsRegisterTransaction

	| transference|
	
	transference _ Transference of: 50 * peso from: senderAccounts  to: receiverAccounts .
		
		
	self assert: (transference depositIsRegisterOnreceiverAccount: receiverAccounts).
	self assert: (transference withdrawIsRegisterOnsenderAccount: senderAccounts).
! !

!TransferenceTest methodsFor: 'tests' stamp: 'AMIT 11/5/2022 16:28:06'!
test04TransferencesSenderTranscationKnowRecipient

	| transferenceValue transference|
	
	transferenceValue _ 50 * peso.
	transference _ Transference of: transferenceValue from: senderAccounts  to: receiverAccounts .
	
	self assert: transference countrapartOfSenderTransactionIsRecipientTransaction.! !

!TransferenceTest methodsFor: 'tests' stamp: 'AMIT 11/5/2022 16:28:01'!
test05TransferencesRecipientTranscationKnowSender

	| transferenceValue transference|
	
	
	transferenceValue _ 50 * peso.
	transference _ Transference of: transferenceValue from: senderAccounts  to: receiverAccounts .
	
	self assert: transference countrapartOfRecipientTransactionIsSenderTransaction .! !

!TransferenceTest methodsFor: 'tests' stamp: 'AMIT 11/5/2022 16:32:02'!
test06TransferencesCannotBe0

	
	self assertIfTransferValue:(0*peso) thenAccountsRemainAsTheyAreAndRaiseError: (Transference transferValueCantBeZeroErrorMessage).! !

!TransferenceTest methodsFor: 'tests' stamp: 'AMIT 11/5/2022 16:30:53'!
test07TransferencesCannotBeNegative

	self assertIfTransferValue:(-15 * peso) thenAccountsRemainAsTheyAreAndRaiseError: (Transference transferValueCantBeNegativeErrorMessage).
	! !


!TransferenceTest methodsFor: 'assertions' stamp: 'AMIT 11/5/2022 16:31:23'!
assertIfTransferValue:aTransferValue thenAccountsRemainAsTheyAreAndRaiseError: anErrorMessage
	
	self
		should: [ Transference of: aTransferValue from: senderAccounts  to: receiverAccounts ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: 100 * peso equals: senderAccounts balance.
			self assert: 0*peso equals: receiverAccounts balance.
			self assert: anError messageText equals: anErrorMessage. ].! !


!TransferenceTest methodsFor: 'setUp/tearDown' stamp: 'AMIT 11/5/2022 16:26:57'!
setUp
	
	senderAccounts := ReceptiveAccount new.
	receiverAccounts  := ReceptiveAccount new.
	Deposit register: 100 * peso on: senderAccounts .! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 16:38:05'!
balance

	self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:01:38'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:24:25'!
transactions

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'components'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 16:50:36'!
add:anAccount
	
	components add:anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 16:59:40'!
balance

	^components sum: [:component | component balance] ifEmpty: [0 * peso].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:04:46'!
hasRegistered: aTransaction

    ^components anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 16:52:04'!
initialize

	components := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AMIT 11/11/2022 17:15:40'!
transactions

	| transactionList |
	
	transactionList := OrderedCollection new.
	
	components do: [:component | transactionList addAll: component transactions].
	
	^transactionList ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AMIT 11/5/2022 13:44:59'!
balance

	^transactions inject: 0*peso into: [ :currentBalance :aTransaction | aTransaction effectsOnBalance: currentBalance ].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 14:18:14'!
effectsOnBalance:aCurrentBalance

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 14:51:55'!
initializeFor:aParameter
	
	self subclassResponsibility.
! !


!classDefinition: #CommonTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #CommonTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!CommonTransaction methodsFor: 'value' stamp: 'AMIT 11/5/2022 14:50:42'!
value

	^  value.! !


!CommonTransaction methodsFor: 'initialization' stamp: 'AMIT 11/5/2022 14:11:38'!
initializeFor: aValue

	value :=aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CommonTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
CommonTransaction class
	instanceVariableNames: ''!

!CommonTransaction class methodsFor: 'instance creation' stamp: 'AMIT 11/5/2022 14:07:45'!
for: aValue

	^ self new initializeFor: aValue ! !

!CommonTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
CommonTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 13:43:44'!
effectsOnBalance:aCurrentBalance

	^aCurrentBalance + (self value).! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
CommonTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 13:43:53'!
effectsOnBalance:aCurrentBalance

	^aCurrentBalance - (self value).! !


!classDefinition: #TransferTransaction category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 16:01:24'!
countrapart
	
	self subclassResponsibility.! !

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 14:52:18'!
initializeFor:aTransfer
	
	transfer _ aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 14:52:18'!
becauseOf: aTransfer

	^self new initializeFor:aTransfer.! !

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 14:54:13'!
in:anAccount becauseOf: aTransfer

	| transferTransaction |
	
	transferTransaction := self becauseOf: aTransfer.
	anAccount register: transferTransaction.
		
	^transferTransaction.! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 16:01:19'!
countrapart
	
	^transfer countrapartOfTransferDeposit.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 14:54:43'!
effectsOnBalance:aCurrentBalance

	^aCurrentBalance + (transfer value).! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 16:01:13'!
countrapart
	
	^transfer countrapartOfTransferWithdraw.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AMIT 11/5/2022 14:54:53'!
effectsOnBalance:aCurrentBalance

	^aCurrentBalance - (transfer value).! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value senderTransaction recipientTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'value' stamp: 'AMIT 11/5/2022 15:10:51'!
value
	
	^value! !


!Transference methodsFor: 'initielization' stamp: 'AMIT 11/5/2022 16:07:28'!
initializeFor: aTransferValue from: aSenderAccount to: aRecipientAccount
	
	value _ aTransferValue.
	senderTransaction _ TransferWithdraw in:aSenderAccount becauseOf: self .
	recipientTransaction _ TransferDeposit in: aRecipientAccount becauseOf: self .! !


!Transference methodsFor: 'accessing' stamp: 'AMIT 11/5/2022 16:01:36'!
countrapartOfTransferDeposit
	
	^senderTransaction.! !

!Transference methodsFor: 'accessing' stamp: 'AMIT 11/5/2022 16:01:39'!
countrapartOfTransferWithdraw
	
	^recipientTransaction.! !


!Transference methodsFor: 'testing' stamp: 'AMIT 11/5/2022 16:01:51'!
countrapartOfRecipientTransactionIsSenderTransaction
	
	^(recipientTransaction countrapart)=senderTransaction.! !

!Transference methodsFor: 'testing' stamp: 'AMIT 11/5/2022 16:01:46'!
countrapartOfSenderTransactionIsRecipientTransaction
	
	^(senderTransaction countrapart)=recipientTransaction.! !

!Transference methodsFor: 'testing' stamp: 'AMIT 11/5/2022 15:29:34'!
depositIsRegisterOnreceiverAccount:receiverAccount

	^receiverAccount hasRegistered:recipientTransaction.! !

!Transference methodsFor: 'testing' stamp: 'AMIT 11/5/2022 15:30:02'!
withdrawIsRegisterOnsenderAccount:senderAccount

	^senderAccount hasRegistered:senderTransaction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'initialize' stamp: 'AMIT 11/5/2022 16:16:21'!
of: aTransferValue from: aSenderAccount to: recipientAccount 
	
	(aTransferValue = (0*peso)) ifTrue: [ self error: self transferValueCantBeZeroErrorMessage].
	(aTransferValue < (0*peso)) ifTrue: [ self error: self transferValueCantBeNegativeErrorMessage].
	
	^self new initializeFor: aTransferValue from: aSenderAccount to: recipientAccount! !


!Transference class methodsFor: 'error' stamp: 'AMIT 11/5/2022 16:16:39'!
transferValueCantBeNegativeErrorMessage
	
	^'Transfer Value Cannot Be less Than 1'! !

!Transference class methodsFor: 'error' stamp: 'AMIT 11/5/2022 16:10:47'!
transferValueCantBeZeroErrorMessage
	
	^'Transfer Value Cannot Be 0'! !
