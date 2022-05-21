if (event.type == "program") then
    interrupt(1, "don")
elseif (event.type == "interrupt" and event.iid == "don") then
    port.d = true
    interrupt(0.5, "doff")
elseif (event.type == "interrupt" and event.iid == "doff") then
    port.d = false
elseif (event.type == "digiline" and event.msg.action == "tput") then
    digiline_send("LCD", event.msg.stack.name)
    if (event.msg.stack.name == "flowers:seaweed"
        or event.msg.stack.name == "farming:seed_wheat"
        or event.msg.stack.name == "algae:algae_thick"
        or event.msg.stack.name == "algae:algae_medium"
        or event.msg.stack.name == "farming:seed_oat"
        or event.msg.stack.name == "beautiflowers:sonia"
        or event.msg.stack.name == "default:grass_1"
        or event.msg.stack.name == "default:grass_2"
        or event.msg.stack.name == "default:grass_3"
        or event.msg.stack.name == "default:grass_4"
        or event.msg.stack.name == "default:grass_5") then
        digiline_send("trash", {
            slotseq = "priority",
            exmatch = true,
            name = event.msg.stack.name,
            count = 1
        })
        interrupt(0.5, "don")
    else
        digiline_send("AC", "off")
        digiline_send("AC", {
            { event.msg.stack.name, "e", "e" },
            { "e", "e", "e" },
            { "e", "e", "e" }
        })
        digiline_send("mover", {
            slotseq = "priority",
            exmatch = true,
            name = event.msg.stack.name,
            count = 1
        })
        digiline_send("AC", "on")
        interrupt(2, "aon")
    end
elseif (event.type == "interrupt" and event.iid == "aon") then
    port.a = true
    interrupt(0.5, "aoff")
elseif (event.type == "interrupt" and event.iid == "aoff") then
    port.a = false
    interrupt(0.5, "don")
end
