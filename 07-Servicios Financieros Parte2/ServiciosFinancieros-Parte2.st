!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportTest methodsFor: 'AcountSummery test' stamp: 'AMIT 11/18/2022 11:39:15'!
test01SummeryOfANewAccountHasOnlyAnEqualTo0Balance

	|anAccount aSummary|
	
	anAccount _ ReceptiveAccount new.
	aSummary _ (AccountSummary of: anAccount) getSummary.
	
	self assert: aSummary size = 1.
	self assert: aSummary includes: ('Balance = 0 * pesos').
	
	! !

!ReportTest methodsFor: 'AcountSummery test' stamp: 'AMIT 11/18/2022 11:40:19'!
test02SummeryOfAnAccountWithADepositReportsIt

	|anAccount aSummary|
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	aSummary _ (AccountSummary of: anAccount) getSummary.
	
	
	self assert: aSummary includes: 'Depósito por 100 * pesos'.
	self assert: aSummary includes: 'Balance = 100 * pesos'.
	! !

!ReportTest methodsFor: 'AcountSummery test' stamp: 'AMIT 11/18/2022 11:40:25'!
test03SummeryOfAnAccountWithADepositAndAWithdrawReportsThem

	|anAccount aSummary|
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	Withdraw register: 50 * peso on: anAccount.
	aSummary _ (AccountSummary of: anAccount) getSummary.
	
	
	self assert: aSummary includes: 'Depósito por 100 * pesos'.
	self assert: aSummary includes: 'Extracción por 50 * pesos'.
	! !

!ReportTest methodsFor: 'AcountSummery test' stamp: 'AMIT 11/18/2022 11:40:30'!
test04SummeryOfAnAccountWithADepositAndAWithdrawMustHaveTheCorrectBalance

	|anAccount aSummary|
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	Withdraw register: 50 * peso on: anAccount.
	aSummary _ (AccountSummary of: anAccount) getSummary.
	
	self assert: aSummary includes: 'Balance = 50 * pesos'.
	! !

!ReportTest methodsFor: 'AcountSummery test' stamp: 'AMIT 11/18/2022 11:40:42'!
test05SummeryOfAnAccountWithDepositFromTransferReportsIt

	|anAccount1 anAccount2 aSummary|
	
	anAccount1 _ ReceptiveAccount new.
	anAccount2 _ ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount1.
	Transfer amount: 50*peso from: anAccount1 to: anAccount2. 
	aSummary _ (AccountSummary of: anAccount2) getSummary.
	
	self assert: aSummary includes: 'Entrada por transferencia de 50 * pesos'.
	self assert: aSummary includes: 'Balance = 50 * pesos'.
	! !

!ReportTest methodsFor: 'AcountSummery test' stamp: 'AMIT 11/18/2022 11:40:50'!
test06SummeryOfAnAccountWithWithdrawFromTransferReportsIt

	|anAccount1 anAccount2 aSummary|
	
	anAccount1 _ ReceptiveAccount new.
	anAccount2 _ ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount1.
	Transfer amount: 50*peso from: anAccount1 to: anAccount2. 
	aSummary _ (AccountSummary of: anAccount1) getSummary.
	
	self assert: aSummary includes: 'Salida por transferencia de 50 * pesos'.
	self assert: aSummary includes: 'Balance = 50 * pesos'.
	! !


!ReportTest methodsFor: 'TransferNet test' stamp: 'AMIT 11/18/2022 15:28:22'!
test07TransferNetOfANewAccountIsEqualTo0

	|anAccount aTransferNet|
	
	anAccount _ ReceptiveAccount new.
	aTransferNet _ (TransferNet of: anAccount) getTransferNet.

	self assert: aTransferNet equals: 0 * peso.
	! !

