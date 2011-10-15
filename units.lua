
StaticLibrary {
	Name = "IMCocoaStatic",
	Env = {
		CPPPATH = { "src" },
	},
	Sources = { 
		Glob {
			Dir = "src/imcocoa",
			Extensions = { ".c", ".m" },
		},
	},
}

SharedLibrary {
	Name = "IMCocoa",
	Env = {
		CPPPATH = { "src" },
	},
	Sources = { 
		Glob {
			Dir = "src/imcocoa",
			Extensions = { ".c", ".m" },
		},
	},

	Frameworks = { "Cocoa" },
}

Program {
	Name = "example1",
	Env = { CPPPATH = { "src" }, },
	Frameworks = { "Cocoa" },
	Sources = { "src/examples/c/example1/example1.c" },
	Depends = { "IMCocoaStatic" },
}

Default "IMCocoa"
Default "example1"

