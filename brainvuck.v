module main

import os

fn brainvuck(source string) {
	mut tape := []rune{len: 1024, init: 0}
	mut tape_idx := 0
	mut idx := 0
	length := source.len
	for idx < length {
		match source[idx] {
			`>` {
				tape_idx++
			}
			`<` {
				if tape_idx > 0 {
					tape_idx--
				}
			}
			`+` {
				tape[tape_idx]++
			}
			`-` {
				tape[tape_idx]--
			}
			`.` {
				print(tape[tape_idx])
			}
			`,` {
				tape[tape_idx] = rune(utf8_getchar())
			}
			`[` {
				if tape[tape_idx] == 0 {
					mut depth := 1
					for depth > 0 {
						idx++
						if source[idx] == `[` {
							depth++
						} else if source[idx] == `]` {
							depth--
						}
					}
				}
			}
			`]` {
				mut depth := 1
				for depth > 0 {
					idx--
					if source[idx] == `[` {
						depth--
					} else if source[idx] == `]` {
						depth++
					}
				}
				idx--
			}
			else {}
		}
		idx++
	}
}

fn main() {
	if os.args.len == 2 {
		filename := os.args[1]
		source := os.read_file(filename) or { panic(err) }
		brainvuck(source)
	} else {
		println('usage: ./brainvuck <program.bf>')
	}
}
