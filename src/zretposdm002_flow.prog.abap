*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM002_FLOW
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  perform f_validar_pantalla_seleccion CHANGING gd_error.

  if gd_error = ''.
    perform f_seleccionar_datos.
  endif.

end-of-selection.
  if gd_error = ''.
    if p_online = 'X'.
      if git_listado[] is not initial.
        PERFORM f_listar_datos USING 'ZRETPOSDM002S01'
                                     'F_STATUS'
                                     'F_UCOMM'
                                     ''
                                     'F_TOP_OF_PAGE_HTML'
                                     'GIT_LISTADO[]'
                                     ''
                                     ''.
      else.
        message s004(zretposdm002).
      endif.
    else.
      if git_listado[] is not initial.
        if p_ar = 'X'.
          perform f_archivar_tickets.
        elseif p_desar = 'X'.
          perform f_desarchivar_tickets.
        endif.
      endif.
    endif.
  endif.
