const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day04.txt");

fn part1() !void {
    var lines = split(u8, data, "\n");
    var solution: u64 = 0;

    while (lines.next()) |line| {
        if (line.len == 0) {
            break;
        }

        var sections = split(u8, line, ",");

        var first_section = sections.next();
        var first_ids = split(u8, first_section.?, "-");

        var first_start = try parseInt(u32, first_ids.next().?, 10);
        var first_end = try parseInt(u32, first_ids.next().?, 10);

        var second_section = sections.next();
        var second_ids = split(u8, second_section.?, "-");

        var second_start = try parseInt(u32, second_ids.next().?, 10);
        var second_end = try parseInt(u32, second_ids.next().?, 10);

        if (first_start <= second_start and first_end >= second_end) {
            solution += 1;
        } else if (second_start <= first_start and second_end >= first_end) {
            solution += 1;
        }
    }

    std.debug.print("part 1: {d}\n", .{solution});
}

fn part2() !void {
    var lines = split(u8, data, "\n");
    var solution: u64 = 0;

    while (lines.next()) |line| {
        if (line.len == 0) {
            break;
        }

        var sections = split(u8, line, ",");

        var first_section = sections.next();
        var first_ids = split(u8, first_section.?, "-");

        var first_start = try parseInt(u32, first_ids.next().?, 10);
        var first_end = try parseInt(u32, first_ids.next().?, 10);

        var second_section = sections.next();
        var second_ids = split(u8, second_section.?, "-");

        var second_start = try parseInt(u32, second_ids.next().?, 10);
        var second_end = try parseInt(u32, second_ids.next().?, 10);

        if (first_start <= second_start and first_end >= second_end) {
            solution += 1;
        } else if (second_start <= first_start and second_end >= first_end) {
            solution += 1;
        } else if (first_end >= second_start and first_start < second_start) {
            solution += 1;
        } else if (first_start <= second_end and second_start < first_start) {
            solution += 1;
        }
    }

    std.debug.print("part 2: {d}", .{solution});
}

pub fn main() !void {
    try part1();
    try part2();
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
