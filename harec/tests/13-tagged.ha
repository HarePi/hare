use rt::{compile, exited, EXIT_SUCCESS};

fn measurements() void = {
	const x: (u8 | u16 | u32 | u64) = 1337u16;	// With padding
	const alignment: size =
		if (size(u64) < size(uint)) size(uint)
		else size(u64);
	assert(align((u8 | u16 | u32 | u64)) == alignment);
	assert(size((u8 | u16 | u32 | u64)) == alignment * 2);
	assert(&x: uintptr: size % size(uint) == 0);
	assert(&x: uintptr: size % size(u64) == 0);

	const y: (u8 | u16) = 1337u16;			// No padding
	assert(align((u8 | u16)) == align(uint));
	assert(align(((u8 | u16) | (i8 | i16))) == align(uint));
};

fn storage() void = {
	let x: (u8 | u16 | u32 | u64) = 42u8;
	const y = &x: *struct {
		tag: uint,
		union { _u8: u8, _u16: u16, _u32: u32, _u64: u64 },
	};
	assert(y.tag == 1268499444); // u8 type ID
	assert(y._u8 == 42);

	x = 1337u16;
	assert(y.tag == 4119164483); // u16 type ID
	assert(y._u16 == 1337);

	x = 0xCAFEBABEu32;
	assert(y.tag == 3481467866); // u32 type ID
	assert(y._u32 == 0xCAFEBABE);

	x = 0xCAFEBABEDEADBEEFu64;
	assert(y.tag == 1906196061); // u64 type ID
	assert(y._u64 == 0xCAFEBABEDEADBEEF);
};

fn operators() void = {
	let x: (u8 | u16 | u32 | u64) = 42u8;
	assert(x is u8);
	x = 1337u16;
	assert(x is u16);
	x = 0xCAFEBABEu32;
	assert(x is u32);
	x = 0xCAFEBABEDEADBEEFu64;
	assert(x is u64);
};

type signed = (i8 | i16 | i32 | i64 | int);
type unsigned = (u8 | u16 | u32 | u64 | uint);
type integer = (...signed | ...unsigned);

fn reduction() void = {
	const a: (i8 | i16) = 42i8;
	const b: (i16 | i8) = a;
	const c: (i8 | i16 | i32) = a;
	const d: (i8 | i16 | i8 | i16) = a;
	assert(compile(
		// Cannot reduce to a single member
		"fn test() void = {
			let a: (u8 | u8) = 42u8;
		};"
	) as exited != EXIT_SUCCESS);
	assert(compile(
		// Cannot assign from more general type
		"fn test() void = {
			let a: (i8 | i16 | i32) = 42i8;
			let b: (i8 | i16) = a;
		};"
	) as exited != EXIT_SUCCESS);
	assert(a is i8 && b is i8 && c is i8 && d is i8);
	assert(size((i8 | i16 | i32)) == size((i8 | (i16 | i32))));
	assert(size(integer) == size(signed));
	assert(size(integer) != size((signed | unsigned)));
	const i: integer = 10i;
	assert(i is int);
};

fn casts() void = {
	let a: (u8 | u16) = 42u16;
	assert(a as u16 == 42);
	let x = a: u8;
	assert(x == 42);

	const val = 0xBEEFu16;
	const is_little = (&val: *[2]u8)[0] == 0xEF;
	a = 0xCAFEu16;
	x = a: u8;
	assert(x == (if (is_little) 0xFEu8 else 0xCAu8));
};

fn membercast() void = {
	// Simple case
	let x: (int | void) = void;
	let p = &x: *struct {
		id: uint,
		data: int,
	};
	assert(p.id == 3650376889);
	x = 1337;
	assert(p.id == 2674862226);
	assert(p.data == 1337);

	// Align of 4
	let x: (int | f32 | void) = 1337;
	let p = &x: *struct {
		id: uint,
		data: union {
			idata: int,
			fdata: f32,
		},
	};
	assert(p.id == 2674862226);
	assert(p.data.idata == 1337);
	x = 13.37f32;
	assert(p.id == 3950255460);
	assert(p.data.fdata == 13.37f32);

	// Align of 8
	let x: (size | void) = 1337z;
	let p = &x: *struct {
		id: uint,
		data: size,
	};
	assert(p.id == 2843771249);
	assert(p.data == 1337z);
};