!ReportTest methodsFor: 'TransferNet test' stamp: 'AMIT 11/18/2022 15:28:29'!
test08TransferNetOfAnAccountWithOnlyADepositTransferEqualsItsAmount

	|anAccount1 aTransferNet anAccount2|
	
	anAccount1 _ ReceptiveAccount new.
	anAccount2 _ ReceptiveAccount new.
	Deposit register: 100*peso on:anAccount2.
	Transfer amount: 50*peso from: anAccount2 to: anAccount1.
	aTransferNet _ (TransferNet of: anAccount1) getTransferNet.

	self assert: aTransferNet equals: 50 * peso.
	! !

!ReportTest methodsFor: 'TransferNet test' stamp: 'AMIT 11/18/2022 15:29:22'!
test09TransferNetOfAnAccountWithOnlyAWithdrawTransferEqualsItsAmountNegated

	|anAccount1 aTransferNet anAccount2|
	
	anAccount1 _ ReceptiveAccount new.
	anAccount2 _ ReceptiveAccount new.
	
	Deposit register: 100*peso on:anAccount2.
	Transfer amount: 50*peso from: anAccount2 to: anAccount1.
	
	aTransferNet _ (TransferNet of: anAccount2) getTransferNet.

	self assert: (-50 * peso) equals: aTransferNet.
	! !

!ReportTest methodsFor: 'TransferNet test' stamp: 'AMIT 11/18/2022 15:29:34'!
test10TransferNetOfAnAccountWithOnlyACommonDepositIs0

	|aTransferNet anAccount2|
	
	anAccount2 _ ReceptiveAccount new.
	
	Deposit register: 100*peso on:anAccount2.
	
	aTransferNet _ (TransferNet of: anAccount2) getTransferNet.

	self assert: (0 * peso) equals: aTransferNet.
	! !

!ReportTest methodsFor: 'TransferNet test' stamp: 'AMIT 11/18/2022 15:29:41'!
test11TransferNetOfAnAccountWithACommonDepositAndAWithdrawIs0

	|aTransferNet anAccount2|
	
	anAccount2 _ ReceptiveAccount new.
	
	Deposit register: 100*peso on:anAccount2.
	Withdraw register: 80*peso on:anAccount2.
	
	aTransferNet _ (TransferNet of: anAccount2) getTransferNet.

	self assert: (0 * peso) equals: aTransferNet.
	! !

!ReportTest methodsFor: 'TransferNet test' stamp: 'AMIT 11/18/2022 15:29:49'!
test12TransferNetOfAnAccountWithATransferDepositAndATransferWithdrawIsTheDifferenceBetweenThem

	|anAccount1 aTransferNet anAccount2|
	
	anAccount1 _ ReceptiveAccount new.
	anAccount2 _ ReceptiveAccount new.
	
	Deposit register: 100*peso on:anAccount2.
	Transfer amount: 50*peso from: anAccount2 to: anAccount1.
	Transfer amount: 25*peso from: anAccount1 to: anAccount2.
	
	aTransferNet _ (TransferNet of: anAccount1) getTransferNet.

	self assert: (25 * peso) equals: aTransferNet.
	! !

!ReportTest methodsFor: 'TransferNet test' stamp: 'AMIT 11/18/2022 15:29:54'!
test13TransferNetOfAComposedAccountItsTheSumOfItsIndividualTransferNet
	
	| aPortfolio anAccount1 aTransferNet anAccount2 anAccount3|
	
	aPortfolio _ Portfolio new.
	anAccount1 _ ReceptiveAccount new.
	anAccount2 _ ReceptiveAccount new.
	anAccount3 _ ReceptiveAccount new.
	
	
	Deposit register: 100*peso on:anAccount2.
	Transfer amount: 50*peso from: anAccount2 to: anAccount1.
	Transfer amount: 25*peso from: anAccount2 to: anAccount3.
	
	aPortfolio add: anAccount1.
	aPortfolio add: anAccount3
	.
	aTransferNet _ (TransferNet of: aPortfolio) getTransferNet.

	self assert: 75*peso equals: aTransferNet .
	! !


