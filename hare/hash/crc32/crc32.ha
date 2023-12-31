// SPDX-License-Identifier: MPL-2.0
// (c) Hare authors <https://harelang.org>

use endian;
use hash;
use io;
use strings;

// The size, in bytes, of a CRC-32 checksum.
export def SZ: size = 4;

// IEEE polynomial for CRC-32. Used in ethernet, SATA, MPEG-2, gzip, bzip2,
// cksum, PNG, etc. It is by far the most common polynomial used.
export def IEEE: u32 = 0xedb88320;

// Castagnoli polynomial for CRC-32. Used in iSCSI, SCTP, SSE4.2, btrfs, ext4,
// and others. It's known to have better error detection than IEEE.
export def CASTAGNOLI: u32 = 0x82f63b78;

// Koopman polnomial for CRC-32. It has good performance for small datasets, but
// poor performance for large ones. Like the Castagnoli polynomial, it has
// better error detection than the IEEE polynomial.
export def KOOPMAN: u32 = 0xeb31d82e;

// Table of memoized values for each byte with the IEEE polynomial.
export const ieee_table: [256]u32 = [
	0x00000000, 0x77073096, 0xEE0E612C, 0x990951BA, 0x076DC419, 0x706AF48F,
	0xE963A535, 0x9E6495A3, 0x0EDB8832, 0x79DCB8A4, 0xE0D5E91E, 0x97D2D988,
	0x09B64C2B, 0x7EB17CBD, 0xE7B82D07, 0x90BF1D91, 0x1DB71064, 0x6AB020F2,
	0xF3B97148, 0x84BE41DE, 0x1ADAD47D, 0x6DDDE4EB, 0xF4D4B551, 0x83D385C7,
	0x136C9856, 0x646BA8C0, 0xFD62F97A, 0x8A65C9EC, 0x14015C4F, 0x63066CD9,
	0xFA0F3D63, 0x8D080DF5, 0x3B6E20C8, 0x4C69105E, 0xD56041E4, 0xA2677172,
	0x3C03E4D1, 0x4B04D447, 0xD20D85FD, 0xA50AB56B, 0x35B5A8FA, 0x42B2986C,
	0xDBBBC9D6, 0xACBCF940, 0x32D86CE3, 0x45DF5C75, 0xDCD60DCF, 0xABD13D59,
	0x26D930AC, 0x51DE003A, 0xC8D75180, 0xBFD06116, 0x21B4F4B5, 0x56B3C423,
	0xCFBA9599, 0xB8BDA50F, 0x2802B89E, 0x5F058808, 0xC60CD9B2, 0xB10BE924,
	0x2F6F7C87, 0x58684C11, 0xC1611DAB, 0xB6662D3D, 0x76DC4190, 0x01DB7106,
	0x98D220BC, 0xEFD5102A, 0x71B18589, 0x06B6B51F, 0x9FBFE4A5, 0xE8B8D433,
	0x7807C9A2, 0x0F00F934, 0x9609A88E, 0xE10E9818, 0x7F6A0DBB, 0x086D3D2D,
	0x91646C97, 0xE6635C01, 0x6B6B51F4, 0x1C6C6162, 0x856530D8, 0xF262004E,
	0x6C0695ED, 0x1B01A57B, 0x8208F4C1, 0xF50FC457, 0x65B0D9C6, 0x12B7E950,
	0x8BBEB8EA, 0xFCB9887C, 0x62DD1DDF, 0x15DA2D49, 0x8CD37CF3, 0xFBD44C65,
	0x4DB26158, 0x3AB551CE, 0xA3BC0074, 0xD4BB30E2, 0x4ADFA541, 0x3DD895D7,
	0xA4D1C46D, 0xD3D6F4FB, 0x4369E96A, 0x346ED9FC, 0xAD678846, 0xDA60B8D0,
	0x44042D73, 0x33031DE5, 0xAA0A4C5F, 0xDD0D7CC9, 0x5005713C, 0x270241AA,
	0xBE0B1010, 0xC90C2086, 0x5768B525, 0x206F85B3, 0xB966D409, 0xCE61E49F,
	0x5EDEF90E, 0x29D9C998, 0xB0D09822, 0xC7D7A8B4, 0x59B33D17, 0x2EB40D81,
	0xB7BD5C3B, 0xC0BA6CAD, 0xEDB88320, 0x9ABFB3B6, 0x03B6E20C, 0x74B1D29A,
	0xEAD54739, 0x9DD277AF, 0x04DB2615, 0x73DC1683, 0xE3630B12, 0x94643B84,
	0x0D6D6A3E, 0x7A6A5AA8, 0xE40ECF0B, 0x9309FF9D, 0x0A00AE27, 0x7D079EB1,
	0xF00F9344, 0x8708A3D2, 0x1E01F268, 0x6906C2FE, 0xF762575D, 0x806567CB,
	0x196C3671, 0x6E6B06E7, 0xFED41B76, 0x89D32BE0, 0x10DA7A5A, 0x67DD4ACC,
	0xF9B9DF6F, 0x8EBEEFF9, 0x17B7BE43, 0x60B08ED5, 0xD6D6A3E8, 0xA1D1937E,
	0x38D8C2C4, 0x4FDFF252, 0xD1BB67F1, 0xA6BC5767, 0x3FB506DD, 0x48B2364B,
	0xD80D2BDA, 0xAF0A1B4C, 0x36034AF6, 0x41047A60, 0xDF60EFC3, 0xA867DF55,
	0x316E8EEF, 0x4669BE79, 0xCB61B38C, 0xBC66831A, 0x256FD2A0, 0x5268E236,
	0xCC0C7795, 0xBB0B4703, 0x220216B9, 0x5505262F, 0xC5BA3BBE, 0xB2BD0B28,
	0x2BB45A92, 0x5CB36A04, 0xC2D7FFA7, 0xB5D0CF31, 0x2CD99E8B, 0x5BDEAE1D,
	0x9B64C2B0, 0xEC63F226, 0x756AA39C, 0x026D930A, 0x9C0906A9, 0xEB0E363F,
	0x72076785, 0x05005713, 0x95BF4A82, 0xE2B87A14, 0x7BB12BAE, 0x0CB61B38,
	0x92D28E9B, 0xE5D5BE0D, 0x7CDCEFB7, 0x0BDBDF21, 0x86D3D2D4, 0xF1D4E242,
	0x68DDB3F8, 0x1FDA836E, 0x81BE16CD, 0xF6B9265B, 0x6FB077E1, 0x18B74777,
	0x88085AE6, 0xFF0F6A70, 0x66063BCA, 0x11010B5C, 0x8F659EFF, 0xF862AE69,
	0x616BFFD3, 0x166CCF45, 0xA00AE278, 0xD70DD2EE, 0x4E048354, 0x3903B3C2,
	0xA7672661, 0xD06016F7, 0x4969474D, 0x3E6E77DB, 0xAED16A4A, 0xD9D65ADC,
	0x40DF0B66, 0x37D83BF0, 0xA9BCAE53, 0xDEBB9EC5, 0x47B2CF7F, 0x30B5FFE9,
	0xBDBDF21C, 0xCABAC28A, 0x53B39330, 0x24B4A3A6, 0xBAD03605, 0xCDD70693,
	0x54DE5729, 0x23D967BF, 0xB3667A2E, 0xC4614AB8, 0x5D681B02, 0x2A6F2B94,
	0xB40BBE37, 0xC30C8EA1, 0x5A05DF1B, 0x2D02EF8D
];

