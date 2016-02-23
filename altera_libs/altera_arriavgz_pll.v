//  Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
//  Your use of Altera Corporation's design tools, logic functions  
//  and other software and tools, and its AMPP partner logic  
//  functions, and any output files from any of the foregoing  
//  (including device programming or simulation files), and any  
//  associated documentation or information are expressly subject  
//  to the terms and conditions of the Altera Program License  
//  Subscription Agreement, the Altera Quartus II License Agreement, 
//  the Altera MegaCore Function License Agreement, or other  
//  applicable license agreement, including, without limitation,  
//  that your use is for the sole purpose of programming logic  
//  devices manufactured by Altera and sold by Altera or its  
//  authorized distributors.  Please refer to the applicable  
//  agreement for further details. 
//  
//  Quartus II 15.0.0 Build 145 04/22/2015 
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// This first module contains the following group of atoms:
//
// arriavgz_pll_dpa_output 
// arriavgz_pll_refclk_select
// arriavgz_pll_reconfig
// arriavgz_fractional_pll 
//
// Currently the Megafunction will create a single instance of this module as fpll_0
// but we may want to eventually allow for creation of the second of these
// groups as fpll_1.
//

module altera_arriavgz_pll_base(

// arriavgz_pll_dpa_output pins

	output [7:0] phout,

// arriavgz_pll_refclk_select pins


	input adjpllin,
	input cclk,
	input coreclkin,
	input extswitch,
	input iqtxrxclkin,
	input plliqclkin,
	input rxiqclkin,

	input [3:0] clkin,
	input [1:0] refiqclk,


	output clk0bad,
	output clk1bad,
	output pllclksel,  

// arriavgz_pll_reconfig pins


	input atpgmode,
	input clk,
	input fpllcsrtest,
	input iocsrclkin,
	input iocsrdatain,
	input iocsren,
	input iocsrrstn,
	input mdiodis,
	input phaseen,
	input read,
	input rstn,
	input scanen,
	input sershiftload,
	input shiftdonei,
	input updn,
	input write,

	input [5:0] addr,
	input [1:0] byteen,
	input [4:0] cntsel,
	input [15:0] din,


	output blockselect,
	output iocsrdataout,
	output iocsrenbuf,
	output iocsrrstnbuf,
	output phasedone,
	output shift,
	output up,

	output [15:0] dout,
	output [815:0] dprioout,
	output [17:0] shiften,

// arriavgz_fractional_pll pins


	input  fbclkfpll,
	input  lvdfbin,
	input  nresync,
	input  pfden,
	input  shiften_input_port,
	input  zdb,


	output cntnen,
	output fbout_clk,
	output fblvdsout,
	output lock,
	output mcntout,
	output plniotribuf,
	output shiftdoneout,
	output tclk,
	output [7:0] vcoph
);

// arriavgz_pll_dpa_output parameters

parameter output_clock_frequency = "0 ps";
parameter pll_vcoph_div = 1;

// arriavgz_pll_refclk_select parameters

parameter pll_auto_clk_sw_en = "false";
parameter pll_clk_loss_edge = "both_edges";
parameter pll_clk_loss_sw_en = "false";
parameter pll_clk_sw_dly = 0;
parameter pll_clkin_0_src = "clk_0";
parameter pll_clkin_1_src = "clk_0";
parameter pll_manu_clk_sw_en = "false";
parameter pll_sw_refclk_src = "clk_0";

// arriavgz_fractional_pll parameters

parameter pll_output_clock_frequency = "300.0 MHz";
parameter reference_clock_frequency = "100.0 MHz";
parameter mimic_fbclk_type = "gclk";
parameter dsm_accumulator_reset_value = 0;
parameter forcelock = "false";
parameter nreset_invert = "false";
parameter pll_atb = 0;
parameter pll_bwctrl = 1000;
parameter pll_cmp_buf_dly = "0 ps";
parameter pll_cp_comp = "true";
parameter pll_cp_current = 30;
parameter pll_ctrl_override_setting = "false";
parameter pll_dsm_dither = "disable";
parameter pll_dsm_out_sel = "disable";
parameter pll_dsm_reset = "false";
parameter pll_ecn_bypass = "false";
parameter pll_ecn_test_en = "false";
parameter pll_enable = "true";
parameter pll_fbclk_mux_1 = "glb";
parameter pll_fbclk_mux_2 = "fb_1";
parameter pll_fractional_carry_out = 24;
parameter pll_fractional_division = 1;
parameter pll_fractional_value_ready = "true";
parameter pll_lf_testen = "false";
parameter pll_lock_fltr_cfg = 25;
parameter pll_lock_fltr_test = "false";
parameter pll_m_cnt_bypass_en = "false";
parameter pll_m_cnt_coarse_dly = "0 ps";
parameter pll_m_cnt_fine_dly = "0 ps";
parameter pll_m_cnt_hi_div = 2;
parameter pll_m_cnt_in_src = "ph_mux_clk";
parameter pll_m_cnt_lo_div = 1;
parameter pll_m_cnt_odd_div_duty_en = "true";
parameter pll_m_cnt_ph_mux_prst = 0;
parameter pll_m_cnt_prst = 1;
parameter pll_n_cnt_bypass_en = "true";
parameter pll_n_cnt_coarse_dly = "0 ps";
parameter pll_n_cnt_fine_dly = "0 ps";
parameter pll_n_cnt_hi_div = 256;
parameter pll_n_cnt_lo_div = 256;
parameter pll_n_cnt_odd_div_duty_en = "false";
parameter pll_ref_buf_dly = "0 ps";
parameter pll_reg_boost = 0;
parameter pll_regulator_bypass = "false";
parameter pll_ripplecap_ctrl = 0;
parameter pll_slf_rst = "false";
parameter pll_tclk_mux_en = "false";
parameter pll_tclk_sel = "n_src";
parameter pll_test_enable = "false";
parameter pll_testdn_enable = "false";
parameter pll_testup_enable = "false";
parameter pll_unlock_fltr_cfg = 2;
parameter pll_vco_div = 1;
parameter pll_vco_ph0_en = "true";
parameter pll_vco_ph1_en = "true";
parameter pll_vco_ph2_en = "true";
parameter pll_vco_ph3_en = "true";
parameter pll_vco_ph4_en = "true";
parameter pll_vco_ph5_en = "true";
parameter pll_vco_ph6_en = "true";
parameter pll_vco_ph7_en = "true";
parameter pll_vctrl_test_voltage = 750;
parameter vccd0g_atb = "disable";
parameter vccd0g_output = 0;
parameter vccd1g_atb = "disable";
parameter vccd1g_output = 0;
parameter vccm1g_tap = 2;
parameter vccr_pd = "false";
parameter vcodiv_override = "false";

//////////////////////////////////////////////////////////////////////////////////////
// Wire Defitions for altera_arriavgz_pll_base module
//////////////////////////////////////////////////////////////////////////////////////

wire pll_reconfig_shiftenm_wire; 
wire pll_reconfig_up_wire;
wire refclk_select_extswitchbuf_wire;
wire refclk_select_clkout_wire;
wire [1:0] fboutclk_wire;

wire [7:0] fpll_mhi_bus;

//////////////////////////////////////////////

stratixv_pll_reconfig PLL_RECONFIG
( 
// Input Ports
	.atpgmode ( atpgmode ),
	.clk( clk ),			
	.cntnen( cntnen ),		
	.fpllcsrtest ( fpllcsrtest ),
	.iocsrclkin( iocsrclkin ),	
	.iocsrdatain( iocsrdatain ),	
	.iocsren( iocsren ),		
	.iocsrrstn( iocsrrstn ),	
	.mdiodis( mdiodis ),		
	.mhi( fpll_mhi_bus ), 
	.phaseen( phaseen ),		
	.read( read ),			
	.rstn( rstn ),			
	.scanen( scanen ),		
	.sershiftload( sershiftload ),	
	.shiftdonei( shiftdonei ),	
	.updn( updn ),			
	.write( write ),		

	.addr( addr ),			
	.byteen( byteen ),		
	.cntsel( cntsel ),		
	.din( din ),			
	
// Output Ports
	.blockselect( blockselect ),			
	.iocsrdataout( iocsrdataout ), 
	.iocsrenbuf( iocsrenbuf ), 
	.iocsrrstnbuf( iocsrrstnbuf ),
	.phasedone( phasedone ),
	.shift( shift ), 
	.shiftenm( pll_reconfig_shiftenm_wire ),
	.up( pll_reconfig_up_wire ),

	.dout( dout ),
	.dprioout( dprioout ), 
	.shiften( shiften )
);

//////////////////////////////////////////////

stratixv_pll_refclk_select 
#(
	.pll_auto_clk_sw_en ( pll_auto_clk_sw_en ),
	.pll_clk_loss_edge ( pll_clk_loss_edge ),
	.pll_clk_loss_sw_en ( pll_clk_loss_sw_en ),
	.pll_clk_sw_dly ( pll_clk_sw_dly ),
	.pll_clkin_0_src ( pll_clkin_0_src ),
	.pll_clkin_1_src ( pll_clkin_1_src ),
	.pll_manu_clk_sw_en ( pll_manu_clk_sw_en ),
	.pll_sw_refclk_src ( pll_sw_refclk_src )
) REFCLK_SELECT
( 
// Input Ports
	.adjpllin( adjpllin ),		
	.cclk( cclk ),			
	.coreclkin( coreclkin ),	
	.extswitch( extswitch ),	
	.iqtxrxclkin( iqtxrxclkin ),	
	.plliqclkin( plliqclkin ),	
	.rxiqclkin( rxiqclkin ),	
	.clkin( clkin ),		
	.refiqclk( refiqclk ),		
	
// Output Ports
	.clk0bad( clk0bad ),		
	.clk1bad( clk1bad ),		
	.clkout( refclk_select_clkout_wire ),
	.extswitchbuf( refclk_select_extswitchbuf_wire ),
	.pllclksel( pllclksel )		

);

//////////////////////////////////////////////

stratixv_pll_dpa_output 
#(
// Parameters 
	.output_clock_frequency ( output_clock_frequency ),
	.pll_vcoph_div ( pll_vcoph_div )
) DPA
( 
// Input Ports
	.pd( cntnen ),
	.phin( vcoph ),

// Output Ports
	.phout( phout )	
);

//////////////////////////////////////////////

