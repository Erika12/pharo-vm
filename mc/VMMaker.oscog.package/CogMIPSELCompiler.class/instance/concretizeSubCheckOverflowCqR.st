generate machine code - concretize
concretizeSubCheckOverflowCqR
	| value reg |
	value := operands at: 0.
	reg := self concreteRegister: (operands at: 1).
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: value)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: value)).

	"Save original LHS"
	self machineCodeAt: 8 put: (self adduR: OverflowTemp1 R: reg R: ZR). 
	
	"The actual subtraction"
	self machineCodeAt: 12 put: (self subuR: reg R: reg R: AT). 

	"Set sign bit of OverflowTemp2 if sign of result differs from sign of RHS."
	self machineCodeAt: 16 put: (self xorR: OverflowTemp2 R: reg R: AT).
	"Set sign bit of OverflowTemp1 if sign of result differs from sign of LHS."
	self machineCodeAt: 20 put: (self xorR: OverflowTemp1 R: reg R: OverflowTemp1).
	"Set sign bit of Overflow if sign of result differs from both LHS and RHS, which indicates overflow."
	self machineCodeAt: 24 put: (self andR: Overflow R: OverflowTemp1 R: OverflowTemp2).
	^machineCodeSize := 28