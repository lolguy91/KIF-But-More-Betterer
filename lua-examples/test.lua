-- Read the contents of the given file and return the checksum of all its bytes.
-- The checksum is the sum of all the byte values, taken modulo 256.
local function add_bytes(filename)
    -- Open the file and read its contents
    local file = io.open(filename, "rb")
    local bytes = file:read("*a")
    file:close()

    -- Calculate the checksum
    local checksum = 0
    for i = 1, #bytes do
        -- Add each byte's value to the checksum
        checksum = checksum + bytes:byte(i)
    end

    -- Return the checksum, taken modulo 256
    return checksum % 256
end

-- Read a 32-bit unsigned integer from a file at a given offset.
-- The integer is read in big-endian order (most significant byte first).
local function read_uint32(filename, offset)
    -- Open the file and seek to the desired offset
    local file = io.open(filename, "rb")
    file:seek("set", offset)

    -- Read the 4 bytes that make up the integer
    local b1,b2,b3,b4 = file:read(4):byte(1,-1)

    -- Close the file
    file:close()

    -- Calculate the integer value from the bytes
    -- The calculation is done in big-endian order:
    -- byte 1 is the most significant byte, so
    -- its value is multiplied by 2^24 (0x10000000)
    -- and so on.
    return (b1 * 0x10000000) + (b2 * 0x10000) + (b3 * 0x100) + b4
end

-- Print some information from the given KIFBMB file.
print("magic number:" .. string.format("0x%x", read_uint32(arg[1],0))) -- The magic number is stored at offset 0.
print("checksum remainder: " .. string.format("0x%x", add_bytes(arg[1]))) -- The checksum is stored at offset 12.
print("width:" .. read_uint32(arg[1],4)) -- The width is stored at offset 4.
print("height:" .. read_uint32(arg[1],8)) -- The height is stored at offset 8.
