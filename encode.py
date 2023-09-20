def parse_line(line):
    "Turns a line of wee into a tuple representing an instruction"
    match line.split():
        case ["mov", n]:
            return (0, int(n))
        case ["swap"]:
            return (1, 0)
        case ["add"]:
            return (2, 0)
        case ["sub"]:
            return (3, 0)
        case ["load"]:
            return (4, 0)
        case ["store"]:
            return (5, 0)
        case ["setlt"]:
            return (6, 0)
        case ["jmpz", n]:
            return (7, int(n))
    raise Exception("Can't understand '%s'" % line.strip())

def pack_32(t):
    "Turns a tuple representing an instruction into a 32-bit unsigned int"
    ins, lit = t
    assert 0 <= ins < (1<<3), "Instruction should be 3 bits"
    assert -(1<<28) <= lit < (1<<28), "Literal should be a 29-bit signed int"
    return ((1<<29) + lit if lit < 0 else lit) | (ins << 29)

def get_numbers(lines):
    "Turns an iterable of wee lines into an iterable of 32-bit unsigned ints"
    for line in lines:
        yield pack_32(parse_line(line))

def group_by_three(numbers):
    "Turns a sequence of values into an iterable of groups of three values, 0-padded at the end"
    mod = len(numbers) % 3
    if mod:
        numbers += [0] * (3 - mod)
    for i in range(0, len(numbers), 3):
        yield numbers[i:i+3]

def get_code(numbers):
    "Turns a sequence of numbers into a string of GLSL code that encodes them into a frame"
    pixels = list(group_by_three(numbers))
    return """const uvec3 lut[{0}] = uvec3[{0}]({1});

void mainImage(out vec4 fragColor, in vec2 fragCoord) {{
    int index = int(fragCoord.y) * kBufferSize.x + int(fragCoord.x);
    fragColor = (index < {0}) ? b127_ieee754_encode(uvec4(lut[index], 0)) : vec4(0);
}}
""".format(
        len(pixels),
        ",".join("uvec3(0x{:08x}u, 0x{:08x}u, 0x{:08x}u)".format(*pixel) for pixel in pixels)
    )

if __name__ == "__main__":
    import sys
    sys.stdout.write(get_code(list(get_numbers(sys.stdin))))
