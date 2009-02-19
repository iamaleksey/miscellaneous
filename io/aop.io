Object before := method(
	a0 := call evalArgAt(0)
	a1 := call evalArgAt(1)

	oldMethod := self getSlot(a0) setIsActivatable(false)

	self setSlot(a0, block(
			a1 performOn(call target, call sender, call message)
			oldMethod performOn(call target, call sender, call message)
		) setIsActivatable(true)
	)
)

Object after := method(
	a0 := call evalArgAt(0)
	a1 := call evalArgAt(1)

	oldMethod := self getSlot(a0) setIsActivatable(false)

	self setSlot(a0, block(
			oldMethod performOn(call target, call sender, call message)
			a1 performOn(call target, call sender, call message)
		) setIsActivatable(true)
	)
)

