MSG = "Mr. Watson, come here. I want to see you."
SPACE_COUNT = 10    # number of spaces to append before and after msg
TAPS = 0xE1         # taps used for LFSR
INIT = 0xFF         # LFSR initial state


def binary(c):
    if type(c) == str:
        return format(ord(c), '08b')
    elif type(c) == int:
        return format(c, '08b')


for c in MSG:
    print(binary(c))

print(binary(SPACE_COUNT))
print(binary(0xe1))
print(binary(INIT))
