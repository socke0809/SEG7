#-----------------------------------------------------------
# PlanAhead v14.7 (64-bit)
# Build 321239 by xbuild on Fri Sep 27 19:29:51 MDT 2013
# Start of session at: Tue Apr 22 14:54:07 2014
# Process ID: 4380
# Log file: C:/Xilinx/14.7/ISE_DS/PlanAhead/bin/planAhead.log
# Journal file: C:/Xilinx/14.7/ISE_DS/PlanAhead/bin\planAhead.jou
#-----------------------------------------------------------
start_gui
create_project Seg7 ./ -part xc3s100ecp132-4
set_property target_language VHDL [current_project]
set_property ng.output_hdl_format VHDL [get_filesets sim_1]
add_files -norecurse {../../VHDL/Int_to_7SEG.vhd ../../VHDL/StoppUhr.vhd ../../VHDL/divide_by.vhd}
add_files -fileset constrs_1 -norecurse ../../VHDL/Basys2_100_250General.ucf
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
set_property steps.map.args.mt on [get_runs impl_1]
set_property steps.par.args.mt 4 [get_runs impl_1]