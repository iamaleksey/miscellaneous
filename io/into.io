Object into := method(
	a0 := call argAt(0)
	a1 := call argAt(1)

	if(a1,
		call sender setSlot(a0 name, self); a1 doInContext(call sender),
		a0 doInContext(self, call sender)
	)
)
