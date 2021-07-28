#!/usr/bin/env nextflow
/*
========================================================================================
                        nf-core/bcellmagic
========================================================================================
    GitHub  : https://github.com/nf-core/bcellmagic
    Website : https://nf-co.re/bcellmagic
    Slack   : https://nfcore.slack.com/channels/bcellmagic
----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

WorkflowMain.initialise(workflow, params, log)

/*
========================================================================================
    NAMED WORKFLOW FOR PIPELINE
========================================================================================
*/

include { BCELLMAGIC } from './workflows/bcellmagic'

//
// WORKFLOW: Run main nf-core/bcellmagic analysis pipeline
//
workflow NFCORE_BCELLMAGIC {
    BCELLMAGIC ()
}

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Execute a single named workflow for the pipeline
// See: https://github.com/nf-core/rnaseq/issues/619
//
workflow {
    if (params.subworkflow == "bcellmagic") {
        include { BCELLMAGIC } from './bcellmagic' addParams( summary_params: summary_params )
        BCELLMAGIC()
    } else if (params.subworkflow == "reveal") {
        include { REVEAL } from './reveal' addParams( summary_params: summary_params )
        REVEAL ()
    } else {
        exit 1
    }
}

/*
========================================================================================
    THE END
========================================================================================
*/
