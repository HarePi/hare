export type _enum = enum {
	ONE = 1,
	TWO = 2,
	THREE = 3,
};

export type other = enum {
	// purposefully something that doesn't exist in _enum
	EIGHT = 8: _enum,
};

export type enum_alias = _enum;
export type error_enum = !_enum;

export def val = 42;
export def val2: int = 90;
export def val3: enum_alias = 1: enum_alias;
export let val4 = 69;
