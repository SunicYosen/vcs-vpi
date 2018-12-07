#include "stdio.h"
#include "string.h"
#include "math.h"
#include "vpi_user.h"
#include "acc_user.h"

testParams()
{
    vpiHandle sysTfH, argI, arg_phase, arg_funct;
    s_vpi_value argval_phase, argval_funct;

    PLI_INT32 value_phase;
    PLI_BYTE8 *value_funct;

    argval_phase.format = vpiIntVal;
    argval_funct.format = vpiStringVal;

    sysTfH = vpi_handle(vpiSysTfCall, NULL);
    argI = vpi_iterate(vpiArgument,sysTfH);

    arg_phase = vpi_scan(argI);
    vpi_get_value(arg_phase, &argval_phase);
    value_phase = argval_phase.value.integer;

    arg_funct = vpi_scan(argI);
    vpi_get_value(arg_funct, &argval_funct);
    value_funct = argval_funct.value.str;

    vpi_free_object(argI);

    printf("%.8x = %d\n",arg_phase,value_phase);
    printf("%.8x = %.2x\n",arg_funct,value_funct[0]);

    float phase = value_phase;
    phase = phase / 65535 * 6.28;
    float Result = 0.0;

    if(value_funct[0] == 0x00){
        Result = sin(phase);
        printf("sin(%f) = %f\n" ,phase,Result);
    }
    else if(value_funct[0] == 0x01){
        Result = cos(phase);
        printf("cos(%f) = %f\n" ,phase,Result);
    }
    else{
        printf("Error!");
        return(1);
    }

    handle reg = acc_handle_object("tb.helloVPI1.result");

    static s_setval_delay delay_s = {{0, 1, 0, 0.0},accNoDelay};
    static s_setval_value value_s = {accIntVal};
    //value_s.value.integer=0;

    value_s.value.integer = (PLI_INT32)(*(int *)&Result);  
    //Turn float to binary according to ieee standards.

    acc_set_value(reg, &value_s,&delay_s);

    return(0);
}

testPut()
{
    handle reg = acc_handle_object("tb.helloVPI1.result");
    static s_setval_delay delay_s = {{ 0, 1, 0, 0.0},accForceFlag};
    static s_setval_value value_s = {accIntVal};
    value_s.value.integer = 3;
    //value_s.value.integer = (PLI_INT32)Result;
    acc_set_value(reg, &value_s,&delay_s);
}