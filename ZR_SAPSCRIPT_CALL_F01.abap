*======================================================================*
*                                                                      *
*                       github.com/vitorcarlessi/                      *
*                                                                      *
*======================================================================*
* Program.....: ZR_SAPSCRIPT_CALL                                      *
* Include.....: ZR_SAPSCRIPT_CALL_F01                                  *
* Module......: ALL                                                    *
* Description.: SAPSCRIPT CALL - Basic Example                         *
*----------------------------------------------------------------------*
* Author......: Vitor Crepaldi Carlessi                                *
* Date........: 07.12.2022                                             *
*======================================================================*
*&---------------------------------------------------------------------*
*&  Include           ZR_SAPSCRIPT_CALL_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_FULL_PROCESS
*&---------------------------------------------------------------------*
FORM f_full_process.

*&---------------------------------------------------------------------*
*& Structures                                                          *
*&---------------------------------------------------------------------*
  DATA: ls_result TYPE itcpp.

*&---------------------------------------------------------------------*
*& Variables                                                           *
*&---------------------------------------------------------------------*
  DATA: lv_form TYPE pbrsp_sap_script_form.

  "Form Name
  lv_form = 'ZHRBR_ADV_CONT'.

  "1)Open Form
  PERFORM: f_open_form USING lv_form.

  "2)Start Form
  PERFORM: f_start_form.

  "3)Write Form
  PERFORM: f_write_form.

  "4)End Form
  PERFORM: f_end_form CHANGING ls_result.

  "5)Close Form
  PERFORM: f_close_form CHANGING ls_result.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_OPEN_FORM
*&---------------------------------------------------------------------*
FORM f_open_form USING pv_form TYPE pbrsp_sap_script_form.

*&---------------------------------------------------------------------*
*& Structures                                                          *
*&---------------------------------------------------------------------*
  DATA: ls_archive_index  TYPE toa_dara,
        ls_archive_params TYPE arc_params,
        ls_options        TYPE itcpo,
        ls_result         TYPE itcpp.

*&---------------------------------------------------------------------*
*& Variables                                                           *
*&---------------------------------------------------------------------*
  DATA: lv_dialog TYPE pbr99_flag.

  "Open Form
  CALL FUNCTION 'OPEN_FORM'
    EXPORTING
      archive_index               = ls_archive_index
      archive_params              = ls_archive_params
      dialog                      = lv_dialog
      form                        = pv_form
      options                     = ls_options
    IMPORTING
      result                      = ls_result
    EXCEPTIONS
      canceled                    = 1
      device                      = 2
      form                        = 3
      options                     = 4
      unclosed                    = 5
      mail_options                = 6
      archive_error               = 7
      invalid_fax_number          = 8
      more_params_needed_in_batch = 9
      spool_error                 = 10
      codepage                    = 11
      OTHERS                      = 12.

  IF sy-subrc IS NOT INITIAL.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_START_FORM
*&---------------------------------------------------------------------*
FORM f_start_form.

*&---------------------------------------------------------------------*
*& Structures                                                          *
*&---------------------------------------------------------------------*
  DATA: ls_archive_index TYPE toa_dara.

  "Start Form
  CALL FUNCTION 'START_FORM'
    EXPORTING
      archive_index = ls_archive_index
    EXCEPTIONS
      form          = 1
      format        = 2
      unended       = 3
      unopened      = 4
      unused        = 5
      spool_error   = 6
      codepage      = 7
      OTHERS        = 8.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_WRITE_FORM
*&---------------------------------------------------------------------*
FORM f_write_form.

*&---------------------------------------------------------------------*
*& Constants                                                           *
*&---------------------------------------------------------------------*
  DATA: lc_element_header  TYPE itcwe-element VALUE 'HEADER',
        lc_element_footer  TYPE itcwe-element VALUE 'FOOTER',
        lc_element_header1 TYPE itcwe-element VALUE 'HEADER1',
        lc_window_main     TYPE itcwe-window  VALUE 'MAIN'.

  "Header
  PERFORM: f_write_form_params USING lc_element_header
                                     lc_window_main.

  "Footer
  PERFORM: f_write_form_params USING lc_element_footer
                                     lc_window_main.

*  "Header1
*  PERFORM: f_write_form_params USING lc_element_header1
*                                     lc_window_main.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_WRITE_FORM_PARAMS
*&---------------------------------------------------------------------*
FORM f_write_form_params USING pv_element TYPE itcwe-element
                               pv_window  TYPE itcwe-window.

  "Write Form
  CALL FUNCTION 'WRITE_FORM'
    EXPORTING
      element                  = pv_element
      window                   = pv_window
    EXCEPTIONS
      element                  = 1
      function                 = 2
      type                     = 3
      unopened                 = 4
      unstarted                = 5
      window                   = 6
      bad_pageformat_for_print = 7
      spool_error              = 8
      codepage                 = 9
      OTHERS                   = 10.

  IF sy-subrc IS NOT INITIAL.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_END_FORM
*&---------------------------------------------------------------------*
FORM f_end_form CHANGING ps_result TYPE itcpp..

  "End Form
  CALL FUNCTION 'END_FORM'
    IMPORTING
      result                   = ps_result
    EXCEPTIONS
      unopened                 = 1
      bad_pageformat_for_print = 2
      spool_error              = 3
      codepage                 = 4
      OTHERS                   = 5.

  IF sy-subrc IS NOT INITIAL.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_CLOSE_FORM
*&---------------------------------------------------------------------*
FORM f_close_form CHANGING ps_result TYPE itcpp.

  "Close Form
  CALL FUNCTION 'CLOSE_FORM'
    IMPORTING
      result                   = ps_result
    EXCEPTIONS
      unopened                 = 1
      bad_pageformat_for_print = 2
      send_error               = 3
      spool_error              = 4
      codepage                 = 5
      OTHERS                   = 6.

  IF sy-subrc IS NOT INITIAL.

  ENDIF.

ENDFORM.