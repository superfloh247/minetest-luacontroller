local function stringreplace(str)
    local nstr = ""
    for i = 1, #str do
        local c = str:sub(i, i)
        if (c == "/") then nstr = nstr .. "\\"
        elseif (c == "\\") then nstr = nstr .. "//"
        else nstr = nstr .. c
        end
    end
    return nstr
end

if (event.type == "program") then
    mem.growa = "                    " ..
        "*|||*               " ..
        "     \\              " ..
        "      *             " ..
        "       \\            " ..
        "        *|||||||||* " ..
        "         \\       /  " ..
        "          \\     /  " ..
        "            *|||*   " ..
        "                    "
    mem.abc = "ABCDEFGHIJ"
    mem.mode = 1
    mem.starfield = {}
    for i = 1, #mem.abc do
        local c = mem.abc:sub(i, i)
        digiline_send(c, "                    ")
    end
elseif (mem.mode == 1 and event.type == "on") then
    for i = 1, #mem.abc do
        local c = mem.abc:sub(i, i)
        local s = mem.growa:sub((i - 1) * 20 + 1, (i - 1) * 20 + 20)
        s = string.reverse(s)
        s = stringreplace(s)
        digiline_send(c, "/O" .. s)
    end
    mem.mode = 2
elseif (mem.mode == 2 and event.type == "on") then
    for i = 1, #mem.abc do
        local c = mem.abc:sub(i, i)
        local str = string.rep(" ", math.random(19)) .. "*"
        str = str .. string.rep(" ", 20 - #str)
        mem.starfield[c] = {  math.random(5), str }
        digiline_send(c, "/O" .. mem.starfield[c][2])
    end
    mem.mode = 3
    interrupt(2)
elseif (mem.mode == 3 and event.type == "on") then
    mem.mode = 1
elseif (mem.mode == 3 and event.type == "interrupt") then
    for i = 1, #mem.abc do
        local c = mem.abc:sub(i, i)
        if (mem.starfield[c][1] == 1) then
            digiline_send(c, "/O" .. mem.starfield[c][2])
            mem.starfield[c][1] = mem.starfield[c][1] + 1
        elseif (mem.starfield[c][1] == 2) then
            digiline_send(c, "/P" .. mem.starfield[c][2])
            mem.starfield[c][1] = mem.starfield[c][1] + 1
        elseif (mem.starfield[c][1] == 3) then
            digiline_send(c, "/Q" .. mem.starfield[c][2])
            mem.starfield[c][1] = mem.starfield[c][1] + 1
        elseif (mem.starfield[c][1] == 4) then
            digiline_send(c, "/R" .. mem.starfield[c][2])
            mem.starfield[c][1] = mem.starfield[c][1] + 1
        elseif (mem.starfield[c][1] == 5) then
            local str = string.rep(" ", math.random(19)) .. "*"
            str = str .. string.rep(" ", 20 - #str)
            mem.starfield[c] = {  math.random(5), str }
            digiline_send(c, "                    ")
        end
    end
    interrupt(2)
end