!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:02'!
test14PortfolioTreePrinterProducesOnlyItsNameIfThePortfolioIsEmpty

	|aPortfolio aPrintedPortfolioTree |
	
	aPortfolio _ Portfolio named: 'Cuenta de XXX'.
	
	aPrintedPortfolioTree _ (PortfolioTreePrinterGeneral of: aPortfolio) print.
	
	self assert: #('Cuenta de XXX') asOrderedCollection equals: aPrintedPortfolioTree.! !

!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:08'!
test15PortfolioTreePrinterPrintsTheCorrectReportIfPortfolioHasAnAccount

	|aPortfolio aChildAccount aPrintedPortfolioTree|
	
	aChildAccount _ ReceptiveAccount named: 'Cuenta de YYY'.
	aPortfolio _ Portfolio named: 'Cuenta de XXX' with: aChildAccount.
	
	aPrintedPortfolioTree _ (PortfolioTreePrinterGeneral of: aPortfolio) print.

	self assert: {'Cuenta de XXX' . 
				String newLineString , String tab, 'Cuenta de YYY'} asOrderedCollection equals: aPrintedPortfolioTree.! !

!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:14'!
test16PortfolioTreePrinterPrintsTheCorrectReportIfPortfolioHasMoreThanOneAccount

	|aPortfolio anAccount1 anAccount2 aPrintedPortfolioTree|
	
	anAccount1 _ ReceptiveAccount named: 'Cuenta de YYY'.
	anAccount2 _ ReceptiveAccount named: 'Cuenta de ZZZ'.
	aPortfolio _ Portfolio named: 'Cuenta de XXX' with: anAccount1 with: anAccount2.
	
	aPrintedPortfolioTree _ (PortfolioTreePrinterGeneral of: aPortfolio) print.

	self assert: {'Cuenta de XXX'.
				String newLineString , String tab, 'Cuenta de YYY'.
				String newLineString , String tab, 'Cuenta de ZZZ'} asOrderedCollection equals: aPrintedPortfolioTree.! !

!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:21'!
test17PortfolioDetailedTreePrinterPrintsOnlyNameOfProfileWhenEmpty

	|aPortfolio  aPrintedPortfolioDetailedTree|
	
	aPortfolio _ Portfolio named: 'Cuenta de XXX'.
	
	aPrintedPortfolioDetailedTree _ (PortfolioDetailedTreePrinter of: aPortfolio) print.

	self assert: {'Cuenta de XXX'.
			String newLineString,String tab, 'Balance = 0 * pesos'} asOrderedCollection equals: aPrintedPortfolioDetailedTree.! !

!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:27'!
test18PortfolioDetailedTreePrinterPrintsOnlyNamesAndBalanceEqualTo0WIfPorfolioHasOnlyOneEmptyAccount

	|aPortfolio anAccount  aPrintedPortfolioDetailedTree|
	
	anAccount _ ReceptiveAccount named: 'Cuenta de YYY'.
	aPortfolio _ Portfolio named: 'Cuenta de XXX' with: anAccount.
	
	
	aPrintedPortfolioDetailedTree _ (PortfolioDetailedTreePrinter of: aPortfolio) print.

	self assert: {'Cuenta de XXX' . 
				String newLineString, String tab, 'Cuenta de YYY' . 
				String newLineString, String tab, String tab, 'Balance = 0 * pesos'. 
				String newLineString, String tab, 'Balance = 0 * pesos'} asOrderedCollection equals: aPrintedPortfolioDetailedTree.! !

!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:39'!
test19PortfolioDetailedTreePrinterPrintsNamesaAndCorrectSummeryIfPorfolioHasAnActiveAccount

	|aPortfolio anAccount  aPrintedPortfolioDetailedTree|
	
	anAccount _ ReceptiveAccount named: 'Cuenta de YYY'.
	Deposit register: 100*peso on: anAccount.
	Withdraw register: 20*peso on: anAccount.
	
	aPortfolio _ Portfolio named: 'Cuenta de XXX' with: anAccount.
	
	
	aPrintedPortfolioDetailedTree _ (PortfolioDetailedTreePrinter of: aPortfolio) print.

	self assert: {'Cuenta de XXX' . 
				String newLineString, String tab, 'Cuenta de YYY' . 
				String newLineString, String tab, String tab, 'Depósito por 100 * pesos'. 
				String newLineString, String tab, String tab, 'Extracción por 20 * pesos'.
				String newLineString, String tab, String tab, 'Balance = 80 * pesos'. 
				String newLineString, String tab, 'Balance = 80 * pesos'} asOrderedCollection equals: aPrintedPortfolioDetailedTree.! !

