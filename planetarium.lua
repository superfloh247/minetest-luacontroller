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
    mem.mode = 1
end
