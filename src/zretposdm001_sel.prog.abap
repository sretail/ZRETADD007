*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM001_SEL
*&---------------------------------------------------------------------*
SELECTION-SCREEN begin of block b01 WITH FRAME TITLE text-001.
  parameters: p_r01 RADIOBUTTON GROUP r01 USER-COMMAND TIPO,
              p_r02 RADIOBUTTON GROUP r01,
              p_r03 RADIOBUTTON GROUP r01,
              p_r05 RADIOBUTTON GROUP r01,
              p_r06 RADIOBUTTON GROUP r01,
              p_r07 RADIOBUTTON GROUP r01,
              p_r08 RADIOBUTTON GROUP r01,
              p_r04 RADIOBUTTON GROUP r01,
              p_r09 RADIOBUTTON GROUP r01,
              p_r10 RADIOBUTTON GROUP r01.
SELECTION-SCREEN end of BLOCK b01.

SELECTION-SCREEN begin of BLOCK b02 WITH FRAME TITLE text-002.
  PARAMETERS: p_tpv01 RADIOBUTTON GROUP r02,
              p_tpv02 RADIOBUTTON GROUP r02.
SELECTION-SCREEN end of BLOCK b02.

SELECTION-SCREEN begin of BLOCK b03 WITH FRAME TITLE text-003.
  PARAMETERS: p_folin like rlgrap-filename,
              p_folpr like rlgrap-filename.
SELECTION-SCREEN end of BLOCK b03.

SELECTION-SCREEN BEGIN OF BLOCK b04 WITH FRAME TITLE text-004.
  SELECTION-SCREEN BEGIN OF TABBED BLOCK tabb1 FOR 15 LINES.
    SELECTION-SCREEN TAB (40) text-005 USER-COMMAND ucomm1 DEFAULT SCREEN 1001.
    SELECTION-SCREEN TAB (40) text-006 USER-COMMAND ucomm2 DEFAULT SCREEN 1002.
  SELECTION-SCREEN END OF BLOCK tabb1.
SELECTION-SCREEN END OF BLOCK b04.


SELECTION-SCREEN begin of BLOCK b05 WITH FRAME TITLE text-007.
 SELECT-OPTIONS: s_2fic for ZPOSDM001-L00FICHERO,
                 s_2fi  for ZPOSDM001-L00FECHAINC,
                 s_2hi  for ZPOSDM001-L00HORAINC,
                 s_2ui   for ZPOSDM001-L00USUARIOINC.
SELECTION-SCREEN end of BLOCK b05.

SELECTION-SCREEN: BEGIN OF SCREEN 1001 AS SUBSCREEN          .
  Select-options: s_fic     for ZZTRANSACTION-ZKEY,
                  s_docnum  for ZZTRANSACTION-docnum.
SELECTION-SCREEN: END OF SCREEN 1001                         .

SELECTION-SCREEN: BEGIN OF SCREEN 1002 AS SUBSCREEN          .
  select-options: s_rsi   for  ZZTRANSACTION-RETAILSTOREID,
                  s_bdd   for  ZZTRANSACTION-BUSINESSDAYDATE,
                  s_ttt   for  ZZTRANSACTION-TRANSACTIONTYPECODE,
                  s_wsid  for  ZZTRANSACTION-WORKSTATIONID,
                  s_tsn   for  ZZTRANSACTION-TRANSACTIONSEQUENCENUMBER,
                  s_bdts  for  ZZTRANSACTION-BEGINDATETIMESTAMP,
                  s_edts  for  ZZTRANSACTION-ENDDATETIMESTAMP,
                  s_dep   for  ZZTRANSACTION-DEPARTMENT,
                  s_opq   for  ZZTRANSACTION-OPERATORQUALIFIER,
                  s_opid  for  ZZTRANSACTION-OPERATORID,
                  s_tcurr for  ZZTRANSACTION-TRANSACTIONCURRENCY,
                  s_pq    for  ZZTRANSACTION-PARTNERQUALIFIER,
                  s_pid   for  ZZTRANSACTION-PARTNERID.
SELECTION-SCREEN: END OF SCREEN 1002                         .

SELECTION-SCREEN begin of block b07 WITH FRAME TITLE text-009.
  SELECT-options: s_feci for sy-datum.
SELECTION-SCREEN end of BLOCK b07.


SELECTION-SCREEN begin of block b06 WITH FRAME TITLE text-008.
  parameters: p_proc as checkbox default ''.
SELECTION-SCREEN end of BLOCK b06.

at SELECTION-SCREEN output.
  perform f_at_selection_screen_output.

INITIALIZATION.
  perform f_initialization.

at SELECTION-SCREEN.
  perform f_at_selection_screen.
