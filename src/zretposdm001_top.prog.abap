*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM001_TOP
*&---------------------------------------------------------------------*

*==========================================================================
* CONSTANTES
*==========================================================================
constants: gc_icono_tickets            type icon_d  value '@O5@',
           gc_icono_detalle_ticket     type icon_d  value '@16@',
           gc_minisemaforo_verde       TYPE icon_d  VALUE '@5B@',
           gc_minisemaforo_ambar       TYPE icon_d  VALUE '@5D@',
           gc_minisemaforo_rojo        TYPE icon_d  VALUE '@5C@',
           gc_minisemaforo_inactivo    TYPE icon_d  VALUE '@BZ@',
           gc_icono_inbox              type icon_d  value '@BP@',
           gc_icono_cajero             type icon_d  value '@BC@'.

*==========================================================================
* DICCIONARIO DE DATOS
*==========================================================================
TABLES: sscrfields,
        ZPOSDM001,
        ZZTRANSACTION,
        ZZLINEITEM,
        ZZLINEITEMDISC,
        ZZTENDER,
        ZRETPOSDM001S11.

*======================================================================
* CLASES: DEFINICIONES
*======================================================================
CLASS lcl_event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_data_changed_alv_10    FOR EVENT data_changed          OF cl_gui_alv_grid IMPORTING er_data_changed,
      handle_data_changed_f_alv_10  FOR EVENT data_changed_finished OF cl_gui_alv_grid IMPORTING e_modified et_good_cells,
      handle_data_changed_alv_17    FOR EVENT data_changed          OF cl_gui_alv_grid IMPORTING er_data_changed,
      handle_data_changed_f_alv_17  FOR EVENT data_changed_finished OF cl_gui_alv_grid IMPORTING e_modified et_good_cells.
endclass.

*======================================================================
* CLASES: IMPLEMENTACIONES
*======================================================================
CLASS lcl_event_handler IMPLEMENTATION.
  METHOD handle_data_changed_alv_17.
    PERFORM f_handle_data_changed_alv_17   USING er_data_changed.
  ENDMETHOD.

  METHOD handle_data_changed_f_alv_17.
    PERFORM f_handle_data_changed_f_alv_17 USING e_modified et_good_cells.
  ENDMETHOD.

  METHOD handle_data_changed_alv_10.
    PERFORM f_handle_data_changed_alv_10   USING er_data_changed.
  ENDMETHOD.

  METHOD handle_data_changed_f_alv_10.
    PERFORM f_handle_data_changed_f_alv_10 USING e_modified et_good_cells.
  ENDMETHOD.
endclass.

*==========================================================================
* TOOLBAR EVENT RECEIVER - Definición
*==========================================================================
CLASS lcl_toolbar_event_receiver DEFINITION.

  PUBLIC SECTION.
    METHODS: on_function_selected
               FOR EVENT function_selected OF cl_gui_toolbar
                 IMPORTING fcode,

             on_toolbar_dropdown
               FOR EVENT dropdown_clicked OF cl_gui_toolbar
                 IMPORTING fcode
                           posx
                           posy.

ENDCLASS.                    "lcl_toolbar_event_receiver DEFINITION

*==========================================================================
* DEFINICIONES GLOBALES
*==========================================================================
data: git_listado       like ZRETPOSDM001S01 occurs 0 WITH HEADER LINE,
      git_listadot      like ZRETPOSDM001S02 occurs 0 WITH HEADER LINE,
      git_ZPOSDM001     like ZPOSDM001 occurs 0 WITH HEADER LINE,
      git_ticket_01     like ZRETPOSDM001S03 occurs 0,
      git_ticket_02     like ZRETPOSDM001S04 occurs 0,
      git_ticket_03     like ZRETPOSDM001S05 occurs 0,
      git_ticket_04     like ZRETPOSDM001S06 occurs 0,
      git_ticket_05     like ZRETPOSDM001S07 occurs 0,
      git_ticket_06     like ZRETPOSDM001S08 occurs 0,
      git_ticket_07     like ZRETPOSDM001S16 occurs 0,
      git_ticket_08     like ZRETPOSDM001S15 occurs 0,
      git_ticket_09     like ZRETPOSDM001S17 occurs 0,
      gr_ticket_01      like ZRETPOSDM001S03,
      gr_ticket_02      like ZRETPOSDM001S04,
      gr_ticket_03      like ZRETPOSDM001S05,
      gr_ticket_04      like ZRETPOSDM001S06,
      gr_ticket_05      like ZRETPOSDM001S07,
      gr_ticket_06      like ZRETPOSDM001S08,
      gr_ticket_07      like ZRETPOSDM001S16,
      gr_ticket_08      like ZRETPOSDM001S15,
      gr_ticket_09      like ZRETPOSDM001S17,
      git_descarte_fic  like ZRETPOSDM001S09 OCCURS 0,
      gr_descarte_fic   like ZRETPOSDM001S09,
      gf_0200_ticket(1),
      gf_mover_procesados like zhardcodes-valor,
      gf_refresh_posdm_popup_l,
      gd_okcode_0100    like sy-ucomm,
      gd_okcode_0200    like sy-ucomm,
      gd_okcode_0400    like sy-ucomm,
      GD_OCKODE_9000    like sy-ucomm,
      GD_OKCODE_9001    like sy-ucomm,
      gd_okcode_9002    like sy-ucomm,
      git_ZZTRANSACTION     like ZZTRANSACTION occurs 0 WITH HEADER LINE,
      git_ZZLINEITEM     like ZZLINEITEM occurs 0 WITH HEADER LINE,
      git_ZZLINEITEMDISC     like ZZLINEITEMDISC occurs 0 WITH HEADER LINE,
      git_ZZTENDER     like ZZTENDER occurs 0 WITH HEADER LINE,
      git_alv_posdm     like ZRETPOSDM001S10 occurs 0,
      gr_alv_posdm      like ZretPOSDM001s10,
