accessing
compactClassIndexOfClass: classOop
	"Ugh, can't reply on the host.  Spur doesn't have compact classes"
	| aClass |
	aClass := self objectForOop: classOop.
	^false
		ifTrue: [aClass indexIfCompact]
		ifFalse:
			[aClass caseOf: {
				[CompiledMethod]		->	[1].
				[Array]					->	[3].
				[LargeNegativeInteger]	->	[4].
				[LargePositiveInteger]	->	[5].
				[Float]					->	[6].
				[Association]			->	[8].
				[Point]					->	[9].
				[Rectangle]				->	[10].
				[ByteString]			->	[11].
				[Context]		->	[14].
				[Bitmap]				->	[16]
				}
				otherwise: [0]]