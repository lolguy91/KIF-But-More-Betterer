local function generateWhiteNoise(width,height)
    local pixels = {}
    local random = math.random
    for y = 1, height do
        local row = {}
        for x = 1, width do
            local r = random(255)
            local g = random(255)
            local b = random(255)
            local a = random(255)
            table.insert(row,{r,g,b,a})
        end
        table.insert(pixels,row)
    end
    return pixels
end

local function writeKIFBMB(fileName,width,height,pixels)
    local file = io.open(fileName, "wb")
    local header = {
        magic = 0x69420666,
        width = width,
        height = height,
    }
    local checksum = 0x69 + 0x42 + 0x06 + 0x66
    checksum = checksum + split_and_add_u32(width)
    checksum = checksum + split_and_add_u32(height)
    for x = 1, width do
        for y = 1, height do
            local pixel = pixels[x][y]
            checksum = checksum + split_and_add_u32(pixel[1])
            checksum = checksum + split_and_add_u32(pixel[2])
            checksum = checksum + split_and_add_u32(pixel[3])
            checksum = checksum + split_and_add_u32(pixel[4])
        end
    end

    header.checksum = 256 - (checksum % 256)
    file:write(string.pack(">IIIB", header.magic, header.width, header.height, header.checksum))
    for x = 1, width do
        for y = 1, height do
            local pixel = pixels[x][y]
            file:write(string.pack(">BBBB", pixel[1], pixel[2], pixel[3], pixel[4]))
        end
    end
    file:close()
end
function split_and_add_u32(val)
    return (val & 0xFF) + ((val >> 8) & 0xFF) + ((val >> 16) & 0xFF) + ((val >> 24) & 0xFF)
end

writeKIFBMB("noise.kifbmb", 69, 69, generateWhiteNoise(69, 69))
