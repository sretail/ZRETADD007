*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM002_SEL
*&---------------------------------------------------------------------*
SELECTION-SCREEN begin of BLOCK b01 WITH FRAME TITLE text-001.
  parameters: p_ar    RADIOBUTTON GROUP r01,
              p_desar RADIOBUTTON GROUP r01.
SELECTION-SCREEN end of BLOCK b01.

SELECTION-SCREEN begin of BLOCK b02 WITH FRAME TITLE text-002.
  select-options:   s_fechat  for zztransaction-BUSINESSDAYDATE,
                    S_TIENDA  for zztransaction-RETAILSTOREID,
                    S_CAJA    for zztransaction-WORKSTATIONID,
                    S_TIPOTR  for zztransaction-TRANSACTIONTYPECODE,
                    S_NUMTIC  for zztransaction-TRANSACTIONSEQUENCENUMBER.
SELECTION-SCREEN end of BLOCK b02.

SELECTION-SCREEN begin of BLOCK b03 WITH FRAME TITLE text-003.
  PARAMETERS: p_online RADIOBUTTON GROUP r02,
              p_fondo  RADIOBUTTON GROUP r02.
SELECTION-SCREEN end of BLOCK b03.