stratixv_fractional_pll
#(
// Parameters 
	.output_clock_frequency ( pll_output_clock_frequency ),
	.reference_clock_frequency ( reference_clock_frequency ),
	.mimic_fbclk_type ( mimic_fbclk_type ),
	.dsm_accumulator_reset_value ( dsm_accumulator_reset_value ),
	.forcelock ( forcelock ),
	.nreset_invert ( nreset_invert ),
	.pll_atb ( pll_atb ),
	.pll_bwctrl ( pll_bwctrl ),
	.pll_cmp_buf_dly ( pll_cmp_buf_dly ),
	.pll_cp_comp ( pll_cp_comp ),
	.pll_cp_current ( pll_cp_current ),
	.pll_ctrl_override_setting ( pll_ctrl_override_setting ),
	.pll_dsm_dither ( pll_dsm_dither ),
	.pll_dsm_out_sel ( pll_dsm_out_sel ),
	.pll_dsm_reset ( pll_dsm_reset ),
	.pll_ecn_bypass ( pll_ecn_bypass ),
	.pll_ecn_test_en ( pll_ecn_test_en ),
	.pll_enable ( pll_enable ),
	.pll_fbclk_mux_1 ( pll_fbclk_mux_1 ),
	.pll_fbclk_mux_2 ( pll_fbclk_mux_2 ),
	.pll_fractional_carry_out ( pll_fractional_carry_out ),
	.pll_fractional_division ( 1 ),
	.pll_fractional_division_string ( pll_fractional_division ),
	.pll_fractional_value_ready ( pll_fractional_value_ready ),
	.pll_lf_testen ( pll_lf_testen ),
	.pll_lock_fltr_cfg ( pll_lock_fltr_cfg ),
	.pll_lock_fltr_test ( pll_lock_fltr_test ),
	.pll_m_cnt_bypass_en ( pll_m_cnt_bypass_en ),
	.pll_m_cnt_coarse_dly ( pll_m_cnt_coarse_dly ),
	.pll_m_cnt_fine_dly ( pll_m_cnt_fine_dly ),
	.pll_m_cnt_hi_div ( pll_m_cnt_hi_div ),
	.pll_m_cnt_in_src ( pll_m_cnt_in_src ),
	.pll_m_cnt_lo_div ( pll_m_cnt_lo_div ),
	.pll_m_cnt_odd_div_duty_en ( pll_m_cnt_odd_div_duty_en ),
	.pll_m_cnt_ph_mux_prst ( pll_m_cnt_ph_mux_prst ),
	.pll_m_cnt_prst ( pll_m_cnt_prst ),
	.pll_n_cnt_bypass_en ( pll_n_cnt_bypass_en ),
	.pll_n_cnt_coarse_dly ( pll_n_cnt_coarse_dly ),
	.pll_n_cnt_fine_dly ( pll_n_cnt_fine_dly ),
	.pll_n_cnt_hi_div ( pll_n_cnt_hi_div ),
	.pll_n_cnt_lo_div ( pll_n_cnt_lo_div ),
	.pll_n_cnt_odd_div_duty_en ( pll_n_cnt_odd_div_duty_en ),
	.pll_ref_buf_dly ( pll_ref_buf_dly ),
	.pll_reg_boost ( pll_reg_boost ),
	.pll_regulator_bypass ( pll_regulator_bypass ),
	.pll_ripplecap_ctrl ( pll_ripplecap_ctrl ),
	.pll_slf_rst ( pll_slf_rst ),
	.pll_tclk_mux_en ( pll_tclk_mux_en ),
	.pll_tclk_sel ( pll_tclk_sel ),
	.pll_test_enable ( pll_test_enable ),
	.pll_testdn_enable ( pll_testdn_enable ),
	.pll_testup_enable ( pll_testup_enable ),
	.pll_unlock_fltr_cfg ( pll_unlock_fltr_cfg ),
	.pll_vco_div ( pll_vco_div ),
	.pll_vco_ph0_en ( pll_vco_ph0_en ),
	.pll_vco_ph1_en ( pll_vco_ph1_en ),
	.pll_vco_ph2_en ( pll_vco_ph2_en ),
	.pll_vco_ph3_en ( pll_vco_ph3_en ),
	.pll_vco_ph4_en ( pll_vco_ph4_en ),
	.pll_vco_ph5_en ( pll_vco_ph5_en ),
	.pll_vco_ph6_en ( pll_vco_ph6_en ),
	.pll_vco_ph7_en ( pll_vco_ph7_en ),
	.pll_vctrl_test_voltage ( pll_vctrl_test_voltage ),
	.vccd0g_atb ( vccd0g_atb ),
	.vccd0g_output ( vccd0g_output ),
	.vccd1g_atb ( vccd1g_atb ),
	.vccd1g_output ( vccd1g_output ),
	.vccm1g_tap ( vccm1g_tap ),
	.vccr_pd ( vccr_pd ),
	.vcodiv_override ( vcodiv_override )
) fpll
( 
// Input Ports
	.coreclkfb( fboutclk_wire[0]),
	.ecnc1test( refclk_select_extswitchbuf_wire ),
	.ecnc2test( updn ),
	.fbclkfpll( fbclkfpll ),
	.lvdsfbin( lvdfbin ),
	.nresync( nresync ),
	.pfden( pfden ), 			
	.refclkin( refclk_select_clkout_wire ),
	.shift( shift ),
	.shiftdonein( shift ), // Connection per the pl_ffpll_ihc#2.v
	.shiften( pll_reconfig_shiftenm_wire ), 
	.up( pll_reconfig_up_wire ),
	.zdb( zdb ),				
	
// Output Ports
	.cntnen( cntnen ), // Drives counter.nen, dpa.pd, and reconfig.ncntnen pins.
	.fbclk(  fboutclk_wire[0]),
	.fblvdsout( fblvdsout ),
	.lock( lock ), 				
	.mcntout( mcntout ),
	.plniotribuf( plniotribuf ), 
	.shiftdoneout( shiftdoneout ),
	.tclk( tclk ),

	.mhi( fpll_mhi_bus ), 
	.vcoph( vcoph )
);

assign fbout_clk = fboutclk_wire[0];
assign up = pll_reconfig_up_wire;

endmodule

//////////////////////////////////////////////

module altera_arriavgz_pll(

// arriavgz_pll_dpa_output pins

// Output
	phout_0,	// 8
	phout_1,	// 8

// arriavgz_pll_refclk_select pins

// Input
        adjpllin,
	cclk,
	coreclkin,
	extswitch,
	iqtxrxclkin,
	plliqclkin,
	rxiqclkin,

	clkin,		// 4
	refiqclk_0,	// 2
	refiqclk_1,	// 2

// Output
	clk0bad,
	clk1bad,
	pllclksel,

// arriavgz_pll_reconfig pins

// Input
	atpgmode,
	clk,
	fpllcsrtest,
	iocsrclkin,
	iocsrdatain,
	iocsren,
	iocsrrstn,
	mdiodis,
	phaseen,
	read,
	rstn,
	scanen,
	sershiftload,
	shiftdonei,
	updn,
	write,

	addr_0,		// 6
	addr_1,		// 6
	byteen_0,	// 2
	byteen_1,	// 2
	cntsel_0,	// 5
	cntsel_1,	// 5
	din_0,		// 16
	din_1,		// 16

// Output
	blockselect,
	iocsrdataout,
	iocsrenbuf,
	iocsrrstnbuf,
	phasedone,

	dout_0,		// 16
	dout_1,		// 16
	dprioout_0,	// 816
	dprioout_1,	// 816


// arriavgz_fractional_pll pins

// Input
	fbclkfpll,
	lvdfbin,
	nresync,
	pfden,
	shiften_fpll,
	zdb,

// Output
	fblvdsout,
	lock,
	mcntout,
	plniotribuf,

// arriavgz_pll_extclk_pins

// Input
	clken,

// Output
	extclk,

// arriavgz_pll_dll_pins

// Input
	dll_clkin,

// Output
	clkout,

// arriavgz_pll_lvds_pins

// Input
	loaden,

// Output
	lvdsclk,

// arriavgz_pll_output_counter pins

	divclk,			// 18
	cascade_out		// 18	
);

// Parameter controlling architecture

// Used in generate statement

parameter number_of_counters = 18;

// These params used to populate appropriate number of ports/wires but the blocks
// associated with these are not created within a generate statement.

parameter number_of_fplls = 1; // Change to 2 for adding fpll_1
parameter number_of_extclks = 4;
parameter number_of_dlls = 2;
parameter number_of_lvds = 4;

// arriavgz_pll_dpa_output pins

	output [7:0] phout_0;
	output [7:0] phout_1;

// arriavgz_pll_refclk_select pins

	input [number_of_fplls-1:0] adjpllin;
	input [number_of_fplls-1:0] cclk;
	input [number_of_fplls-1:0] coreclkin;
	input [number_of_fplls-1:0] extswitch;
	input [number_of_fplls-1:0] iqtxrxclkin;
	input [number_of_fplls-1:0] plliqclkin;
	input [number_of_fplls-1:0] rxiqclkin;

	input [3:0] clkin;
	input [1:0] refiqclk_0;
	input [1:0] refiqclk_1;



	output [number_of_fplls-1:0] clk0bad;
	output [number_of_fplls-1:0] clk1bad;
	output [number_of_fplls-1:0] pllclksel;

// arriavgz_pll_reconfig pins


	input [number_of_fplls-1:0] atpgmode;
	input [number_of_fplls-1:0] clk;
	input [number_of_fplls-1:0] fpllcsrtest;
	input [number_of_fplls-1:0] iocsrclkin;
	input [number_of_fplls-1:0] iocsrdatain;
	input [number_of_fplls-1:0] iocsren;
	input [number_of_fplls-1:0] iocsrrstn;
	input [number_of_fplls-1:0] mdiodis;
	input [number_of_fplls-1:0] phaseen;
	input [number_of_fplls-1:0] read;
	input [number_of_fplls-1:0] rstn;
	input [number_of_fplls-1:0] scanen;
	input [number_of_fplls-1:0] sershiftload;
	input [number_of_fplls-1:0] shiftdonei;
	input [number_of_fplls-1:0] updn;
	input [number_of_fplls-1:0] write;

	input [5:0] addr_0;
	input [5:0] addr_1;
	input [1:0] byteen_0;
	input [1:0] byteen_1;
	input [4:0] cntsel_0;
	input [4:0] cntsel_1;
	input [15:0] din_0;
	input [15:0] din_1;


	output [number_of_fplls-1:0] blockselect;
	output [number_of_fplls-1:0] iocsrdataout;
	output [number_of_fplls-1:0] iocsrenbuf;
	output [number_of_fplls-1:0] iocsrrstnbuf;
	output [number_of_fplls-1:0] phasedone;

	output [15:0] dout_0;
	output [15:0] dout_1;
	output [815:0] dprioout_0;
	output [815:0] dprioout_1;

// arriavgz_fractional_pll pins


	input [number_of_fplls-1:0] fbclkfpll;
	input [number_of_fplls-1:0] lvdfbin;
	input [number_of_fplls-1:0] nresync;
	input [number_of_fplls-1:0] pfden;
	input [number_of_fplls-1:0] shiften_fpll;
	input [number_of_fplls-1:0] zdb;

	output [number_of_fplls-1:0] fblvdsout;
	output [number_of_fplls-1:0] lock;
	output [number_of_fplls-1:0] mcntout;
	output [number_of_fplls-1:0] plniotribuf;

// arriavgz_pll_extclk_output pins

	input [number_of_extclks-1:0] clken;
	output [number_of_extclks-1:0] extclk;

// arriavgz_pll_dll_output pins

	input [number_of_dlls-1:0] dll_clkin;
	output [number_of_dlls-1:0] clkout;

// arriavgz_pll_lvds_output pins

	output [number_of_lvds-1:0] loaden;
	output [number_of_lvds-1:0] lvdsclk;

// arriavgz_pll_output_counter pins

	output [number_of_counters-1:0] divclk;
	output [number_of_counters-1:0] cascade_out;

///////// The following parameters are specific to the fpll_0 instance ///////

// Will need to replicate these with _1 suffix if we plan to instantiate an fpll_1

// arriavgz_pll_dpa_output parameters

parameter dpa_output_clock_frequency_0 = "0 ps";
parameter pll_vcoph_div_0 = 1;

