if (event.type == "program") then
    mem.producing = false

elseif (event.type == "digiline" and event.msg == "production") then
    mem.producing = true
elseif (event.type == "digiline" and event.msg == "idle") then
    mem.producing = false

elseif (event.type == "on" and mem.producing == false) then
    mem.producing = true
    digiline_send("broadcast", "production")
    digiline_send("LCD", "chainlink fence")
    digiline_send("plastic_sheet", {
        slotseq = "rotation",
        exmatch = true,
        name = "basic_materials:plastic_sheet",
        count = 28
    })
    interrupt(10, "step2")

elseif (event.type == "interrupt" and event.iid == "step2") then
    digiline_send("AC1", "off")
    digiline_send("AC1", {
        { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" },
        { "e", "basic_materials:plastic_sheet", "e" },
        { "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
    })
    digiline_send("AC1", "on")
    interrupt(10, "step3")

elseif (event.type == "interrupt" and event.iid == "step3") then
    digiline_send("iron_ingot", {
        slotseq = "rotation",
        exmatch = true,
        name = "default:steel_ingot",
        count = 6
    })
    digiline_send("feedback1", {
        slotseq = "priority",
        exmatch = true
    })
    interrupt(12, "step4")

elseif (event.type == "interrupt" and event.iid == "step4") then
    digiline_send("AC1", "off")
    digiline_send("AC1", {
        { "default:steel_ingot", "basic_materials:empty_spool", "e" },
        { "basic_materials:empty_spool", "e", "e" },
        { "e", "e", "e" }
    })
    digiline_send("AC1", "on")
    interrupt(12, "step5")

elseif (event.type == "interrupt" and event.iid == "step5") then
    digiline_send("iron_ingot", {
        slotseq = "rotation",
        exmatch = true,
        name = "default:steel_ingot",
        count = 15
    })
    digiline_send("feedback1", {
        slotseq = "priority",
        exmatch = true
    })
    interrupt(12, "step6")

elseif (event.type == "interrupt" and event.iid == "step6") then
    digiline_send("AC1", "off")
    digiline_send("AC1", {
        { "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
        { "basic_materials:steel_wire", "basic_materials:steel_wire", "default:steel_ingot" },
        { "basic_materials:steel_wire", "basic_materials:steel_wire", "default:steel_ingot" }
    })
    digiline_send("AC1", "on")
    interrupt(10, "step7")

elseif (event.type == "interrupt" and event.iid == "step7") then
    digiline_send("final1", {
        slotseq = "priority",
        exmatch = true
    })
    digiline_send("broadcast", "idle")
    digiline_send("LCD", "idle")
    mem.producing = false
end
