if (event.type == "program" or event.type == "on" or event.type == "off") then
    port.a = false
    port.c = false
    port.d = false
    mem.step = 1
elseif (event.type == "digiline" and pin.b == true) then
    port.d = true
    mem.step = 2
    interrupt(1)
elseif (event.type == "interrupt" and pin.b == true) then
    if (mem.step == 2) then
        port.d = false
        mem.step = 3
        interrupt(1)
    elseif (mem.step == 3) then
        port.c = true
        mem.step = 4
        interrupt(1)
    elseif (mem.step == 4) then
        port.c = false
        mem.step = 5
        interrupt(1)
    elseif (mem.step == 5) then
        port.a = true
        mem.step = 6
        interrupt(1)
    elseif (mem.step == 6) then
        port.a = false
    end
end
