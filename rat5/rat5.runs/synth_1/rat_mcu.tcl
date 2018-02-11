# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.cache/wt [current_project]
set_property parent.project_path C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/imports/cpe233/rat2_new/rat2/rat2.srcs/sources_1/new/pc.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/imports/new/mux_4to1.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/new/mux_rf.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/imports/new/rat2.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/imports/cpe233/rat3/rat3.srcs/sources_1/new/register_file.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/imports/cpe233/rat4/rat4.srcs/sources_1/new/rat_alu.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/imports/rat5/prog_rom.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/imports/new/mux_2T1.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/new/d_flip_flop.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/new/control_unit.vhd
  C:/Users/Russe/OneDrive/Documents/GitHub/cpe233/rat5/rat5.srcs/sources_1/new/rat_mcu.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top rat_mcu -part xc7a35tcpg236-1


write_checkpoint -force -noxdef rat_mcu.dcp

catch { report_utilization -file rat_mcu_utilization_synth.rpt -pb rat_mcu_utilization_synth.pb }