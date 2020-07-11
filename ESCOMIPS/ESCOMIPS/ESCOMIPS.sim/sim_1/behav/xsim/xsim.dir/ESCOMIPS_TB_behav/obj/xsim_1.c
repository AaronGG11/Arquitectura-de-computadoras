/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_325(char*, char *);
extern void execute_326(char*, char *);
extern void execute_14(char*, char *);
extern void execute_309(char*, char *);
extern void execute_310(char*, char *);
extern void execute_311(char*, char *);
extern void execute_312(char*, char *);
extern void execute_313(char*, char *);
extern void execute_314(char*, char *);
extern void execute_315(char*, char *);
extern void execute_316(char*, char *);
extern void execute_317(char*, char *);
extern void execute_318(char*, char *);
extern void execute_319(char*, char *);
extern void execute_320(char*, char *);
extern void execute_321(char*, char *);
extern void execute_322(char*, char *);
extern void execute_323(char*, char *);
extern void execute_324(char*, char *);
extern void execute_29(char*, char *);
extern void execute_31(char*, char *);
extern void execute_88(char*, char *);
extern void execute_37(char*, char *);
extern void execute_34(char*, char *);
extern void execute_85(char*, char *);
extern void execute_90(char*, char *);
extern void execute_92(char*, char *);
extern void execute_94(char*, char *);
extern void execute_272(char*, char *);
extern void execute_273(char*, char *);
extern void execute_274(char*, char *);
extern void execute_275(char*, char *);
extern void execute_97(char*, char *);
extern void execute_98(char*, char *);
extern void execute_99(char*, char *);
extern void execute_100(char*, char *);
extern void execute_101(char*, char *);
extern void execute_105(char*, char *);
extern void execute_103(char*, char *);
extern void execute_104(char*, char *);
extern void execute_277(char*, char *);
extern void execute_278(char*, char *);
extern void execute_304(char*, char *);
extern void execute_305(char*, char *);
extern void execute_306(char*, char *);
extern void execute_281(char*, char *);
extern void execute_282(char*, char *);
extern void execute_284(char*, char *);
extern void execute_285(char*, char *);
extern void execute_286(char*, char *);
extern void execute_287(char*, char *);
extern void execute_288(char*, char *);
extern void execute_289(char*, char *);
extern void execute_291(char*, char *);
extern void execute_293(char*, char *);
extern void execute_295(char*, char *);
extern void execute_297(char*, char *);
extern void execute_299(char*, char *);
extern void execute_301(char*, char *);
extern void execute_302(char*, char *);
extern void execute_303(char*, char *);
extern void execute_308(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[64] = {(funcp)execute_325, (funcp)execute_326, (funcp)execute_14, (funcp)execute_309, (funcp)execute_310, (funcp)execute_311, (funcp)execute_312, (funcp)execute_313, (funcp)execute_314, (funcp)execute_315, (funcp)execute_316, (funcp)execute_317, (funcp)execute_318, (funcp)execute_319, (funcp)execute_320, (funcp)execute_321, (funcp)execute_322, (funcp)execute_323, (funcp)execute_324, (funcp)execute_29, (funcp)execute_31, (funcp)execute_88, (funcp)execute_37, (funcp)execute_34, (funcp)execute_85, (funcp)execute_90, (funcp)execute_92, (funcp)execute_94, (funcp)execute_272, (funcp)execute_273, (funcp)execute_274, (funcp)execute_275, (funcp)execute_97, (funcp)execute_98, (funcp)execute_99, (funcp)execute_100, (funcp)execute_101, (funcp)execute_105, (funcp)execute_103, (funcp)execute_104, (funcp)execute_277, (funcp)execute_278, (funcp)execute_304, (funcp)execute_305, (funcp)execute_306, (funcp)execute_281, (funcp)execute_282, (funcp)execute_284, (funcp)execute_285, (funcp)execute_286, (funcp)execute_287, (funcp)execute_288, (funcp)execute_289, (funcp)execute_291, (funcp)execute_293, (funcp)execute_295, (funcp)execute_297, (funcp)execute_299, (funcp)execute_301, (funcp)execute_302, (funcp)execute_303, (funcp)execute_308, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 64;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/ESCOMIPS_TB_behav/xsim.reloc",  (void **)funcTab, 64);
	iki_vhdl_file_variable_register(dp + 72056);
	iki_vhdl_file_variable_register(dp + 72112);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/ESCOMIPS_TB_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/ESCOMIPS_TB_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/ESCOMIPS_TB_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/ESCOMIPS_TB_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/ESCOMIPS_TB_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