// Table of memoized values for each byte with the Castagnoli polynomial.
export const castagnoli_table: [256]u32 = [
	0x00000000, 0xF26B8303, 0xE13B70F7, 0x1350F3F4, 0xC79A971F, 0x35F1141C,
	0x26A1E7E8, 0xD4CA64EB, 0x8AD958CF, 0x78B2DBCC, 0x6BE22838, 0x9989AB3B,
	0x4D43CFD0, 0xBF284CD3, 0xAC78BF27, 0x5E133C24, 0x105EC76F, 0xE235446C,
	0xF165B798, 0x030E349B, 0xD7C45070, 0x25AFD373, 0x36FF2087, 0xC494A384,
	0x9A879FA0, 0x68EC1CA3, 0x7BBCEF57, 0x89D76C54, 0x5D1D08BF, 0xAF768BBC,
	0xBC267848, 0x4E4DFB4B, 0x20BD8EDE, 0xD2D60DDD, 0xC186FE29, 0x33ED7D2A,
	0xE72719C1, 0x154C9AC2, 0x061C6936, 0xF477EA35, 0xAA64D611, 0x580F5512,
	0x4B5FA6E6, 0xB93425E5, 0x6DFE410E, 0x9F95C20D, 0x8CC531F9, 0x7EAEB2FA,
	0x30E349B1, 0xC288CAB2, 0xD1D83946, 0x23B3BA45, 0xF779DEAE, 0x05125DAD,
	0x1642AE59, 0xE4292D5A, 0xBA3A117E, 0x4851927D, 0x5B016189, 0xA96AE28A,
	0x7DA08661, 0x8FCB0562, 0x9C9BF696, 0x6EF07595, 0x417B1DBC, 0xB3109EBF,
	0xA0406D4B, 0x522BEE48, 0x86E18AA3, 0x748A09A0, 0x67DAFA54, 0x95B17957,
	0xCBA24573, 0x39C9C670, 0x2A993584, 0xD8F2B687, 0x0C38D26C, 0xFE53516F,
	0xED03A29B, 0x1F682198, 0x5125DAD3, 0xA34E59D0, 0xB01EAA24, 0x42752927,
	0x96BF4DCC, 0x64D4CECF, 0x77843D3B, 0x85EFBE38, 0xDBFC821C, 0x2997011F,
	0x3AC7F2EB, 0xC8AC71E8, 0x1C661503, 0xEE0D9600, 0xFD5D65F4, 0x0F36E6F7,
	0x61C69362, 0x93AD1061, 0x80FDE395, 0x72966096, 0xA65C047D, 0x5437877E,
	0x4767748A, 0xB50CF789, 0xEB1FCBAD, 0x197448AE, 0x0A24BB5A, 0xF84F3859,
	0x2C855CB2, 0xDEEEDFB1, 0xCDBE2C45, 0x3FD5AF46, 0x7198540D, 0x83F3D70E,
	0x90A324FA, 0x62C8A7F9, 0xB602C312, 0x44694011, 0x5739B3E5, 0xA55230E6,
	0xFB410CC2, 0x092A8FC1, 0x1A7A7C35, 0xE811FF36, 0x3CDB9BDD, 0xCEB018DE,
	0xDDE0EB2A, 0x2F8B6829, 0x82F63B78, 0x709DB87B, 0x63CD4B8F, 0x91A6C88C,
	0x456CAC67, 0xB7072F64, 0xA457DC90, 0x563C5F93, 0x082F63B7, 0xFA44E0B4,
	0xE9141340, 0x1B7F9043, 0xCFB5F4A8, 0x3DDE77AB, 0x2E8E845F, 0xDCE5075C,
	0x92A8FC17, 0x60C37F14, 0x73938CE0, 0x81F80FE3, 0x55326B08, 0xA759E80B,
	0xB4091BFF, 0x466298FC, 0x1871A4D8, 0xEA1A27DB, 0xF94AD42F, 0x0B21572C,
	0xDFEB33C7, 0x2D80B0C4, 0x3ED04330, 0xCCBBC033, 0xA24BB5A6, 0x502036A5,
	0x4370C551, 0xB11B4652, 0x65D122B9, 0x97BAA1BA, 0x84EA524E, 0x7681D14D,
	0x2892ED69, 0xDAF96E6A, 0xC9A99D9E, 0x3BC21E9D, 0xEF087A76, 0x1D63F975,
	0x0E330A81, 0xFC588982, 0xB21572C9, 0x407EF1CA, 0x532E023E, 0xA145813D,
	0x758FE5D6, 0x87E466D5, 0x94B49521, 0x66DF1622, 0x38CC2A06, 0xCAA7A905,
	0xD9F75AF1, 0x2B9CD9F2, 0xFF56BD19, 0x0D3D3E1A, 0x1E6DCDEE, 0xEC064EED,
	0xC38D26C4, 0x31E6A5C7, 0x22B65633, 0xD0DDD530, 0x0417B1DB, 0xF67C32D8,
	0xE52CC12C, 0x1747422F, 0x49547E0B, 0xBB3FFD08, 0xA86F0EFC, 0x5A048DFF,
	0x8ECEE914, 0x7CA56A17, 0x6FF599E3, 0x9D9E1AE0, 0xD3D3E1AB, 0x21B862A8,
	0x32E8915C, 0xC083125F, 0x144976B4, 0xE622F5B7, 0xF5720643, 0x07198540,
	0x590AB964, 0xAB613A67, 0xB831C993, 0x4A5A4A90, 0x9E902E7B, 0x6CFBAD78,
	0x7FAB5E8C, 0x8DC0DD8F, 0xE330A81A, 0x115B2B19, 0x020BD8ED, 0xF0605BEE,
	0x24AA3F05, 0xD6C1BC06, 0xC5914FF2, 0x37FACCF1, 0x69E9F0D5, 0x9B8273D6,
	0x88D28022, 0x7AB90321, 0xAE7367CA, 0x5C18E4C9, 0x4F48173D, 0xBD23943E,
	0xF36E6F75, 0x0105EC76, 0x12551F82, 0xE03E9C81, 0x34F4F86A, 0xC69F7B69,
	0xD5CF889D, 0x27A40B9E, 0x79B737BA, 0x8BDCB4B9, 0x988C474D, 0x6AE7C44E,
	0xBE2DA0A5, 0x4C4623A6, 0x5F16D052, 0xAD7D5351
];

