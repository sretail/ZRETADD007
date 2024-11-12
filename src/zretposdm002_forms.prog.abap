*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM002_FORMS
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  f_mostrar_datos
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_listar_datos USING  pe_estructura     LIKE  dd02l-tabname
                              pe_status         TYPE  slis_formname
                              pe_ucomm          TYPE  slis_formname
                              pe_top            TYPE  slis_formname
                              pe_top_html       TYPE  slis_formname
                              pe_datos
                              pe_color_line
                              pe_sel.

*0.- Declaracion de variables
*======================================================================
  DATA: lit_fieldcatalog TYPE         lvc_t_fcat,
        wa_fieldcatalog  TYPE LINE OF lvc_t_fcat,
        lr_layout        TYPE         lvc_s_layo,
        ld_index         LIKE         sy-tabix,
        lit_sort_lvc     TYPE         lvc_t_sort,
        wa_sort_lvc      TYPE         lvc_s_sort,
        ld_index2        LIKE         sy-tabix.

* 1.- Logica
*======================================================================

  FIELD-SYMBOLS: <fs_tabla> TYPE STANDARD TABLE.

  ASSIGN (pe_datos) TO <fs_tabla>.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = pe_estructura
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = lit_fieldcatalog
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


*  lr_layout-zebra             = 'X'.
*  lr_layout-no_hgridln  = 'X'.
  lr_layout-stylefname = 'FIELD_STYLE'.
  lr_layout-cwidth_opt = 'X'.
  IF pe_sel = 'X'.
    lr_layout-box_fname = 'SEL'.
  ENDIF.

  IF pe_color_line <> ''.
    lr_layout-info_fname = pe_color_line.
  ENDIF.

  lr_layout-ctab_fname = 'CELLCOLR'.

  PERFORM f_formatear_columnas_alv USING pe_estructura CHANGING lit_fieldcatalog.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
*     I_INTERFACE_CHECK           = ' '
*     I_BYPASSING_BUFFER          =
*     I_BUFFER_ACTIVE             =
      i_callback_program          = sy-repid
      i_callback_pf_status_set    = pe_status
      i_callback_user_command     = pe_ucomm
      i_callback_top_of_page      = pe_top
      i_callback_html_top_of_page = pe_top_html
*     I_CALLBACK_HTML_END_OF_LIST = ' '
*     I_STRUCTURE_NAME            =
*     i_background_id             = ''
*     I_GRID_TITLE                =
*     I_GRID_SETTINGS             =
      is_layout_lvc               = lr_layout
      it_fieldcat_lvc             = lit_fieldcatalog
*     IT_EXCLUDING                =
*     IT_SPECIAL_GROUPS_LVC       =
*     it_sort_lvc                 =
*     IT_FILTER_LVC               =
*     IT_HYPERLINK                =
*     IS_SEL_HIDE                 =
      i_default                   = 'X'
      i_save                      = 'A'
*     is_variant                  =
*     it_events                   =
*     IT_EVENT_EXIT               =
*     IS_PRINT_LVC                =
*     IS_REPREP_ID_LVC            =
*     I_SCREEN_START_COLUMN       = 0
*     I_SCREEN_START_LINE         = 0
*     I_SCREEN_END_COLUMN         = 0
*     I_SCREEN_END_LINE           = 0
*     I_HTML_HEIGHT_TOP           =
*     I_HTML_HEIGHT_END           =
*     IT_ALV_GRAPHICS             =
*     IT_EXCEPT_QINFO_LVC         =
*     IR_SALV_FULLSCREEN_ADAPTER  =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER     =
*     ES_EXIT_CAUSED_BY_USER      =
    TABLES
      t_outtab                    = <fs_tabla>
    EXCEPTIONS
      program_error               = 1
      OTHERS                      = 2.
  IF sy-subrc <> 0. ENDIF.
ENDFORM.                    " f_listar_datos

