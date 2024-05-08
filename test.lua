local function add_bytes(filename)
    local file = io.open(filename, "rb")
    local bytes = file:read("*a")
    file:close()
    local checksum = 0
    for i = 1, #bytes do
        checksum = checksum + bytes:byte(i)
    end
    return checksum % 256
end
local function read_uint32(filename, offset)
    local file = io.open(filename, "rb")
    file:seek("set", offset)
    local b1,b2,b3,b4 = file:read(4):byte(1,-1)
    file:close()
    return (b1 * 0x10000000) + (b2 * 0x10000) + (b3 * 0x100) + b4
end
print("magic number:" .. string.format("0x%x", read_uint32(arg[1],0)))
print("checksum remainder: " .. string.format("0x%x", add_bytes(arg[1])))
print("width:" .. read_uint32(arg[1],4))
print("height:" .. read_uint32(arg[1],8))