!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:45'!
test20PortfolioDetailedTreePrinterPrintsCorrectlyForMoreThanOneActiveAccount

	|aPortfolio anAccount  aPrintedPortfolioDetailedTree secondAccount|
	
	anAccount _ ReceptiveAccount named: 'Cuenta de YYY'.
	Deposit register: 100*peso on: anAccount.
	Withdraw register: 20*peso on: anAccount.
	secondAccount _ ReceptiveAccount named: 'Cuenta de ZZZ'.
	Deposit register: 30*peso on: secondAccount.
	Transfer amount: 20*peso from:anAccount  to: secondAccount.
	
	aPortfolio _ Portfolio named: 'Cuenta de XXX' with: anAccount with:secondAccount .
	
	
	aPrintedPortfolioDetailedTree _ (PortfolioDetailedTreePrinter of: aPortfolio) print.

	self assert: {'Cuenta de XXX' . 
				String newLineString, String tab, 'Cuenta de YYY' . 
				String newLineString, String tab, String tab, 'Depósito por 100 * pesos'. 
				String newLineString, String tab, String tab, 'Extracción por 20 * pesos'.
				String newLineString, String tab, String tab, 'Salida por transferencia de 20 * pesos'.
				String newLineString, String tab, String tab, 'Balance = 60 * pesos'. 
				String newLineString, String tab, 'Cuenta de ZZZ' .
				String newLineString, String tab, String tab, 'Depósito por 30 * pesos'. 
				String newLineString, String tab, String tab, 'Entrada por transferencia de 20 * pesos'.
				String newLineString, String tab, String tab, 'Balance = 50 * pesos'. 
				String newLineString, String tab, 'Balance = 110 * pesos'} asOrderedCollection equals: aPrintedPortfolioDetailedTree.! !

!ReportTest methodsFor: 'PortfolioTreePrinter test' stamp: 'AMIT 11/18/2022 15:30:51'!
test21PortfolioDetailedTreePrinterPrintsCorrectlyForAPortfolioWithAnotherPortfoliosChild

	|aPortfolio anAccount  aPrintedPortfolioDetailedTree aSecondPortfolio secondAccount|
	
	anAccount _ ReceptiveAccount named: 'Cuenta de YYY'.
	Deposit register: 100*peso on: anAccount.
	Withdraw register: 20*peso on: anAccount.
	secondAccount _ ReceptiveAccount named: 'Cuenta de ZZZ'.
	Deposit register: 30*peso on: secondAccount.
	Transfer amount: 20*peso from:anAccount  to: secondAccount.
	
	aSecondPortfolio _ Portfolio named: 'Cuenta de AAA' with: secondAccount.
	aPortfolio _ Portfolio named: 'Cuenta de XXX' with: anAccount with:aSecondPortfolio.
	
	
	aPrintedPortfolioDetailedTree _ (PortfolioDetailedTreePrinter of: aPortfolio) print.

	self assert: {'Cuenta de XXX' . 
				String newLineString, String tab, 'Cuenta de YYY' . 
				String newLineString, String tab, String tab, 'Depósito por 100 * pesos'. 
				String newLineString, String tab, String tab, 'Extracción por 20 * pesos'.
				String newLineString, String tab, String tab, 'Salida por transferencia de 20 * pesos'.
				String newLineString, String tab, String tab, 'Balance = 60 * pesos'. 
				String newLineString, String tab, 'Cuenta de AAA' . 
				String newLineString, String tab, String tab,'Cuenta de ZZZ' .
				String newLineString, String tab, String tab,String tab, 'Depósito por 30 * pesos'. 
				String newLineString, String tab, String tab,String tab, 'Entrada por transferencia de 20 * pesos'.
				String newLineString, String tab, String tab,String tab, 'Balance = 50 * pesos'. 
				String newLineString, String tab, String tab, 'Balance = 50 * pesos'. 
				String newLineString, String tab, 'Balance = 110 * pesos'} asOrderedCollection equals: aPrintedPortfolioDetailedTree.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'AMIT 11/18/2022 13:07:31'!