*     Cabecera ticket
      git_posdm_popup_c  like ZretPOSDM001s11 occurs 0,
      gr_posdm_popup_c   like ZretPOSDM001s11,

*     Lineas ticket
      git_posdm_popup_l like ZretPOSDM001s12 occurs 0,
      gr_posdm_popup_l  like ZretPOSDM001s12,
*     Descuentos ticket
      git_posdm_popup_d like ZretPOSDM001s13 occurs 0,
      gr_posdm_popup_d  like ZretPOSDM001s13,
*     Metodos de pago ticket
      git_posdm_popup_m like ZretPOSDM001s14 occurs 0,
      gr_posdm_popup_m  like ZretPOSDM001s14,
*     Tareas
      git_posdm_popup_t like ZretPOSDM001s20 occurs 0,
      gr_posdm_popup_t  like ZretPOSDM001s20,

      git_cierre_dias   like ZretPOSDM001s18 occurs 0,
      gr_cierre_dias    like ZretPOSDM001s18,

      git_cierre_det   like ZretPOSDM001s19 occurs 0,
      gr_cierre_det    like ZretPOSDM001s19,

      gf_call_t4(1),


      gd_num_idocs      type int4,
      gd_num_idocs_51   type int4,
      gd_num_idocs_53   type int4,
      gd_num_idocs_64   type int4,
      gr_event_handler_17    TYPE REF TO lcl_event_handler,
      gr_event_handler_10    TYPE REF TO lcl_event_handler.

*==========================================================================
* TOOLBAR EVENT RECEIVER - Implementación
*==========================================================================
CLASS lcl_toolbar_event_receiver IMPLEMENTATION.

  METHOD on_function_selected.
