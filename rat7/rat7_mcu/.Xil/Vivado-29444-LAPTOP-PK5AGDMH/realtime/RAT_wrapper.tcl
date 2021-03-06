# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/.Xil/Vivado-29444-LAPTOP-PK5AGDMH/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a35tcpg236-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_vhdl -lib xil_defaultlib {
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/pc.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/mux_4to1.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_sp/rat7/rat7.srcs/sources_1/new/stack_pointer.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/mux_scr_data_in.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat3/rat3.srcs/sources_1/new/Scratch_RAM.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/register_file.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/rat_alu.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/rat2.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/prog_rom.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/mux_rf.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/mux_2T1.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/d_flip_flop.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/control_unit.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/sseg_lut.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/rat_mcu.vhd
      C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/rat7_mcu.srcs/sources_1/new/RAT_WRAPPER.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top RAT_wrapper
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "C:/Users/Russe/OneDrive/Documents/GitHub/rat-cpu/rat7_mcu/.Xil/Vivado-29444-LAPTOP-PK5AGDMH/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
      rt::run_rtlelab -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
