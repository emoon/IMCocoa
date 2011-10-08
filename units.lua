
StaticLibrary {
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
}

Program {
	Name = "example1",
	Env = { CPPPATH = { "src" }, },
	Frameworks = { "Cocoa" },
	Sources = { "src/example1/example1.m" },
	Depends = { "IMCocoa" },
}

Default "example1"

