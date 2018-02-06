# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/pangj/OneDrive - California Polytechnic State University/cpe233/hw2/hw2.cache/wt} [current_project]
set_property parent.project_path {C:/Users/pangj/OneDrive - California Polytechnic State University/cpe233/hw2/hw2.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {{C:/Users/pangj/OneDrive - California Polytechnic State University/cpe233/hw2/hw2.srcs/sources_1/new/spkr_drvr.vhd}}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/pangj/OneDrive - California Polytechnic State University/cpe233/hw2/hw2.srcs/constrs_1/imports/Desktop/adsf.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/pangj/OneDrive - California Polytechnic State University/cpe233/hw2/hw2.srcs/constrs_1/imports/Desktop/adsf.xdc}}]


synth_design -top spkr_drvr -part xc7a35tcpg236-1


write_checkpoint -force -noxdef spkr_drvr.dcp

catch { report_utilization -file spkr_drvr_utilization_synth.rpt -pb spkr_drvr_utilization_synth.pb }
