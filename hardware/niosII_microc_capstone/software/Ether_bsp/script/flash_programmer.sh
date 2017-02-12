#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting ELF File: /afs/ualberta.ca/home/b/e/benkhale/Documents/ECE_492/Capstone/hardware/niosII_microc_capstone/software/Ether/Ether.elf to: "../flash/Ether_generic_tristate_controller_0.flash"
#
elf2flash --input="/afs/ualberta.ca/home/b/e/benkhale/Documents/ECE_492/Capstone/hardware/niosII_microc_capstone/software/Ether/Ether.elf" --output="../flash/Ether_generic_tristate_controller_0.flash" --boot="$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec" --base=0x1400000 --end=0x1800000 --reset=0x1400000 --verbose 

#
# Programming File: "../flash/Ether_generic_tristate_controller_0.flash" To Device: generic_tristate_controller_0
#
nios2-flash-programmer "../flash/Ether_generic_tristate_controller_0.flash" --base=0x1400000 --sidp=0x1909440 --id=0x0 --timestamp=1486856274 --device=1 --instance=0 '--cable=USB-Blaster on localhost [2-1.6]' --program --verbose 