// arriavgz_pll_refclk_select parameters

parameter pll_auto_clk_sw_en_0 = "false";
parameter pll_clk_loss_edge_0 = "both_edges";
parameter pll_clk_loss_sw_en_0 = "false";
parameter pll_clk_sw_dly_0 = 0;
parameter pll_clkin_0_src_0 = "clk_0";
parameter pll_clkin_1_src_0 = "clk_0";
parameter pll_manu_clk_sw_en_0 = "false";
parameter pll_sw_refclk_src_0 = "clk_0";

// arriavgz_fractional_pll parameters

parameter pll_output_clock_frequency_0 = "300.0 MHz";
parameter reference_clock_frequency_0 = "100.0 MHz";
parameter mimic_fbclk_type_0 = "gclk";
parameter dsm_accumulator_reset_value_0 = 0;
parameter forcelock_0 = "false";
parameter nreset_invert_0 = "false";
parameter pll_atb_0 = 0;
parameter pll_bwctrl_0 = 4000;
parameter pll_cmp_buf_dly_0 = "0 ps";
parameter pll_cp_comp_0 = "true";
parameter pll_cp_current_0 = 20;
parameter pll_ctrl_override_setting_0 = "false";
parameter pll_dsm_dither_0 = "disable";
parameter pll_dsm_out_sel_0 = "disable";
parameter pll_dsm_reset_0 = "false";
parameter pll_ecn_bypass_0 = "false";
parameter pll_ecn_test_en_0 = "false";
parameter pll_enable_0 = "true";
parameter pll_fbclk_mux_1_0 = "glb";
parameter pll_fbclk_mux_2_0 = "fb_1";
parameter pll_fractional_carry_out_0 = 24;
parameter pll_fractional_division_0 = 1;
parameter pll_fractional_value_ready_0 = "true";
parameter pll_lf_testen_0 = "false";
parameter pll_lock_fltr_cfg_0 = 25;
parameter pll_lock_fltr_test_0 = "false";
parameter pll_m_cnt_bypass_en_0 = "false";
parameter pll_m_cnt_coarse_dly_0 = "0 ps";
parameter pll_m_cnt_fine_dly_0 = "0 ps";
parameter pll_m_cnt_hi_div_0 = 2;
parameter pll_m_cnt_in_src_0 = "ph_mux_clk";
parameter pll_m_cnt_lo_div_0 = 1;
parameter pll_m_cnt_odd_div_duty_en_0 = "true";
parameter pll_m_cnt_ph_mux_prst_0 = 0;
parameter pll_m_cnt_prst_0 = 1;
parameter pll_n_cnt_bypass_en_0 = "true";
parameter pll_n_cnt_coarse_dly_0 = "0 ps";
parameter pll_n_cnt_fine_dly_0 = "0 ps";
parameter pll_n_cnt_hi_div_0 = 256;
parameter pll_n_cnt_lo_div_0 = 256;
parameter pll_n_cnt_odd_div_duty_en_0 = "false";
parameter pll_ref_buf_dly_0 = "0 ps";
parameter pll_reg_boost_0 = 0;
parameter pll_regulator_bypass_0 = "false";
parameter pll_ripplecap_ctrl_0 = 0;
parameter pll_slf_rst_0 = "false";
parameter pll_tclk_mux_en_0 = "false";
parameter pll_tclk_sel_0 = "n_src";
parameter pll_test_enable_0 = "false";
parameter pll_testdn_enable_0 = "false";
parameter pll_testup_enable_0 = "false";
parameter pll_unlock_fltr_cfg_0 = 2;
parameter pll_vco_div_0 = 1;
parameter pll_vco_ph0_en_0 = "true";
parameter pll_vco_ph1_en_0 = "true";
parameter pll_vco_ph2_en_0 = "true";
parameter pll_vco_ph3_en_0 = "true";
parameter pll_vco_ph4_en_0 = "true";
parameter pll_vco_ph5_en_0 = "true";
parameter pll_vco_ph6_en_0 = "true";
parameter pll_vco_ph7_en_0 = "true";
parameter pll_vctrl_test_voltage_0 = 750;
parameter vccd0g_atb_0 = "disable";
parameter vccd0g_output_0 = 0;
parameter vccd1g_atb_0 = "disable";
parameter vccd1g_output_0 = 0;
parameter vccm1g_tap_0 = 2;
parameter vccr_pd_0 = "false";
parameter vcodiv_override_0 = "false";

///////// End of fpll_0 instance parameters ///////

parameter enable_lvds_output_0 = "false";
parameter pll_loaden_coarse_dly_0 = "0 ps";
parameter pll_loaden_enable_disable_0 = "true";
parameter pll_loaden_fine_dly_0 = "0 ps";
parameter pll_lvdsclk_coarse_dly_0 = "0 ps";
parameter pll_lvdsclk_enable_disable_0 = "true";
parameter pll_lvdsclk_fine_dly_0 = "0 ps";

parameter enable_lvds_output_1 = "false";
parameter pll_loaden_coarse_dly_1 = "0 ps";
parameter pll_loaden_enable_disable_1 = "true";
parameter pll_loaden_fine_dly_1 = "0 ps";
parameter pll_lvdsclk_coarse_dly_1 = "0 ps";
parameter pll_lvdsclk_enable_disable_1 = "true";
parameter pll_lvdsclk_fine_dly_1 = "0 ps";

parameter enable_lvds_output_2 = "false";
parameter pll_loaden_coarse_dly_2 = "0 ps";
parameter pll_loaden_enable_disable_2 = "true";
parameter pll_loaden_fine_dly_2 = "0 ps";
parameter pll_lvdsclk_coarse_dly_2 = "0 ps";
parameter pll_lvdsclk_enable_disable_2 = "true";
parameter pll_lvdsclk_fine_dly_2 = "0 ps";

parameter enable_lvds_output_3 = "false";
parameter pll_loaden_coarse_dly_3 = "0 ps";
parameter pll_loaden_enable_disable_3 = "true";
parameter pll_loaden_fine_dly_3 = "0 ps";
parameter pll_lvdsclk_coarse_dly_3 = "0 ps";
parameter pll_lvdsclk_enable_disable_3 = "true";
parameter pll_lvdsclk_fine_dly_3 = "0 ps";

// arriavgz_pll_dll_output parameters

parameter enable_dll_output_0 = "false";
parameter pll_dll_src_value_0 = "vss";

parameter enable_dll_output_1 = "false";
parameter pll_dll_src_value_1 = "vss";

// arriavgz_pll_extclk_output parameters

parameter enable_extclk_output_0 = "false";
parameter pll_extclk_cnt_src_0 = "m0_cnt";
parameter pll_extclk_enable_0 = "false";
parameter pll_extclk_invert_0 = "false";

parameter enable_extclk_output_1 = "false";
parameter pll_extclk_cnt_src_1 = "m0_cnt";
parameter pll_extclk_enable_1 = "false";
parameter pll_extclk_invert_1 = "false";

parameter enable_extclk_output_2 = "false";
parameter pll_extclk_cnt_src_2 = "m0_cnt";
parameter pll_extclk_enable_2 = "false";
parameter pll_extclk_invert_2 = "false";

parameter enable_extclk_output_3 = "false";
parameter pll_extclk_cnt_src_3 = "m0_cnt";
parameter pll_extclk_enable_3 = "false";
parameter pll_extclk_invert_3 = "false";

// Counter parameters, these are autogenerated with a perl script
// Default behavior expects a 300MHz clock out of the fpll with only counter_0
// active and producing a 100MHz clock.

//////////////////////////////////////////////////////////////////////////////////////
// Beginning of auto generated parameters

parameter output_clock_frequency_0 = "100.0 MHz";
parameter enable_output_counter_0 = "true";
parameter phase_shift_0 = "0 ps";
parameter duty_cycle_0 = 50;
parameter c_cnt_coarse_dly_0 = "0 ps";
parameter c_cnt_fine_dly_0 = "0 ps";
parameter c_cnt_in_src_0 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_0 = 0;
parameter c_cnt_prst_0 = 1;
localparam cnt_fpll_src_0 = "fpll_0";
parameter dprio0_cnt_bypass_en_0 = "false";
parameter dprio0_cnt_hi_div_0 = 2;
parameter dprio0_cnt_lo_div_0 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_0 = "true";
localparam dprio1_cnt_bypass_en_0 = dprio0_cnt_bypass_en_0;
localparam dprio1_cnt_hi_div_0 = dprio0_cnt_hi_div_0;
localparam dprio1_cnt_lo_div_0 = dprio0_cnt_lo_div_0;
localparam dprio1_cnt_odd_div_even_duty_en_0 = dprio0_cnt_odd_div_even_duty_en_0;

parameter output_clock_frequency_1 = "0 ps";
parameter enable_output_counter_1 = "false";
parameter phase_shift_1 = "0 ps";
parameter duty_cycle_1 = 50;
parameter c_cnt_coarse_dly_1 = "0 ps";
parameter c_cnt_fine_dly_1 = "0 ps";
parameter c_cnt_in_src_1 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_1 = 0;
parameter c_cnt_prst_1 = 1;
localparam cnt_fpll_src_1 = "fpll_0";
parameter dprio0_cnt_bypass_en_1 = "false";
parameter dprio0_cnt_hi_div_1 = 1;
parameter dprio0_cnt_lo_div_1 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_1 = "false";
localparam dprio1_cnt_bypass_en_1 = dprio0_cnt_bypass_en_1;
localparam dprio1_cnt_hi_div_1 = dprio0_cnt_hi_div_1;
localparam dprio1_cnt_lo_div_1 = dprio0_cnt_lo_div_1;
localparam dprio1_cnt_odd_div_even_duty_en_1 = dprio0_cnt_odd_div_even_duty_en_1;

parameter output_clock_frequency_2 = "0 ps";
parameter enable_output_counter_2 = "false";
parameter phase_shift_2 = "0 ps";
parameter duty_cycle_2 = 50;
parameter c_cnt_coarse_dly_2 = "0 ps";
parameter c_cnt_fine_dly_2 = "0 ps";
parameter c_cnt_in_src_2 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_2 = 0;
parameter c_cnt_prst_2 = 1;
localparam cnt_fpll_src_2 = "fpll_0";
parameter dprio0_cnt_bypass_en_2 = "false";
parameter dprio0_cnt_hi_div_2 = 1;
parameter dprio0_cnt_lo_div_2 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_2 = "false";
localparam dprio1_cnt_bypass_en_2 = dprio0_cnt_bypass_en_2;
localparam dprio1_cnt_hi_div_2 = dprio0_cnt_hi_div_2;
localparam dprio1_cnt_lo_div_2 = dprio0_cnt_lo_div_2;
localparam dprio1_cnt_odd_div_even_duty_en_2 = dprio0_cnt_odd_div_even_duty_en_2;

