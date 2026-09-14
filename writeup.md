The Parable of the Square-Dancing Witches and Wizards
=====================================================

Introduction
------------

In this Presentation I will tell The Parable of the Square-Dancing Witches and
Wizards. This parable explains how to perform the bit-permutation operation
that compresses the selected bits to the LSB end of the word, while the
remaining bits are pushed to the MSB end of the word in reversed bit order.

This operation is referred to as “sheep and goats” (SAG) operation with
reversed goat bits by other authors, in reference to The Parable of the Sheep
and the Goats, found in Matthew 25:31-46. Sources usually cite verses 32-33
of the parable when discussing the "sheep and goats" (SAG) operation and its
unusual name:

> All the nations will be gathered before him, and he will separate people one
> from another as a shepherd separates the sheep from the goats, and he will
> put the sheep at his right hand and the goats at the left.

Mentalising and discussing routing networks using symbolism from scripture is
awkward or even problematic for many reasons. The Parable of the Square-Dancing
Witches and Wizards on the other hand is loosely based on symbolisms from The
Wizard of Oz, and does not only provide a mental image for what this
bit-permutation operation does, but also how that can be achieved in an
efficient manner using a Reverse Omega Network.

This author discovered the method independently but the method is not novel. In
fact, the US patents [US8285766] and [US9134953], originally filed in 2008 and
due to expire in November 2028, seem to claim this invention. And it is in big
part because of this patent that there's no instruction implementing any of the
"sheep and goats" family of functions in open ISAs and processors yet.

However, the 1994 paper [narasimha1994] describes this exact circuit and
deriving this exact circuit should be rather straigth-forward for anyone
familiar with banyan networks and other self-routing switching networks.

A family of three functions (and their respective inverse)
----------------------------------------------------------

Ignoring symmetries there are three reasonable mental pictures for translating
the language of The Parable of the Sheep and the Goats to a bit permutation
operation semantic. In all three cases the "sheep" and "goat" bits are processed
in LSB-first order and the selected "sheep" bits approach the area
on the right from its left end, the point where the left and right area meet,
then turn right onto the right area, and then traverse the right area from left
to right until each bit has reached its final position, with the LSB sheep
ending up in the most right (LSB) position of the output word. The behavior of
the "goat" bits however is different in the three mental pictures.

In the first mental picture the goats approach the left area from the left,
then turn right onto the left area, and then traverse the left area from left
to right until each bit has reached its final position, with LSB goat ending up
in the most right position of the left area, and the MSB goat ending up in the
most left position in the left area, the MSB position of the output word. In
this mental picture the goats behave exactly like the sheep, only shifted to
the left by the number of sheep. This operation is most commonly referred to
as "sheep and goats" (SAG).

In the second mental picture both the goats and the sheep approach their
respective output areas from the mid-point between the areas. Then the sheep
turn right onto their area and the goats turn left onto their area. The goats
now traverse the left area from right to left and the first (LSB) goat will
now end up in the very left spot (MSB of the output). In this picture the sheep
and goat behaviors are mirror images of each other, and thus the sheep will
be sorted stably to the right while the order of the goats with respect to
MSB/LSB of the input and output words is being reversed. This operation is
most commonly referred to as "sheep and goats with reversed goat order", but
I am going to refer to it as the "witches and wizards" (WAW) operation from
now on.

In the third mental picture we simply throw the goat bits away and replace them
with zeros in the output word. This is the semantic of the X86 / X86\_64 "parallel
extract" (PEXT) instruction. Arguably this third mental picture is the most
reasonable considering verses 41-42 of the parable from christian scripture:

> Then he will say to those on his left, ‘Depart from me, you who are cursed,
> into the eternal fire prepared for the devil and his angels. For I was hungry
> and you gave me nothing to eat, I was thirsty and you gave me nothing to
> drink, [...]

I have illustrated the three mental pictures in this sketch:

https://github.com/clairexen/fmcad2026/blob/main/illustrations/family-of-three-functions-line-art-faithful.png

The X86 / X86\_64 ISA also contains the inverse operation with regards to the
selected bits: "parallel deposit" (PDEP), that places the selected bits in
their original positions, when executed with a PEXT result and the control word
that created it, ignoring additional "goat" bits in the input and setting
"goat" positions in the output word to zero.

We also consider the "inverse sheep and goats" (GAS) and "inverse witches and
wizards" (AWW) operations. (The meaning behind the memnonic AWW will become
clear at the end of the discussion of the AWA operation below.)

I personally consider the use of the the word "parallel" (and prefix letter P)
in the X86 PEXT and PDEP instruction memnonics a prime example of bad ISA
design, because the memnonic for an instruction should focus on the instruction
semantic, not performance. Following the direction of my work for the RISC-V
Bitmanip Taks Group I therefore use the prefix BM (for Bit-Mask, ... or maybe
Bit-Magic?) instead, yielding the following 6 instructions with the semantics
as described above:

| Operation | Reverse-OP | Unselected Bits |
|:---------:|:----------:|:----------------|
| BMSAG     | BMGAS      | Order preserved |
| BMWAW     | BMAWW      | Order reversed  |
| BMEXT     | BMDEP      | Cleared         |

I've provided Verilog reference implementations for BMWAW and BMAWW in
the GitHub repository for this Key-Note presentation:

- https://github.com/clairexen/fmcad2026/blob/main/bmwaw.v
- https://github.com/clairexen/fmcad2026/blob/main/bmaww.v

The same directory (https://github.com/clairexen/fmcad2026/) also contains
simple reference implementations for the other four instructions BMEXT,
BMDEP, BMSAG, and BMGAS based on BMWAW and BMAWW using the following equivalences:

	BMEXT(din, cin) := BMWAW(din & cin, cin)
	BMDEP(din, cin) := BMAWW(din & cout, cin)         [with cout := BMAWW(cin, cin)]
	BMSAG(din, cin) := BMWAW(BMWAW(din, cin), cout)   [with cout := BMWAW(cin, cin)]
	BMGAS(din, cin) := BMAWW(BMAWW(din, cout), cin)   [with cout := BMAWW(cin, cin)]

Note that `cout = BMWAW(cin, cin) = BMAWW(cin, cin)` and that the Verilog
reference implementations of BMDEP, BMSAG, and BMGAS do not contain an
additional instantiation of BMWAW / BMAWW to generate cout because we can
simply use the `.cout()` output of any BMWAW / BMAWW instance that is
instantiated with `cin` routed to its `.cin()` input port. We even can route
cout anti-parallel to the data-bus, as can be seen in the BMGAS reference
implementation, because the `.cout()` output of the BMAWW module does only
depend on `.cin()` and not `.din()`.

The six Verilog modules also contain formal safety properties for the expected
semantic for each of the bit-manipulation instructions and the repository contains
`*.sby` files for checking those formal properties with SymbiYosys (https://github.com/YosysHQ/sby).

Prior art and a peculiar patent
-------------------------------

...

Implementing BMWAW / BMAWW using a reverse omega network
--------------------------------------------------------

Let's start with some definitions:

- An Omega Network consists of repeated perfect-shuffle permutations followed by layers of 2x2 switches.
- A Reverse Omega Network consists of layers of 2x2 switches followed by perfect un-shuffle permutations.
- A perfect shuffle rotates each wire's binary address one bit to the left, interleaving the wires from the LSB and MSB halves.
- A perfect un-shuffle rotates each wire's binary address one bit to the right, compressing the even-numbered wires to the LSB end and the odd-numbered wires to the MSB end.

...

The Parable of the Square-Dancing Witches and Wizards
-----------------------------------------------------

...

References
----------
- [narasimha1994] M. J. Narasimha, “A Recursive Concentrator Structure with Applications to Self-Routing Switching Networks,” IEEE Transactions on Communications, 42(2–4), 896–898, 1994: https://doi.org/10.1109/TCOMM.1994.580197.
- [chuan-linwu1980] C.-L. Wu and T.-Y. Feng, “The Reverse-Exchange Interconnection Network,” IEEE Transactions on Computers, C-29(9), 801–811, 1980: https://doi.org/10.1109/TC.1980.1675679.
- [parker1980] D. S. Parker, “Notes on Shuffle/Exchange-Type Switching Networks,” IEEE Transactions on Computers, C-29(3), 213–222, 1980: https://doi.org/10.1109/TC.1980.1675553.
- [lawrie1975] D. H. Lawrie, “Access and Alignment of Data in an Array Processor,” IEEE Transactions on Computers, C-24(12), 1145–1155, 1975: https://doi.org/10.1109/T-C.1975.224157.
- [hilewitz2006] Y. Hilewitz and R. B. Lee, “Fast Bit Compression and Expansion with Parallel Extract and Parallel Deposit Instructions,” in IEEE 17th International Conference on Application-specific Systems, Architectures and Processors (ASAP’06), IEEE, Sep. 2006: https://doi.org/10.1109/ASAP.2006.33.
- [US9134953] R. B. Lee and Y. Hilewitz, “Microprocessor shifter circuits utilizing butterfly and inverse butterfly routing circuits, and control circuits therefor,” U.S. Patent 9 134 953 B2, Sep. 15, 2015: https://patents.google.com/patent/US9134953B2
- [US8285766] R. B. Lee and Y. Hilewitz, “Microprocessor shifter circuits utilizing butterfly and inverse butterfly routing circuits, and control circuits therefor,” U.S. Patent 8 285 766 B2, Oct. 9, 2012: https://patents.google.com/patent/US8285766B2