effectsOn:anAccountType

	^self subclassResponsibility.
	! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'private' stamp: 'AMIT 11/18/2022 12:52:28'!
name

	^name! !


!Account methodsFor: 'initialization' stamp: 'AMIT 11/18/2022 12:54:18'!
initializeNamed: aName

	name _ aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/18/2022 12:48:33'!
named: aName 

	^self new initializeNamed: aName.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'AMIT 11/18/2022 14:48:44'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'AMIT 11/18/2022 13:25:52'!
accounts

	^accounts! !

!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'AMIT 11/18/2022 13:29:51'!
effectsOn:aReport
	
	aReport affectedByPortfolio: self.! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/18/2022 12:49:06'!
named: aName with: aReceptiveAccount 
		
	^(self named: aName) add: aReceptiveAccount; yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AMIT 11/18/2022 12:49:27'!
named: aName with: aReceptiveAccount with: anotherReceptiveAccount
		
	^(self named: aName) add: aReceptiveAccount; add: anotherReceptiveAccount; yourself.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AMIT 11/18/2022 11:07:41'!
balance

	^transactions 
		inject: 0 *peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'AMIT 11/18/2022 13:48:15'!
effectsOn: aReport
	
	aReport affectedByReceptiveAccount:self.
! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'associating' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:04:44'!
effectsOn:anAccountReport

	^ self subclassResponsibility.! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'associating' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:06:26'!
effectsOn:anAccountReport

	 ^anAccountReport addDepositEffectsOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'associating' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !

!TransferDepositLeg methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:06:14'!
effectsOn:anAccountReport

	 ^anAccountReport addTransferDepositEffectsOf: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'associating' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !

!TransferWithdrawLeg methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:06:03'!
effectsOn:anAccountReport

	 ^anAccountReport addTransferWithdrawEffectsOf: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'associating' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:05:47'!
effectsOn:anAccountReport

	 ^anAccountReport addWithdrawEffectsOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioTreePrinter
	instanceVariableNames: 'account report indentationAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'associating' stamp: 'AMIT 11/18/2022 14:23:43'!
affectedByPortfolio: aPortfolio

	self subclassResponsibility.! !

!PortfolioTreePrinter methodsFor: 'associating' stamp: 'AMIT 11/18/2022 14:22:41'!
affectedByReceptiveAccount: anAccount

	self subclassResponsibility.! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'AMIT 11/18/2022 13:39:54'!
initializeFor:anAccount

	account _ anAccount.
	report _ OrderedCollection new.
	indentationAmount  _ 0.! !


!PortfolioTreePrinter methodsFor: 'report' stamp: 'AMIT 11/18/2022 15:25:42'!
indentation

	 |indentate|
	
	indentate _ ''.
	(indentationAmount >0) ifTrue:[indentate _ String newLineString].
	indentationAmount timesRepeat: [indentate _ indentate , String tab].
	^ indentate.! !

!PortfolioTreePrinter methodsFor: 'report' stamp: 'AMIT 11/18/2022 14:40:05'!
print
	 
	account effectsOn:self.
	
	^report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'initialization' stamp: 'AMIT 11/18/2022 12:35:36'!
of: aPortfolio 
	^self new initializeFor:aPortfolio.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'effects' stamp: 'AMIT 11/18/2022 15:26:45'!
affectedByPortfolio:aPortfolio
	
	report add:(self indentation, aPortfolio name). 
	indentationAmount _	indentationAmount +1.
	
	aPortfolio accounts do: [ :anAccount | anAccount effectsOn: self ].
	report add: (self indentation, 'Balance = ', aPortfolio balance asString).
	indentationAmount _	indentationAmount -1.! !

