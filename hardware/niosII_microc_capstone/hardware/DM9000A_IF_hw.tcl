# TCL File Generated by Component Editor 10.0
# Wed Aug 11 17:55:59 CST 2010
# DO NOT MODIFY


# +-----------------------------------
# | 
# | DM9000A_IF "DM9000A_IF" v1.0
# | null 2010.08.11.17:55:59
# | 
# | 
# | E:/SVN/DE2_70_demonstrations/DE2_70_NET/ip/TERASIC_DM9000A/hdl/DM9000A_IF.v
# | 
# |    ./DM9000A_IF.v syn
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 10.0
# | 
package require -exact sopc 10.0
# | 
# +-----------------------------------

# +-----------------------------------
# | module DM9000A_IF
# | 
set_module_property DESCRIPTION ""
set_module_property NAME DM9000A_IF
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property GROUP "Terasic Technologies Inc."
set_module_property DISPLAY_NAME DM9000A_IF
set_module_property TOP_LEVEL_HDL_FILE DM9000A_IF.v
set_module_property TOP_LEVEL_HDL_MODULE DM9000A_IF
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file DM9000A_IF.v SYNTHESIS
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s1_clock
# | 
add_interface s1_clock clock end

set_interface_property s1_clock ENABLED true

add_interface_port s1_clock avs_s1_clk_iCLK clk Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s1_clock_reset
# | 
add_interface s1_clock_reset reset end
set_interface_property s1_clock_reset associatedClock s1_clock
set_interface_property s1_clock_reset synchronousEdges DEASSERT

set_interface_property s1_clock_reset ASSOCIATED_CLOCK s1_clock
set_interface_property s1_clock_reset ENABLED true

add_interface_port s1_clock_reset avs_s1_reset_n_iRST_N reset_n Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s1
# | 
add_interface s1 avalon end
set_interface_property s1 addressAlignment NATIVE
set_interface_property s1 associatedClock s1_clock
set_interface_property s1 associatedReset s1_clock_reset
set_interface_property s1 burstOnBurstBoundariesOnly false
set_interface_property s1 explicitAddressSpan 0
set_interface_property s1 holdTime 5
set_interface_property s1 isMemoryDevice false
set_interface_property s1 isNonVolatileStorage false
set_interface_property s1 linewrapBursts false
set_interface_property s1 maximumPendingReadTransactions 0
set_interface_property s1 printableDevice false
set_interface_property s1 readLatency 0
set_interface_property s1 readWaitStates 60
set_interface_property s1 readWaitTime 60
set_interface_property s1 setupTime 5
set_interface_property s1 timingUnits Nanoseconds
set_interface_property s1 writeWaitStates 60
set_interface_property s1 writeWaitTime 60

set_interface_property s1 ASSOCIATED_CLOCK s1_clock
set_interface_property s1 ENABLED true

add_interface_port s1 avs_s1_writedata_iDATA writedata Input 16
add_interface_port s1 avs_s1_readdata_oDATA readdata Output 16
add_interface_port s1 avs_s1_address_iCMD address Input 1
add_interface_port s1 avs_s1_read_n_iRD_N read_n Input 1
add_interface_port s1 avs_s1_write_n_iWR_N write_n Input 1
add_interface_port s1 avs_s1_chipselect_n_iCS_N chipselect_n Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s1_irq
# | 
add_interface s1_irq interrupt end
set_interface_property s1_irq associatedAddressablePoint s1
set_interface_property s1_irq associatedClock s1_clock
set_interface_property s1_irq associatedReset s1_clock_reset

set_interface_property s1_irq ASSOCIATED_CLOCK s1_clock
set_interface_property s1_irq ENABLED true

add_interface_port s1_irq avs_s1_irq_oINT irq Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s1_export
# | 
add_interface s1_export conduit end

set_interface_property s1_export ENABLED true

add_interface_port s1_export avs_s1_export_ENET_DATA export Bidir 16
add_interface_port s1_export avs_s1_export_ENET_CMD export Output 1
add_interface_port s1_export avs_s1_export_ENET_RD_N export Output 1
add_interface_port s1_export avs_s1_export_ENET_WR_N export Output 1
add_interface_port s1_export avs_s1_export_ENET_CS_N export Output 1
add_interface_port s1_export avs_s1_export_ENET_RST_N export Output 1
add_interface_port s1_export avs_s1_export_ENET_INT export Input 1
add_interface_port s1_export avs_s1_export_ENET_CLK export Output 1
# | 
# +-----------------------------------