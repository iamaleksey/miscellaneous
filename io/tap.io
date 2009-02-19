Object tap := method(
	a0 := call argAt(0)
	a1 := call argAt(1)

	call sender setSlot(a0 name, self)
	a1 doInContext(call sender)

	self
)
