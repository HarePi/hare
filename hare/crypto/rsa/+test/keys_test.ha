// SPDX-License-Identifier: MPL-2.0
// (c) Hare authors <https://harelang.org>

use bytes;

type keypair = struct {
	pub: pubparams,
	priv: privparams,
	d: []u8,
};

let sign3072: keypair = keypair {
	pub = pubparams {
		n = [
			0xe1, 0x83, 0x1c, 0x9d, 0xa1, 0x19, 0xe5, 0x74, 0x86,
			0x07, 0x85, 0x50, 0x96, 0x21, 0x62, 0x11, 0xdd, 0x80,
			0xca, 0xe2, 0x2b, 0xf0, 0x22, 0x11, 0x83, 0xf0, 0x35,
			0x65, 0xc6, 0x1c, 0x54, 0x18, 0xc6, 0x58, 0xd8, 0x2e,
			0x32, 0xed, 0xa0, 0x84, 0x65, 0x24, 0xe5, 0x96, 0x79,
			0xda, 0x05, 0x43, 0x65, 0x83, 0x56, 0xe7, 0x5c, 0xed,
			0x2f, 0x82, 0x56, 0x04, 0x2f, 0x47, 0x4b, 0xdf, 0x7d,
			0x7c, 0xd5, 0xf2, 0x07, 0xbb, 0x44, 0x43, 0x78, 0x18,
			0x14, 0xc1, 0x00, 0x44, 0x16, 0xca, 0x6c, 0x08, 0x53,
			0x1c, 0x19, 0x76, 0x51, 0xcf, 0x4a, 0x25, 0x33, 0xca,
			0x1e, 0xf3, 0x0d, 0x31, 0x2a, 0x6a, 0x6f, 0x77, 0x1f,
			0xe4, 0x55, 0xe9, 0x01, 0xea, 0x7c, 0x1d, 0x41, 0x70,
			0xb7, 0x39, 0x2e, 0xb9, 0x05, 0x79, 0x47, 0xe9, 0xae,
			0x14, 0xeb, 0x38, 0xfe, 0xc8, 0x57, 0x8d, 0xfe, 0x1b,
			0x68, 0x66, 0x34, 0xb1, 0x80, 0xf6, 0xf8, 0x8a, 0x82,
			0xe8, 0x60, 0x1b, 0x3a, 0xf7, 0xcc, 0x51, 0xdf, 0xd3,
			0xb4, 0x67, 0xbf, 0xae, 0xb2, 0x6d, 0xa0, 0x7f, 0xdf,
			0x08, 0xdf, 0xc4, 0x1d, 0xf9, 0x15, 0xad, 0x68, 0xe8,
			0x71, 0xce, 0xf2, 0x5a, 0x0d, 0x1d, 0x92, 0x87, 0x77,
			0x88, 0x05, 0x9c, 0xb6, 0x7d, 0x08, 0x33, 0x7a, 0x94,
			0xcf, 0x53, 0x80, 0x04, 0x16, 0xe6, 0x03, 0x14, 0x54,
			0x53, 0x7d, 0xb2, 0xe5, 0x8c, 0x80, 0x64, 0xe7, 0x14,
			0xdf, 0xbd, 0xf9, 0x07, 0xbe, 0xa6, 0xb1, 0x1e, 0x4d,
			0x65, 0xfa, 0x0a, 0x18, 0x10, 0x45, 0x83, 0x39, 0x0e,
			0x9b, 0xa0, 0x86, 0xa7, 0x0b, 0xb7, 0x58, 0x58, 0x82,
			0x52, 0x17, 0x53, 0x7c, 0xfe, 0xcf, 0x55, 0x0e, 0x61,
			0xd8, 0xd4, 0xbc, 0xe9, 0x87, 0x21, 0x65, 0x74, 0xe8,
			0x0a, 0xab, 0x43, 0x98, 0x3a, 0x83, 0x72, 0xaf, 0xd0,
			0x7f, 0x93, 0xd4, 0x39, 0xa6, 0x09, 0xc8, 0x1d, 0xf1,
			0x06, 0x25, 0x95, 0x9e, 0x13, 0x55, 0x06, 0x28, 0x03,
			0xb2, 0x3c, 0xf2, 0x3a, 0xb0, 0x8c, 0xba, 0x4e, 0x05,
			0x19, 0xbb, 0x98, 0x02, 0xca, 0x8d, 0x4d, 0xd2, 0xff,
			0x8a, 0xa5, 0x34, 0x8a, 0x06, 0x15, 0xc0, 0xc3, 0xf6,
			0x1b, 0xb8, 0x5e, 0xd7, 0xb9, 0x28, 0x39, 0x8c, 0x96,
			0xdb, 0x85, 0x56, 0x21, 0xba, 0xff, 0x7b, 0x5f, 0x25,
			0x47, 0xb5, 0x2e, 0x6c, 0x70, 0x73, 0xab, 0x13, 0x4d,
			0x24, 0xa8, 0xb3, 0x73, 0xd7, 0x7f, 0xd8, 0xb3, 0xe4,
			0xdf, 0x94, 0x9c, 0x48, 0xd6, 0x80, 0x0b, 0x8b, 0xd1,
			0xd4, 0x29, 0xb9, 0xa2, 0xef, 0xab, 0x1e, 0x8d, 0xa7,
			0x74, 0xa2, 0xc7, 0xe3, 0x89, 0xb5, 0x01, 0xcf, 0xf0,
			0xc2, 0x28, 0x4d, 0x8e, 0x60, 0x42, 0x37, 0xbe, 0x18,
			0x61, 0x29, 0x8d, 0x01, 0xe6, 0xf9, 0xb5, 0xa7, 0xc5,
			0xb7, 0xce, 0xa8, 0x85, 0x61, 0x1b,
		],
		e = [0x01, 0x00, 0x01],
		...
	},
	priv = privparams {
		nbitlen = 3072,
		p = [
			0x00, 0xff, 0xce, 0xa3, 0x93, 0x98, 0xe2, 0x7b, 0x85,
			0xab, 0xfe, 0x6d, 0x3b, 0xb3, 0xfb, 0xa4, 0xca, 0xbe,
			0x21, 0x7f, 0xa9, 0x09, 0x40, 0xe1, 0xf0, 0x10, 0xcf,
			0xee, 0x9b, 0x23, 0xea, 0xff, 0xe7, 0x52, 0x28, 0x38,
			0x51, 0x3b, 0xd4, 0x5b, 0xb7, 0xef, 0x4b, 0x7a, 0x23,
			0xa8, 0xff, 0xa3, 0x41, 0xd9, 0xc1, 0x7b, 0xf4, 0x7d,
			0x7a, 0xa6, 0x4f, 0x28, 0x66, 0x25, 0x6b, 0xda, 0x96,
			0x97, 0x75, 0x8a, 0xd9, 0x3b, 0xb2, 0x48, 0x5a, 0xe7,
			0x06, 0x37, 0x18, 0x0f, 0xb0, 0x3f, 0x0f, 0x1c, 0x38,
			0x63, 0xe3, 0x16, 0x5c, 0xa0, 0xfe, 0xea, 0xc0, 0x08,
			0x4d, 0xfc, 0x34, 0x28, 0x18, 0xd1, 0xa1, 0x51, 0x8c,
			0xb1, 0x58, 0xb2, 0xbc, 0xad, 0xc0, 0xa8, 0x6b, 0x7f,
			0xf2, 0xf9, 0xbc, 0xb5, 0xc7, 0x3f, 0x1f, 0x1a, 0x44,
			0x75, 0xfe, 0x9f, 0xd1, 0x96, 0x8b, 0x7f, 0x03, 0xe7,
			0x0a, 0x58, 0x67, 0xb1, 0xf4, 0x0d, 0x77, 0xc9, 0x31,
			0xde, 0xda, 0xf2, 0x16, 0x1e, 0x02, 0xb7, 0xfc, 0x17,
			0x93, 0xd7, 0x6d, 0x08, 0x73, 0xda, 0x92, 0x12, 0x49,
			0xf2, 0x86, 0x93, 0xcd, 0x60, 0xb8, 0x00, 0xe2, 0xbc,
			0xf7, 0x7e, 0x2c, 0xb1, 0x1c, 0x3f, 0x74, 0xf0, 0x01,
			0x53, 0x25, 0x11, 0x47, 0x89, 0xe7, 0x4d, 0x6f, 0x06,
			0x9b, 0x43, 0x9e, 0xab, 0x47, 0x9f, 0x83, 0x45, 0x40,
			0x95, 0x3f, 0x83, 0xff,
		],
		q = [
			0x00, 0xe1, 0xae, 0xa0, 0x84, 0xac, 0xc1, 0xa4, 0xba,
			0xf9, 0x4b, 0x00, 0x65, 0xa7, 0x89, 0xf0, 0x92, 0x34,
			0x62, 0x58, 0x5a, 0x1c, 0xcf, 0x4b, 0xb2, 0xda, 0x5f,
			0xab, 0x11, 0x6e, 0x78, 0x91, 0x56, 0x9d, 0x8b, 0xb1,
			0xdb, 0x5a, 0x68, 0xb7, 0x5d, 0x39, 0x76, 0xac, 0x77,
			0xd7, 0x2c, 0xea, 0xd8, 0xac, 0xa1, 0xc6, 0xbe, 0x87,
			0xe4, 0xca, 0xa8, 0x00, 0x85, 0x2b, 0x8a, 0x9c, 0x53,
			0x89, 0x3f, 0xdf, 0x84, 0x6a, 0x8e, 0x6e, 0xb2, 0xc0,
			0x2a, 0x56, 0xd9, 0x43, 0xee, 0xca, 0x43, 0x6a, 0x4d,
			0x04, 0x59, 0xe1, 0xd4, 0x5b, 0x11, 0x3d, 0xea, 0x5b,
			0xe1, 0x11, 0xa2, 0xfc, 0xca, 0x77, 0xd7, 0x3a, 0xbc,
			0x43, 0xbf, 0xf3, 0xae, 0x9c, 0x98, 0x2a, 0x6c, 0x2e,
			0x34, 0x27, 0x5c, 0x4b, 0xd7, 0x5a, 0x74, 0xf4, 0xf4,
			0x4e, 0x63, 0x83, 0xef, 0x2d, 0xc5, 0x15, 0x2a, 0xd0,
			0x7b, 0x3c, 0xf9, 0x2e, 0xcb, 0x0f, 0x8f, 0x48, 0x29,
			0x1f, 0xe3, 0xc4, 0xac, 0x65, 0xbd, 0xcb, 0xbb, 0xb1,
			0xf0, 0x45, 0x6e, 0x6c, 0x38, 0xbf, 0x5d, 0x50, 0xef,
			0xb2, 0xd9, 0x62, 0x13, 0x92, 0x6f, 0xa7, 0x4a, 0x24,
			0x83, 0x1e, 0x25, 0x40, 0x4a, 0x4e, 0x1c, 0x90, 0xf2,
			0x5f, 0x6c, 0x8a, 0xe0, 0x4f, 0xdc, 0xc1, 0x2d, 0x8d,
			0x15, 0x95, 0xdf, 0x0f, 0x1b, 0xce, 0x28, 0xce, 0x2f,
			0xcf, 0x13, 0xb2, 0xe5,
		],
		dp = [
			0x02, 0x49, 0x8c, 0xb8, 0xe3, 0x23, 0x13, 0x4b, 0xac,
			0xb0, 0x07, 0xb6, 0x02, 0xf3, 0xfb, 0x13, 0x3d, 0x03,
			0xfb, 0xaa, 0x3d, 0x44, 0xf1, 0x40, 0x3e, 0x46, 0x3d,
			0xb1, 0xf1, 0x6e, 0x46, 0x7f, 0x81, 0x02, 0x8f, 0x0e,
			0x5a, 0xe4, 0x99, 0x35, 0x59, 0xd4, 0x68, 0xf1, 0x2c,
			0xaf, 0xac, 0x7c, 0x08, 0x40, 0x6c, 0xa5, 0x51, 0x01,
			0xe9, 0xbe, 0xc7, 0x73, 0xb2, 0x5d, 0xf6, 0x84, 0x66,
			0x32, 0x4c, 0xdd, 0x88, 0x65, 0x1d, 0xb4, 0x82, 0x60,
			0x51, 0xd9, 0xcb, 0x3a, 0x1e, 0x36, 0x3a, 0x60, 0x5e,
			0xb4, 0x47, 0x1c, 0xe8, 0xeb, 0x9e, 0x99, 0xbc, 0xf9,
			0x45, 0x8a, 0x09, 0xd9, 0xbe, 0xf6, 0x1c, 0x4e, 0x8f,
			0xbf, 0x65, 0x49, 0xbe, 0x9b, 0xfc, 0x65, 0x89, 0xad,
			0x58, 0x82, 0x51, 0x75, 0xc8, 0xa0, 0xb4, 0x91, 0x6c,
			0x24, 0xac, 0xb5, 0x29, 0x0d, 0x72, 0x43, 0x4c, 0xab,
			0x91, 0x02, 0xcc, 0x5a, 0x8c, 0x4c, 0x47, 0xe6, 0x44,
			0x41, 0xdc, 0xec, 0x49, 0xb4, 0x68, 0x84, 0xbe, 0x89,
			0x39, 0xe1, 0xe5, 0xb3, 0x73, 0x7e, 0xde, 0xde, 0xfe,
			0x66, 0x29, 0xa8, 0x2a, 0x77, 0x3a, 0xba, 0xcc, 0x49,
			0xc2, 0x3d, 0x10, 0x10, 0x5a, 0x98, 0xe7, 0x14, 0x7b,
			0xf3, 0xd6, 0xe5, 0xb6, 0xdb, 0xf4, 0x9b, 0x4b, 0x89,
			0xd3, 0xde, 0xf5, 0x55, 0x1c, 0x9e, 0x05, 0xde, 0x7f,
			0xf7, 0x23, 0x6d,
		],
		dq = [
			0x2d, 0x13, 0x96, 0x18, 0x29, 0xf1, 0x5b, 0x97, 0xc4,
			0xe7, 0x48, 0x23, 0x05, 0xbd, 0xb5, 0x81, 0x5e, 0x59,
			0x2e, 0x50, 0x81, 0x64, 0x9e, 0x38, 0x11, 0x09, 0xfe,
			0xbf, 0x32, 0x93, 0x7e, 0x64, 0x10, 0x7f, 0xb0, 0x7c,
			0xa1, 0xa8, 0x3c, 0xc7, 0xb0, 0x0c, 0x96, 0x12, 0x31,
			0xb6, 0x55, 0x0a, 0x06, 0x21, 0x21, 0xf3, 0x38, 0x6d,
			0x68, 0x54, 0xfa, 0x15, 0x9f, 0x46, 0xc6, 0x46, 0xa1,
			0x29, 0x52, 0xd9, 0xbd, 0xf6, 0xc9, 0x01, 0x87, 0x04,
			0x6d, 0xe8, 0x63, 0x7b, 0x34, 0x87, 0x16, 0x9a, 0x5f,
			0x7e, 0x1c, 0x6f, 0x2f, 0xe9, 0x57, 0xb6, 0x91, 0xb7,
			0x78, 0xb0, 0x57, 0x51, 0x91, 0x72, 0x39, 0xd7, 0x14,
			0xa9, 0x28, 0x60, 0xfe, 0x02, 0x1e, 0xa7, 0x10, 0xeb,
			0x75, 0xd9, 0x27, 0x84, 0xd2, 0x1a, 0x7e, 0x3a, 0xb5,
			0xd5, 0x86, 0xaa, 0xa5, 0x37, 0xb2, 0x2c, 0xa5, 0x0b,
			0x98, 0x78, 0x24, 0xf2, 0x86, 0x1f, 0x16, 0x48, 0xb0,
			0x87, 0xeb, 0xe6, 0x8b, 0x43, 0xc7, 0x87, 0xab, 0xd8,
			0xd3, 0xe5, 0x64, 0x54, 0x49, 0x54, 0xb8, 0x2f, 0xc8,
			0x47, 0x47, 0x21, 0xa5, 0xa4, 0x0b, 0x83, 0xf1, 0x9b,
			0x06, 0xd0, 0x65, 0xf0, 0xf1, 0x7d, 0x1f, 0x2e, 0x6a,
			0x04, 0xe2, 0x10, 0x3f, 0xa3, 0x56, 0x2a, 0x64, 0xfd,
			0xa4, 0xbb, 0xb2, 0xe6, 0xd8, 0xdc, 0xa9, 0xa2, 0x3e,
			0xf8, 0x2e, 0x49,
		],
		iq = [
			0x66, 0x80, 0xb0, 0x0c, 0xd2, 0x08, 0xc1, 0x5f, 0x8c,
			0x33, 0xb9, 0xa0, 0x1b, 0x0d, 0xb4, 0xd3, 0x00, 0x3d,
			0xda, 0xd7, 0x46, 0xb4, 0xab, 0xc8, 0xa7, 0x8a, 0xe1,
			0x06, 0x07, 0x5e, 0x34, 0xb2, 0xb3, 0x88, 0x6f, 0xb9,
			0x3d, 0x51, 0x0d, 0x23, 0x9f, 0xa0, 0x65, 0x87, 0x41,
			0x5e, 0x7d, 0xb0, 0x4c, 0xbf, 0xc5, 0xfc, 0x18, 0xbc,
			0x22, 0xd6, 0xae, 0x95, 0xee, 0xad, 0x14, 0xe0, 0x75,
			0xcc, 0x6e, 0xfa, 0xa0, 0xe6, 0x21, 0xd3, 0x1d, 0x1b,
			0x8c, 0xda, 0x4d, 0x24, 0xcc, 0x1e, 0xd9, 0x94, 0x72,
			0xb6, 0x2e, 0xe0, 0x5c, 0xc4, 0x4e, 0x84, 0xfe, 0xe9,
			0xe2, 0x8c, 0xf0, 0x98, 0x07, 0xc3, 0x82, 0x2c, 0xfc,
			0xbe, 0x9e, 0xb5, 0x77, 0xdb, 0x94, 0xf9, 0xc6, 0x84,
			0xdf, 0x36, 0x6f, 0xfe, 0x62, 0x91, 0xda, 0x5b, 0xe2,
			0x6e, 0x73, 0x4d, 0x3b, 0x7a, 0x84, 0xc6, 0x69, 0xb7,
			0x04, 0x6d, 0x1e, 0xa1, 0x7d, 0x5b, 0x50, 0xd9, 0x1b,
			0xda, 0xb4, 0x67, 0xb7, 0x9c, 0x15, 0x49, 0x8b, 0x53,
			0xd2, 0x11, 0xe8, 0x8d, 0x96, 0x96, 0x8f, 0x0b, 0xe2,
			0x4b, 0x7d, 0xca, 0x4a, 0x1e, 0x7f, 0xb2, 0x1c, 0x42,
			0x10, 0x1f, 0x68, 0x1d, 0x7c, 0x47, 0xe3, 0xd6, 0x11,
			0x4a, 0x2d, 0x81, 0xfe, 0xf0, 0x1d, 0xd6, 0x8c, 0xd5,
			0xb0, 0x42, 0x0b, 0x65, 0x4b, 0x18, 0xd9, 0x12, 0x22,
			0xbd, 0x0f, 0x88,
		],
		...
	},
	...
};

