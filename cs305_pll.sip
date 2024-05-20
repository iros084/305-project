set_global_assignment -entity "cs305_pll" -library "lib_cs305_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "cs305_pll" -library "lib_cs305_pll" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "cs305_pll" -library "lib_cs305_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_cs305_pll" -name SPD_FILE [file join $::quartus(sip_path) "cs305_pll.spd"]

set_global_assignment -library "lib_cs305_pll" -name MISC_FILE [file join $::quartus(sip_path) "cs305_pll_sim/cs305_pll.vho"]
