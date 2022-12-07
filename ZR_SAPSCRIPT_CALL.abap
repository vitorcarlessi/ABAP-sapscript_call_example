*======================================================================*
*                                                                      *
*                       github.com/vitorcarlessi/                      *
*                                                                      *
*======================================================================*
* Program.....: ZR_SAPSCRIPT_CALL                                      *
* Module......: ALL                                                    *
* Description.: SAPSCRIPT CALL - Basic Example                         *
*----------------------------------------------------------------------*
* Author......: Vitor Crepaldi Carlessi                                *
* Date........: 07.12.2022                                             *
*======================================================================*
REPORT zr_sapscript_call.

INCLUDE zr_sapscript_call_top.
INCLUDE zr_sapscript_call_f01.

START-OF-SELECTION.
  PERFORM: f_full_process.