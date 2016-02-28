
vlib work

vlog ../mfic.v
vlog ../divider_mfic.v
vlog ../delay_mfic.v
vlog ../sort_16.v
vlog ../fifo_mfic.v

vlog write_signal.v
vlog mfic_tb.v

vsim -voptargs=+acc work.mfic_tb

add wave sim:/mfic_tb/mfic_inst/*

add wave  \
sim:/mfic_tb/mfic_inst/amplitude \
sim:/mfic_tb/mfic_inst/doppler \
sim:/mfic_tb/mfic_inst/ena \
sim:/mfic_tb/mfic_inst/index_range \
sim:/mfic_tb/mfic_inst/range

add wave  \
sim:/mfic_tb/mfic_inst/denum \
sim:/mfic_tb/mfic_inst/num


add wave sim:/mfic_tb/mfic_inst/divider_mfic_inst_15/*

add wave  \
sim:/mfic_tb/clk_out \
sim:/mfic_tb/ena_out \
sim:/mfic_tb/sig_out

add wave  \
sim:/mfic_tb/ind

run 12000 us