*    DATA: ls_sflight TYPE sflight.
*    CASE fcode.
*      WHEN 'DELETE'.
**       get selected node
*        DATA: lt_selected_node TYPE lvc_t_nkey.
*        CALL METHOD tree1->get_selected_nodes
*          CHANGING
*            ct_selected_nodes = lt_selected_node.
*        CALL METHOD cl_gui_cfw=>flush.
*        DATA l_selected_node TYPE lvc_nkey.
*        READ TABLE lt_selected_node INTO l_selected_node INDEX 1.
*
**       delete subtree
*        IF NOT l_selected_node IS INITIAL.
*          CALL METHOD tree1->delete_subtree
*            EXPORTING
*              i_node_key                = l_selected_node
*              i_update_parents_expander = ''
*              i_update_parents_folder   = 'X'.
*        ELSE.
*          MESSAGE i227(0h).
*        ENDIF.
*      WHEN 'INSERT_LC'.
**       get selected node
*        CALL METHOD tree1->get_selected_nodes
*          CHANGING
*            ct_selected_nodes = lt_selected_node.
*        CALL METHOD cl_gui_cfw=>flush.
*        READ TABLE lt_selected_node INTO l_selected_node INDEX 1.
**       get current Line
*        IF NOT l_selected_node IS INITIAL.
*          CALL METHOD tree1->get_outtab_line
*            EXPORTING
*              i_node_key    = l_selected_node
*            IMPORTING
*              e_outtab_line = ls_sflight.
*          ls_sflight-seatsmax = ls_sflight-price + 99.
*          ls_sflight-price = ls_sflight-seatsmax + '99.99'.
*          CALL METHOD tree1->add_node
*            EXPORTING
*              i_relat_node_key = l_selected_node
*              i_relationship   = cl_tree_control_base=>relat_last_child
*              is_outtab_line   = ls_sflight
**             is_node_layout
**             it_item_layout
*              i_node_text      = 'Last Child'.              "#EC NOTEXT
**           importing
**             e_new_node_key
*        ELSE.
*          MESSAGE i227(0h).
*        ENDIF.
*      WHEN 'INSERT_FC'.
**       get selected node
*        CALL METHOD tree1->get_selected_nodes
*          CHANGING
*            ct_selected_nodes = lt_selected_node.
*        CALL METHOD cl_gui_cfw=>flush.
*        READ TABLE lt_selected_node INTO l_selected_node INDEX 1.
**       get current Line
*        IF NOT l_selected_node IS INITIAL.
*          CALL METHOD tree1->get_outtab_line
*            EXPORTING
*              i_node_key    = l_selected_node
*            IMPORTING
*              e_outtab_line = ls_sflight.
*          ls_sflight-seatsmax = ls_sflight-price + 99.
*          ls_sflight-price = ls_sflight-seatsmax + '99.99'.
*          CALL METHOD tree1->add_node
*            EXPORTING
*              i_relat_node_key = l_selected_node
*              i_relationship   = cl_tree_control_base=>relat_first_child
*              is_outtab_line   = ls_sflight
**             is_node_layout
**             it_item_layout
*              i_node_text      = 'First Child'.             "#EC NOTEXT
**           importing
**             e_new_node_key
*        ELSE.
*          MESSAGE i227(0h).
*        ENDIF.
*      WHEN 'INSERT_FS'.
**       get selected node
*        CALL METHOD tree1->get_selected_nodes
*          CHANGING
*            ct_selected_nodes = lt_selected_node.
*        CALL METHOD cl_gui_cfw=>flush.
*        READ TABLE lt_selected_node INTO l_selected_node INDEX 1.
**       get current Line
*        IF NOT l_selected_node IS INITIAL.
*          CALL METHOD tree1->get_outtab_line
*            EXPORTING
*              i_node_key    = l_selected_node
*            IMPORTING
*              e_outtab_line = ls_sflight.
*          ls_sflight-seatsmax = ls_sflight-price + 99.
*          ls_sflight-price = ls_sflight-seatsmax + '99.99'.
*          CALL METHOD tree1->add_node
*            EXPORTING
*              i_relat_node_key = l_selected_node
*              i_relationship   =
*                             cl_tree_control_base=>relat_first_sibling
*              is_outtab_line   = ls_sflight
**             is_node_layout
**             it_item_layout
*              i_node_text      = 'First Sibling'.           "#EC NOTEXT
**           importing
**             e_new_node_key
*        ELSE.
*          MESSAGE i227(0h).
*        ENDIF.
*      WHEN 'INSERT_LS'.
**       get selected node
*        CALL METHOD tree1->get_selected_nodes
*          CHANGING
*            ct_selected_nodes = lt_selected_node.
*        CALL METHOD cl_gui_cfw=>flush.
*        READ TABLE lt_selected_node INTO l_selected_node INDEX 1.
**       get current Line
*        IF NOT l_selected_node IS INITIAL.
*          CALL METHOD tree1->get_outtab_line
*            EXPORTING
*              i_node_key    = l_selected_node
*            IMPORTING
*              e_outtab_line = ls_sflight.
*          ls_sflight-seatsmax = ls_sflight-price + 99.
*          ls_sflight-price = ls_sflight-seatsmax + '99.99'.
*          CALL METHOD tree1->add_node
*            EXPORTING
*              i_relat_node_key = l_selected_node
*              i_relationship   =
*                             cl_tree_control_base=>relat_last_sibling
*              is_outtab_line   = ls_sflight
**             is_node_layout
**             it_item_layout
*              i_node_text      = 'Last Sibling'.            "#EC NOTEXT
**           importing
**             e_new_node_key
*        ELSE.
*          MESSAGE i227(0h).
*        ENDIF.
*      WHEN 'INSERT_NS'.
**       get selected node
*        CALL METHOD tree1->get_selected_nodes
*          CHANGING
*            ct_selected_nodes = lt_selected_node.
*        CALL METHOD cl_gui_cfw=>flush.
*        READ TABLE lt_selected_node INTO l_selected_node INDEX 1.
**       get current Line
*        IF NOT l_selected_node IS INITIAL.
*          CALL METHOD tree1->get_outtab_line
*            EXPORTING
*              i_node_key    = l_selected_node
*            IMPORTING
*              e_outtab_line = ls_sflight.
*          ls_sflight-seatsmax = ls_sflight-price + 99.
*          ls_sflight-price = ls_sflight-seatsmax + '99.99'.
*          CALL METHOD tree1->add_node
*            EXPORTING
*              i_relat_node_key = l_selected_node
*              i_relationship   =
*                             cl_tree_control_base=>relat_next_sibling
*              is_outtab_line   = ls_sflight
**             is_node_layout
**             it_item_layout
*              i_node_text      = 'Next Sibling'.            "#EC NOTEXT
**           importing
**             e_new_node_key
*        ELSE.
*          MESSAGE i227(0h).
*        ENDIF.
*
*    ENDCASE.
**   update frontend
*    CALL METHOD tree1->frontend_update.
  ENDMETHOD.                    "on_function_selected

  METHOD on_toolbar_dropdown.
