# wee-to-shadertoy
Also known as, wee backend for ShaderToy.

Also known as, GLSL implementation of an interpreter or VM for https://github.com/nathanfarlow/wee

Running at https://www.shadertoy.com/view/mdtcW4

## Features
 * Most wee instructions (`mov`, `swap`, `add`, `sub`, `store`, `setlt`, `jmpz`)
 * MMIO (mouse, keyboard, display)

## Missing Features
 * Some nonessential wee instructions (`getc`, `putc`, `exit`)

Who needs those instructions anyway?
It turns out that the ["truly minimal instruction set"](https://github.com/nathanfarlow/wee#wee) can be pruned of this ISA bloat and still be very [functional](https://www.shadertoy.com/view/mdtcW4).

## Planned Features
 * MMIO-based ALU
 * **Documentation!** (standardized MMIO framework)

## Usage
 * The VM is available at https://www.shadertoy.com/view/mdtcW4, with a sample program.
 * To run the interpreter on a different program, pipe the wee code to `python3 encode.py`, and put the output into the "Buffer A" tab. Then, just click the Compile (▶) button and the Reset (⏮) button.
 * For example, I used `m4 prog.wee.m4 | python3 encode.py | xclip -sel c -i` to evaluate the macros, convert from wee to glsl, and copy to clipboard so I can paste on the website.