fn subsetcast() void = {
	// Equal alignment
	// subset -> superset
	let x: (size | void) = 1337z;
	let y: (size | int | void) = x;
	let p = &y: *struct {
		tag: uint,
		data: union {
			z: size,
			i: int,
		},
	};
	assert(p.tag == 2843771249);
	assert(p.data.z == 1337z);
	// superset -> subset
	let x: (size | void | int) = 2z;
	assert(x: (size | void) as size == 2);
	assert(x as (size | void) as size == 2);
	assert(x is (size | void) && (x is size) && !(x is void));

	// Disjoint alignment
	// subset -> superset
	let x: (int | void) = 1337;
	let y: (size | int | void) = x;
	let p = &y: *struct {
		tag: uint,
		data: union {
			z: size,
			i: int,
		},
	};
	assert(p.tag == 2674862226);
	assert(p.data.i == 1337);
	// superset -> subset
	let x: (size | int | void) = 2i;
	assert(x: (int | void) as int == 2);
	assert(x as (int | void) as int == 2);
	assert(x is (int | void) && (x is int) && !(x is void));
};

type foo = (int | void);
type bar = (size | foo);
type t1 = t2;
type t2 = int;
type t3 = (t2 | void);
type t4 = t2;
type t5 = (t4 | void);

fn castout() void = {
	let x: (int | void) = 1337;
	assert(x: int == 1337);
	assert(x as int == 1337);
	assert(x is int);
	// XXX: We can probably expand this

	let a: bar = 42i;
	assert(a as int == 42);
	assert(a: int == 42);
	assert(a is int);

	const a: t1 = 42;
	const x = a: t3;
	assert(x as t2 == 42);
	const x = a: t5;
	assert(x as t4 == 42);
};

fn assertions() void = {
	let a: (u8 | u16) = 42u16;
	assert(a is u16);
	assert(a as u16 == 42u16);
};

fn reject() void = {
	// cannot type assert into a disjoint tagged type
	assert(compile(
		"fn test() void = {
			let a: (u8 | u16) = 42u8;
			let b = a as (str | void);
		};"
	) as exited != EXIT_SUCCESS);

	// cannot type assert into non-member type
	assert(compile(
		"fn test() void = {
			let a: (u8 | u16) = 42u8;
			let b = a as *str;
		};"
	) as exited != EXIT_SUCCESS);

	// cannot type assert into superset
	assert(compile(
		"fn test() void = {
			let a: (u8 | u16) = 42u8;
			let b = a as (u8 | u16 | void);
		};"
	) as exited != EXIT_SUCCESS);

	// cannot type assert into the same type
	assert(compile(
		"fn test() void = {
			let a: (u8 | u16) = 42u8;
			let b = a as (u8 | u16);
		};"
	) as exited != EXIT_SUCCESS);

	// cannot have members of undefined size
	assert(compile(
		"fn test() (void | [*]int) = {
			void;
		};"
	) as exited != EXIT_SUCCESS);

	// cannot have <2 members
	assert(compile(
		"fn test() (void | void) = {
			void;
		};"
	) as exited != EXIT_SUCCESS);

	assert(compile(
		"fn test() void = {
			let x = 3: (int | void) + 5: (int | void);
		};"
	) as exited != EXIT_SUCCESS);
	assert(compile(
		"fn test() void = {
			let x = 3: (int | void);
			x += 5: (int | void);
		};"
	) as exited != EXIT_SUCCESS);
};

def val1: integer = 8u8;
def val1val: u8 = val1 as u8;
def val1type: bool = val1 is u8;
def val2: integer = val1;
def val2val: u8 = val2 as u8;
def val2type: bool = val2 is u8;
def val3: integer = 8u8: u16;
def val3val: u16 = val3 as u16;
def val3type: bool = val3 is u16;

fn translation() void = {
	assert(val1 as u8 == 8u8);
	assert(val1val == 8u8);
	assert(val1type == true);
	assert(val2 as u8 == 8u8);
	assert(val2val == 8u8);
	assert(val2type == true);
	assert(val3 as u16 == 8u16);
	assert(val3val == 8u16);
	assert(val3type == true);
};

export fn main() void = {
	measurements();
	storage();
	operators();
	reduction();
	casts();
	membercast();
	subsetcast();
	castout();
	assertions();
	reject();
	translation();
};
