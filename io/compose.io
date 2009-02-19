Block compose := method(anotherBlock,
	thisBlock := self
	block(
		thisBlock call(anotherBlock performOn(call target, call sender, call message))	
	)
)

Block * := method(anotherBlock,
	self compose(anotherBlock)
)
