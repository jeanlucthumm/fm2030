MSG = "Mr. Watson, come here. I want to see you."
SPACE_COUNT = 10
TAPS = 0xE1
INIT = 0xFF


def binary(c):
    if type(c) == str:
        return format(ord(c), '08b')
    elif type(c) == int:
        return format(c, '08b')


for c in enumerate(MSG):
    print(binary(c))

print(binary(SPACE_COUNT))
print(binary(0xe1))
print(binary(INIT))