**   create contextmenu
*    DATA: l_menu TYPE REF TO cl_ctmenu,
*          l_fc_handled TYPE as4flag.
*
*    CREATE OBJECT l_menu.
*    CLEAR l_fc_handled.
*
*    CASE fcode.
*      WHEN 'INSERT_LC'.
*        l_fc_handled = 'X'.
**       insert as last child
*        CALL METHOD l_menu->add_function
*          EXPORTING
*            fcode = 'INSERT_LC'
*            text  = 'Insert New Line as Last Child'.        "#EC NOTEXT
**       insert as first child
*        CALL METHOD l_menu->add_function
*          EXPORTING
*            fcode = 'INSERT_FC'
*            text  = 'Insert New Line as First Child'.       "#EC NOTEXT
**       insert as next sibling
*        CALL METHOD l_menu->add_function
*          EXPORTING
*            fcode = 'INSERT_NS'
*            text  = 'Insert New Line as Next Sibling'.      "#EC NOTEXT
**       insert as last sibling
*        CALL METHOD l_menu->add_function
*          EXPORTING
*            fcode = 'INSERT_LS'
*            text  = 'Insert New Line as Last Sibling'.      "#EC NOTEXT
**       insert as first sibling
*        CALL METHOD l_menu->add_function
*          EXPORTING
*            fcode = 'INSERT_FS'
*            text  = 'Insert New Line as First Sibling'.     "#EC NOTEXT
*    ENDCASE.
*
** show dropdownbox
*    IF l_fc_handled = 'X'.
*      CALL METHOD mr_toolbar->track_context_menu
*        EXPORTING
*          context_menu = l_menu
*          posx         = posx
*          posy         = posy.
*    ENDIF.

  ENDMETHOD.                    "on_toolbar_dropdown
ENDCLASS.                    "lcl_toolbar_event_receiver IMPLEMENTATION

*======================================================================
* CLASES: DEFINICIONES
*======================================================================
CLASS lcl_tree_event_handler DEFINITION.
  PUBLIC SECTION.
    methods: HANDLE_ITEM_DOUBLE_CLICK for event ITEM_DOUBLE_CLICK of cl_gui_alv_tree
                                      importing FIELDNAME
                                                NODE_KEY,

             HANDLE_NODE_DOUBLE_CLICK for event NODE_DOUBLE_CLICK of cl_gui_alv_tree
                                      importing NODE_KEY.
                      .
endclass.

*======================================================================
* CLASES: DEFINICIONES
*======================================================================
CLASS lcl_alv_grid_event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS:
      handle_hotspot_click_alv_08 FOR EVENT hotspot_click OF cl_gui_alv_grid
                                  IMPORTING e_row_id
                                            e_column_id
                                            es_row_no,
      handle_hotspot_click_alv_16 FOR EVENT hotspot_click OF cl_gui_alv_grid
                                  IMPORTING e_row_id
                                            e_column_id
                                            es_row_no.
endclass.


*======================================================================
* CLASES: IMPLEMENTACIONES
*======================================================================
CLASS lcl_alv_grid_event_handler IMPLEMENTATION.
  METHOD handle_hotspot_click_alv_08.
    PERFORM f_handle_hotspot_click_alv_08 USING  e_row_id
                                                 e_column_id
                                                 es_row_no.
  ENDMETHOD.

  METHOD handle_hotspot_click_alv_16.
    PERFORM f_handle_hotspot_click_alv_16 USING  e_row_id
                                                 e_column_id
                                                 es_row_no.
  ENDMETHOD.

ENDCLASS.

