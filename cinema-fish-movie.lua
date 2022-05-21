local screen = {}

local function screentostring()
    local s = ""
    for i = 1, 56 do
        s = s .. screen[i]
    end
    return s
end

local function water()
    if mem.water == 1 then for i = 1, 56 do screen[i] = "/8" .. string.sub("~~~~~~~~~~~~~~^^^^ ^^^  ^^^   ^^^^      ^^^^  ^^      ^^", i, i) end  mem.water = 2
    elseif mem.water == 2 then for i = 1, 56 do screen[i] = "/8" .. string.sub("~~~~~~~~~~~~~~ ^^^^ ^^^  ^^^   ^^^^      ^^^^  ^^      ^", i, i) end  mem.water = 3
    elseif mem.water == 3 then for i = 1, 56 do screen[i] = "/8" .. string.sub("~~~~~~~~~~~~~~  ^^^^ ^^^  ^^^   ^^^^      ^^^^  ^^      ", i, i) end  mem.water = 4
    elseif mem.water == 4 then for i = 1, 56 do screen[i] = "/8" .. string.sub("~~~~~~~~~~~~~~   ^^^^ ^^^  ^^^   ^^^^      ^^^^  ^^     ", i, i) end  mem.water = 1
    end
end

local function addsprite(color, sprite, offset)
    for i = 1, 56 do
        if sprite[i] ~= nil then
            if i > 0 and i < 15 and (i + offset) > 0 and (i + offset) < 15 then
                screen[i + offset] = color .. sprite[i]
            elseif i > 14 and i < 29 and (i + offset) > 14 and (i + offset) < 29 then
                screen[i + offset] = color .. sprite[i]
            elseif i > 28 and i < 43 and (i + offset) > 28 and (i + offset) < 43 then
                screen[i + offset] = color .. sprite[i]
            elseif i > 42 and i < 57 and (i + offset) > 42 and (i + offset) < 57 then
                screen[i + offset] = color .. sprite[i]
            end
        end
    end
end

local function fish1()
    if mem.fish1 < 35 then addsprite("/2", mem.fish1s, mem.fish1 - 5); mem.fish1 = mem.fish1 + 1
    else mem.fish1 = 1
    end
end

local function fish2()
    if mem.fish2 > 0 then addsprite("/3", mem.fish2s, mem.fish2 - 10); mem.fish2 = mem.fish2 - 1
    else mem.fish2 = 45
    end
end

local function dolphin1()
    if mem.dolphin1 < 64 then addsprite("/Q", mem.dolphin1s, math.floor(mem.dolphin1 / 2) - 15); mem.dolphin1 = mem.dolphin1 + 1
    else mem.dolphin1 = 1
    end
end

-- main loop
if mem.fish1 == nil then mem.fish1 = 1 end
if mem.fish2 == nil then mem.fish2 = 45 end
if mem.dolphin1 == nil then mem.dolphin1 = 1 end
if mem.water == nil then mem.water = 1 end
--mem.fish1s = nil
if mem.fish1s == nil then
    mem.fish1s = {};
    local fish1ss =
    "              " ..
        "  __          " ..
        "><_'>         " ..
        "   '          "
    for i = 1, 56 do
        local c = string.sub(fish1ss, i, i)
        if c == " " then mem.fish1s[i] = nil
        else mem.fish1s[i] = c
        end
    end
end
--mem.fish2s = nil
if mem.fish2s == nil then
    mem.fish2s = {};
    local fish2ss =
    "              " ..
        "  ,|..        " ..
        "<')###`=<     " ..
        " ``\\```       "
    for i = 1, 56 do
        local c = string.sub(fish2ss, i, i)
        if c == " " then mem.fish2s[i] = nil
        else mem.fish2s[i] = c
        end
    end
end

--mem.dolphin1s = nil
if mem.dolphin1s == nil then
    mem.dolphin1s = {};
    local dolphin1ss =
    "        ,     " ..
        "      __)\\_   " ..
        "(\\_.-'----a`-." ..
        "(/~~````(/~^^`"
    for i = 1, 56 do
        local c = string.sub(dolphin1ss, i, i)
        if c == " " then mem.dolphin1s[i] = nil
        elseif c == "/" then mem.dolphin1s[i] = "//"
        else mem.dolphin1s[i] = c
        end
    end
end

water()
fish2()
dolphin1()
fish1()
digiline_send("screen", screentostring());
