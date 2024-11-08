*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM001_FLOW
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  if p_r02 = 'X'.
*   Monitor PI
    perform f_seleccionar_datos_pi.
  elseif p_r01 = 'X'.
*   Incorporar tickets TPV
    perform f_incorporar_tickets.
  elseif p_r03 = 'X'.
*   Monitor POSDM
    perform f_seleccionar_datos_posdm.
  elseif P_R05 = 'X'.
*   Tarea 1: Mov. salida por venta
    perform f_t1_mov_salida_por_venta.
  elseif P_R06 = 'X'.
*  	Tarea 2: Agrup. Tickets anonim
    perform f_t2_agrup_tickets_anonimos.
  elseif P_R07 = 'X'.
*  	Tarea 3: Vta a clientes a cta
    perform f_t3_venta_a_clientes_a_cuenta.
  elseif P_R08 = 'X'.
*   Tarea 4: Fact.cli.especiales
    perform f_t4_fact_cli_especiales.
  elseif p_r04 = 'X'.
*   Tarea 5: Cierre de caja
    perform f_seleccionar_datos_cierre.
  elseif p_r09 = 'X'.
*   Tarea 4: Cierre de caja (Casa Ametller)
    perform f_t4_cierre_caja_ametller.
  elseif p_r10 = 'X'.
*   Tarea 6: Anticipos Candelsa
    perform f_t6_anticipos_candelsa.
  endif.

end-of-selection.
  if git_listado[] is not initial.
    if sy-batch = ''.
      perform f_listar_datos using 'ZRETPOSDM001S01'
                                   'F_STATUS'
                                   'F_UCOMM'
                                   ''
                                   'F_TOP_OF_PAGE_HTML'
                                   'GIT_LISTADO[]'
                                   ''
                                   ''.
    endif.
  else.
    if p_r01 = 'X'.
*     Msg: No se encontró ningún fichero procesable de TPV.
      message i007(ZRETPOSDM001).
    endif.
  endif.
