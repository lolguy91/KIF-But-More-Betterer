-- Generate a random white noise image with the given dimensions
local function generateWhiteNoise(width,height)
    -- Create an empty table to hold the pixels
    local pixels = {}

    -- Iterate over all the rows of the image
    for y = 1, height do
        -- Create an empty table to hold the pixels in this row
        local row = {}

        -- Iterate over all the columns of the image
        for x = 1, width do
            -- Generate random values for the RGBA color components
            local r = math.random(255)
            local g = math.random(255)
            local b = math.random(255)
            local a = math.random(255)

            -- Add the pixel to the row
            table.insert(row,{r,g,b,a})
        end

        -- Add the row to the pixels
        table.insert(pixels,row)
    end

    -- Return the pixels
    return pixels
end

-- Write a KIFBMB image to the given file with the given dimensions and pixels
local function writeKIFBMB(fileName,width,height,pixels)
    -- Open the file
    local file = io.open(fileName, "wb")

    -- Create the header
    local header = {
        magic = 0x69420666,
        width = width,
        height = height,
    }

    -- Calculate the checksum
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

    -- Set the checksum in the header
    header.checksum = 256 - (checksum % 256)

    -- Write the header
    file:write(string.pack(">IIIB", header.magic, header.width, header.height, header.checksum))

    -- Write the pixels
    for x = 1, width do
        for y = 1, height do
            local pixel = pixels[x][y]
            file:write(string.pack(">BBBB", pixel[1], pixel[2], pixel[3], pixel[4]))
        end
    end

    -- Close the file
    file:close()
end

-- Split a u32 into 4 bytes and add them
function split_and_add_u32(val)
    return (val & 0xFF) + ((val >> 8) & 0xFF) + ((val >> 16) & 0xFF) + ((val >> 24) & 0xFF)
end

-- Generate a random white noise image and write it to a file
writeKIFBMB("noise.kifbmb", 69, 69, generateWhiteNoise(69, 69))