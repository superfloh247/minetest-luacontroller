digiline_send("LCD", "e:"..event.type)
if (event.type == "program") then
    mem.step = "start"
    mem.ingredient = nil
    mem.speed = 4
    digiline_send("LCD", "programmed")
    interrupt(mem.speed, "step")
elseif (event.type == "digiline" and event.msg.action == "tput") then
    mem.empty = false
    if (event.msg.stack.name == "flowers:seaweed"
        or event.msg.stack.name == "farming:seed_wheat"
        or event.msg.stack.name == "algae:algae_thick"
        or event.msg.stack.name == "algae:algae_medium"
        or event.msg.stack.name == "algae:algae_thin"
        or event.msg.stack.name == "farming:seed_oat"
        or event.msg.stack.name == "default:grass_1"
        or event.msg.stack.name == "default:grass_2"
        or event.msg.stack.name == "default:grass_3"
        or event.msg.stack.name == "default:grass_4"
        or event.msg.stack.name == "default:grass_5") then
        mem.ingredient = nil
        digiline_send("trash", {
            slotseq = "priority",
            exmatch = true,
            name = event.msg.stack.name
        })
        digiline_send("LCD", "trash: " .. event.msg.stack.name)
    else
        mem.ingredient = event.msg.stack.name
        digiline_send("LCD", "in: " .. mem.ingredient)
    end
elseif (event.type == "interrupt" and event.iid == "step") then
    if (mem.step == "start") then
        mem.step = "loadchest_on"
        interrupt(mem.speed/4, "step")
    elseif (mem.step == "loadchest_on") then
        port.d = true
        mem.step = "loadchest_off"
        interrupt(mem.speed/2, "step")
    elseif (mem.step == "loadchest_off") then
        port.d = false
        if (mem.ingredient ~= nil) then
            mem.step = "movetoAC"
        else
            mem.step = "loadchest_on"
        end
        interrupt(mem.speed/2, "step")
    elseif (mem.step == "movetoAC") then
        digiline_send("AC", "off")
        digiline_send("AC", {
            { mem.ingredient, "e", "e" },
            { "e", "e", "e" },
            { "e", "e", "e" }
        })
        digiline_send("mover", {
            slotseq = "priority",
            exmatch = true,
            name = mem.ingredient
        })
        digiline_send("AC", "on")
        digiline_send("LCD", "working ... " .. mem.ingredient)
        mem.step = "pushDyes_on"
        interrupt(mem.speed*4, "step")
    elseif (mem.step == "pushDyes_on") then
        port.a = true
        mem.step = "pushDyes_off"
        digiline_send("LCD", "done")
        interrupt(mem.speed/2, "step")
    elseif (mem.step == "pushDyes_off") then
        port.a = false
        mem.step = "loadchest_on"
        interrupt(mem.speed/2, "step")
    end
else
    mem.step = "start"
    mem.ingredient = nil
    mem.empty = true
    interrupt(mem.speed, "step")
end