*&---------------------------------------------------------------------*
*&      Form  F_FORMATEAR_COLUMNAS_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_LIT_FIELDCATALOG  text
*----------------------------------------------------------------------*
FORM f_formatear_columnas_alv  USING pe_estructura
                            CHANGING lit_fieldcatalog TYPE lvc_t_fcat.
  DATA: ld_index        LIKE sy-tabix,
        wa_fieldcatalog TYPE LINE OF lvc_t_fcat.

  LOOP AT lit_fieldcatalog INTO wa_fieldcatalog.
    ld_index = sy-tabix.

    CASE wa_fieldcatalog-fieldname.
      WHEN 'SEL' OR 'ROW_COLOR'.
        DELETE lit_fieldcatalog INDEX ld_index.
        CONTINUE.
      WHEN 'STATUSARCH'.
        wa_fieldcatalog-reptext    = 'Marcado para borrado'.
        wa_fieldcatalog-scrtext_l  = 'MB'.
        wa_fieldcatalog-scrtext_m  = 'MB'.
        wa_fieldcatalog-scrtext_s  = 'MB'.
    ENDCASE.

    MODIFY lit_fieldcatalog FROM wa_fieldcatalog INDEX ld_index.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_VALIDAR_PANTALLA_SELECCION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GD_ERROR
*&---------------------------------------------------------------------*
FORM f_validar_pantalla_seleccion  CHANGING ps_error.
  IF s_fechat[] IS INITIAL.
    MESSAGE s001(zretposdm002) DISPLAY LIKE 'E'.

    ps_error = 'X'.
  ENDIF.
ENDFORM.

FORM f_status USING extab TYPE slis_t_extab.
  DATA: lit_excluding LIKE sy-ucomm OCCURS 0.

  IF p_ar = 'X'.
    APPEND 'DESARCHIVA' TO lit_excluding.
  ELSE.
    APPEND 'ARCHIVAR' TO lit_excluding.
  ENDIF.

  SET PF-STATUS 'STATUS_ALV' EXCLUDING lit_excluding.
ENDFORM.                    "F_STATUS_S02

FORM f_ucomm USING pe_ucomm   LIKE sy-ucomm
                                   rs_selfield TYPE slis_selfield.

  rs_selfield-refresh = 'X'.
  rs_selfield-col_stable = 'X'.
  rs_selfield-row_stable = 'X'.



  CASE pe_ucomm.
    WHEN 'ARCHIVAR'.
      PERFORM f_archivar_tickets.
    WHEN 'DESARCHIVA'.
      PERFORM f_desarchivar_tickets.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_ARCHIVAR_TICKETS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_archivar_tickets .
* 0.- Declaración de variables
*===================================================================================================
  DATA: ld_respuesta(1),
        ld_cont          TYPE int4,
        ld_num_tickets   TYPE p DECIMALS 0,
        ld_ticket_actual TYPE p DECIMALS 0,
        ld_porc          TYPE p DECIMALS 2.

* 1.- Lógica
*===================================================================================================
  LOOP AT git_listado WHERE statusarch = gc_icono_archivado.
    EXIT.
  ENDLOOP.

  IF sy-subrc = 0.
*   Msg: Tickets ya han sido archivados
    MESSAGE s009(zretposdm002) DISPLAY LIKE 'E'.

    EXIT.
  ENDIF.

* Solicitar confirmación
  PERFORM f_popup_to_confirm USING '¿Archivar tickets seleccionados?' CHANGING ld_respuesta.

  IF ld_respuesta = '1'.
    MODIFY zztransactiona    FROM TABLE git_zztransaction.
    COMMIT WORK AND WAIT.
    MODIFY zzlineitema       FROM TABLE git_zzlineitem.
    COMMIT WORK AND WAIT.
    MODIFY zzlineitemdisca   FROM TABLE git_zzlineitemdisc.
    COMMIT WORK AND WAIT.
    MODIFY zzlineitemdiscea  FROM TABLE git_zzlineitemdiscex.
    COMMIT WORK AND WAIT.
    MODIFY zztendera         FROM TABLE git_zztender.
    COMMIT WORK AND WAIT.
    MODIFY zzcustdetailsa    FROM TABLE git_zzcustdetails.
    COMMIT WORK AND WAIT.
    MODIFY zzlineitem2weba   FROM TABLE git_zzlineitem2web.
    COMMIT WORK AND WAIT.

    DELETE FROM zztransaction
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zzlineitem
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zzlineitemdisc
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zzlineitemdiscex
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zztender
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zzcustdetails
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    LOOP AT git_listado.
      git_listado-statusarch = gc_icono_archivado.
      git_listado-statusarcht = 'Archivado'.

      MODIFY git_listado.
    ENDLOOP.

*   Msg: Tickets archivados
    MESSAGE s005(zretposdm002).
  ELSE.
