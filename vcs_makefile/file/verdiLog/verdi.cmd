debImport "-f" "file_list.f"
wvCreateWindow
wvOpenFile -win $_nWave2 \
           {/mnt/mydata/asic/vcs_makefile_example/file/simv_simple_fsm.fsdb}
verdiWindowResize -win $_Verdi_1 -3 "31" "1870" "861"
srcHBSelect "tb_simple_fsm.simple_fsm_inst" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_simple_fsm.simple_fsm_inst" -delim "."
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "sys_rst_n" -win $_nTrace1
srcAddSelectedToWave -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "state" -win $_nTrace1
srcAddSelectedToWave -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 \
           {/mnt/mydata/asic/vcs_makefile_example/file/simple_fsm.fsdb}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "sys_clk" -win $_nTrace1
srcAddSelectedToWave -win $_nTrace1
wvZoom -win $_nWave2 890.469899 1859.156748
wvZoom -win $_nWave2 989.704049 1102.207882
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 480.421510 736.654183
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 472.481450 976.705840
wvZoom -win $_nWave2 627.742921 741.260979
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 8463.754956 16979.434788
wvZoom -win $_nWave2 11836.552507 14301.484251
wvZoom -win $_nWave2 12921.474817 13555.691919
debExit
