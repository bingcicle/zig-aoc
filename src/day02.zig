const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day02.txt");

fn part1(opp_move: u8, my_move: u8) u32 {
    var result: u32 = 0;
    switch (my_move) {
        88 => {
            if (opp_move == 65) {
                result = 4;
            }
            if (opp_move == 66) {
                result = 1;
            }
            if (opp_move == 67) {
                result = 7;
            }
        },
        // Y (Paper)
        89 => {
            if (opp_move == 65) {
                result = 8;
            }
            if (opp_move == 66) {
                result = 5;
            }
            if (opp_move == 67) {
                result = 2;
            }
        },
        // Z (Scissors)
        90 => {
            if (opp_move == 65) {
                result = 3;
            }
            if (opp_move == 66) {
                result = 9;
            }
            if (opp_move == 67) {
                result = 6;
            }
        },
        else => {
            std.debug.print("unexpected move {}\n", .{my_move});
            result = 0;
        },
    }
    return result;
}

fn part2(opp_move: u8, expected_result: u8) u32 {
    var my_move: u32 = 0;
    switch (opp_move) {
        // Rock
        65 => {
            if (expected_result == 88) {
                my_move = 3;
            }
            if (expected_result == 89) {
                my_move = 4;
            }
            if (expected_result == 90) {
                my_move = 8;
            }
        },
        // Y (Paper)
        66 => {
            if (expected_result == 88) {
                my_move = 1;
            }
            if (expected_result == 89) {
                my_move = 5;
            }
            if (expected_result == 90) {
                my_move = 9;
            }
        },
        // Z (Scissors)
        67 => {
            if (expected_result == 88) {
                my_move = 2;
            }
            if (expected_result == 89) {
                my_move = 6;
            }
            if (expected_result == 90) {
                my_move = 7;
            }
        },
        else => {
            std.debug.print("unexpected move {}\n", .{my_move});
            my_move = 0;
        },
    }
    return my_move;
}

pub fn main() !void {
    var lines = split(u8, data, "\n");
    var result: u32 = 0;
    while (lines.next()) |line| {
        var moves = split(u8, line, " ");

        while (moves.next()) |opp| {
            if (opp.len == 0) {
                break;
            }
            var opp_move = opp[0];
            var my_move = moves.next().?[0];

            result += part2(opp_move, my_move);
        }
    }
    std.debug.print("{d}", .{result});
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
