use rt::{compile, exited, EXIT_SUCCESS};

type inta = int;
type intp = *int;
type u32a = u32;
type func = fn() void;

fn basics() void = {
	let x = 42;
	let y: intp = &x;
	assert(*y == 42);
	let y: *int = y;
	assert(*y == 42);
	*y = 1337;
	assert(x == 1337);
	let z: *inta = &42;
	assert(*z == 42);
	let w: *const u32a = &42u32;
	assert(*w == 42);
	let a: *func = &basics;
	let b: *opaque = &42;

	assert(size(*int) == size(uintptr));
	assert(align(*int) == align(uintptr));
};

fn _nullable() void = {
	let x: nullable *int = null;
	assert(x == null);
	let y = 42;
	x = &y;
	assert(*(x: *int) == 42);

	assert(compile(
		"fn test() void = { let x: nullable *int = null; let z = *x; };",
	) as exited != EXIT_SUCCESS);
};

fn casts() void = {
	let a: *uint = &4u;
	let b = a: *opaque;
	let c = b: *uint;
	assert(a == c && *c == 4);

	let a: nullable *uint = &7u;
	let b = a: *uint;
	assert(b == a && *b == 7);

	let a: nullable *uint = &10u;
	let b = a as *uint;
	assert(b == a && *b == 10);

	let a: nullable *int = &4;
	assert(a is *int);

	let a: nullable *int = null;
	assert(a is null);
	assert((a as null): nullable *opaque == null);

	let a: nullable *int = &4;
	assert(a is *int);

	let a = &42;
	let b = a: intp;
	assert(b == a && *b == 42);
};

fn reject() void = {
	assert(compile("
		type s = null;
		fn test() void = {
			void;
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		type s = *null;
		fn test() void = {
			void;
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a = &null;
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a = &3: null;
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let b: nullable *int = null;
			let a = b as null;
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a = (null, 3);
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a: []null = [null];
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a = [null];
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a: [_]null = [null];
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a = null;
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a: nullable *int = &4;
			a as int;
		};
	") as exited != EXIT_SUCCESS);
	assert(compile("
		fn test() void = {
			let a: nullable *int = &4;
			a as *str;
		};
	") as exited != EXIT_SUCCESS);

	// type assertions on non-nullable pointers are prohibited
	assert(compile("
		fn test() void = {
			let a: *int = &4;
			assert(a as *int);
		};
	") as exited != EXIT_SUCCESS);

	// dereference expression not in translation-compatible subset
	assert(compile("
		let a: int = 0;
		let b: *int = &a;
		let c: int = *b;
	") as exited != EXIT_SUCCESS);

	// can't cast to alias of opaque
	assert(compile("
		type t = opaque;
		fn test() void = {
			let x: *t = &0;
		};
	") as exited != EXIT_SUCCESS);

	// can't have pointer to void
	assert(compile("
		fn test() void = {
			let a: *void = &12;
		};
	") as exited != EXIT_SUCCESS);

	assert(compile("
		fn test() void = {
			let a = &void;
		};
	") as exited != EXIT_SUCCESS);

	assert(compile("
		fn test() void = {
			&12: *void;
		};
	") as exited != EXIT_SUCCESS);

	assert(compile("
		fn f() void = {
			let a: nullable *void = null;
		};
	") as exited != EXIT_SUCCESS);

	// arithmetic on pointer types is not allowed
	assert(compile(`
		fn f() void = {
			let a = &12i + &8i;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn f() void = {
			let a = &12i + 8i: uintptr;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn f() void = {
			let a = &12i + 8i;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn f() void = {
			let a = &12i;
			a += &8i;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn f() void = {
			let a = &12i;
			a += 8i: uintptr;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn f() void = {
			let a = &12i;
			a += 8i;
		};
	`) as exited != EXIT_SUCCESS);

	// type promotion
	assert(compile(`
		fn test() void = {
			let a: *str = &0;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() void = {
			let a: *str = alloc(0);
		};
	`) as exited != EXIT_SUCCESS);

	// pointer to never
	assert(compile(`
		fn test() void = {
			&abort();
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() nullable *never = null;
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() void = {
			*(&0: *never);
		};
	`) as exited != EXIT_SUCCESS);

	// pointer to zero-size type
	assert(compile(`
		fn test() void = {
			let a = &void;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() void = {
			let a = &(void, void);
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() void = {
			let a = &(int, void).1;
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() void = {
			let a = &([]: [0]int);
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() void = {
			let a = &struct { v: void = void };
		};
	`) as exited != EXIT_SUCCESS);

	assert(compile(`
		fn test() void = {
			let a = &struct { i: int = 0, v: void = void }.v;
		};
	`) as exited != EXIT_SUCCESS);
};

export fn main() void = {
	basics();
	_nullable();
	casts();
	reject();
};
