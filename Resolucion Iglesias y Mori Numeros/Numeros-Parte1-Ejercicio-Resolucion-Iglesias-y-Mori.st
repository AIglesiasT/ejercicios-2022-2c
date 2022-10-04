!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:32'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:10'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:43'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:11'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:28'!
test10AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:42'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (twoFifth) * (fiveHalfs) ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:04:04'!
test14NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:05:06'!
test15NegationOfFraccionIsCorrect

	self assert: (Numero with: negativeOne over: two) equals: oneHalf negated! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/8/2019 21:09:34'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: 'value numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'AMIT 9/27/2022 21:59:32'!
* aMultiplier 

	self subclassResponsibility .

	
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AMIT 9/28/2022 13:12:45'!
+ anAdder 
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AMIT 9/28/2022 20:33:27'!
negated
	
		self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AMIT 10/3/2022 13:45:03'!
productoriaConNumeroDelMismoTipo: aNumber
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AMIT 10/3/2022 13:37:00'!
sumatoriaConElNumerosDelMismoTipo: aNumber
	
	self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:10:15'!
isNegative
	
	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:25:11'!
isOne

	self subclassResponsibility .! !

!Numero methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:27:00'!
isZero

	self subclassResponsibility .! !


!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:46'!
denominator

	^denominator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:33:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:52'!
numerator

	^numerator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 21:55:04'!
type
	
	^type! !


!Numero methodsFor: 'printing' stamp: 'AMIT 9/28/2022 20:34:56'!
printOn: aStream
	
	self subclassResponsibility .! !


!Numero methodsFor: 'comparing' stamp: 'AMIT 9/28/2022 20:38:09'!
= anObject

	self subclassResponsibility.! !

!Numero methodsFor: 'comparing' stamp: 'AMIT 9/28/2022 20:40:00'!
hash
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'AMIT 10/4/2022 00:37:00'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^NumeroEntero new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'AMIT 10/4/2022 00:37:24'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^NumeroFraccionario new initializeWith: numerator over: denominator! !


!classDefinition: #NumeroEntero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #NumeroEntero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroEntero methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:10:38'!
isNegative
	^value < 0! !

!NumeroEntero methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:24:50'!
isOne
	 ^value = 1! !

!NumeroEntero methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:27:39'!
isZero
	 ^value = 0.! !


!NumeroEntero methodsFor: 'arithmetic' stamp: 'AMIT 10/3/2022 13:45:03'!
* aMultiplier

	^aMultiplier productoriaConNumeroDelMismoTipo: self.! !

!NumeroEntero methodsFor: 'arithmetic' stamp: 'AMIT 10/3/2022 13:37:00'!
+ anAdder 

	^anAdder sumatoriaConElNumerosDelMismoTipo: self.! !

!NumeroEntero methodsFor: 'arithmetic' stamp: 'AMIT 9/28/2022 20:33:37'!
negated
	^self * (self class with: -1).! !


!NumeroEntero methodsFor: 'arithmetic-private' stamp: 'AMIT 9/28/2022 20:32:03'!
// aDivisor
	^self class with: value // aDivisor integerValue! !

!NumeroEntero methodsFor: 'arithmetic-private' stamp: 'AMIT 10/3/2022 13:49:59'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).
		! !

!NumeroEntero methodsFor: 'arithmetic-private' stamp: 'AMIT 10/3/2022 13:45:03'!
productoriaConNumeroDelMismoTipo: anInteger
	^self class with: value * anInteger integerValue.! !

!NumeroEntero methodsFor: 'arithmetic-private' stamp: 'AMIT 10/3/2022 13:37:00'!
sumatoriaConElNumerosDelMismoTipo:anInteger
	^anInteger class with: (anInteger integerValue )+ value.! !


!NumeroEntero methodsFor: 'compering' stamp: 'AMIT 9/28/2022 20:38:42'!
= anObject
	^(anObject isKindOf: self class)ifTrue: [ value = anObject integerValue] ! !

!NumeroEntero methodsFor: 'compering' stamp: 'AMIT 9/28/2022 20:40:08'!
hash
	 ^value hash ! !


!NumeroEntero methodsFor: 'printing' stamp: 'AMIT 9/28/2022 20:34:34'!
printOn:aStream

	aStream print: value ! !


!NumeroEntero methodsFor: 'initialization' stamp: 'AMIT 10/4/2022 00:33:32'!
initializeWith: aValue


	value := aValue! !


!classDefinition: #NumeroFraccionario category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #NumeroFraccionario
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroFraccionario methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:10:47'!
isNegative

	^denominator < 0! !

!NumeroFraccionario methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:24:50'!
isOne
	^false! !

!NumeroFraccionario methodsFor: 'testing' stamp: 'AMIT 9/27/2022 21:27:23'!
isZero
	 ^false.! !


!NumeroFraccionario methodsFor: 'arithmetic private' stamp: 'AMIT 10/3/2022 13:45:03'!
productoriaConNumeroDelMismoTipo: aMultiplier 
		^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator).! !

!NumeroFraccionario methodsFor: 'arithmetic private' stamp: 'AMIT 10/3/2022 13:37:00'!
sumatoriaConElNumerosDelMismoTipo: aFraction
			 | newNumerator newDenominator |
		
			newNumerator := (aFraction numerator * denominator) + (aFraction denominator * numerator).
			newDenominator := aFraction denominator * denominator.
		
			^ aFraction class with: newNumerator over: newDenominator.! !


!NumeroFraccionario methodsFor: 'arithmetic' stamp: 'AMIT 10/3/2022 13:45:54'!
* aMultiplier 
	
	^aMultiplier productoriaConNumeroDelMismoTipo: self.! !

!NumeroFraccionario methodsFor: 'arithmetic' stamp: 'AMIT 10/3/2022 13:37:00'!
+ anAdder
	
	^anAdder sumatoriaConElNumerosDelMismoTipo: self.! !

!NumeroFraccionario methodsFor: 'arithmetic' stamp: 'AMIT 9/28/2022 20:33:09'!
negated
	^self class with: numerator * (self class with: -1) over: denominator! !


!NumeroFraccionario methodsFor: 'comparing' stamp: 'AMIT 9/28/2022 20:38:27'!
= anObject

	^(anObject isKindOf: self class) ifTrue:
			[ (numerator * anObject denominator) = (denominator * anObject numerator)].! !

!NumeroFraccionario methodsFor: 'comparing' stamp: 'AMIT 9/28/2022 20:39:48'!
hash
	^(numerator hash / denominator hash) hash ! !


!NumeroFraccionario methodsFor: 'printing' stamp: 'AMIT 9/28/2022 20:35:16'!
printOn: aStream
	aStream 
			print: numerator;
			nextPut: $/;
			print: denominator ! !


!NumeroFraccionario methodsFor: 'initialization' stamp: 'AMIT 10/4/2022 00:33:57'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator.! !
