*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM003_SEL
*&---------------------------------------------------------------------*
SELECTION-SCREEN begin of BLOCK b01 WITH FRAME TITLE text-001.
  PARAMETERS: p_folin like rlgrap-filename OBLIGATORY,
              p_folpr like rlgrap-filename OBLIGATORY,
              p_foler like rlgrap-filename OBLIGATORY.
SELECTION-SCREEN end of BLOCK b01.

SELECTION-SCREEN begin of BLOCK b02 WITH FRAME TITLE text-002.
  parameters: p_direct as CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN end of BLOCK b02.

at SELECTION-SCREEN OUTPUT.
  loop at SCREEN.
    if screen-name cs 'P_FOL'.
      screen-input = 0.
    endif.

    MODIFY SCREEN.
  endloop.

INITIALIZATION.
  perform f_initialization.
