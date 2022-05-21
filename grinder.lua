if (event.type == "program") then
    mem.step = 1
    interrupt(1)
end

if (pin.a == true) then
    digiline_send("flo_stackwise_eject_insert", {
        slotseq = "rotation",
        exmatch = true,
        count = 99
    }
    )
    if (mem.step < 10) then
        digiline_send("flo_stackwise_eject", {
            slotseq = "rotation",
            exmatch = true,
            count = 99
        }
        )
        mem.step = mem.step + 1
        interrupt(5)
    else
        digiline_send("flo_stackwise_eject", {
            slotseq = "rotation",
            exmatch = true
        }
        )
        mem.step = 1
        interrupt(30)
    end
end