parameter output_clock_frequency_3 = "0 ps";
parameter enable_output_counter_3 = "false";
parameter phase_shift_3 = "0 ps";
parameter duty_cycle_3 = 50;
parameter c_cnt_coarse_dly_3 = "0 ps";
parameter c_cnt_fine_dly_3 = "0 ps";
parameter c_cnt_in_src_3 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_3 = 0;
parameter c_cnt_prst_3 = 1;
localparam cnt_fpll_src_3 = "fpll_0";
parameter dprio0_cnt_bypass_en_3 = "false";
parameter dprio0_cnt_hi_div_3 = 1;
parameter dprio0_cnt_lo_div_3 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_3 = "false";
localparam dprio1_cnt_bypass_en_3 = dprio0_cnt_bypass_en_3;
localparam dprio1_cnt_hi_div_3 = dprio0_cnt_hi_div_3;
localparam dprio1_cnt_lo_div_3 = dprio0_cnt_lo_div_3;
localparam dprio1_cnt_odd_div_even_duty_en_3 = dprio0_cnt_odd_div_even_duty_en_3;

parameter output_clock_frequency_4 = "0 ps";
parameter enable_output_counter_4 = "false";
parameter phase_shift_4 = "0 ps";
parameter duty_cycle_4 = 50;
parameter c_cnt_coarse_dly_4 = "0 ps";
parameter c_cnt_fine_dly_4 = "0 ps";
parameter c_cnt_in_src_4 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_4 = 0;
parameter c_cnt_prst_4 = 1;
localparam cnt_fpll_src_4 = "fpll_0";
parameter dprio0_cnt_bypass_en_4 = "false";
parameter dprio0_cnt_hi_div_4 = 1;
parameter dprio0_cnt_lo_div_4 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_4 = "false";
localparam dprio1_cnt_bypass_en_4 = dprio0_cnt_bypass_en_4;
localparam dprio1_cnt_hi_div_4 = dprio0_cnt_hi_div_4;
localparam dprio1_cnt_lo_div_4 = dprio0_cnt_lo_div_4;
localparam dprio1_cnt_odd_div_even_duty_en_4 = dprio0_cnt_odd_div_even_duty_en_4;

parameter output_clock_frequency_5 = "0 ps";
parameter enable_output_counter_5 = "false";
parameter phase_shift_5 = "0 ps";
parameter duty_cycle_5 = 50;
parameter c_cnt_coarse_dly_5 = "0 ps";
parameter c_cnt_fine_dly_5 = "0 ps";
parameter c_cnt_in_src_5 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_5 = 0;
parameter c_cnt_prst_5 = 1;
localparam cnt_fpll_src_5 = "fpll_0";
parameter dprio0_cnt_bypass_en_5 = "false";
parameter dprio0_cnt_hi_div_5 = 1;
parameter dprio0_cnt_lo_div_5 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_5 = "false";
localparam dprio1_cnt_bypass_en_5 = dprio0_cnt_bypass_en_5;
localparam dprio1_cnt_hi_div_5 = dprio0_cnt_hi_div_5;
localparam dprio1_cnt_lo_div_5 = dprio0_cnt_lo_div_5;
localparam dprio1_cnt_odd_div_even_duty_en_5 = dprio0_cnt_odd_div_even_duty_en_5;

parameter output_clock_frequency_6 = "0 ps";
parameter enable_output_counter_6 = "false";
parameter phase_shift_6 = "0 ps";
parameter duty_cycle_6 = 50;
parameter c_cnt_coarse_dly_6 = "0 ps";
parameter c_cnt_fine_dly_6 = "0 ps";
parameter c_cnt_in_src_6 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_6 = 0;
parameter c_cnt_prst_6 = 1;
localparam cnt_fpll_src_6 = "fpll_0";
parameter dprio0_cnt_bypass_en_6 = "false";
parameter dprio0_cnt_hi_div_6 = 1;
parameter dprio0_cnt_lo_div_6 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_6 = "false";
localparam dprio1_cnt_bypass_en_6 = dprio0_cnt_bypass_en_6;
localparam dprio1_cnt_hi_div_6 = dprio0_cnt_hi_div_6;
localparam dprio1_cnt_lo_div_6 = dprio0_cnt_lo_div_6;
localparam dprio1_cnt_odd_div_even_duty_en_6 = dprio0_cnt_odd_div_even_duty_en_6;

parameter output_clock_frequency_7 = "0 ps";
parameter enable_output_counter_7 = "false";
parameter phase_shift_7 = "0 ps";
parameter duty_cycle_7 = 50;
parameter c_cnt_coarse_dly_7 = "0 ps";
parameter c_cnt_fine_dly_7 = "0 ps";
parameter c_cnt_in_src_7 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_7 = 0;
parameter c_cnt_prst_7 = 1;
localparam cnt_fpll_src_7 = "fpll_0";
parameter dprio0_cnt_bypass_en_7 = "false";
parameter dprio0_cnt_hi_div_7 = 1;
parameter dprio0_cnt_lo_div_7 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_7 = "false";
localparam dprio1_cnt_bypass_en_7 = dprio0_cnt_bypass_en_7;
localparam dprio1_cnt_hi_div_7 = dprio0_cnt_hi_div_7;
localparam dprio1_cnt_lo_div_7 = dprio0_cnt_lo_div_7;
localparam dprio1_cnt_odd_div_even_duty_en_7 = dprio0_cnt_odd_div_even_duty_en_7;

parameter output_clock_frequency_8 = "0 ps";
parameter enable_output_counter_8 = "false";
parameter phase_shift_8 = "0 ps";
parameter duty_cycle_8 = 50;
parameter c_cnt_coarse_dly_8 = "0 ps";
parameter c_cnt_fine_dly_8 = "0 ps";
parameter c_cnt_in_src_8 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_8 = 0;
parameter c_cnt_prst_8 = 1;
localparam cnt_fpll_src_8 = "fpll_0";
parameter dprio0_cnt_bypass_en_8 = "false";
parameter dprio0_cnt_hi_div_8 = 1;
parameter dprio0_cnt_lo_div_8 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_8 = "false";
localparam dprio1_cnt_bypass_en_8 = dprio0_cnt_bypass_en_8;
localparam dprio1_cnt_hi_div_8 = dprio0_cnt_hi_div_8;
localparam dprio1_cnt_lo_div_8 = dprio0_cnt_lo_div_8;
localparam dprio1_cnt_odd_div_even_duty_en_8 = dprio0_cnt_odd_div_even_duty_en_8;

parameter output_clock_frequency_9 = "0 ps";
parameter enable_output_counter_9 = "false";
parameter phase_shift_9 = "0 ps";
parameter duty_cycle_9 = 50;
parameter c_cnt_coarse_dly_9 = "0 ps";
parameter c_cnt_fine_dly_9 = "0 ps";
parameter c_cnt_in_src_9 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_9 = 0;
parameter c_cnt_prst_9 = 1;
localparam cnt_fpll_src_9 = "fpll_0";
parameter dprio0_cnt_bypass_en_9 = "false";
parameter dprio0_cnt_hi_div_9 = 1;
parameter dprio0_cnt_lo_div_9 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_9 = "false";
localparam dprio1_cnt_bypass_en_9 = dprio0_cnt_bypass_en_9;
localparam dprio1_cnt_hi_div_9 = dprio0_cnt_hi_div_9;
localparam dprio1_cnt_lo_div_9 = dprio0_cnt_lo_div_9;
localparam dprio1_cnt_odd_div_even_duty_en_9 = dprio0_cnt_odd_div_even_duty_en_9;

parameter output_clock_frequency_10 = "0 ps";
parameter enable_output_counter_10 = "false";
parameter phase_shift_10 = "0 ps";
parameter duty_cycle_10 = 50;
parameter c_cnt_coarse_dly_10 = "0 ps";
parameter c_cnt_fine_dly_10 = "0 ps";
parameter c_cnt_in_src_10 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_10 = 0;
parameter c_cnt_prst_10 = 1;
localparam cnt_fpll_src_10 = "fpll_0";
parameter dprio0_cnt_bypass_en_10 = "false";
parameter dprio0_cnt_hi_div_10 = 1;
parameter dprio0_cnt_lo_div_10 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_10 = "false";
localparam dprio1_cnt_bypass_en_10 = dprio0_cnt_bypass_en_10;
localparam dprio1_cnt_hi_div_10 = dprio0_cnt_hi_div_10;
localparam dprio1_cnt_lo_div_10 = dprio0_cnt_lo_div_10;
localparam dprio1_cnt_odd_div_even_duty_en_10 = dprio0_cnt_odd_div_even_duty_en_10;

parameter output_clock_frequency_11 = "0 ps";
parameter enable_output_counter_11 = "false";
parameter phase_shift_11 = "0 ps";
parameter duty_cycle_11 = 50;
parameter c_cnt_coarse_dly_11 = "0 ps";
parameter c_cnt_fine_dly_11 = "0 ps";
parameter c_cnt_in_src_11 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_11 = 0;
parameter c_cnt_prst_11 = 1;
localparam cnt_fpll_src_11 = "fpll_0";
parameter dprio0_cnt_bypass_en_11 = "false";
parameter dprio0_cnt_hi_div_11 = 1;
parameter dprio0_cnt_lo_div_11 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_11 = "false";
localparam dprio1_cnt_bypass_en_11 = dprio0_cnt_bypass_en_11;
localparam dprio1_cnt_hi_div_11 = dprio0_cnt_hi_div_11;
localparam dprio1_cnt_lo_div_11 = dprio0_cnt_lo_div_11;
localparam dprio1_cnt_odd_div_even_duty_en_11 = dprio0_cnt_odd_div_even_duty_en_11;

parameter output_clock_frequency_12 = "0 ps";
parameter enable_output_counter_12 = "false";
parameter phase_shift_12 = "0 ps";
parameter duty_cycle_12 = 50;
parameter c_cnt_coarse_dly_12 = "0 ps";
parameter c_cnt_fine_dly_12 = "0 ps";
parameter c_cnt_in_src_12 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_12 = 0;
parameter c_cnt_prst_12 = 1;
localparam cnt_fpll_src_12 = "fpll_0";
parameter dprio0_cnt_bypass_en_12 = "false";
parameter dprio0_cnt_hi_div_12 = 1;
parameter dprio0_cnt_lo_div_12 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_12 = "false";
localparam dprio1_cnt_bypass_en_12 = dprio0_cnt_bypass_en_12;
localparam dprio1_cnt_hi_div_12 = dprio0_cnt_hi_div_12;
localparam dprio1_cnt_lo_div_12 = dprio0_cnt_lo_div_12;
localparam dprio1_cnt_odd_div_even_duty_en_12 = dprio0_cnt_odd_div_even_duty_en_12;

parameter output_clock_frequency_13 = "0 ps";
parameter enable_output_counter_13 = "false";
parameter phase_shift_13 = "0 ps";
parameter duty_cycle_13 = 50;
parameter c_cnt_coarse_dly_13 = "0 ps";
parameter c_cnt_fine_dly_13 = "0 ps";
parameter c_cnt_in_src_13 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_13 = 0;
parameter c_cnt_prst_13 = 1;
localparam cnt_fpll_src_13 = "fpll_0";
parameter dprio0_cnt_bypass_en_13 = "false";
parameter dprio0_cnt_hi_div_13 = 1;
parameter dprio0_cnt_lo_div_13 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_13 = "false";
localparam dprio1_cnt_bypass_en_13 = dprio0_cnt_bypass_en_13;
localparam dprio1_cnt_hi_div_13 = dprio0_cnt_hi_div_13;
localparam dprio1_cnt_lo_div_13 = dprio0_cnt_lo_div_13;
localparam dprio1_cnt_odd_div_even_duty_en_13 = dprio0_cnt_odd_div_even_duty_en_13;