!PortfolioDetailedTreePrinter methodsFor: 'effects' stamp: 'AMIT 11/18/2022 15:26:54'!
affectedByReceptiveAccount:anAccount
	
	report add:(self indentation, anAccount name). 
	indentationAmount _ 	indentationAmount +1.
	(AccountSummary of: anAccount) getSummary do: [ :entry | report add: ( self indentation, entry)].
	indentationAmount _ 	indentationAmount -1.! !


!classDefinition: #PortfolioTreePrinterGeneral category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter subclass: #PortfolioTreePrinterGeneral
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterGeneral methodsFor: 'effects' stamp: 'AMIT 11/18/2022 14:23:48'!
affectedByPortfolio: aPortfolio

	report  add:(self indentation , aPortfolio name).
	indentationAmount _ indentationAmount + 1.
	aPortfolio accounts do: [ :anAccount | anAccount effectsOn: self].
	indentationAmount _ indentationAmount -1.
! !

!PortfolioTreePrinterGeneral methodsFor: 'effects' stamp: 'AMIT 11/18/2022 15:26:11'!
affectedByReceptiveAccount: anAccount

	report add: ( self indentation, anAccount name).! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'initialization' stamp: 'AMIT 11/18/2022 11:45:17'!
initializeFor:anAccount

	account _ anAccount.! !


!Report methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:06:53'!
addDepositEffectsOf:  aDeposit
	
	^self subclassResponsibility.! !

!Report methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:07:08'!
addTransferDepositEffectsOf:  aTransferDeposit
	
	^self subclassResponsibility.! !

!Report methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:07:30'!
addTransferWithdrawEffectsOf:  aTransferWithdraw
	
	^self subclassResponsibility.! !

!Report methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:07:50'!
addWithdrawEffectsOf:  aWithdraw
	
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'initialization' stamp: 'AMIT 11/18/2022 11:52:24'!
of: aReceptiveAccount 

	^ self new initializeFor: aReceptiveAccount! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!


!AccountSummary methodsFor: 'accessing' stamp: 'AMIT 11/18/2022 14:33:31'!
getSummary
	
	|accountSummary|
	accountSummary _ OrderedCollection new.
	(account transactions) do: [ :aTransaction | accountSummary add: (aTransaction effectsOn: self)].
	accountSummary add: ('Balance = ', account balance asString).
	
	^ accountSummary.! !


!AccountSummary methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:06:26'!
addDepositEffectsOf:  aDeposit
	
	^'Depósito por ', ((aDeposit value) asString).! !

!AccountSummary methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:06:14'!
addTransferDepositEffectsOf:  aTransferDepositLeg
	
	^'Entrada por transferencia de ', ((aTransferDepositLeg value) asString).! !

!AccountSummary methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:06:03'!
addTransferWithdrawEffectsOf:  aTransferWithdrawLeg
	
	^'Salida por transferencia de ', ((aTransferWithdrawLeg value) asString).! !

!AccountSummary methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:05:47'!
addWithdrawEffectsOf:  aWithdraw
	
	^'Extracción por ', ((aWithdraw value) asString).! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'accessing' stamp: 'AMIT 11/18/2022 12:03:33'!
getTransferNet
	
	^ account transactions sum:[:aTransaction| aTransaction effectsOn: self]  ifEmpty: [0*peso].! !


!TransferNet methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:08:22'!
addDepositEffectsOf:  aDeposit
	
	^0*peso.! !

!TransferNet methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:08:48'!
addTransferDepositEffectsOf:  aTransferDeposit
	
	^aTransferDeposit value.! !

!TransferNet methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:09:11'!
addTransferWithdrawEffectsOf:  aTransferWithdraw
	
	^(aTransferWithdraw value) negated.! !

!TransferNet methodsFor: 'associating' stamp: 'AMIT 11/18/2022 12:08:07'!
addWithdrawEffectsOf:  aWithdraw
	
	^0*peso.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