let enc4096: keypair = keypair {
	pub = pubparams {
		n = [
			0x00, 0xaf, 0xa5, 0xc5, 0xc6, 0x39, 0x74, 0xc1, 0x5b,
			0x85, 0xba, 0xc9, 0x66, 0x2e, 0x44, 0x9f, 0xd8, 0x75,
			0xbc, 0x14, 0x4e, 0x8b, 0x93, 0x09, 0xa9, 0x32, 0x32,
			0x06, 0xcc, 0x33, 0x40, 0x5f, 0xd1, 0x68, 0xc6, 0x00,
			0x6f, 0xa4, 0xe4, 0xe0, 0x3d, 0xde, 0x7e, 0xed, 0x87,
			0xeb, 0x7e, 0x42, 0xd4, 0xe1, 0xa6, 0xab, 0xfc, 0xf4,
			0xf3, 0x47, 0x46, 0x7d, 0x1c, 0x05, 0x62, 0xaa, 0x6e,
			0x5f, 0x61, 0xe7, 0xca, 0x48, 0xf6, 0xb9, 0x70, 0x23,
			0x9d, 0x50, 0xe3, 0x7d, 0x00, 0x19, 0x78, 0x32, 0xb2,
			0x05, 0x4b, 0xe1, 0x99, 0x6f, 0x1f, 0x57, 0x98, 0x2a,
			0x58, 0x53, 0x45, 0xc8, 0x44, 0x59, 0x68, 0xf2, 0x22,
			0xc4, 0x4e, 0x0e, 0xff, 0xcd, 0x2b, 0x9a, 0x1a, 0x39,
			0xd0, 0x77, 0xff, 0x7c, 0x62, 0x04, 0xc9, 0xb3, 0xfc,
			0xff, 0x66, 0x38, 0x6e, 0x54, 0xc4, 0xa7, 0x56, 0xa2,
			0xf0, 0xab, 0xdf, 0x18, 0x98, 0xd9, 0x6a, 0x12, 0x64,
			0xa0, 0xff, 0x96, 0x89, 0x52, 0x4d, 0xc0, 0x3a, 0x33,
			0x07, 0x73, 0x83, 0x42, 0xd3, 0x30, 0x86, 0xba, 0x29,
			0x69, 0x6b, 0x65, 0x14, 0x93, 0xf5, 0x61, 0xea, 0x40,
			0x28, 0xa2, 0xcb, 0xa2, 0x0c, 0xa4, 0x47, 0x52, 0x40,
			0x05, 0x95, 0xc4, 0x4a, 0x1d, 0x2c, 0x93, 0x5a, 0x67,
			0x31, 0xac, 0x95, 0x42, 0x2e, 0x9c, 0x07, 0x22, 0x6a,
			0xaa, 0x60, 0x38, 0x8e, 0xab, 0x97, 0x09, 0x0a, 0x63,
			0x43, 0x57, 0x0b, 0x58, 0x02, 0x55, 0x3d, 0x78, 0xba,
			0xcb, 0x80, 0x29, 0x84, 0xc3, 0xd2, 0x08, 0x8a, 0xce,
			0xc5, 0x41, 0x04, 0x85, 0x6d, 0xad, 0xbb, 0x30, 0x09,
			0x32, 0x8b, 0x32, 0x95, 0xcb, 0xd6, 0x9c, 0x2a, 0xfc,
			0x52, 0x5e, 0xf8, 0xbc, 0x7b, 0x1f, 0x97, 0x09, 0xbc,
			0x84, 0x67, 0xf3, 0xf4, 0x2d, 0x5c, 0xc5, 0x5b, 0x30,
			0xcd, 0x85, 0xee, 0xbc, 0x44, 0xd1, 0x45, 0x09, 0x9f,
			0xa2, 0x62, 0xf6, 0x2b, 0xe9, 0xe1, 0x4e, 0x08, 0x3d,
			0xf7, 0x78, 0xd8, 0x4e, 0x6e, 0xec, 0x87, 0x0a, 0x9d,
			0x6d, 0x17, 0x33, 0xa2, 0x9a, 0x28, 0x10, 0x42, 0xfc,
			0x34, 0xd7, 0x86, 0x4c, 0x21, 0x97, 0x9e, 0xae, 0xe4,
			0x36, 0x6e, 0xd2, 0xdf, 0x4f, 0xe8, 0xd6, 0xcc, 0xd7,
			0x82, 0xb9, 0xb0, 0x6e, 0x8c, 0x19, 0x08, 0xa5, 0xca,
			0x44, 0x47, 0x52, 0x83, 0x26, 0x66, 0xe8, 0x54, 0x18,
			0x80, 0x11, 0x69, 0x11, 0x4e, 0x00, 0x59, 0xf2, 0x62,
			0x9b, 0x57, 0x87, 0xb3, 0x87, 0xd3, 0x17, 0xaf, 0x87,
			0x20, 0xeb, 0x90, 0x7f, 0x19, 0xd9, 0x3f, 0xee, 0x98,
			0xe6, 0xcf, 0x26, 0x1f, 0x20, 0xef, 0xf6, 0x77, 0x5b,
			0xc7, 0x01, 0x89, 0x8b, 0x77, 0xf9, 0x13, 0x89, 0xfb,
			0x9d, 0xb8, 0x3f, 0x82, 0x05, 0x66, 0xa9, 0xd9, 0x72,
			0x66, 0x2c, 0xda, 0x19, 0x56, 0x18, 0x1e, 0xf8, 0x12,
			0x1f, 0x61, 0x8b, 0xa9, 0x6e, 0x75, 0x0e, 0x40, 0x33,
			0xfd, 0xde, 0x70, 0x62, 0xc2, 0x0a, 0x30, 0x0c, 0x46,
			0x8f, 0x22, 0xc9, 0x15, 0x31, 0x6c, 0xc8, 0xfd, 0xdd,
			0xc5, 0x9e, 0x6b, 0x41, 0x46, 0x9f, 0x32, 0xac, 0x3d,
			0xc4, 0xd6, 0x61, 0x80, 0x8e, 0x12, 0x3b, 0x7c, 0xb2,
			0xda, 0x07, 0x80, 0xd8, 0xf5, 0x07, 0xcd, 0xe6, 0x74,
			0x9d, 0x4f, 0x09, 0x54, 0x24, 0x3d, 0x02, 0xf8, 0x96,
			0x10, 0x58, 0x4f, 0x78, 0x30, 0xbc, 0x98, 0x01, 0xf6,
			0xa3, 0x80, 0x58, 0x64, 0x07, 0x50, 0x5d, 0x06, 0x1e,
			0xe9, 0x77, 0xf5, 0x65, 0xe5, 0x90, 0xf9, 0x63, 0x73,
			0x9f, 0xd3, 0x9d, 0xc7, 0xba, 0xc1, 0x79, 0x28, 0x7f,
			0xfd, 0xce, 0x28, 0x84, 0xb8, 0x49, 0x78, 0x9b, 0xb4,
			0x6e, 0x7b, 0xe5, 0xeb, 0x1d, 0x9f, 0xc8, 0x63, 0xd5,
			0x99, 0x05, 0x2d, 0x73, 0x8e, 0xe1, 0x32, 0xaa, 0x2d,
		],
		e = [0x10, 0x00, 0x01],
		...
	},
	priv = privparams {
		nbitlen = 4096,
		p = [
			0x00, 0xd9, 0x34, 0x08, 0x8a, 0x7c, 0x2f, 0xe7, 0x38,
			0x7d, 0x7e, 0xc9, 0x30, 0xb5, 0x05, 0x2b, 0x5f, 0x93,
			0xd3, 0xf8, 0xee, 0x13, 0x2a, 0x81, 0xec, 0x6d, 0x69,
			0x35, 0x8b, 0x7c, 0x92, 0x0b, 0xae, 0x5b, 0x8d, 0x4c,
			0x8d, 0x0c, 0x08, 0x77, 0x39, 0xf0, 0xde, 0x2b, 0x9e,
			0x48, 0x87, 0xc4, 0x2f, 0x15, 0x80, 0x30, 0x94, 0x18,
			0xfe, 0x72, 0x5e, 0x3d, 0x6b, 0x82, 0x29, 0xca, 0xd6,
			0xe7, 0xa5, 0x7e, 0x8b, 0x26, 0x23, 0xee, 0x2e, 0x6d,
			0xe8, 0x00, 0x53, 0x1a, 0xaa, 0x9c, 0x2f, 0xc7, 0xfb,
			0xab, 0x10, 0x3d, 0xb9, 0x84, 0x15, 0x73, 0xbb, 0x18,
			0xfe, 0x45, 0xa7, 0x70, 0x74, 0xdc, 0x9e, 0x39, 0xe6,
			0x61, 0xa9, 0x6a, 0x06, 0xb3, 0xa5, 0x35, 0x57, 0x3b,
			0x7b, 0xa9, 0xb7, 0xe1, 0xd7, 0x56, 0x00, 0xa9, 0x03,
			0xd8, 0x33, 0xe4, 0x5a, 0x76, 0x4f, 0x8f, 0x14, 0xcc,
			0xe2, 0xf2, 0xf7, 0xf0, 0x10, 0x3f, 0xd4, 0x5d, 0x02,
			0x49, 0xb7, 0xf8, 0x47, 0x32, 0x4c, 0x13, 0x6c, 0xfb,
			0xf5, 0xf5, 0x8a, 0x43, 0xcb, 0xa7, 0xb4, 0x8d, 0xd5,
			0x11, 0x39, 0x99, 0x1b, 0xe1, 0x81, 0x0b, 0x1b, 0x4e,
			0x1f, 0x15, 0xf9, 0x60, 0x98, 0x5c, 0x0a, 0x89, 0x72,
			0x2b, 0x25, 0xfb, 0x11, 0xfb, 0x8f, 0x4f, 0x21, 0x3c,
			0x3a, 0xe9, 0xd1, 0xca, 0x36, 0x64, 0xaf, 0xbf, 0xac,
			0x5e, 0xee, 0x92, 0x98, 0xa6, 0xd0, 0x4d, 0x74, 0x1d,
			0x68, 0xfe, 0x84, 0xd4, 0x8d, 0xa8, 0x44, 0xac, 0x63,
			0xf7, 0xbb, 0x9c, 0xaa, 0x65, 0x3a, 0xe9, 0x4b, 0x12,
			0xb8, 0x28, 0xbf, 0xf1, 0x58, 0x44, 0x32, 0xe6, 0x59,
			0x10, 0xb5, 0x5d, 0xd0, 0x03, 0xf7, 0x8d, 0x42, 0xcc,
			0x61, 0x24, 0xe1, 0xf1, 0x2f, 0x7a, 0x4b, 0xf6, 0x97,
			0x1e, 0x75, 0xa1, 0xec, 0xd9, 0x0b, 0x64, 0x46, 0xae,
			0x67, 0x5b, 0x7d, 0xc5, 0x63,
		],
		q = [
			0x00, 0xcf, 0x05, 0x89, 0xb9, 0x51, 0x83, 0xd3, 0xab,
			0xed, 0xe4, 0x61, 0x35, 0x3c, 0x48, 0xbe, 0xb6, 0x15,
			0x87, 0x4e, 0xab, 0x18, 0xef, 0x23, 0x6d, 0x37, 0xcf,
			0x39, 0xe7, 0x64, 0x4e, 0x58, 0xaa, 0xe9, 0x3a, 0xb5,
			0x23, 0x45, 0xc9, 0xe5, 0x4f, 0xad, 0xa9, 0x10, 0x30,
			0xdf, 0x5d, 0x06, 0x20, 0x16, 0xc6, 0x5e, 0x2a, 0x49,
			0xbd, 0x2d, 0x14, 0xe3, 0x32, 0x96, 0xfa, 0x50, 0x5d,
			0xfc, 0x9b, 0x44, 0x60, 0xa7, 0x36, 0x59, 0x62, 0xe9,
			0xba, 0x8e, 0x15, 0x5b, 0x52, 0xd3, 0x6d, 0x84, 0x02,
			0x90, 0x0d, 0xee, 0xb8, 0x60, 0x7b, 0x68, 0x80, 0x1f,
			0xf2, 0xe2, 0x2a, 0xe3, 0x9a, 0xfb, 0x0d, 0x97, 0xae,
			0x34, 0x65, 0x32, 0xfd, 0x13, 0xf2, 0x77, 0xfd, 0x21,
			0x79, 0x48, 0x39, 0xb3, 0xd4, 0x19, 0x29, 0x0c, 0x42,
			0xcb, 0xd5, 0x6a, 0x6c, 0xed, 0x48, 0xfa, 0x54, 0x83,
			0x16, 0x04, 0x73, 0xd6, 0xbc, 0xb2, 0xc9, 0xb2, 0xd4,
			0x6b, 0xbb, 0x5f, 0xb1, 0x69, 0xd3, 0x51, 0x3c, 0x29,
			0x77, 0xba, 0xcf, 0x83, 0xc4, 0xe7, 0x84, 0xf6, 0x0c,
			0xdc, 0xfa, 0x55, 0x1b, 0xa3, 0xb4, 0xa1, 0xc0, 0x8a,
			0x61, 0xfa, 0x79, 0x1b, 0x82, 0xb3, 0xb0, 0xaa, 0xc0,
			0xed, 0xe2, 0xf9, 0x69, 0x1c, 0x8a, 0x17, 0x56, 0xa9,
			0xc1, 0xbb, 0x86, 0xe7, 0xff, 0xfe, 0x71, 0xcc, 0xa2,
			0xea, 0xe4, 0x92, 0x8b, 0xed, 0xcc, 0x3e, 0x10, 0xd6,
			0x4a, 0x53, 0xea, 0xdf, 0x53, 0xf5, 0x0c, 0x2b, 0x7d,
			0x84, 0x54, 0x6e, 0xac, 0xb8, 0x57, 0x1e, 0xd3, 0x8c,
			0xc4, 0x92, 0xae, 0x6a, 0x1d, 0x6f, 0x1d, 0x44, 0xfe,
			0xc8, 0x61, 0xf8, 0x4e, 0xd9, 0xc6, 0x61, 0xef, 0xc9,
			0x5d, 0xc1, 0xc6, 0x64, 0xfa, 0x42, 0xf5, 0x46, 0x39,
			0x6e, 0xa0, 0x7a, 0x70, 0xb2, 0x20, 0xbc, 0x1e, 0xf8,
			0xb4, 0x91, 0x1c, 0xef, 0x2f,
		],
		dp = [
			0x4f, 0xcd, 0x85, 0x61, 0xd4, 0x55, 0x09, 0x60, 0x41,
			0x03, 0xa7, 0x4a, 0x05, 0x08, 0x7c, 0x32, 0x26, 0xaf,
			0x58, 0x23, 0xa8, 0xd9, 0x12, 0x59, 0x5a, 0xad, 0xb0,
			0x25, 0xaa, 0xc4, 0x42, 0x14, 0x72, 0xc0, 0xcc, 0xa2,
			0x7a, 0x0c, 0x56, 0x39, 0xec, 0x9c, 0xc4, 0x6b, 0xe8,
			0x7c, 0x31, 0x81, 0x97, 0x25, 0xbd, 0x33, 0x7c, 0xa7,
			0x68, 0x3f, 0xe5, 0xd3, 0x2d, 0x44, 0xcb, 0xa8, 0xff,
			0xfd, 0x57, 0x2c, 0x2a, 0xfc, 0x42, 0x93, 0xbe, 0x7f,
			0xe2, 0x36, 0xa6, 0x72, 0x8e, 0xe6, 0x23, 0x54, 0xfd,
			0x39, 0xff, 0x63, 0xbc, 0xfa, 0xe0, 0xc5, 0x9a, 0x5e,
			0x3a, 0x1b, 0x55, 0xff, 0x29, 0xdb, 0xdc, 0xac, 0x1f,
			0xaf, 0xce, 0x2b, 0xde, 0x2f, 0x52, 0x14, 0xd5, 0xdf,
			0x0e, 0xb1, 0x68, 0x01, 0xe5, 0x30, 0x62, 0xe8, 0xed,
			0xb3, 0xcb, 0x2f, 0xcd, 0x8e, 0x57, 0xa4, 0xad, 0xce,
			0xa8, 0xb4, 0x9d, 0xf8, 0x6a, 0x6b, 0x4d, 0x2c, 0xfd,
			0x06, 0xe1, 0xea, 0xce, 0xb9, 0x12, 0xde, 0x15, 0x08,
			0xfe, 0x89, 0x29, 0x75, 0x97, 0x0d, 0x88, 0x9b, 0x03,
			0x34, 0x25, 0x64, 0x10, 0x0b, 0x88, 0x98, 0x24, 0xb0,
			0xd9, 0x33, 0x01, 0xe1, 0x98, 0xd7, 0xaa, 0x3e, 0x4f,
			0x4a, 0x2a, 0x20, 0x26, 0x4c, 0x36, 0x27, 0xa0, 0xe8,
			0x88, 0x66, 0x33, 0x24, 0x9f, 0x03, 0xcf, 0xa9, 0xb6,
			0x4b, 0x73, 0x83, 0x30, 0xaf, 0x11, 0xf6, 0x1a, 0xa4,
			0x2b, 0xf7, 0x83, 0xdc, 0xf4, 0x39, 0x1f, 0x19, 0xaf,
			0xb8, 0xb7, 0xcc, 0x07, 0x5b, 0x88, 0xc1, 0xb3, 0x84,
			0x04, 0x3c, 0xd9, 0xa0, 0xb3, 0x95, 0xfb, 0xfa, 0x37,
			0x60, 0x5b, 0xb2, 0x84, 0xf2, 0x9c, 0x6d, 0x31, 0x88,
			0x73, 0xb3, 0xac, 0x18, 0xe4, 0x97, 0x2a, 0x67, 0xc5,
			0xa2, 0x34, 0xb7, 0x3f, 0xdb, 0xa6, 0xa1, 0x2d, 0x8c,
			0xfe, 0x19, 0x8c, 0xbf,
		],
		dq = [
			0x00, 0xcb, 0x6c, 0x77, 0xae, 0xa0, 0x08, 0xd7, 0xa0,
			0x23, 0xfc, 0xbc, 0x00, 0x61, 0xa2, 0x61, 0xb3, 0xee,
			0x67, 0xac, 0xc7, 0xb7, 0x92, 0x94, 0xcf, 0x27, 0x7d,
			0xfb, 0x3a, 0x02, 0x78, 0x71, 0xec, 0x4f, 0x8d, 0x9e,
			0x9c, 0x70, 0x61, 0x39, 0x71, 0x18, 0x05, 0xfe, 0xa0,
			0xe7, 0x7b, 0x33, 0x1f, 0xa9, 0x01, 0x77, 0x5a, 0x3a,
			0x67, 0x27, 0xbb, 0x54, 0x9d, 0x4b, 0x79, 0xe0, 0x2a,
			0xda, 0xa3, 0x7f, 0x87, 0x32, 0x07, 0xd7, 0xc1, 0xb8,
			0x45, 0xd6, 0x83, 0xe9, 0xde, 0xf3, 0x5e, 0xb3, 0xcf,
			0x08, 0xda, 0x87, 0xee, 0xa8, 0xef, 0xda, 0xf9, 0xbb,
			0x6b, 0x21, 0x0e, 0x5f, 0xe4, 0xd4, 0x38, 0xc1, 0x09,
			0x2e, 0xf7, 0x1a, 0x29, 0x50, 0xc6, 0x7b, 0x5d, 0x42,
			0xdd, 0x38, 0x39, 0x6b, 0x19, 0x49, 0x37, 0xea, 0x92,
			0x60, 0x54, 0xef, 0x64, 0xe5, 0xad, 0x46, 0x3e, 0x71,
			0x28, 0xdb, 0x6b, 0x30, 0x60, 0xef, 0x95, 0xfe, 0xa1,
			0x78, 0xd2, 0xff, 0xef, 0x07, 0x3b, 0xdc, 0xa1, 0x2f,
			0x66, 0x35, 0x2c, 0xe0, 0x20, 0x46, 0x17, 0x82, 0xe7,
			0x94, 0xe4, 0x6f, 0x68, 0xdf, 0x6e, 0x09, 0x5b, 0x77,
			0x1f, 0x5b, 0xce, 0x51, 0x58, 0x17, 0x55, 0xcc, 0x14,
			0x14, 0x2d, 0x6a, 0x42, 0xfd, 0x06, 0x3c, 0x74, 0xae,
			0x0e, 0x6e, 0x44, 0xdc, 0x07, 0xd2, 0x70, 0xe4, 0x52,
			0x5a, 0x5a, 0x0c, 0x1e, 0x6f, 0xa6, 0xb8, 0x7e, 0x36,
			0xf3, 0x86, 0x8e, 0x4e, 0xb0, 0xe3, 0x23, 0xf8, 0x40,
			0x38, 0x1d, 0xf7, 0x3a, 0xc5, 0x50, 0xe6, 0x3b, 0x9e,
			0x21, 0x32, 0xb9, 0x2c, 0x10, 0x8c, 0x34, 0xc8, 0xad,
			0x4b, 0x1d, 0xe9, 0xaf, 0x21, 0x93, 0x2c, 0x7d, 0x40,
			0xf3, 0x5e, 0x0b, 0xa3, 0x01, 0xbf, 0x75, 0xe0, 0x71,
			0x62, 0xe1, 0x52, 0x2f, 0x16, 0xf9, 0xcf, 0xa0, 0xe7,
			0x66, 0x17, 0x09, 0xc5, 0x85,
		],
		iq = [
			0x00, 0xcc, 0x1c, 0x14, 0x9c, 0x4f, 0x16, 0xa4, 0x5c,
			0x14, 0x37, 0x53, 0xde, 0xf7, 0xf4, 0x74, 0x76, 0xc8,
			0xb1, 0x62, 0x49, 0x42, 0xcf, 0xbf, 0x65, 0xe5, 0x8f,
			0x4c, 0xb6, 0x7d, 0x59, 0x41, 0x87, 0x32, 0x8c, 0x9b,
			0x9f, 0x96, 0x9e, 0xb1, 0xf0, 0x2e, 0x4b, 0xa2, 0xc2,
			0xab, 0x01, 0x19, 0x19, 0x6c, 0x79, 0x01, 0xc8, 0x52,
			0xff, 0xd4, 0xbd, 0xd8, 0xba, 0xeb, 0xc1, 0x70, 0xea,
			0xfb, 0x37, 0x31, 0x79, 0x16, 0xe0, 0x78, 0x79, 0xaf,
			0x41, 0x37, 0xaa, 0x4e, 0x2c, 0xdc, 0x1d, 0x1b, 0xdc,
			0x44, 0x1e, 0x03, 0x2e, 0xd0, 0x17, 0x25, 0x23, 0x67,
			0xd2, 0x7b, 0xea, 0xc2, 0x91, 0xb7, 0x9a, 0x31, 0xa5,
			0xff, 0xbd, 0x36, 0x07, 0xae, 0xd7, 0xec, 0x05, 0xb9,
			0x05, 0x31, 0x16, 0xc4, 0x29, 0xf9, 0x23, 0x0c, 0x6d,
			0x2e, 0xc3, 0x0b, 0x6a, 0xc9, 0xe2, 0xab, 0x8b, 0x05,
			0x8b, 0xb4, 0xc2, 0x4d, 0xbf, 0xa7, 0x6b, 0xa4, 0x00,
			0x23, 0x82, 0xb4, 0xfa, 0x8d, 0xcf, 0x0d, 0x31, 0x8e,
			0xd6, 0xbc, 0xc2, 0x15, 0xae, 0x8c, 0xa7, 0x0f, 0xd0,
			0xf4, 0x5b, 0x87, 0x6a, 0xd0, 0x9f, 0xa5, 0xb4, 0x5c,
			0xd7, 0xbf, 0xca, 0x40, 0x82, 0x44, 0x00, 0xf9, 0xda,
			0x06, 0x4e, 0x8c, 0x48, 0x8f, 0x11, 0xf3, 0x64, 0x05,
			0x55, 0x8d, 0xfb, 0x39, 0xf8, 0x91, 0x8a, 0x83, 0xd6,
			0x73, 0x05, 0x1f, 0x4c, 0xed, 0x47, 0x96, 0xf5, 0x73,
			0xe8, 0xf9, 0xb3, 0xeb, 0x91, 0xe4, 0xea, 0x0e, 0xb8,
			0xd5, 0xa8, 0xf2, 0x60, 0xcc, 0x05, 0x5b, 0x1d, 0x9b,
			0xe5, 0xe4, 0xe5, 0x36, 0x0b, 0x2b, 0xc0, 0xd2, 0x1c,
			0x55, 0xd6, 0x68, 0xb6, 0xd8, 0x56, 0x83, 0x80, 0x22,
			0x44, 0x34, 0x9b, 0x2b, 0x71, 0xc1, 0x4b, 0xca, 0x36,
			0x41, 0x2a, 0x2e, 0xff, 0x23, 0x8b, 0x0a, 0x16, 0x76,
			0x56, 0xb6, 0x8e, 0x3b, 0x69,
		],
		...
	},
	d = [
		0x54, 0x76, 0xd8, 0x0b, 0x41, 0x77, 0xe6, 0xbf, 0x77, 0x28,
		0x62, 0x4e, 0xf3, 0xb2, 0xe6, 0x56, 0xf6, 0x0e, 0xd2, 0x89,
		0x0e, 0xcf, 0x4f, 0x57, 0x00, 0x9f, 0x53, 0xeb, 0x80, 0x3d,
		0xd5, 0x95, 0xe2, 0xd7, 0x4c, 0x40, 0x63, 0xbf, 0xf8, 0x21,
		0x68, 0x4c, 0x0b, 0x37, 0x50, 0x44, 0x30, 0x29, 0x24, 0xb5,
		0xbc, 0x80, 0xf0, 0xdd, 0xc8, 0x09, 0x9a, 0x82, 0x0e, 0x08,
		0xeb, 0x42, 0x16, 0x36, 0x03, 0x7b, 0x9f, 0xe8, 0x9d, 0x35,
		0xd2, 0xba, 0x84, 0xba, 0x50, 0x52, 0xea, 0xec, 0x85, 0x1c,
		0x5c, 0x35, 0xa8, 0x2f, 0xdb, 0x62, 0xec, 0x01, 0x6d, 0x63,
		0x79, 0xef, 0xd5, 0xa5, 0x20, 0x85, 0xb9, 0xe2, 0x84, 0x19,
		0xb1, 0x56, 0xcb, 0x37, 0xcb, 0x6c, 0x0f, 0x1f, 0x33, 0x85,
		0x35, 0x30, 0x01, 0x73, 0x69, 0x4d, 0x21, 0x17, 0xeb, 0xcd,
		0x0a, 0x90, 0x62, 0x93, 0xe3, 0xd8, 0xee, 0x1d, 0x63, 0x3b,
		0xa5, 0x59, 0x3f, 0xad, 0x0a, 0x4a, 0xbd, 0xfe, 0x1d, 0x08,
		0xec, 0x86, 0x50, 0x21, 0xa6, 0x27, 0x99, 0xcb, 0xea, 0xca,
		0xee, 0xdc, 0x99, 0x28, 0x1e, 0xbc, 0x6d, 0x86, 0x13, 0x66,
		0xcd, 0x21, 0x7d, 0x5f, 0x84, 0xf6, 0xa5, 0x4c, 0xf2, 0xbd,
		0x7c, 0xb2, 0x0f, 0x69, 0x40, 0x6c, 0x3e, 0x13, 0xbc, 0x0a,
		0x04, 0x1e, 0xe6, 0x6b, 0x79, 0x76, 0x68, 0xd3, 0x78, 0x48,
		0xbb, 0x09, 0xc8, 0x73, 0xe1, 0xd2, 0x0f, 0xf7, 0xc2, 0xf4,
		0xde, 0x86, 0x88, 0xac, 0xfd, 0xd0, 0x7d, 0xa9, 0x8c, 0xcd,
		0x9e, 0x48, 0xf2, 0xf8, 0xa5, 0x03, 0xf0, 0x07, 0x17, 0x8e,
		0xad, 0x7b, 0x95, 0x56, 0xe6, 0xea, 0x4f, 0x11, 0xff, 0xaa,
		0x9d, 0x00, 0x82, 0xc3, 0xad, 0x8d, 0xd9, 0x3d, 0x2f, 0xec,
		0xb6, 0xae, 0xe3, 0xd1, 0x05, 0x5c, 0x07, 0x30, 0x54, 0x6b,
		0x4c, 0xa5, 0x98, 0x61, 0x3c, 0x40, 0xe3, 0x8c, 0xf3, 0x01,
		0xc2, 0xdd, 0xdd, 0x18, 0xbd, 0x38, 0x35, 0x34, 0x87, 0xbf,
		0x05, 0xba, 0x8e, 0x1d, 0x4b, 0x33, 0x63, 0xcc, 0x65, 0x11,
		0xbf, 0x59, 0x48, 0x5e, 0x46, 0x82, 0x17, 0xda, 0x6b, 0xcf,
		0x7c, 0x06, 0xca, 0x74, 0xbd, 0xa9, 0x78, 0xe0, 0xd2, 0x20,
		0xdf, 0xcd, 0x4a, 0xa0, 0x67, 0xe6, 0x90, 0x14, 0x43, 0x20,
		0x26, 0x47, 0x83, 0x79, 0xc0, 0xe8, 0xb7, 0x60, 0xb7, 0xa8,
		0x96, 0x56, 0x77, 0xc4, 0x9d, 0x32, 0x52, 0xc3, 0xa2, 0x10,
		0x69, 0x2c, 0x51, 0x81, 0xc5, 0xd2, 0xa2, 0x27, 0x61, 0xf4,
		0x0a, 0xa7, 0x51, 0xe8, 0x44, 0xcb, 0xae, 0xbe, 0xb1, 0x10,
		0x75, 0xaa, 0x1c, 0xae, 0x5e, 0xa8, 0x8d, 0x16, 0x6a, 0x4c,
		0xf4, 0x26, 0x7a, 0xce, 0x61, 0x70, 0xaf, 0x86, 0x9b, 0x4c,
		0xca, 0x26, 0x51, 0xe4, 0xcd, 0xb5, 0x7a, 0x4e, 0xe2, 0xe8,
		0x8a, 0xbc, 0x70, 0xcc, 0x1a, 0xc6, 0x54, 0x07, 0x51, 0x14,
		0xfd, 0x08, 0x58, 0xba, 0x46, 0xca, 0xa2, 0x2e, 0xf0, 0x4c,
		0x0e, 0xc3, 0x5d, 0xd9, 0x53, 0x4d, 0xbe, 0x8c, 0x2f, 0x28,
		0x38, 0xf4, 0x26, 0x84, 0x59, 0xba, 0x07, 0xbc, 0xf0, 0xaf,
		0x74, 0xb6, 0x4b, 0xf6, 0xdc, 0xab, 0x21, 0xbb, 0xab, 0x5c,
		0x97, 0x29, 0x48, 0x87, 0x00, 0x27, 0xf7, 0x58, 0xbb, 0x1d,
		0xad, 0x66, 0x50, 0x77, 0x33, 0xfc, 0xb2, 0xc2, 0x8f, 0x4c,
		0x3b, 0x4f, 0xab, 0xb4, 0x8f, 0x87, 0x00, 0x3d, 0x55, 0xf3,
		0x23, 0xce, 0x22, 0xde, 0x74, 0x29, 0x3e, 0xf0, 0xe8, 0x04,
		0x14, 0xf7, 0x36, 0xb1, 0x1b, 0xcf, 0xbc, 0x9b, 0x5d, 0x3d,
		0x75, 0xfc, 0x15, 0xcb, 0x3d, 0x2d, 0x8f, 0xaf, 0x1e, 0x12,
		0xe8, 0xb4, 0x94, 0xac, 0x64, 0x1b, 0x7c, 0x54, 0x1c, 0xeb,
		0x47, 0x40, 0xe3, 0x2b, 0x48, 0x3c, 0xd8, 0x10, 0xf3, 0x93,
		0xdb, 0x75,
	],
};

@test fn initd() void = {
	let params = privparams {
		p = enc4096.priv.p,
		q = enc4096.priv.q,
		iq = enc4096.priv.iq,
		...
	};

	let priv: [PRIVKEYSZ]u8 = [0...];
	privkey_initd(priv, params, enc4096.d, enc4096.pub.n)!;

	const newparams = privkey_params(priv);

	assert(enc4096.priv.nbitlen == newparams.nbitlen);
	assert(enc4096.priv.nbitlen == privkey_nbitlen(priv));
	assert(bytes::equal(ltrim(enc4096.priv.dp), ltrim(newparams.dp)));
	assert(bytes::equal(ltrim(enc4096.priv.dq), ltrim(newparams.dq)));
};