parameter output_clock_frequency_14 = "0 ps";
parameter enable_output_counter_14 = "false";
parameter phase_shift_14 = "0 ps";
parameter duty_cycle_14 = 50;
parameter c_cnt_coarse_dly_14 = "0 ps";
parameter c_cnt_fine_dly_14 = "0 ps";
parameter c_cnt_in_src_14 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_14 = 0;
parameter c_cnt_prst_14 = 1;
localparam cnt_fpll_src_14 = "fpll_0";
parameter dprio0_cnt_bypass_en_14 = "false";
parameter dprio0_cnt_hi_div_14 = 1;
parameter dprio0_cnt_lo_div_14 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_14 = "false";
localparam dprio1_cnt_bypass_en_14 = dprio0_cnt_bypass_en_14;
localparam dprio1_cnt_hi_div_14 = dprio0_cnt_hi_div_14;
localparam dprio1_cnt_lo_div_14 = dprio0_cnt_lo_div_14;
localparam dprio1_cnt_odd_div_even_duty_en_14 = dprio0_cnt_odd_div_even_duty_en_14;

parameter output_clock_frequency_15 = "0 ps";
parameter enable_output_counter_15 = "false";
parameter phase_shift_15 = "0 ps";
parameter duty_cycle_15 = 50;
parameter c_cnt_coarse_dly_15 = "0 ps";
parameter c_cnt_fine_dly_15 = "0 ps";
parameter c_cnt_in_src_15 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_15 = 0;
parameter c_cnt_prst_15 = 1;
localparam cnt_fpll_src_15 = "fpll_0";
parameter dprio0_cnt_bypass_en_15 = "false";
parameter dprio0_cnt_hi_div_15 = 1;
parameter dprio0_cnt_lo_div_15 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_15 = "false";
localparam dprio1_cnt_bypass_en_15 = dprio0_cnt_bypass_en_15;
localparam dprio1_cnt_hi_div_15 = dprio0_cnt_hi_div_15;
localparam dprio1_cnt_lo_div_15 = dprio0_cnt_lo_div_15;
localparam dprio1_cnt_odd_div_even_duty_en_15 = dprio0_cnt_odd_div_even_duty_en_15;

parameter output_clock_frequency_16 = "0 ps";
parameter enable_output_counter_16 = "false";
parameter phase_shift_16 = "0 ps";
parameter duty_cycle_16 = 50;
parameter c_cnt_coarse_dly_16 = "0 ps";
parameter c_cnt_fine_dly_16 = "0 ps";
parameter c_cnt_in_src_16 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_16 = 0;
parameter c_cnt_prst_16 = 1;
localparam cnt_fpll_src_16 = "fpll_0";
parameter dprio0_cnt_bypass_en_16 = "false";
parameter dprio0_cnt_hi_div_16 = 1;
parameter dprio0_cnt_lo_div_16 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_16 = "false";
localparam dprio1_cnt_bypass_en_16 = dprio0_cnt_bypass_en_16;
localparam dprio1_cnt_hi_div_16 = dprio0_cnt_hi_div_16;
localparam dprio1_cnt_lo_div_16 = dprio0_cnt_lo_div_16;
localparam dprio1_cnt_odd_div_even_duty_en_16 = dprio0_cnt_odd_div_even_duty_en_16;

parameter output_clock_frequency_17 = "0 ps";
parameter enable_output_counter_17 = "false";
parameter phase_shift_17 = "0 ps";
parameter duty_cycle_17 = 50;
parameter c_cnt_coarse_dly_17 = "0 ps";
parameter c_cnt_fine_dly_17 = "0 ps";
parameter c_cnt_in_src_17 = "ph_mux_clk";
parameter c_cnt_ph_mux_prst_17 = 0;
parameter c_cnt_prst_17 = 1;
localparam cnt_fpll_src_17 = "fpll_0";
parameter dprio0_cnt_bypass_en_17 = "false";
parameter dprio0_cnt_hi_div_17 = 1;
parameter dprio0_cnt_lo_div_17 = 1;
parameter dprio0_cnt_odd_div_even_duty_en_17 = "false";
localparam dprio1_cnt_bypass_en_17 = dprio0_cnt_bypass_en_17;
localparam dprio1_cnt_hi_div_17 = dprio0_cnt_hi_div_17;
localparam dprio1_cnt_lo_div_17 = dprio0_cnt_lo_div_17;
localparam dprio1_cnt_odd_div_even_duty_en_17 = dprio0_cnt_odd_div_even_duty_en_17;

// End of auto generated parameters

//////////////////////////////////////////////////////////////////////////////////////
// Wire Defitions for altera_arriavgz_pll module
//////////////////////////////////////////////////////////////////////////////////////

wire [number_of_fplls-1:0] fpll_fbclk_wire;
wire [number_of_fplls-1:0] fpll_up_wire;
wire [number_of_fplls-1:0] fpll_shift_wire;
wire [number_of_fplls-1:0] fpll_shiftdoneout_wire;
wire [number_of_fplls-1:0] fpll_tclk_wire;
wire [number_of_fplls-1:0] fpll_cntnen_wire;
wire [number_of_fplls-1:0] fbout_clk;

wire [17:0] fpll_shiften_bus_0;
wire [17:0] fpll_shiften_bus_1;
wire [7:0] fpll_vcoph_bus_0;
wire [7:0] fpll_vcoph_bus_1;

// This may need to change once a correction has been made to the nresync port on the fpll 

wire [number_of_counters-1:0] cascade_wire;
wire [number_of_counters-1:0] shiftdone_wire;

altera_arriavgz_pll_base
#(
// arriavgz_pll_dpa_output parameters

	.output_clock_frequency ( dpa_output_clock_frequency_0 ),
	.pll_vcoph_div ( pll_vcoph_div_0 ),

// arriavgz_pll_refclk_select parameters

	.pll_auto_clk_sw_en ( pll_auto_clk_sw_en_0 ),
	.pll_clk_loss_edge ( pll_clk_loss_edge_0 ),
	.pll_clk_loss_sw_en ( pll_clk_loss_sw_en_0 ),
	.pll_clk_sw_dly ( pll_clk_sw_dly_0 ),
	.pll_clkin_0_src ( pll_clkin_0_src_0 ),
	.pll_clkin_1_src ( pll_clkin_1_src_0 ),
	.pll_manu_clk_sw_en ( pll_manu_clk_sw_en_0 ),
	.pll_sw_refclk_src ( pll_sw_refclk_src_0 ),

// arriavgz_fractional_pll parameters

	.pll_output_clock_frequency ( pll_output_clock_frequency_0 ),
	.reference_clock_frequency ( reference_clock_frequency_0 ),
	.mimic_fbclk_type ( mimic_fbclk_type_0 ),
	.dsm_accumulator_reset_value ( dsm_accumulator_reset_value_0 ),
	.forcelock ( forcelock_0 ),
	.nreset_invert ( nreset_invert_0 ),
	.pll_atb ( pll_atb_0 ),
	.pll_bwctrl ( pll_bwctrl_0 ),
	.pll_cmp_buf_dly ( pll_cmp_buf_dly_0 ),
	.pll_cp_comp ( pll_cp_comp_0 ),
	.pll_cp_current ( pll_cp_current_0 ),
	.pll_ctrl_override_setting ( pll_ctrl_override_setting_0 ),
	.pll_dsm_dither ( pll_dsm_dither_0 ),
	.pll_dsm_out_sel ( pll_dsm_out_sel_0 ),
	.pll_dsm_reset ( pll_dsm_reset_0 ),
	.pll_ecn_bypass ( pll_ecn_bypass_0 ),
	.pll_ecn_test_en ( pll_ecn_test_en_0 ),
	.pll_enable ( pll_enable_0 ),
	.pll_fbclk_mux_1 ( pll_fbclk_mux_1_0 ),
	.pll_fbclk_mux_2 ( pll_fbclk_mux_2_0 ),
	.pll_fractional_carry_out ( pll_fractional_carry_out_0 ),
	.pll_fractional_division ( pll_fractional_division_0 ),
	.pll_fractional_value_ready ( pll_fractional_value_ready_0 ),
	.pll_lf_testen ( pll_lf_testen_0 ),
	.pll_lock_fltr_cfg ( pll_lock_fltr_cfg_0 ),
	.pll_lock_fltr_test ( pll_lock_fltr_test_0 ),
	.pll_m_cnt_bypass_en ( pll_m_cnt_bypass_en_0 ),
	.pll_m_cnt_coarse_dly ( pll_m_cnt_coarse_dly_0 ),
	.pll_m_cnt_fine_dly ( pll_m_cnt_fine_dly_0 ),
	.pll_m_cnt_hi_div ( pll_m_cnt_hi_div_0 ),
	.pll_m_cnt_in_src ( pll_m_cnt_in_src_0 ),
	.pll_m_cnt_lo_div ( pll_m_cnt_lo_div_0 ),
	.pll_m_cnt_odd_div_duty_en ( pll_m_cnt_odd_div_duty_en_0 ),
	.pll_m_cnt_ph_mux_prst ( pll_m_cnt_ph_mux_prst_0 ),
	.pll_m_cnt_prst ( pll_m_cnt_prst_0 ),
	.pll_n_cnt_bypass_en ( pll_n_cnt_bypass_en_0 ),
	.pll_n_cnt_coarse_dly ( pll_n_cnt_coarse_dly_0 ),
	.pll_n_cnt_fine_dly ( pll_n_cnt_fine_dly_0 ),
	.pll_n_cnt_hi_div ( pll_n_cnt_hi_div_0 ),
	.pll_n_cnt_lo_div ( pll_n_cnt_lo_div_0 ),
	.pll_n_cnt_odd_div_duty_en ( pll_n_cnt_odd_div_duty_en_0 ),
	.pll_ref_buf_dly ( pll_ref_buf_dly_0 ),
	.pll_reg_boost ( pll_reg_boost_0 ),
	.pll_regulator_bypass ( pll_regulator_bypass_0 ),
	.pll_ripplecap_ctrl ( pll_ripplecap_ctrl_0 ),
	.pll_slf_rst ( pll_slf_rst_0 ),
	.pll_tclk_mux_en ( pll_tclk_mux_en_0 ),
	.pll_tclk_sel ( pll_tclk_sel_0 ),
	.pll_test_enable ( pll_test_enable_0 ),
	.pll_testdn_enable ( pll_testdn_enable_0 ),
	.pll_testup_enable ( pll_testup_enable_0 ),
	.pll_unlock_fltr_cfg ( pll_unlock_fltr_cfg_0 ),
	.pll_vco_div ( pll_vco_div_0 ),
	.pll_vco_ph0_en ( pll_vco_ph0_en_0 ),
	.pll_vco_ph1_en ( pll_vco_ph1_en_0 ),
	.pll_vco_ph2_en ( pll_vco_ph2_en_0 ),
	.pll_vco_ph3_en ( pll_vco_ph3_en_0 ),
	.pll_vco_ph4_en ( pll_vco_ph4_en_0 ),
	.pll_vco_ph5_en ( pll_vco_ph5_en_0 ),
	.pll_vco_ph6_en ( pll_vco_ph6_en_0 ),
	.pll_vco_ph7_en ( pll_vco_ph7_en_0 ),
	.pll_vctrl_test_voltage ( pll_vctrl_test_voltage_0 ),
	.vccd0g_atb ( vccd0g_atb_0 ),
	.vccd0g_output ( vccd0g_output_0 ),
	.vccd1g_atb ( vccd1g_atb_0 ),
	.vccd1g_output ( vccd1g_output_0 ),
	.vccm1g_tap ( vccm1g_tap_0 ),
	.vccr_pd ( vccr_pd_0 ),
	.vcodiv_override ( vcodiv_override_0 )
) fpll_0
(

// arriavgz_pll_dpa_output pins

	.phout( phout_0 ),		// 8

// arriavgz_pll_refclk_select pins 

// Input Ports
	.adjpllin( adjpllin[0] ),		
	.cclk( cclk[0] ),			
	.coreclkin( coreclkin[0] ),		
	.extswitch( extswitch[0] ),		
	.iqtxrxclkin( iqtxrxclkin[0] ),		
	.plliqclkin( plliqclkin[0] ),		
	.rxiqclkin( rxiqclkin[0] ),		
	
	.clkin( clkin ),		// 4
	.refiqclk( refiqclk_0 ),	// 2

// Output Ports
	.clk0bad( clk0bad[0] ),			
	.clk1bad( clk1bad[0] ),			
	.pllclksel( pllclksel[0] ),		
	
// arriavgz_pll_reconfig pins
	
// Input Ports
	.atpgmode ( atpgmode[0] ),
	.clk( clk[0] ),			
	.fpllcsrtest ( fpllcsrtest[0] ),
	.iocsrclkin( iocsrclkin[0] ),	
	.iocsrdatain( iocsrdatain[0] ),	
	.iocsren( iocsren[0] ),		
	.iocsrrstn( iocsrrstn[0] ),	
	.mdiodis( mdiodis[0] ),		
	.phaseen( phaseen[0] ),		
	.read( read[0] ),		
	.rstn( rstn[0] ),		
	.scanen( scanen[0] ),		
	.sershiftload( sershiftload[0] ),
	.shiftdonei( shiftdonei[0] ),	
	.updn( updn[0] ),		
	.write( write[0] ),		
	
	.addr( addr_0 ),		// 6
	.byteen( byteen_0 ),		// 2
	.cntsel( cntsel_0 ),		// 5
	.din( din_0 ),			// 16

// Output Ports
	.blockselect( blockselect[0] ),	
	.iocsrdataout( iocsrdataout[0] ),
	.iocsrenbuf( iocsrenbuf[0] ),
	.iocsrrstnbuf( iocsrrstnbuf[0] ),
	.phasedone( phasedone[0] ),
	.shift( fpll_shift_wire[0] ),
	.up( fpll_up_wire[0] ), 

	.dout( dout_0 ),		// 16
	.dprioout( dprioout_0 ),	// 16
	.shiften( fpll_shiften_bus_0 ),	// 18
	
// arriavgz_fractional_pll pins
	
// Input Ports
	.fbclkfpll( fbclkfpll[0] ),
	.lvdfbin( lvdfbin[0] ),
	.nresync( nresync[0] ),	
	.pfden( pfden[0] ), 		
	.shiften_input_port( shiften_fpll[0] ),	
	.zdb( zdb[0] ),			
	
// Output Ports
	.fbout_clk( fbout_clk[0] ),
	.fblvdsout( fblvdsout[0] ),
	.cntnen ( fpll_cntnen_wire[0] ),
	.lock( lock[0] ), 		
	.mcntout( mcntout[0] ),
	.plniotribuf( plniotribuf[0] ),
// Currently not supported
//	.shiftdoneout( fpll_shiftdoneout_wire[0] ),
	.tclk( fpll_tclk_wire[0] ),
	.vcoph( fpll_vcoph_bus_0 )	// 8
);