// Table of memoized values for each byte with the Koopman polynomial.
export const koopman_table: [256]u32 = [
	0x00000000, 0x9695C4CA, 0xFB4839C9, 0x6DDDFD03, 0x20F3C3CF, 0xB6660705,
	0xDBBBFA06, 0x4D2E3ECC, 0x41E7879E, 0xD7724354, 0xBAAFBE57, 0x2C3A7A9D,
	0x61144451, 0xF781809B, 0x9A5C7D98, 0x0CC9B952, 0x83CF0F3C, 0x155ACBF6,
	0x788736F5, 0xEE12F23F, 0xA33CCCF3, 0x35A90839, 0x5874F53A, 0xCEE131F0,
	0xC22888A2, 0x54BD4C68, 0x3960B16B, 0xAFF575A1, 0xE2DB4B6D, 0x744E8FA7,
	0x199372A4, 0x8F06B66E, 0xD1FDAE25, 0x47686AEF, 0x2AB597EC, 0xBC205326,
	0xF10E6DEA, 0x679BA920, 0x0A465423, 0x9CD390E9, 0x901A29BB, 0x068FED71,
	0x6B521072, 0xFDC7D4B8, 0xB0E9EA74, 0x267C2EBE, 0x4BA1D3BD, 0xDD341777,
	0x5232A119, 0xC4A765D3, 0xA97A98D0, 0x3FEF5C1A, 0x72C162D6, 0xE454A61C,
	0x89895B1F, 0x1F1C9FD5, 0x13D52687, 0x8540E24D, 0xE89D1F4E, 0x7E08DB84,
	0x3326E548, 0xA5B32182, 0xC86EDC81, 0x5EFB184B, 0x7598EC17, 0xE30D28DD,
	0x8ED0D5DE, 0x18451114, 0x556B2FD8, 0xC3FEEB12, 0xAE231611, 0x38B6D2DB,
	0x347F6B89, 0xA2EAAF43, 0xCF375240, 0x59A2968A, 0x148CA846, 0x82196C8C,
	0xEFC4918F, 0x79515545, 0xF657E32B, 0x60C227E1, 0x0D1FDAE2, 0x9B8A1E28,
	0xD6A420E4, 0x4031E42E, 0x2DEC192D, 0xBB79DDE7, 0xB7B064B5, 0x2125A07F,
	0x4CF85D7C, 0xDA6D99B6, 0x9743A77A, 0x01D663B0, 0x6C0B9EB3, 0xFA9E5A79,
	0xA4654232, 0x32F086F8, 0x5F2D7BFB, 0xC9B8BF31, 0x849681FD, 0x12034537,
	0x7FDEB834, 0xE94B7CFE, 0xE582C5AC, 0x73170166, 0x1ECAFC65, 0x885F38AF,
	0xC5710663, 0x53E4C2A9, 0x3E393FAA, 0xA8ACFB60, 0x27AA4D0E, 0xB13F89C4,
	0xDCE274C7, 0x4A77B00D, 0x07598EC1, 0x91CC4A0B, 0xFC11B708, 0x6A8473C2,
	0x664DCA90, 0xF0D80E5A, 0x9D05F359, 0x0B903793, 0x46BE095F, 0xD02BCD95,
	0xBDF63096, 0x2B63F45C, 0xEB31D82E, 0x7DA41CE4, 0x1079E1E7, 0x86EC252D,
	0xCBC21BE1, 0x5D57DF2B, 0x308A2228, 0xA61FE6E2, 0xAAD65FB0, 0x3C439B7A,
	0x519E6679, 0xC70BA2B3, 0x8A259C7F, 0x1CB058B5, 0x716DA5B6, 0xE7F8617C,
	0x68FED712, 0xFE6B13D8, 0x93B6EEDB, 0x05232A11, 0x480D14DD, 0xDE98D017,
	0xB3452D14, 0x25D0E9DE, 0x2919508C, 0xBF8C9446, 0xD2516945, 0x44C4AD8F,
	0x09EA9343, 0x9F7F5789, 0xF2A2AA8A, 0x64376E40, 0x3ACC760B, 0xAC59B2C1,
	0xC1844FC2, 0x57118B08, 0x1A3FB5C4, 0x8CAA710E, 0xE1778C0D, 0x77E248C7,
	0x7B2BF195, 0xEDBE355F, 0x8063C85C, 0x16F60C96, 0x5BD8325A, 0xCD4DF690,
	0xA0900B93, 0x3605CF59, 0xB9037937, 0x2F96BDFD, 0x424B40FE, 0xD4DE8434,
	0x99F0BAF8, 0x0F657E32, 0x62B88331, 0xF42D47FB, 0xF8E4FEA9, 0x6E713A63,
	0x03ACC760, 0x953903AA, 0xD8173D66, 0x4E82F9AC, 0x235F04AF, 0xB5CAC065,
	0x9EA93439, 0x083CF0F3, 0x65E10DF0, 0xF374C93A, 0xBE5AF7F6, 0x28CF333C,
	0x4512CE3F, 0xD3870AF5, 0xDF4EB3A7, 0x49DB776D, 0x24068A6E, 0xB2934EA4,
	0xFFBD7068, 0x6928B4A2, 0x04F549A1, 0x92608D6B, 0x1D663B05, 0x8BF3FFCF,
	0xE62E02CC, 0x70BBC606, 0x3D95F8CA, 0xAB003C00, 0xC6DDC103, 0x504805C9,
	0x5C81BC9B, 0xCA147851, 0xA7C98552, 0x315C4198, 0x7C727F54, 0xEAE7BB9E,
	0x873A469D, 0x11AF8257, 0x4F549A1C, 0xD9C15ED6, 0xB41CA3D5, 0x2289671F,
	0x6FA759D3, 0xF9329D19, 0x94EF601A, 0x027AA4D0, 0x0EB31D82, 0x9826D948,
	0xF5FB244B, 0x636EE081, 0x2E40DE4D, 0xB8D51A87, 0xD508E784, 0x439D234E,
	0xCC9B9520, 0x5A0E51EA, 0x37D3ACE9, 0xA1466823, 0xEC6856EF, 0x7AFD9225,
	0x17206F26, 0x81B5ABEC, 0x8D7C12BE, 0x1BE9D674, 0x76342B77, 0xE0A1EFBD,
	0xAD8FD171, 0x3B1A15BB, 0x56C7E8B8, 0xC0522C72
];

