a := block(x, x + 4)
b := block(y, y / 2)
c := block(z, z - 2)

Block compose := method(anotherBlock,
	thisBlock := self
	block(
		thisBlock call(anotherBlock performOn(call target, call sender, call message))	
	)
)

a compose(b) compose(c) call(4) println #=> 5
c compose(b) compose(a) call(4) println #=> 2


Block * := method(anotherBlock,
	self compose(anotherBlock)
)

(a * b * c) call(4) println #=> 5
(c * b * a) call(4) println #=> 2