*   Msg: Acción cancelada
    MESSAGE s002(zretposdm002).
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_DESARCHIVAR_TICKETS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_desarchivar_tickets .
* 0.- Declaración de variables
*===================================================================================================
  DATA: ld_respuesta(1),
        ld_cont          TYPE int4,
        ld_num_tickets   TYPE int4,
        ld_ticket_actual,
        ld_porc          TYPE p DECIMALS 2.

* 1.- Lógica
*===================================================================================================
  LOOP AT git_listado WHERE statusarch = gc_icono_desarchivado.
    EXIT.
  ENDLOOP.

  IF sy-subrc = 0.
*   Msg: Tickets ya han sido desarchivados
    MESSAGE s010(zretposdm002) DISPLAY LIKE 'E'.

    EXIT.
  ENDIF.

* Solicitar confirmación
  PERFORM f_popup_to_confirm USING '¿Desarchivar tickets seleccionados?' CHANGING ld_respuesta.

  IF ld_respuesta = '1'.
    MODIFY zztransaction     FROM TABLE git_zztransaction.
    COMMIT WORK AND WAIT.
    MODIFY zzlineitem        FROM TABLE git_zzlineitem.
    COMMIT WORK AND WAIT.
    MODIFY zzlineitemdisc    FROM TABLE git_zzlineitemdisc.
    COMMIT WORK AND WAIT.
    MODIFY zzlineitemdiscex  FROM TABLE git_zzlineitemdiscex.
    COMMIT WORK AND WAIT.
    MODIFY zztender          FROM TABLE git_zztender.
    COMMIT WORK AND WAIT.
    MODIFY zzcustdetails     FROM TABLE git_zzcustdetails.
    COMMIT WORK AND WAIT.


    DELETE FROM zztransactiona
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zzlineitema
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.


    DELETE FROM zzlineitemdisca
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zzlineitemdiscea
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zztendera
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    DELETE FROM zzcustdetailsa
          WHERE retailstoreid        IN s_tienda
            AND businessdaydate      IN s_fechat
            AND transactiontypecode  IN s_tipotr
            AND workstationid        IN s_caja
            AND transactionsequencenumber IN s_numtic.

    COMMIT WORK AND WAIT.

    LOOP AT git_listado.
      git_listado-statusarch = gc_icono_desarchivado.
      git_listado-statusarcht = 'No Archivado'.

      MODIFY git_listado.
    ENDLOOP.

*   Msg: Tickets desarchivados
    MESSAGE s006(zretposdm002).
  ELSE.
*   Msg: Acción cancelada
    MESSAGE s002(zretposdm002).
  ENDIF.
ENDFORM.


FORM f_top_of_page_html USING top TYPE REF TO cl_dd_document.
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_contador   TYPE int4,
        ld_texto(255),
        ld_fecha(10),
        ld_hora(8),
        BEGIN OF lit_matnr OCCURS 0,
          matnr LIKE mara-matnr,
        END OF lit_matnr,

        ld_table       TYPE REF TO cl_dd_table_element,
        ld_table_area  TYPE REF TO cl_dd_table_area,
        ld_column_1    TYPE REF TO cl_dd_area,
        ld_column_2    TYPE REF TO cl_dd_area,
        ld_column_3    TYPE REF TO cl_dd_area,
        ld_column_4    TYPE REF TO cl_dd_area,

        ld_total_venta TYPE kwert,
        ld_total_coste TYPE kwert,
        ld_margen      TYPE kwert,

        ld_numtickets  TYPE int4.

* 1.- Lógica
*==========================================================================
  WRITE sy-datum TO ld_fecha.
  WRITE sy-uzeit TO ld_hora.

  DESCRIBE TABLE git_listado LINES ld_numtickets.

* Titulo
  IF p_ar = 'X'.
    PERFORM f_add_text USING 'HEADING' '' '' 'MONITOR DE ARCHIVADO DE TICKETS POSDM' CHANGING top.
  ELSEIF p_desar = 'X'.
    PERFORM f_add_text USING 'HEADING' '' '' 'MONITOR DE DESARCHIVADO DE TICKETS POSDM' CHANGING top.
  ENDIF.

  CALL METHOD top->new_line( ).
  CALL METHOD top->new_line( ).

  PERFORM f_add_text USING '' '' '' 'Tickets seleccionados:' CHANGING top.
  WRITE ld_numtickets TO ld_texto LEFT-JUSTIFIED.
  PERFORM f_add_text USING '' 'STRONG' 'LIST_TOTAL_INT' ld_texto CHANGING top.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_ADD_TEXT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_1650   text