// Populate a user-provided buffer with the memoized values for a custom
// polynomial.
//
// The user-provided polynomial must be in the reversed form.
export fn memoize(polynomial: u32, buf: *[256]u32) void = {
	for (let i = 0z; i < 256; i += 1) {
		let value = i: u32;
		for (let z = 0z; z < 8; z += 1) {
			value = if (value & 0x1 == 1) {
				yield (value >> 1) ^ polynomial;
			} else {
				yield value >> 1;
			};
		};
		buf[i] = value;
	};
};

export type state = struct {
	hash::hash,
	table: *[256]u32,
	cval: u32,
};

const crc32_vtable: io::vtable = io::vtable {
	writer = &write,
	...
};

// Creates a [[hash::hash]] which computes the CRC-32 algorithm. This hash
// function does not allocate any state, so you do not need to call
// [[hash::close]] when you are done with it.
//
// It takes a table of memoized values for a given polynomail (for example,
// [[ieee_table]], [[castagnoli_table]], or [[koopman_table]]); a table for a
// custom polynomial, populated by [[memoize]] function, may also be used.
export fn crc32(table: *[256]u32) state = state {
	stream = &crc32_vtable,
	sum = &sum,
	reset = &reset,
	sz = SZ,
	table = table,
	cval = ~0u32,
	...
};