*======================================================================
* CLASES: IMPLEMENTACIONES
*======================================================================
CLASS lcl_tree_event_handler IMPLEMENTATION.
  method HANDLE_ITEM_DOUBLE_CLICK.
    perform f_handle_item_double_click using fieldname
                                             NODE_KEY.

  ENDMETHOD.

  method HANDLE_node_DOUBLE_CLICK.
    perform f_handle_node_double_click using NODE_KEY.
  ENDMETHOD.
endclass.

*==========================================================================
* ALV GRID
*==========================================================================
DATA: gr_grid_01                TYPE REF TO cl_gui_alv_grid,
      gr_container_01           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_01       TYPE lvc_t_fcat,
      gr_layout_01              TYPE lvc_s_layo,
      gr_grid_02                TYPE REF TO cl_gui_alv_grid,
      gr_container_02           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_02       TYPE lvc_t_fcat,
      gr_layout_02              TYPE lvc_s_layo,
      gr_grid_03                TYPE REF TO cl_gui_alv_grid,
      gr_container_03           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_03       TYPE lvc_t_fcat,
      gr_layout_03              TYPE lvc_s_layo,
      gr_grid_04                TYPE REF TO cl_gui_alv_grid,
      gr_container_04           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_04       TYPE lvc_t_fcat,
      gr_layout_04              TYPE lvc_s_layo,
      gr_grid_05                TYPE REF TO cl_gui_alv_grid,
      gr_container_05           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_05       TYPE lvc_t_fcat,
      gr_layout_05              TYPE lvc_s_layo,
      gr_grid_06                TYPE REF TO cl_gui_alv_grid,
      gr_container_06           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_06       TYPE lvc_t_fcat,
      gr_layout_06              TYPE lvc_s_layo,
      gr_grid_07                TYPE REF TO cl_gui_alv_grid,
      gr_container_07           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_07       TYPE lvc_t_fcat,
      gr_layout_07              TYPE lvc_s_layo,

      gr_grid_08                TYPE REF TO cl_gui_alv_grid,
      gr_container_08           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_08       TYPE lvc_t_fcat,
      gr_layout_08              TYPE lvc_s_layo,

      gr_grid_09                TYPE REF TO cl_gui_alv_grid,
      gr_container_09           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_09       TYPE lvc_t_fcat,
      gr_layout_09              TYPE lvc_s_layo,

      gr_grid_10                TYPE REF TO cl_gui_alv_grid,
      gr_container_10           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_10       TYPE lvc_t_fcat,
      gr_layout_10              TYPE lvc_s_layo,

      gr_grid_11                TYPE REF TO cl_gui_alv_grid,
      gr_container_11           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_11       TYPE lvc_t_fcat,
      gr_layout_11              TYPE lvc_s_layo,

      gr_grid_12                TYPE REF TO cl_gui_alv_grid,
      gr_container_12           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_12       TYPE lvc_t_fcat,
      gr_layout_12              TYPE lvc_s_layo,

      gr_grid_13                TYPE REF TO cl_gui_alv_grid,
      gr_container_13           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_13       TYPE lvc_t_fcat,
      gr_layout_13              TYPE lvc_s_layo,

      gr_grid_14                TYPE REF TO cl_gui_alv_grid,
      gr_container_14           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_14       TYPE lvc_t_fcat,
      gr_layout_14              TYPE lvc_s_layo,

      gr_grid_15                TYPE REF TO cl_gui_alv_grid,
      gr_container_15           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_15       TYPE lvc_t_fcat,
      gr_layout_15              TYPE lvc_s_layo,

      gr_grid_16                TYPE REF TO cl_gui_alv_grid,
      gr_container_16           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_16       TYPE lvc_t_fcat,
      gr_layout_16              TYPE lvc_s_layo,

      gr_grid_17                TYPE REF TO cl_gui_alv_grid,
      gr_container_17           TYPE REF TO cl_gui_custom_container,
      git_fieldcatalog_17       TYPE lvc_t_fcat,
      gr_layout_17              TYPE lvc_s_layo,

      gr_tree_01                TYPE REF TO cl_gui_alv_tree,
      gr_tree_container_01      TYPE REF TO cl_gui_custom_container,
      git_tree_fieldcatalog_01  TYPE lvc_t_fcat,
      gr_tree_toolbar_01        TYPE REF TO cl_gui_toolbar,
      gr_tree_toolbar_er_01 TYPE REF TO lcl_toolbar_event_receiver.

data: gr_event_handler_tree     TYPE REF TO lcl_tree_event_handler,
      gr_event_handler_08       TYPE REF TO lcl_alv_grid_event_handler,
      gr_event_handler_16       TYPE REF TO lcl_alv_grid_event_handler.