*      -->P_1651   text
*      -->P_1652   text
*----------------------------------------------------------------------*
FORM f_add_text  USING    pe_sap_style
                          pe_emphasis
                          pe_sap_color
                          pe_texto
              CHANGING    top TYPE REF TO cl_dd_document.

  CALL METHOD top->add_text
    EXPORTING
      text         = pe_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = pe_sap_style
      sap_color    = pe_sap_color
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = pe_emphasis
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*   CHANGING
*     DOCUMENT     =
    .
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_SELECCIONAR_DATOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleccionar_datos .

  IF p_ar = 'X'.
*   Si acción es archivar tickets...

*   Seleccionamos tickets no archivados
    SELECT *
      FROM zztransaction
      APPENDING TABLE git_zztransaction
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zzlineitem
      APPENDING TABLE git_zzlineitem
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zzlineitemdisc
      APPENDING TABLE git_zzlineitemdisc
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zzlineitemdiscex
      APPENDING TABLE git_zzlineitemdiscex
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zztender
      APPENDING TABLE git_zztender
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
       FROM zzcustdetails
       APPENDING TABLE git_zzcustdetails
      WHERE retailstoreid        IN s_tienda
        AND businessdaydate      IN s_fechat
        AND transactiontypecode  IN s_tipotr
        AND workstationid        IN s_caja
        AND transactionsequencenumber IN s_numtic.

    LOOP AT git_zztransaction.
      MOVE-CORRESPONDING git_zztransaction TO git_listado.

      git_listado-statusarch = gc_icono_desarchivado.
      git_listado-statusarcht = 'No archivado'.
      APPEND git_listado.
    ENDLOOP.
  ELSE.
*   Si acción es desarchivar tickets...

*   Seleccionamos tickets no archivados
    SELECT *
      FROM zztransactiona
      APPENDING TABLE git_zztransaction
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zzlineitema
      APPENDING TABLE git_zzlineitem
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zzlineitemdisca
      APPENDING TABLE git_zzlineitemdisc
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zzlineitemdiscea
      APPENDING TABLE git_zzlineitemdiscex
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
      FROM zztendera
      APPENDING TABLE git_zztender
     WHERE retailstoreid        IN s_tienda
       AND businessdaydate      IN s_fechat
       AND transactiontypecode  IN s_tipotr
       AND workstationid        IN s_caja
       AND transactionsequencenumber IN s_numtic.

    SELECT *
       FROM zzcustdetailsa
       APPENDING TABLE git_zzcustdetails
      WHERE retailstoreid        IN s_tienda
        AND businessdaydate      IN s_fechat
        AND transactiontypecode  IN s_tipotr
        AND workstationid        IN s_caja
        AND transactionsequencenumber IN s_numtic.

    LOOP AT git_zztransaction.
      MOVE-CORRESPONDING git_zztransaction TO git_listado.

      git_listado-statusarch = gc_icono_archivado.
      git_listado-statusarcht = 'Archivado'.
      APPEND git_listado.
    ENDLOOP.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_POPUP_TO_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      <-- LD_RESPUESTA
*&---------------------------------------------------------------------*
FORM f_popup_to_confirm  USING    pe_pregunta
                         CHANGING ps_respuesta.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
*     TITLEBAR       = ' '
*     DIAGNOSE_OBJECT             = ' '
      text_question  = pe_pregunta
*     TEXT_BUTTON_1  = 'Ja'(001)
*     ICON_BUTTON_1  = ' '
*     TEXT_BUTTON_2  = 'Nein'(002)
*     ICON_BUTTON_2  = ' '
*     DEFAULT_BUTTON = '1'
*     DISPLAY_CANCEL_BUTTON       = 'X'
*     USERDEFINED_F1_HELP         = ' '
*     START_COLUMN   = 25
*     START_ROW      = 6
*     POPUP_TYPE     =
*     IV_QUICKINFO_BUTTON_1       = ' '
*     IV_QUICKINFO_BUTTON_2       = ' '
    IMPORTING
      answer         = ps_respuesta
*   TABLES
*     PARAMETER      =
    EXCEPTIONS
      text_not_found = 1
      OTHERS         = 2.
  IF sy-subrc <> 0. ENDIF.

ENDFORM.