// Generate section will produce counters, lvds_output, dll_output, and extclk
// blocks
//
// Will be using this for all of the various generate blocks
genvar i;  

//////////////////////////////////////////////
// Create the 18 counters

generate
	for (i=0; i<=number_of_counters-1; i = i + 1)
	begin : counter
	
// For output counter cascading
		wire cascadein_wire;
		if ((	(i == 0) ? c_cnt_in_src_0 : 
				(i == 1) ? c_cnt_in_src_1 :
				(i == 2) ? c_cnt_in_src_2 :
				(i == 3) ? c_cnt_in_src_3 :
				(i == 4) ? c_cnt_in_src_4 :
				(i == 5) ? c_cnt_in_src_5 :
				(i == 6) ? c_cnt_in_src_6 :
				(i == 7) ? c_cnt_in_src_7 :
				(i == 8) ? c_cnt_in_src_8 :
				(i == 9) ? c_cnt_in_src_9 :
				(i == 10) ? c_cnt_in_src_10 :
				(i == 11) ? c_cnt_in_src_11 :
				(i == 12) ? c_cnt_in_src_12 :
				(i == 13) ? c_cnt_in_src_13 :
				(i == 14) ? c_cnt_in_src_14 :
				(i == 15) ? c_cnt_in_src_15 :
				(i == 16) ? c_cnt_in_src_16 : 
				            c_cnt_in_src_17 ) == "cscd_clk")
			assign cascadein_wire = (i == 0) ? mcntout[0] : cascade_wire[i-1];
		else
			assign cascadein_wire = 1'b0;
	