fn write(s: *io::stream, buf: const []u8) (size | io::error) = {
	let s = s: *state;
	for (let i = 0z; i < len(buf); i += 1) {
		let rightbits = s.cval & 0xFF;
		s.cval = s.table[rightbits ^ buf[i]] ^ (s.cval >> 8);
	};
	return len(buf);
};

fn reset(h: *hash::hash) void = {
	let h = h: *state;
	h.cval = ~0u32;
};

fn sum(h: *hash::hash, buf: []u8) void = {
	let h = h: *state;
	endian::host.putu32(buf, ~h.cval);
};

// Returns the computed 32-bit CRC.
export fn sum32(h: *hash::hash) u32 = {
	assert(h.reset == &reset);
	let h = h: *state;
	return ~h.cval;
};

@test fn crc32() void = {
	const vectors: [](str, u32, u32, u32) = [
		("", 0, 0, 0),
		("Give a man a fire, they be warm for a day", 4026734998, 2112273292, 1263149916),
		("Set a man on fire, they be warm for the rest of their life", 3931092334, 4172943610, 3071632577),
		("By trying we can easily learn to endure adversity.  Another man's, I mean.", 3101256971, 2228454711, 3853172117),
		("Civilization is the limitless multiplication of unnecessary necessities.", 3294636496, 2539066349, 896967959),
		("Black lives matter", 2370964079, 2068416418, 4151357773),
		("UNIX is simple and coherent", 3254252081, 1650777601, 340189632),
		("GNU's not UNIX", 224734747, 200511816, 332335539)
	];

	let crc_ieee = crc32(&ieee_table);
	let crc_castagnoli = crc32(&castagnoli_table);
	let crc_koopman = crc32(&koopman_table);

	let buf: [SZ]u8 = [0...];

	for (let i = 0z; i < len(vectors); i += 1) {
		let vec = vectors[i];

		hash::reset(&crc_ieee);
		hash::write(&crc_ieee, strings::toutf8(vec.0));
		hash::sum(&crc_ieee, buf);
		assert(endian::host.getu32(buf) == vec.1);
		assert(sum32(&crc_ieee) == vec.1);

		hash::reset(&crc_castagnoli);
		hash::write(&crc_castagnoli, strings::toutf8(vec.0));
		hash::sum(&crc_castagnoli, buf);
		assert(endian::host.getu32(buf) == vec.2);
		assert(sum32(&crc_castagnoli) == vec.2);

		hash::reset(&crc_koopman);
		hash::write(&crc_koopman, strings::toutf8(vec.0));
		hash::sum(&crc_koopman, buf);
		assert(endian::host.getu32(buf) == vec.3);
		assert(sum32(&crc_koopman) == vec.3);
	};
};
