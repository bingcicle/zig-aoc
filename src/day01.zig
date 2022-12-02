const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day01.txt");

const Elf = struct { index: usize, calories: i64 };

pub fn main() !void {
    var lines = split(u8, data, "\n");

    var elf_count: usize = 1;
    var elves_list = List(Elf).init(gpa);
    var acc_calories: i64 = 0;
    var final_elf: usize = 1;
    var max_calories: i64 = 0;

    while (lines.next()) |line| {
        if (line.len != 0) {
            acc_calories += try parseInt(i64, line, 10);
        } else {
            if (max_calories < acc_calories) {
                max_calories = acc_calories;
                final_elf = elf_count;
            }
            try elves_list.append(Elf{ .index = elf_count, .calories = acc_calories });
            acc_calories = 0;
            elf_count += 1;
        }
    }

    const elfDesc = (struct {
        fn elfDesc(context: void, a: Elf, b: Elf) bool {
            _ = context;
            return a.calories > b.calories;
        }
    }).elfDesc;

    var elves = elves_list.items;
    const dupes = try gpa.dupe(Elf, elves);
    sort(Elf, dupes, {}, comptime elfDesc);

    var top_three = dupes[0].calories + dupes[1].calories + dupes[2].calories;
    std.debug.print("part 1: {d}\n", .{max_calories});
    std.debug.print("part 2: {d}\n", .{top_three});
}

// Useful stdlib functions
const tokenize = std.mem.tokenize;
const split = std.mem.split;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const min = std.math.min;
const min3 = std.math.min3;
const max = std.math.max;
const max3 = std.math.max3;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
