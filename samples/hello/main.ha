use fmt;

export fn main() void = {
	const greetings = [
		"Hello!",
                "你好！",
		"¡Hola!",
		"こんにちは！",
	];
	for (let i = 0z; i < len(greetings); i += 1) {
		fmt::println(greetings[i])!;
	};
};
