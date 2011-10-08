Build {
	Units = "units.lua",

	SyntaxExtensions = { "tundra.syntax.glob" },

	Configs = {
		{
			Name = "macosx-gcc",
			DefaultOnHost = "macosx",
			Tools = { "clang-osx" },
			Env = {
				CPPDEFS = { "IMCOCOA_MACOSX" },
				CCOPTS = {
					{ "-g", "-O0", "-Werror", "-pedantic-errors", "-Wall"; Config = "macosx-gcc-debug" },
				},
			},
		},
	},
}
