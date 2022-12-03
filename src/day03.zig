const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day03.txt");

fn part1() !void {
    var lines = split(u8, data, "\n");
    var solution: u64 = 0;

    while (lines.next()) |line| {
        var result: u64 = 0;
        const first_compartment = try gpa.alloc(u8, line.len / 2);
        const second_compartment = try gpa.alloc(u8, line.len / 2);
        if (line.len > 0) {
            std.mem.copy(u8, first_compartment, line[0..(line.len / 2)]);
            std.mem.copy(u8, second_compartment, line[(line.len / 2)..(line.len)]);

            sort(u8, first_compartment, {}, comptime asc(u8));
            sort(u8, second_compartment, {}, comptime asc(u8));

            outer_1: for (first_compartment) |char| {
                if (!std.ascii.isUpper(char)) {
                    for (second_compartment) |second_char| {
                        if (char == second_char) {
                            result = char % 96;
                            break :outer_1;
                        }
                    }
                }
            }
            if (result == 0) {
                outer_2: for (first_compartment) |char| {
                    if (std.ascii.isUpper(char)) {
                        for (second_compartment) |second_char| {
                            if (char == second_char) {
                                result = char % 65 + 27;
                                break :outer_2;
                            }
                        }
                    }
                }
            }

            solution += result;
        }
    }

    std.debug.print("part 1: {d}\n", .{solution});
}

pub fn part2() !void {
    var lines = split(u8, data, "\n");
    var solution: u64 = 0;
    while (lines.next()) |line| {
        var result: u64 = 0;

        if (line.len == 0) {
            break;
        }
        const bag_1 = try gpa.alloc(u8, line.len);
        std.mem.copy(u8, bag_1, line[0..]);

        var bag_2_it = lines.next().?[0..];

        const bag_2 = try gpa.alloc(u8, bag_2_it.len);
        std.mem.copy(u8, bag_2, bag_2_it[0..]);
        var bag_3_it = lines.next().?[0..];
        const bag_3 = try gpa.alloc(u8, bag_3_it.len);
        std.mem.copy(u8, bag_3, bag_3_it[0..]);

        sort(u8, bag_1, {}, comptime asc(u8));
        sort(u8, bag_2, {}, comptime asc(u8));
        sort(u8, bag_3, {}, comptime asc(u8));

        outer_1: for (bag_1) |char| {
            if (!std.ascii.isUpper(char)) {
                for (bag_2) |second_char| {
                    if (char == second_char) {
                        for (bag_3) |third_char| {
                            if (char == third_char) {
                                result = char % 96;
                                break :outer_1;
                            }
                        }
                    }
                }
            }
        }
        if (result == 0) {
            outer_2: for (bag_1) |char| {
                if (std.ascii.isUpper(char)) {
                    for (bag_2) |second_char| {
                        if (char == second_char) {
                            for (bag_3) |third_char| {
                                if (char == third_char) {
                                    result = char % 65 + 27;
                                    break :outer_2;
                                }
                            }
                        }
                    }
                }
            }
        }

        solution += result;
    }

    std.debug.print("part 2: {d}", .{solution});
}

pub fn main() !void {
    // Rucksack reorg
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