// Don't instantiate counters that are not being used
// Going to allow either the output_clock_frequency parameter or the
// enable_output_counter parameter to be used as key for backward
// compatibility
		if ((
		(i == 0) ? output_clock_frequency_0 : 
		(i == 1) ? output_clock_frequency_1 :
		(i == 2) ? output_clock_frequency_2 :
		(i == 3) ? output_clock_frequency_3 :
		(i == 4) ? output_clock_frequency_4 :
		(i == 5) ? output_clock_frequency_5 :
		(i == 6) ? output_clock_frequency_6 :
		(i == 7) ? output_clock_frequency_7 :
		(i == 8) ? output_clock_frequency_8 :
		(i == 9) ? output_clock_frequency_9 :
		(i == 10) ? output_clock_frequency_10 :
		(i == 11) ? output_clock_frequency_11 :
		(i == 12) ? output_clock_frequency_12 :
		(i == 13) ? output_clock_frequency_13 :
		(i == 14) ? output_clock_frequency_14 :
		(i == 15) ? output_clock_frequency_15 :
		(i == 16) ? output_clock_frequency_16 : 
		(i == 17) ? output_clock_frequency_17 : "0 ps") != "0 ps" || (
		(i == 0) ? enable_output_counter_0 : 
		(i == 1) ? enable_output_counter_1 :
		(i == 2) ? enable_output_counter_2 :
		(i == 3) ? enable_output_counter_3 :
		(i == 4) ? enable_output_counter_4 :
		(i == 5) ? enable_output_counter_5 :
		(i == 6) ? enable_output_counter_6 :
		(i == 7) ? enable_output_counter_7 :
		(i == 8) ? enable_output_counter_8 :
		(i == 9) ? enable_output_counter_9 :
		(i == 10) ? enable_output_counter_10 :
		(i == 11) ? enable_output_counter_11 :
		(i == 12) ? enable_output_counter_12 :
		(i == 13) ? enable_output_counter_13 :
		(i == 14) ? enable_output_counter_14 :
		(i == 15) ? enable_output_counter_15 :
		(i == 16) ? enable_output_counter_16 : 
		(i == 17) ? enable_output_counter_17 : "false") == "true")
		stratixv_pll_output_counter
		#( 
			.output_clock_frequency (
			(i == 0) ? output_clock_frequency_0 : 
			(i == 1) ? output_clock_frequency_1 :
			(i == 2) ? output_clock_frequency_2 :
			(i == 3) ? output_clock_frequency_3 :
			(i == 4) ? output_clock_frequency_4 :
			(i == 5) ? output_clock_frequency_5 :
			(i == 6) ? output_clock_frequency_6 :
			(i == 7) ? output_clock_frequency_7 :
			(i == 8) ? output_clock_frequency_8 :
			(i == 9) ? output_clock_frequency_9 :
			(i == 10) ? output_clock_frequency_10 :
			(i == 11) ? output_clock_frequency_11 :
			(i == 12) ? output_clock_frequency_12 :
			(i == 13) ? output_clock_frequency_13 :
			(i == 14) ? output_clock_frequency_14 :
			(i == 15) ? output_clock_frequency_15 :
			(i == 16) ? output_clock_frequency_16 : 
			output_clock_frequency_17 ),
			.phase_shift (
			(i == 0) ? phase_shift_0 : 
			(i == 1) ? phase_shift_1 :
			(i == 2) ? phase_shift_2 :
			(i == 3) ? phase_shift_3 :
			(i == 4) ? phase_shift_4 :
			(i == 5) ? phase_shift_5 :
			(i == 6) ? phase_shift_6 :
			(i == 7) ? phase_shift_7 :
			(i == 8) ? phase_shift_8 :
			(i == 9) ? phase_shift_9 :
			(i == 10) ? phase_shift_10 :
			(i == 11) ? phase_shift_11 :
			(i == 12) ? phase_shift_12 :
			(i == 13) ? phase_shift_13 :
			(i == 14) ? phase_shift_14 :
			(i == 15) ? phase_shift_15 :
			(i == 16) ? phase_shift_16 : 
			phase_shift_17 ), 
			.duty_cycle (
			(i == 0) ? duty_cycle_0 : 
			(i == 1) ? duty_cycle_1 :
			(i == 2) ? duty_cycle_2 :
			(i == 3) ? duty_cycle_3 :
			(i == 4) ? duty_cycle_4 :
			(i == 5) ? duty_cycle_5 :
			(i == 6) ? duty_cycle_6 :
			(i == 7) ? duty_cycle_7 :
			(i == 8) ? duty_cycle_8 :
			(i == 9) ? duty_cycle_9 :
			(i == 10) ? duty_cycle_10 :
			(i == 11) ? duty_cycle_11 :
			(i == 12) ? duty_cycle_12 :
			(i == 13) ? duty_cycle_13 :
			(i == 14) ? duty_cycle_14 :
			(i == 15) ? duty_cycle_15 :
			(i == 16) ? duty_cycle_16 : 
			duty_cycle_17 ), 
			.c_cnt_coarse_dly (
			(i == 0) ? c_cnt_coarse_dly_0 : 
			(i == 1) ? c_cnt_coarse_dly_1 :
			(i == 2) ? c_cnt_coarse_dly_2 :
			(i == 3) ? c_cnt_coarse_dly_3 :
			(i == 4) ? c_cnt_coarse_dly_4 :
			(i == 5) ? c_cnt_coarse_dly_5 :
			(i == 6) ? c_cnt_coarse_dly_6 :
			(i == 7) ? c_cnt_coarse_dly_7 :
			(i == 8) ? c_cnt_coarse_dly_8 :
			(i == 9) ? c_cnt_coarse_dly_9 :
			(i == 10) ? c_cnt_coarse_dly_10 :
			(i == 11) ? c_cnt_coarse_dly_11 :
			(i == 12) ? c_cnt_coarse_dly_12 :
			(i == 13) ? c_cnt_coarse_dly_13 :
			(i == 14) ? c_cnt_coarse_dly_14 :
			(i == 15) ? c_cnt_coarse_dly_15 :
			(i == 16) ? c_cnt_coarse_dly_16 : 
			c_cnt_coarse_dly_17 ), 
			.c_cnt_fine_dly (
			(i == 0) ? c_cnt_fine_dly_0 : 
			(i == 1) ? c_cnt_fine_dly_1 :
			(i == 2) ? c_cnt_fine_dly_2 :
			(i == 3) ? c_cnt_fine_dly_3 :
			(i == 4) ? c_cnt_fine_dly_4 :
			(i == 5) ? c_cnt_fine_dly_5 :
			(i == 6) ? c_cnt_fine_dly_6 :
			(i == 7) ? c_cnt_fine_dly_7 :
			(i == 8) ? c_cnt_fine_dly_8 :
			(i == 9) ? c_cnt_fine_dly_9 :
			(i == 10) ? c_cnt_fine_dly_10 :
			(i == 11) ? c_cnt_fine_dly_11 :
			(i == 12) ? c_cnt_fine_dly_12 :
			(i == 13) ? c_cnt_fine_dly_13 :
			(i == 14) ? c_cnt_fine_dly_14 :
			(i == 15) ? c_cnt_fine_dly_15 :
			(i == 16) ? c_cnt_fine_dly_16 : 
			c_cnt_fine_dly_17 ), 
			.c_cnt_in_src (
			(i == 0) ? c_cnt_in_src_0 : 
			(i == 1) ? c_cnt_in_src_1 :
			(i == 2) ? c_cnt_in_src_2 :
			(i == 3) ? c_cnt_in_src_3 :
			(i == 4) ? c_cnt_in_src_4 :
			(i == 5) ? c_cnt_in_src_5 :
			(i == 6) ? c_cnt_in_src_6 :
			(i == 7) ? c_cnt_in_src_7 :
			(i == 8) ? c_cnt_in_src_8 :
			(i == 9) ? c_cnt_in_src_9 :
			(i == 10) ? c_cnt_in_src_10 :
			(i == 11) ? c_cnt_in_src_11 :
			(i == 12) ? c_cnt_in_src_12 :
			(i == 13) ? c_cnt_in_src_13 :
			(i == 14) ? c_cnt_in_src_14 :
			(i == 15) ? c_cnt_in_src_15 :
			(i == 16) ? c_cnt_in_src_16 : 
			c_cnt_in_src_17 ), 
			.c_cnt_ph_mux_prst (
			(i == 0) ? c_cnt_ph_mux_prst_0 : 
			(i == 1) ? c_cnt_ph_mux_prst_1 :
			(i == 2) ? c_cnt_ph_mux_prst_2 :
			(i == 3) ? c_cnt_ph_mux_prst_3 :
			(i == 4) ? c_cnt_ph_mux_prst_4 :
			(i == 5) ? c_cnt_ph_mux_prst_5 :
			(i == 6) ? c_cnt_ph_mux_prst_6 :
			(i == 7) ? c_cnt_ph_mux_prst_7 :
			(i == 8) ? c_cnt_ph_mux_prst_8 :
			(i == 9) ? c_cnt_ph_mux_prst_9 :
			(i == 10) ? c_cnt_ph_mux_prst_10 :
			(i == 11) ? c_cnt_ph_mux_prst_11 :
			(i == 12) ? c_cnt_ph_mux_prst_12 :
			(i == 13) ? c_cnt_ph_mux_prst_13 :
			(i == 14) ? c_cnt_ph_mux_prst_14 :
			(i == 15) ? c_cnt_ph_mux_prst_15 :
			(i == 16) ? c_cnt_ph_mux_prst_16 : 
			c_cnt_ph_mux_prst_17 ), 
			.c_cnt_prst (
			(i == 0) ? c_cnt_prst_0 : 
			(i == 1) ? c_cnt_prst_1 :
			(i == 2) ? c_cnt_prst_2 :
			(i == 3) ? c_cnt_prst_3 :
			(i == 4) ? c_cnt_prst_4 :
			(i == 5) ? c_cnt_prst_5 :
			(i == 6) ? c_cnt_prst_6 :
			(i == 7) ? c_cnt_prst_7 :
			(i == 8) ? c_cnt_prst_8 :
			(i == 9) ? c_cnt_prst_9 :
			(i == 10) ? c_cnt_prst_10 :
			(i == 11) ? c_cnt_prst_11 :
			(i == 12) ? c_cnt_prst_12 :
			(i == 13) ? c_cnt_prst_13 :
			(i == 14) ? c_cnt_prst_14 :
			(i == 15) ? c_cnt_prst_15 :
			(i == 16) ? c_cnt_prst_16 : 
			c_cnt_prst_17 ), 
			.cnt_fpll_src (
			(i == 0) ? cnt_fpll_src_0 : 
			(i == 1) ? cnt_fpll_src_1 :
			(i == 2) ? cnt_fpll_src_2 :
			(i == 3) ? cnt_fpll_src_3 :
			(i == 4) ? cnt_fpll_src_4 :
			(i == 5) ? cnt_fpll_src_5 :
			(i == 6) ? cnt_fpll_src_6 :
			(i == 7) ? cnt_fpll_src_7 :
			(i == 8) ? cnt_fpll_src_8 :
			(i == 9) ? cnt_fpll_src_9 :
			(i == 10) ? cnt_fpll_src_10 :
			(i == 11) ? cnt_fpll_src_11 :
			(i == 12) ? cnt_fpll_src_12 :
			(i == 13) ? cnt_fpll_src_13 :
			(i == 14) ? cnt_fpll_src_14 :
			(i == 15) ? cnt_fpll_src_15 :
			(i == 16) ? cnt_fpll_src_16 : 
			cnt_fpll_src_17 ), 
			.dprio0_cnt_bypass_en (
			(i == 0) ? dprio0_cnt_bypass_en_0 : 
			(i == 1) ? dprio0_cnt_bypass_en_1 :
			(i == 2) ? dprio0_cnt_bypass_en_2 :
			(i == 3) ? dprio0_cnt_bypass_en_3 :
			(i == 4) ? dprio0_cnt_bypass_en_4 :
			(i == 5) ? dprio0_cnt_bypass_en_5 :
			(i == 6) ? dprio0_cnt_bypass_en_6 :
			(i == 7) ? dprio0_cnt_bypass_en_7 :
			(i == 8) ? dprio0_cnt_bypass_en_8 :
			(i == 9) ? dprio0_cnt_bypass_en_9 :
			(i == 10) ? dprio0_cnt_bypass_en_10 :
			(i == 11) ? dprio0_cnt_bypass_en_11 :
			(i == 12) ? dprio0_cnt_bypass_en_12 :
			(i == 13) ? dprio0_cnt_bypass_en_13 :
			(i == 14) ? dprio0_cnt_bypass_en_14 :
			(i == 15) ? dprio0_cnt_bypass_en_15 :
			(i == 16) ? dprio0_cnt_bypass_en_16 : 
			dprio0_cnt_bypass_en_17 ), 
			.dprio0_cnt_hi_div (
			(i == 0) ? dprio0_cnt_hi_div_0 : 
			(i == 1) ? dprio0_cnt_hi_div_1 :
			(i == 2) ? dprio0_cnt_hi_div_2 :
			(i == 3) ? dprio0_cnt_hi_div_3 :
			(i == 4) ? dprio0_cnt_hi_div_4 :
			(i == 5) ? dprio0_cnt_hi_div_5 :
			(i == 6) ? dprio0_cnt_hi_div_6 :
			(i == 7) ? dprio0_cnt_hi_div_7 :
			(i == 8) ? dprio0_cnt_hi_div_8 :
			(i == 9) ? dprio0_cnt_hi_div_9 :
			(i == 10) ? dprio0_cnt_hi_div_10 :
			(i == 11) ? dprio0_cnt_hi_div_11 :
			(i == 12) ? dprio0_cnt_hi_div_12 :
			(i == 13) ? dprio0_cnt_hi_div_13 :
			(i == 14) ? dprio0_cnt_hi_div_14 :
			(i == 15) ? dprio0_cnt_hi_div_15 :
			(i == 16) ? dprio0_cnt_hi_div_16 : 
			dprio0_cnt_hi_div_17 ), 
			.dprio0_cnt_lo_div (
			(i == 0) ? dprio0_cnt_lo_div_0 : 
			(i == 1) ? dprio0_cnt_lo_div_1 :
			(i == 2) ? dprio0_cnt_lo_div_2 :
			(i == 3) ? dprio0_cnt_lo_div_3 :
			(i == 4) ? dprio0_cnt_lo_div_4 :
			(i == 5) ? dprio0_cnt_lo_div_5 :
			(i == 6) ? dprio0_cnt_lo_div_6 :
			(i == 7) ? dprio0_cnt_lo_div_7 :
			(i == 8) ? dprio0_cnt_lo_div_8 :
			(i == 9) ? dprio0_cnt_lo_div_9 :
			(i == 10) ? dprio0_cnt_lo_div_10 :
			(i == 11) ? dprio0_cnt_lo_div_11 :
			(i == 12) ? dprio0_cnt_lo_div_12 :
			(i == 13) ? dprio0_cnt_lo_div_13 :
			(i == 14) ? dprio0_cnt_lo_div_14 :
			(i == 15) ? dprio0_cnt_lo_div_15 :
			(i == 16) ? dprio0_cnt_lo_div_16 : 
			dprio0_cnt_lo_div_17 ), 
			.dprio0_cnt_odd_div_even_duty_en (
		       	(i == 0) ? dprio0_cnt_odd_div_even_duty_en_0 : 
			(i == 1) ? dprio0_cnt_odd_div_even_duty_en_1 :
			(i == 2) ? dprio0_cnt_odd_div_even_duty_en_2 :
			(i == 3) ? dprio0_cnt_odd_div_even_duty_en_3 :
			(i == 4) ? dprio0_cnt_odd_div_even_duty_en_4 :
			(i == 5) ? dprio0_cnt_odd_div_even_duty_en_5 :
			(i == 6) ? dprio0_cnt_odd_div_even_duty_en_6 :
			(i == 7) ? dprio0_cnt_odd_div_even_duty_en_7 :
			(i == 8) ? dprio0_cnt_odd_div_even_duty_en_8 :
			(i == 9) ? dprio0_cnt_odd_div_even_duty_en_9 :
			(i == 10) ? dprio0_cnt_odd_div_even_duty_en_10 :
			(i == 11) ? dprio0_cnt_odd_div_even_duty_en_11 :
			(i == 12) ? dprio0_cnt_odd_div_even_duty_en_12 :
			(i == 13) ? dprio0_cnt_odd_div_even_duty_en_13 :
			(i == 14) ? dprio0_cnt_odd_div_even_duty_en_14 :
			(i == 15) ? dprio0_cnt_odd_div_even_duty_en_15 :
			(i == 16) ? dprio0_cnt_odd_div_even_duty_en_16 : 
			dprio0_cnt_odd_div_even_duty_en_17 ), 
			.dprio1_cnt_bypass_en (
			(i == 0) ? dprio1_cnt_bypass_en_0 : 
			(i == 1) ? dprio1_cnt_bypass_en_1 :
			(i == 2) ? dprio1_cnt_bypass_en_2 :
			(i == 3) ? dprio1_cnt_bypass_en_3 :
			(i == 4) ? dprio1_cnt_bypass_en_4 :
			(i == 5) ? dprio1_cnt_bypass_en_5 :
			(i == 6) ? dprio1_cnt_bypass_en_6 :
			(i == 7) ? dprio1_cnt_bypass_en_7 :
			(i == 8) ? dprio1_cnt_bypass_en_8 :
			(i == 9) ? dprio1_cnt_bypass_en_9 :
			(i == 10) ? dprio1_cnt_bypass_en_10 :
			(i == 11) ? dprio1_cnt_bypass_en_11 :
			(i == 12) ? dprio1_cnt_bypass_en_12 :
			(i == 13) ? dprio1_cnt_bypass_en_13 :
			(i == 14) ? dprio1_cnt_bypass_en_14 :
			(i == 15) ? dprio1_cnt_bypass_en_15 :
			(i == 16) ? dprio1_cnt_bypass_en_16 : 
			dprio1_cnt_bypass_en_17 ), 
			.dprio1_cnt_hi_div (
			(i == 0) ? dprio1_cnt_hi_div_0 : 
			(i == 1) ? dprio1_cnt_hi_div_1 :
			(i == 2) ? dprio1_cnt_hi_div_2 :
			(i == 3) ? dprio1_cnt_hi_div_3 :
			(i == 4) ? dprio1_cnt_hi_div_4 :
			(i == 5) ? dprio1_cnt_hi_div_5 :
			(i == 6) ? dprio1_cnt_hi_div_6 :
			(i == 7) ? dprio1_cnt_hi_div_7 :
			(i == 8) ? dprio1_cnt_hi_div_8 :
			(i == 9) ? dprio1_cnt_hi_div_9 :
			(i == 10) ? dprio1_cnt_hi_div_10 :
			(i == 11) ? dprio1_cnt_hi_div_11 :
			(i == 12) ? dprio1_cnt_hi_div_12 :
			(i == 13) ? dprio1_cnt_hi_div_13 :
			(i == 14) ? dprio1_cnt_hi_div_14 :
			(i == 15) ? dprio1_cnt_hi_div_15 :
			(i == 16) ? dprio1_cnt_hi_div_16 : 
			dprio1_cnt_hi_div_17 ), 
			.dprio1_cnt_lo_div (
			(i == 0) ? dprio1_cnt_lo_div_0 : 
			(i == 1) ? dprio1_cnt_lo_div_1 :
			(i == 2) ? dprio1_cnt_lo_div_2 :
			(i == 3) ? dprio1_cnt_lo_div_3 :
			(i == 4) ? dprio1_cnt_lo_div_4 :
			(i == 5) ? dprio1_cnt_lo_div_5 :
			(i == 6) ? dprio1_cnt_lo_div_6 :
			(i == 7) ? dprio1_cnt_lo_div_7 :
			(i == 8) ? dprio1_cnt_lo_div_8 :
			(i == 9) ? dprio1_cnt_lo_div_9 :
			(i == 10) ? dprio1_cnt_lo_div_10 :
			(i == 11) ? dprio1_cnt_lo_div_11 :
			(i == 12) ? dprio1_cnt_lo_div_12 :
			(i == 13) ? dprio1_cnt_lo_div_13 :
			(i == 14) ? dprio1_cnt_lo_div_14 :
			(i == 15) ? dprio1_cnt_lo_div_15 :
			(i == 16) ? dprio1_cnt_lo_div_16 : 
			dprio1_cnt_lo_div_17 ), 
			.dprio1_cnt_odd_div_even_duty_en (
			(i == 0) ? dprio1_cnt_odd_div_even_duty_en_0 : 
			(i == 1) ? dprio1_cnt_odd_div_even_duty_en_1 :
			(i == 2) ? dprio1_cnt_odd_div_even_duty_en_2 :
			(i == 3) ? dprio1_cnt_odd_div_even_duty_en_3 :
			(i == 4) ? dprio1_cnt_odd_div_even_duty_en_4 :
			(i == 5) ? dprio1_cnt_odd_div_even_duty_en_5 :
			(i == 6) ? dprio1_cnt_odd_div_even_duty_en_6 :
			(i == 7) ? dprio1_cnt_odd_div_even_duty_en_7 :
			(i == 8) ? dprio1_cnt_odd_div_even_duty_en_8 :
			(i == 9) ? dprio1_cnt_odd_div_even_duty_en_9 :
			(i == 10) ? dprio1_cnt_odd_div_even_duty_en_10 :
			(i == 11) ? dprio1_cnt_odd_div_even_duty_en_11 :
			(i == 12) ? dprio1_cnt_odd_div_even_duty_en_12 :
			(i == 13) ? dprio1_cnt_odd_div_even_duty_en_13 :
			(i == 14) ? dprio1_cnt_odd_div_even_duty_en_14 :
			(i == 15) ? dprio1_cnt_odd_div_even_duty_en_15 :
			(i == 16) ? dprio1_cnt_odd_div_even_duty_en_16 : 
			dprio1_cnt_odd_div_even_duty_en_17) 
		) output_counter
		(
	// Input Ports
			.cascadein( cascadein_wire ),			
			.nen0( fpll_cntnen_wire[0] ),
			.nen1( {1'b0} ),
			.shift0( fpll_shift_wire[0] ),
			.shift1( {1'b0} ),
// Currently not supported
//			.shiftdone0i( (i == 0) ? fpll_shiftdoneout_wire : shiftdone_wire[i-1] ),
//			.shiftdone1i( {1'b0} ),
			.shiften( fpll_shiften_bus_0[i] ),
			.tclk0( fpll_tclk_wire[0] ),
			.tclk1( {1'b0} ),
			.up0( fpll_up_wire[0] ),
			.up1( {1'b0} ),
			.vco0ph( fpll_vcoph_bus_0 ),
	//		.vco1ph( fpll_vcoph_bus_1 ),  Uncomment if creating fpll_1
		
	// Output Ports
			.cascadeout( cascade_wire[i] ), // Don't need to add the final wire as no further cascade!
			.divclk( divclk[i] ),		
			.shiftdone0o( shiftdone_wire[i] ),
			.shiftdone1o( )
		);
		
		assign cascade_out = cascade_wire;
	end
endgenerate

//////////////////////////////////////////////
// Create the lvds outputs

generate
	for (i=0; i<=number_of_lvds-1; i = i + 1)
	begin : lvds_output
		if ((
		(i == 0) ? enable_lvds_output_0 : 
		(i == 1) ? enable_lvds_output_1 :
		(i == 2) ? enable_lvds_output_2 :
		(i == 3) ? enable_lvds_output_3 : "false") == "true")
		stratixv_pll_lvds_output
		#(
			.pll_loaden_coarse_dly ( 
			(i == 0) ? pll_loaden_coarse_dly_0 : 
			(i == 1) ? pll_loaden_coarse_dly_1 :
			(i == 2) ? pll_loaden_coarse_dly_2 :
			pll_loaden_coarse_dly_3 ),
			.pll_loaden_enable_disable ( 
			(i == 0) ? pll_loaden_enable_disable_0 : 
			(i == 1) ? pll_loaden_enable_disable_1 :
			(i == 2) ? pll_loaden_enable_disable_2 :
			pll_loaden_enable_disable_3 ),
			.pll_loaden_fine_dly ( 
			(i == 0) ? pll_loaden_fine_dly_0 : 
			(i == 1) ? pll_loaden_fine_dly_1 :
			(i == 2) ? pll_loaden_fine_dly_2 :
			pll_loaden_fine_dly_3 ),
			.pll_lvdsclk_coarse_dly ( 
			(i == 0) ? pll_lvdsclk_coarse_dly_0 : 
			(i == 1) ? pll_lvdsclk_coarse_dly_1 :
			(i == 2) ? pll_lvdsclk_coarse_dly_2 :
			pll_loaden_fine_dly_3 ),
			.pll_lvdsclk_enable_disable ( 
			(i == 0) ? pll_lvdsclk_enable_disable_0 : 
			(i == 1) ? pll_lvdsclk_enable_disable_1 :
			(i == 2) ? pll_lvdsclk_enable_disable_2 :
			pll_loaden_fine_dly_3 ),
			.pll_lvdsclk_fine_dly ( 
			(i == 0) ? pll_lvdsclk_fine_dly_0 : 
			(i == 1) ? pll_lvdsclk_fine_dly_1 :
			(i == 2) ? pll_lvdsclk_fine_dly_2 :
			pll_loaden_fine_dly_3 )
		) lvds_output
		(
		// Input Ports
			.ccout( 
			(i == 0) ? divclk[1:0] :
			(i == 1) ? divclk[3:2] : 
			(i == 2) ? { divclk[16], divclk[17] } :
			{ divclk[14], divclk[15] } 
			), 

	// Output Ports
			.loaden( loaden[i] ),
			.lvdsclk( lvdsclk[i] )
		);
        else
        begin
            assign loaden[i] = 0;
            assign lvdsclk[i] = 0;
        end
	end
endgenerate

//////////////////////////////////////////////


//////////////////////////////////////////////
// Create the dll output blocks
generate
	for (i=0; i<=number_of_dlls-1; i = i + 1)
	begin : dll_output
		if ((
		(i == 0) ? enable_dll_output_0 : 
		(i == 1) ? enable_dll_output_1 : "false") == "true")
		stratixv_pll_dll_output
		#(
		// Parameters 
			.pll_dll_src ( 
			(i == 0) ? pll_dll_src_value_0 :
			pll_dll_src_value_1)
		) dll_out
		(
		// Input Ports
			.cclk( divclk ),
			.clkin( dll_clkin ),

		// Output Ports
			.clkout( clkout[i] )
		);
        else
            assign clkout[i] = 0;
	end
endgenerate

//////////////////////////////////////////////

//////////////////////////////////////////////
// Create the extclk output blocks

generate
	for (i=0; i<=number_of_extclks-1; i = i + 1)
	begin : extclk_output
		if ((
		(i == 0) ? enable_extclk_output_0 : 
		(i == 1) ? enable_extclk_output_1 : 
		(i == 2) ? enable_extclk_output_2 : 
		(i == 3) ? enable_extclk_output_3 : "false") == "true")
		stratixv_pll_extclk_output
		#(
		// Parameters 
			.pll_extclk_cnt_src ( 
			(i == 0) ? pll_extclk_cnt_src_0 :
			(i == 1) ? pll_extclk_cnt_src_1 :
			(i == 2) ? pll_extclk_cnt_src_2 :
			pll_extclk_cnt_src_3),
			.pll_extclk_enable ( 
			(i == 0) ? pll_extclk_enable_0 :
			(i == 1) ? pll_extclk_enable_1 :
			(i == 2) ? pll_extclk_enable_2 :
			pll_extclk_enable_3),
			.pll_extclk_invert ( 
			(i == 0) ? pll_extclk_invert_0 :
			(i == 1) ? pll_extclk_invert_1 :
			(i == 2) ? pll_extclk_invert_2 :
			pll_extclk_invert_3)
		) extclk_out
		(
		// Input Ports
			.clken(),
			.mcnt0(fbout_clk[0]),
			.mcnt1(),
			.cclk(),
		
		// Output Ports
			.extclk( extclk[i] )
		);
        else
            assign extclk[i] = 0;
	end
endgenerate

//////////////////////////////////////////////
//DRIVING UNUSED PLL_1 PORTS TO '0' TO REMOVE
//WARNINGS DURING SYNTH
/////////////////////////////////////////////
assign phout_1 = 8'b0;
assign dout_1 = 16'b0;
assign dprioout_1 = 816'b0;


endmodule
