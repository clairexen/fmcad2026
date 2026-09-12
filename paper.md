The Parable of the Square-Dancing Witches and Wizards
=====================================================

Abstract
--------

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
with zeros in the output word. This is the semantic of the X86 PEXT instruction.
Arguably this third mental picture is the most reasonable considering verses
41-42 of the parable:

> Then he will say to those on his left, ‘Depart from me, you who are cursed,
> into the eternal fire prepared for the devil and his angels. For I was hungry
> and you gave me nothing to eat, I was thirsty and you gave me nothing to
> drink, [...]




