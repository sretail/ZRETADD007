*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM003_FORMS
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form f_start_of_selection
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_start_of_selection .
*===================================================================================================
* 0.- Declaración de variables
*===================================================================================================
  DATA: lit_dir_list                    LIKE eps2fili OCCURS 0 WITH HEADER LINE,
        ld_fichero                      TYPE string,
        ld_linea_xml                    TYPE string,
        lit_xml                         LIKE zretposdm003s01 OCCURS 0 WITH HEADER LINE,
        lit_idoc_containers             LIKE edidd OCCURS 0 WITH HEADER LINE,
        lr_idoc_control_new             LIKE edidc,
        lr_idoc_control                 LIKE edidc,
        lf_error                        LIKE sy-subrc,
        ld_kunnr_tienda                 TYPE kunnr,
        ld_segnum                       TYPE idocdsgnum,
        ld_segnum_cab                   TYPE idocdsgnum,
        ld_identifier                   LIKE edidc-docnum,
        ld_status                       LIKE edidc-status,
        ld_linea                        TYPE numc2,
        lr_edidc                        LIKE edidc,
        lr_zzposdwe1postr_createmultip  LIKE zzposdwe1postr_createmultip,
        lr_zzposdwe1bpsourcedocumentli  LIKE zzposdwe1bpsourcedocumentli,
        lr_zztransaction                LIKE zzposdwe1bptransaction,

        lit_zzlineitem                  LIKE zzposdwe1bpretaillineitem OCCURS 0 WITH HEADER LINE,
*       Formas de pago
        lit_zztender                    LIKE ZZPOSDWE1BPTENDER OCCURS 0 WITH HEADER LINE,
*       Información cliente
        lit_zzcustdetails               like ZZPOSDWE1BPCUSTOMERDETAILS OCCURS 0 WITH HEADER LINE,
*       Descuentos posición
        lit_zzlineitemdisc              like ZZPOSDWE1BPLINEITEMDISCOUNT OCCURS 0 WITH HEADER LINE,
*       Descuentos posición - Datos adicionales
        lit_ZZLINEITEMDISCEX            like ZZPOSDWE1BPLINEITEMDISCEXT occurs 0 WITH HEADER LINE.

*===================================================================================================
* 1.- Lógica
*===================================================================================================

*>Cargar tickets de venta de CMZ
  PERFORM f_get_ficheros_tpv TABLES lit_dir_list
                              USING p_folin.

  LOOP AT lit_dir_list WHERE name(4) = 'VCAN'.
*  >Inicializar datos
    CLEAR: 	lr_idoc_control,
            ld_identifier,
            lf_error,
            ld_segnum,
            ld_segnum_cab,
            ld_linea_xml,
            git_monitor.

    REFRESH: lit_idoc_containers,
             lit_xml.

    CONCATENATE p_folin lit_dir_list-name INTO ld_fichero.

    OPEN DATASET ld_fichero FOR INPUT IN TEXT MODE ENCODING DEFAULT.

    IF sy-subrc = 0.

      DO.
        READ DATASET ld_fichero INTO ld_linea_xml.

        IF sy-subrc <> 0.
          EXIT.
        ELSE.
          lit_xml-linea = ld_linea_xml.
          condense lit_xml-linea.
          APPEND lit_xml.
        ENDIF.
      ENDDO.

      CLOSE DATASET ld_fichero.
    ENDIF.

    PERFORM f_fill_edidc
      TABLES
        lit_xml
      CHANGING
        lr_edidc.

    PERFORM f_fill_zzposdwe1postr_createm
      TABLES
        lit_xml
      CHANGING
        lr_zzposdwe1postr_createmultip.

    perform f_fill_zzposdwe1bpsourcedocume
      tables
        lit_xml
      CHANGING
        lr_ZZPOSDWE1BPSOURCEDOCUMENTLI.

    perform f_fill_zztransaction
      tables
        lit_xml
      CHANGING
        lr_zztransaction.

    git_monitor-name          = lit_dir_list-name.
    git_monitor-RETAILSTOREID = lr_zztransaction-retailstoreid.
    git_monitor-BUSINESSDAYDATE = lr_zztransaction-businessdaydate.
    git_monitor-TRANSACTIONTYPECODE = lr_zztransaction-transactiontypecode.
    git_monitor-WORKSTATIONID = lr_zztransaction-workstationid.
    git_monitor-TRANSACTIONSEQUENCENUMBER = lr_zztransaction-transactionsequencenumber.

    perform f_fill_zzlineitem
      tables
        lit_xml
        lit_zzlineitem.

    perform f_fill_zztender
      tables
        lit_xml
        lit_zztender.

    perform f_fill_zzcustdetails
      tables
        lit_xml
        lit_zzcustdetails.

    perform f_fill_zzlineitemdisc
      tables
        lit_xml
         lit_zzlineitemdisc.

    perform f_fill_zzlineitemdiscex
      tables
        lit_xml
        lit_ZZLINEITEMDISCEX.

    ADD 1 TO ld_segnum.
    CLEAR lit_idoc_containers.
    lit_idoc_containers-segnam  = 'ZZPOSDWE1POSTR_CREATEMULTIP'.
    lit_idoc_containers-sdata   = lr_ZZPOSDWE1POSTR_CREATEMULTIP.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    APPEND lit_idoc_containers.
    ld_segnum_cab = ld_segnum.

    ADD 1 TO ld_segnum.
    CLEAR lit_idoc_containers.
    lit_idoc_containers-segnam  = 'ZZPOSDWE1BPSOURCEDOCUMENTLI'.
    lit_idoc_containers-sdata   = lr_ZZPOSDWE1BPSOURCEDOCUMENTLI.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

    ADD 1 TO ld_segnum.
    CLEAR lit_idoc_containers.
    lit_idoc_containers-segnam  = 'ZZPOSDWE1BPTRANSACTION'.
    lit_idoc_containers-sdata   = lr_zztransaction.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

    loop at lit_zzcustdetails.
      ADD 1 TO ld_segnum.
      CLEAR lit_idoc_containers.
      lit_idoc_containers-segnam  = 'ZZPOSDWE1BPCUSTOMERDETAILS'.
      lit_idoc_containers-sdata   = lit_zzcustdetails.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    endloop.

    loop at lit_zzlineitem.
      ADD 1 TO ld_segnum.
      CLEAR lit_idoc_containers.
      lit_idoc_containers-segnam  = 'ZZPOSDWE1BPRETAILLINEITEM'.
      lit_idoc_containers-sdata   = lit_zzlineitem.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    endloop.

    loop at lit_zzlineitemdisc.
      ADD 1 TO ld_segnum.
      CLEAR lit_idoc_containers.
      lit_idoc_containers-segnam  = 'ZZPOSDWE1BPLINEITEMDISCOUNT'.
      lit_idoc_containers-sdata   = lit_zzlineitemdisc.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    endloop.

    loop at lit_zzlineitemdiscex.
      ADD 1 TO ld_segnum.
      CLEAR lit_idoc_containers.
      lit_idoc_containers-segnam  = 'ZZPOSDWE1BPLINEITEMDISCEXT'.
      lit_idoc_containers-sdata   = lit_zzlineitemdiscex.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    endloop.

    loop at lit_zztender.
      ADD 1 TO ld_segnum.
      CLEAR lit_idoc_containers.
      lit_idoc_containers-segnam  = 'ZZPOSDWE1BPTENDER'.
      lit_idoc_containers-sdata   = lit_zztender.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    endloop.

    PERFORM f_idoc_abrir
      USING
        lr_edidc-idoctp
        lr_edidc-mestyp
        lr_edidc-mescod
        lr_edidc-stdmes
        lr_edidc-sndpor
        lr_edidc-sndprt
        lr_edidc-sndprn
        lr_edidc-rcvpor
        lr_edidc-rcvprt
        lr_edidc-rcvprn
      CHANGING
        lr_idoc_control_new
        ld_identifier
        lf_error.

*  >Añadimos segmentos
    PERFORM f_idoc_add_segmentos  TABLES    lit_idoc_containers
                                  USING     ld_identifier
                                  CHANGING  lf_error.

*  >Cerramos IDOC
    PERFORM f_idoc_cerrar USING     ld_identifier
                          CHANGING  lr_idoc_control_new
                                    lf_error.

*  >Cambiamos STATUS al idoc
    PERFORM f_idoc_cambiar_status USING     lr_idoc_control_new-docnum '64'
                                  CHANGING  lf_error.

*  >Desbloquear idoc para su proceso
    COMMIT WORK AND WAIT.

    CALL FUNCTION 'DEQUEUE_ALL'
*       EXPORTING
*         _SYNCHRON       = ' '
      .


*  >Procesar idoc
    SUBMIT rbdapp01
      WITH docnum BETWEEN lr_idoc_control_new-docnum AND space
      WITH p_output = space
      AND RETURN.

    COMMIT WORK AND WAIT.

*  >Obtener status idoc
    git_monitor-DOCNUM =  lr_idoc_control_new-docnum.


    PERFORM f_get_status_idoc USING lr_idoc_control_new-docnum CHANGING git_monitor-DOCNUMS.
    PERFORM f_get_status_idoc_icon USING lr_idoc_control_new-docnum CHANGING git_monitor-DOCNUMI.

    append git_monitor.

    if lr_idoc_control_new-docnum is not initial.
      perform f_copiar_fichero
        using
          p_folin
          p_folpr
          lit_dir_list-name
        CHANGING
          lf_error.

      if lf_error = ''.
        perform f_borrar_fichero
          USING
            p_folin
            lit_dir_list-name
          CHANGING
            lf_Error.
      endif.
    endif.

  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  f_mover_fichero
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_copiar_fichero USING pe_carpeta_origen
                            pe_carpeta_destino
                            pe_fichero
                   CHANGING ps_error.


  DATA: ld_fichero_origen(200),
        ld_fichero_destino(200),
        ld_linea_xml TYPE string.

  CLEAR: ps_error.

  CONCATENATE pe_carpeta_origen
              pe_fichero
         INTO ld_fichero_origen.

  CONCATENATE pe_carpeta_destino
              pe_fichero
     INTO     ld_fichero_destino.


* Primero se copia el fichero al destino
  OPEN DATASET ld_fichero_origen FOR INPUT IN TEXT MODE ENCODING DEFAULT.

  IF sy-subrc = 0.
    open DATASET ld_fichero_destino for OUTPUT in TEXT MODE ENCODING DEFAULT.

    if sy-subrc = 0.

      DO.
        READ DATASET ld_fichero_origen INTO ld_linea_xml.

        IF sy-subrc <> 0.
          EXIT.
        ELSE.
          transfer ld_linea_xml to ld_fichero_destino.
        ENDIF.
      ENDDO.

      CLOSE DATASET ld_fichero_origen.
      close DATASET ld_fichero_destino.
    ENDIF.
  endif.
ENDFORM.                    " f_mover_fichero

*&---------------------------------------------------------------------*
*&      Form  f_borrar_fichero
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_borrar_fichero USING pe_carpeta_origen
                            pe_fichero
                    CHANGING ps_error.
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_fichero_borrado TYPE eps2filnam,
        ld_ruta_borrado    LIKE epsf-epsdirnam.

  ld_fichero_borrado = pe_fichero.
  ld_ruta_borrado = pe_carpeta_origen.

* 1.- Lógica
*==========================================================================
  CALL FUNCTION 'EPS_DELETE_FILE'
    EXPORTING
*     FILE_NAME              =
      iv_long_file_name      = ld_fichero_borrado
      dir_name               = ld_ruta_borrado
*     IV_LONG_DIR_NAME       =
*   IMPORTING
*     FILE_PATH              =
*     EV_LONG_FILE_PATH      =
    EXCEPTIONS
      invalid_eps_subdir     = 1
      sapgparam_failed       = 2
      build_directory_failed = 3
      no_authorization       = 4
      build_path_failed      = 5
      delete_failed          = 6
      OTHERS                 = 7.
  IF sy-subrc <> 0.
    ps_error = 'X'.
  ELSE.
    ps_error = ''.
  ENDIF.

ENDFORM.                    " f_borrar_fichero

*&---------------------------------------------------------------------*
*& Form F_GET_STATUS_IDOC @ v1.0
*&---------------------------------------------------------------------*
*& Devuelve un icono con el estado del idoc:
*&   51 = Rojo
*&   64 = Amarillo
*&   53 = Rojo
*&---------------------------------------------------------------------*
*      -->P_GIT_ZPOSDM001_DOCNUM  text
*      <--P_GIT_LISTADOT_STATUS_IDOC  text
*&---------------------------------------------------------------------*
FORM f_get_status_idoc_icon  USING    pe_docnum
                          CHANGING ps_status_idoc.
*==========================================================================
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_status LIKE edidc-status.

*==========================================================================
* 1.- Lógica
*==========================================================================
  SELECT SINGLE status
    FROM edidc
    INTO ld_status
   WHERE docnum = pe_docnum.

  CASE ld_status.
    WHEN '51' or '63'.
      ps_status_idoc = gc_minisemaforo_rojo.
    WHEN '64'.
      ps_status_idoc = gc_minisemaforo_ambar.
    WHEN '53'.
      ps_status_idoc = gc_minisemaforo_verde.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  f_idoc_add_segmentos
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->PE_IT_IDOC_CONTAINERS  text
*      -->PE_IDENTIFIER          text
*      -->PS_ERROR               text
*----------------------------------------------------------------------*
FORM f_idoc_add_segmentos TABLES   pe_it_idoc_containers STRUCTURE edidd
                          USING    pe_identifier
                          CHANGING ps_error.

  CLEAR ps_error.

  CALL FUNCTION 'EDI_SEGMENTS_ADD_BLOCK'
    EXPORTING
      identifier                    = pe_identifier
    TABLES
      idoc_containers               = pe_it_idoc_containers
    EXCEPTIONS
      identifier_invalid            = 1
      idoc_containers_empty         = 2
      parameter_error               = 3
      segment_number_not_sequential = 4
      OTHERS                        = 5.

  IF sy-subrc <> 0.
    ps_error = sy-subrc.
  ENDIF.

ENDFORM.                    "f_add_segmentos

*&---------------------------------------------------------------------*
*&      Form  f_idoc_cambiar_status
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->PE_NUMIDOC text
*      -->PE_STATUS  text
*      -->PS_ERROR   text
*----------------------------------------------------------------------*
FORM f_idoc_cambiar_status  USING    pe_numidoc
                                     pe_status
                            CHANGING ps_error.
* 0.- Declaracion de variables
*=======================================================================
  DATA: lt_edids TYPE TABLE OF bdidocstat WITH HEADER LINE.

* 1.- Logica
*=======================================================================
  CLEAR ps_error.

  CLEAR lt_edids.
  lt_edids-docnum   = pe_numidoc.
  lt_edids-status   = pe_status.
  lt_edids-uname    = sy-uname.
  lt_edids-repid    = sy-repid.
  lt_edids-tid      = sy-tcode.
  APPEND lt_edids.

  CALL FUNCTION 'IDOC_STATUS_WRITE_TO_DATABASE'
    EXPORTING
      idoc_number               = pe_numidoc
    TABLES
      idoc_status               = lt_edids[]
    EXCEPTIONS
      idoc_foreign_lock         = 1
      idoc_not_found            = 2
      idoc_status_records_empty = 3
      idoc_status_invalid       = 4
      db_error                  = 5
      OTHERS                    = 6.

  IF sy-subrc <> 0.
    ps_error = sy-subrc.
  ENDIF.

ENDFORM.                    " F_CAMBIAR_STATUS_IDOC

*&---------------------------------------------------------------------*
*&      Form  f_idoc_cerrar
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->PE_IDENTIFIER        text
*      -->PS_IDOC_CONTROL_NEW  text
*      -->PS_ERROR             text
*----------------------------------------------------------------------*
FORM f_idoc_cerrar USING    pe_identifier
                   CHANGING ps_idoc_control_new LIKE edidc
                            ps_error.

  CLEAR ps_error.

  CALL FUNCTION 'EDI_DOCUMENT_CLOSE_CREATE'
    EXPORTING
      identifier          = pe_identifier
*     NO_DEQUEUE          = ' '
*     SYN_ACTIVE          = ' '
    IMPORTING
      idoc_control        = ps_idoc_control_new
*     SYNTAX_RETURN       =
    EXCEPTIONS
      document_not_open   = 1
      document_no_key     = 2
      failure_in_db_write = 3
      parameter_error     = 4
      OTHERS              = 5.
  IF sy-subrc <> 0.
    ps_error = sy-subrc.
  ENDIF.

ENDFORM.                    " F_IDOC_CERRAR

*===================================================================================================
*& Form F_GET_STATUS_IDOC
*===================================================================================================
*& Devuelve el código de status de un IDOC
*===================================================================================================
* Devuelve el status de un idoc
*===================================================================================================
FORM f_get_status_idoc  USING    pe_docnum
                        CHANGING ps_status.

  CLEAR ps_status.

  SELECT SINGLE status
    FROM edidc
    INTO ps_status
   WHERE docnum = pe_docnum.

ENDFORM.


FORM f_idoc_abrir  USING pe_doctyp
                         pe_mestyp
                         pe_mescod
                         pe_stdmes
                         pe_sndpor
                         pe_sndprt
                         pe_sndprn
                         pe_rcvpor
                         pe_rcvprt
                         pe_rcvprn
                   CHANGING ps_lr_idoc_control STRUCTURE edidc
                            ps_identifier
                            ps_error.

* 0.- Declaracion de variables
*=======================================================================
  DATA: lit_zretposdmp01 LIKE zretposdmp01 OCCURS 0 WITH HEADER LINE.

* 1.- Logica
*=======================================================================
* Inicializamos parámetros de salida
  CLEAR: ps_lr_idoc_control,
         ps_identifier,
         ps_error.

  SELECT *
    FROM zretposdmp01
    INTO TABLE lit_zretposdmp01
   WHERE para1 = 'ZRETPOSDM003'
     AND para2 = 'ZZCREATEMULTIPLE_EDIDC'.

  LOOP AT lit_zretposdmp01.
    CASE lit_zretposdmp01-valo1.
      WHEN 'DOCREL'.
        ps_lr_idoc_control-docrel = lit_zretposdmp01-valo2.
      WHEN 'DIRECT'.
        ps_lr_idoc_control-direct = lit_zretposdmp01-valo2.
      WHEN 'TEST'.
        ps_lr_idoc_control-test   = lit_zretposdmp01-valo2.
      WHEN 'STDVRS'.
        ps_lr_idoc_control-stdvrs = lit_zretposdmp01-valo2.
      WHEN 'SNDLAD'.
        ps_lr_idoc_control-sndlad = lit_zretposdmp01-valo2.
      WHEN 'MESFCT'.
        ps_lr_idoc_control-mesfct = lit_zretposdmp01-valo2.
    ENDCASE.
  ENDLOOP.


  ps_lr_idoc_control-rcvpor = pe_rcvpor.
  ps_lr_idoc_control-rcvprt = pe_rcvprt.
  ps_lr_idoc_control-rcvprn = pe_rcvprn.
  ps_lr_idoc_control-stdmes = pe_stdmes.
  ps_lr_idoc_control-sndpor = pe_sndpor.
  ps_lr_idoc_control-sndprt = pe_sndprt.
  ps_lr_idoc_control-sndprn = pe_sndprn.
  ps_lr_idoc_control-mestyp = pe_mestyp.
  ps_lr_idoc_control-idoctp = pe_doctyp.
  ps_lr_idoc_control-mescod = pe_mescod.

  CONCATENATE sy-datum sy-uzeit INTO ps_lr_idoc_control-serial.

* Abrir creacion del IDOC
  CALL FUNCTION 'EDI_DOCUMENT_OPEN_FOR_CREATE'
    EXPORTING
      idoc_control         = ps_lr_idoc_control
*     PI_RFC_MULTI_CP      = '    '
    IMPORTING
      identifier           = ps_identifier
    EXCEPTIONS
      other_fields_invalid = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
    ps_error = sy-subrc.
  ENDIF.


ENDFORM.                    " F_IDOC_ABRIR



FORM f_get_ficheros_tpv  TABLES   it_dir_list STRUCTURE eps2fili
                         USING    pe_dir_name.

  DATA: ld_dir_name   TYPE eps2filnam.

  ld_dir_name = p_folin.

  CALL FUNCTION 'EPS2_GET_DIRECTORY_LISTING'
    EXPORTING
      iv_dir_name            = ld_dir_name
*     FILE_MASK              = ' '
*   IMPORTING
*     DIR_NAME               =
*     FILE_COUNTER           =
*     ERROR_COUNTER          =
    TABLES
      dir_list               = it_dir_list
    EXCEPTIONS
      invalid_eps_subdir     = 1
      sapgparam_failed       = 2
      build_directory_failed = 3
      no_authorization       = 4
      read_directory_failed  = 5
      too_many_read_errors   = 6
      empty_directory_list   = 7
      OTHERS                 = 8.
  IF sy-subrc <> 0.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_initialization
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_initialization .

*>Carpetas por defecto
  SELECT SINGLE valo1
    FROM zretposdmp01
    INTO p_folin
   WHERE para1 = 'ZRETPOSDM003'
     AND para2 = 'FOLIN'.

  SELECT SINGLE valo1
    FROM zretposdmp01
    INTO p_folpr
   WHERE para1 = 'ZRETPOSDM003'
     AND para2 = 'FOLPR'.

  SELECT SINGLE valo1
    FROM zretposdmp01
    INTO p_foler
   WHERE para1 = 'ZRETPOSDM003'
     AND para2 = 'FOLER'.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_fill_edidc
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LD_XML
*&      <-- LR_EDIDC
*&---------------------------------------------------------------------*
FORM f_fill_edidc  TABLES   lit_xml  STRUCTURE zretposdm003s01
                   CHANGING ps_edidc LIKE edidc.

  DATA: lf_start.

  CLEAR ps_edidc.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</EDI_DC40>'.
      EXIT.
    ENDIF.

    IF lit_xml-linea = '<EDI_DC40 SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    if lit_xml-linea cs '<IDOCTYP>'.
      replace '<IDOCTYP>' IN lit_xml-linea WITH ''.
      REPLACE '</IDOCTYP>' IN lit_xml-linea WITH ''.

      ps_edidc-idoctp = lit_xml-linea.
    endif.

    IF lit_xml-linea CS '<MESTYP>'.
      REPLACE '<MESTYP>' IN lit_xml-linea WITH ''.
      REPLACE '</MESTYP>' IN lit_xml-linea WITH ''.

      ps_edidc-mestyp = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<MESCOD>'.
      REPLACE '<MESCOD>' IN lit_xml-linea WITH ''.
      REPLACE '</MESCOD>' IN lit_xml-linea WITH ''.

      ps_edidc-mescod = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<STDMES>'.
      REPLACE '<STDMES>' IN lit_xml-linea WITH ''.
      REPLACE '</STDMES>' IN lit_xml-linea WITH ''.

      ps_edidc-stdmes = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<SNDPOR>'.
      REPLACE '<SNDPOR>' IN lit_xml-linea WITH ''.
      REPLACE '</SNDPOR>' IN lit_xml-linea WITH ''.

      ps_edidc-sndpor = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<SNDPRT>'.
      REPLACE '<SNDPRT>' IN lit_xml-linea WITH ''.
      REPLACE '</SNDPRT>' IN lit_xml-linea WITH ''.

      ps_edidc-sndprt = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<SNDPRN>'.
      REPLACE '<SNDPRN>' IN lit_xml-linea WITH ''.
      REPLACE '</SNDPRN>' IN lit_xml-linea WITH ''.

      ps_edidc-sndprn = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<RCVPOR>'.
      REPLACE '<RCVPOR>' IN lit_xml-linea WITH ''.
      REPLACE '</RCVPOR>' IN lit_xml-linea WITH ''.

      ps_edidc-rcvpor = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<RCVPRT>'.
      REPLACE '<RCVPRT>' IN lit_xml-linea WITH ''.
      REPLACE '</RCVPRT>' IN lit_xml-linea WITH ''.

      ps_edidc-rcvprt = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<RCVPRN>'.
      REPLACE '<RCVPRN>' IN lit_xml-linea WITH ''.
      REPLACE '</RCVPRN>' IN lit_xml-linea WITH ''.

      ps_edidc-rcvprn = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<SNDPRN>'.
      REPLACE '<SNDPRN>' IN lit_xml-linea WITH ''.
      REPLACE '</SNDPRN>' IN lit_xml-linea WITH ''.

      ps_edidc-rcvprn = lit_xml-linea.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM f_fill_zzposdwe1postr_createm  TABLES lit_xml  STRUCTURE zretposdm003s01
                                  CHANGING ps_zzposdwe1postr_createmultip LIKE zzposdwe1postr_createmultip.


  DATA: lf_start.

  CLEAR ps_zzposdwe1postr_createmultip.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</ZZPOSDWE1POSTR_CREATEMULTIP>'.
      EXIT.
    ENDIF.

    IF lit_xml-linea = '<ZZPOSDWE1POSTR_CREATEMULTIP SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS '<I_LOCKWAIT>'.
      REPLACE '<I_LOCKWAIT>' IN lit_xml-linea WITH ''.
      REPLACE '</I_LOCKWAIT>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1postr_createmultip-i_lockwait = lit_xml-linea.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM f_fill_zzposdwe1bpsourcedocume TABLES lit_xml  STRUCTURE zretposdm003s01
                                  CHANGING ps_zzposdwe1bpsourcedocumentli LIKE zzposdwe1bpsourcedocumentli.


  DATA: lf_start.

  CLEAR ps_zzposdwe1bpsourcedocumentli.

  LOOP AT lit_xml.
    IF lit_xml-linea = '<ZZPOSDWE1BPSOURCEDOCUMENTLI>'.
      EXIT.
    ENDIF.

    IF lit_xml-linea = '<ZZPOSDWE1BPSOURCEDOCUMENTLI SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS '<KEY>'.
      REPLACE '<KEY>' IN lit_xml-linea WITH ''.
      REPLACE '</KEY>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bpsourcedocumentli-key = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<TYPE>'.
      REPLACE '<TYPE>' IN lit_xml-linea WITH ''.
      REPLACE '</TYPE>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bpsourcedocumentli-type = lit_xml-linea.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM f_fill_zztransaction TABLES lit_xml  STRUCTURE zretposdm003s01
                                  CHANGING ps_zzposdwe1bptransaction LIKE zzposdwe1bptransaction.


  DATA: lf_start.

  CLEAR ps_zzposdwe1bptransaction.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</ZZPOSDWE1BPTRANSACTION>'.
      EXIT.
    ENDIF.

    IF lit_xml-linea = '<ZZPOSDWE1BPTRANSACTION SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS '<RETAILSTOREID>'.
      REPLACE '<RETAILSTOREID>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSTOREID>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-retailstoreid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<BUSINESSDAYDATE>'.
      REPLACE '<BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.
      REPLACE '</BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-businessdaydate = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<TRANSACTIONTYPECODE>'.
      REPLACE '<TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-transactiontypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<WORKSTATIONID>'.
      REPLACE '<WORKSTATIONID>' IN lit_xml-linea WITH ''.
      REPLACE '</WORKSTATIONID>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-workstationid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<TRANSACTIONSEQUENCENUMBER>'.
      REPLACE '<TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-transactionsequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<BEGINDATETIMESTAMP>'.
      REPLACE '<BEGINDATETIMESTAMP>' IN lit_xml-linea WITH ''.
      REPLACE '</BEGINDATETIMESTAMP>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-begindatetimestamp = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<ENDDATETIMESTAMP>'.
      REPLACE '<ENDDATETIMESTAMP>' IN lit_xml-linea WITH ''.
      REPLACE '</ENDDATETIMESTAMP>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-enddatetimestamp = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<DEPARTMENT>'.
      REPLACE '<DEPARTMENT>' IN lit_xml-linea WITH ''.
      REPLACE '</DEPARTMENT>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-department = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<OPERATORQUALIFIER>'.
      REPLACE '<OPERATORQUALIFIER>' IN lit_xml-linea WITH ''.
      REPLACE '</OPERATORQUALIFIER>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-operatorqualifier = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<OPERATORID>'.
      REPLACE '<OPERATORID>' IN lit_xml-linea WITH ''.
      REPLACE '</OPERATORID>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-operatorid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<TRANSACTIONCURRENCY>'.
      REPLACE '<TRANSACTIONCURRENCY>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONCURRENCY>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-transactioncurrency = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<PARTNERQUALIFIER>'.
      REPLACE '<PARTNERQUALIFIER>' IN lit_xml-linea WITH ''.
      REPLACE '</PARTNERQUALIFIER>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-partnerqualifier = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<PARTNERID>'.
      REPLACE '<PARTNERID>' IN lit_xml-linea WITH ''.
      REPLACE '</PARTNERID>' IN lit_xml-linea WITH ''.

      ps_zzposdwe1bptransaction-partnerid = lit_xml-linea.
    ENDIF.
  ENDLOOP.
ENDFORM.


FORM f_fill_zzlineitem TABLES lit_xml  STRUCTURE zretposdm003s01
                                           lit_zzposdwe1bpretaillineitem STRUCTURE zzposdwe1bpretaillineitem.


  DATA: lf_start.

  CLEAR: lit_zzposdwe1bpretaillineitem.
  REFRESH: lit_zzposdwe1bpretaillineitem.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</ZZPOSDWE1BPRETAILLINEITEM>'.
      APPEND lit_zzposdwe1bpretaillineitem.
      CLEAR lf_start.
    ENDIF.


    IF lit_xml-linea = '<ZZPOSDWE1BPRETAILLINEITEM SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS '<RETAILSTOREID>'.
      REPLACE '<RETAILSTOREID>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSTOREID>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-retailstoreid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<BUSINESSDAYDATE>'.
      REPLACE '<BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.
      REPLACE '</BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-businessdaydate = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<TRANSACTIONTYPECODE>'.
      REPLACE '<TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-transactiontypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<WORKSTATIONID>'.
      REPLACE '<WORKSTATIONID>' IN lit_xml-linea WITH ''.
      REPLACE '</WORKSTATIONID>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-workstationid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<TRANSACTIONSEQUENCENUMBER>'.
      REPLACE '<TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-transactionsequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<RETAILSEQUENCENUMBER>'.
      REPLACE '<RETAILSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-retailsequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<RETAILTYPECODE>'.
      REPLACE '<RETAILTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-retailtypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<ITEMIDQUALIFIER>'.
      REPLACE '<ITEMIDQUALIFIER>' IN lit_xml-linea WITH ''.
      REPLACE '</ITEMIDQUALIFIER>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-itemidqualifier = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<ITEMID>'.
      REPLACE '<ITEMID>' IN lit_xml-linea WITH ''.
      REPLACE '</ITEMID>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-itemid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<RETAILQUANTITY>'.
      REPLACE '<RETAILQUANTITY>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILQUANTITY>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-retailquantity = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<SALESAMOUNT>'.
      REPLACE '<SALESAMOUNT>' IN lit_xml-linea WITH ''.
      REPLACE '</SALESAMOUNT>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-salesamount = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<NORMALSALESAMOUNT>'.
      REPLACE '<NORMALSALESAMOUNT>' IN lit_xml-linea WITH ''.
      REPLACE '</NORMALSALESAMOUNT>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-normalsalesamount = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<COST>'.
      REPLACE '<COST>' IN lit_xml-linea WITH ''.
      REPLACE '</COST>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-cost = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS '<ACTUALUNITPRICE>'.
      REPLACE '<ACTUALUNITPRICE>' IN lit_xml-linea WITH ''.
      REPLACE '</ACTUALUNITPRICE>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bpretaillineitem-actualunitprice = lit_xml-linea.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM f_fill_zztender TABLES lit_xml  STRUCTURE zretposdm003s01
                                           lit_zzposdwe1bptender STRUCTURE zzposdwe1bptender.

  DATA: lf_start.

  CLEAR: lit_zzposdwe1bptender.
  REFRESH: lit_zzposdwe1bptender.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</ZZPOSDWE1BPTENDER>'.
      APPEND lit_zzposdwe1bptender.
      CLEAR lf_start.
    ENDIF.

    IF lit_xml-linea = '<ZZPOSDWE1BPTENDER SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS 'RETAILSTOREID'.
      REPLACE '<RETAILSTOREID>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSTOREID>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-retailstoreid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'BUSINESSDAYDATE'.
      REPLACE '<BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.
      REPLACE '</BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-businessdaydate = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONTYPECODE'.
      REPLACE '<TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-transactiontypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'WORKSTATIONID'.
      REPLACE '<WORKSTATIONID>' IN lit_xml-linea WITH ''.
      REPLACE '</WORKSTATIONID>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-workstationid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONSEQUENCENUMBER'.
      REPLACE '<TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-transactionsequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TENDERSEQUENCENUMBER'.
      REPLACE '<TENDERSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</TENDERSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-tendersequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TENDERTYPECODE'.
      REPLACE '<TENDERTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</TENDERTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-tendertypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TENDERAMOUNT'.
      REPLACE '<TENDERAMOUNT>' IN lit_xml-linea WITH ''.
      REPLACE '</TENDERAMOUNT>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-tenderamount = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TENDERCURRENCY'.
      REPLACE '<TENDERCURRENCY>' IN lit_xml-linea WITH ''.
      REPLACE '</TENDERCURRENCY>' IN lit_xml-linea WITH ''.

      lit_zzposdwe1bptender-tendercurrency = lit_xml-linea.
    ENDIF.

  ENDLOOP.
ENDFORM.

FORM f_fill_Zzcustdetails TABLES lit_xml  STRUCTURE zretposdm003s01
                                           lit_zzcustdetails STRUCTURE ZZPOSDWE1BPCUSTOMERDETAILS.

  DATA: lf_start.

  CLEAR: lit_zzcustdetails.
  REFRESH: lit_zzcustdetails.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</ZZPOSDWE1BPCUSTOMERDETAILS>'.
      APPEND lit_zzcustdetails.
      CLEAR lf_start.
    ENDIF.

    IF lit_xml-linea = '<ZZPOSDWE1BPCUSTOMERDETAILS SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS 'RETAILSTOREID'.
      REPLACE '<RETAILSTOREID>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSTOREID>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-retailstoreid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'BUSINESSDAYDATE'.
      REPLACE '<BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.
      REPLACE '</BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-businessdaydate = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONTYPECODE'.
      REPLACE '<TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-transactiontypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'WORKSTATIONID'.
      REPLACE '<WORKSTATIONID>' IN lit_xml-linea WITH ''.
      REPLACE '</WORKSTATIONID>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-workstationid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONSEQUENCENUMBER'.
      REPLACE '<TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-transactionsequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'CUSTOMERINFORMATIONTYPECODE'.
      REPLACE '<CUSTOMERINFORMATIONTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</CUSTOMERINFORMATIONTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-CUSTOMERINFORMATIONTYPECODE = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DATAELEMENTID'.
      REPLACE '<DATAELEMENTID>' IN lit_xml-linea WITH ''.
      REPLACE '</DATAELEMENTID>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-DATAELEMENTID = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DATAELEMENTVALUE'.
      REPLACE '<DATAELEMENTVALUE>' IN lit_xml-linea WITH ''.
      REPLACE '</DATAELEMENTVALUE>' IN lit_xml-linea WITH ''.

      lit_zzcustdetails-DATAELEMENTVALUE = lit_xml-linea.
    ENDIF.

  ENDLOOP.
ENDFORM.

FORM f_fill_zzlineitemdisc TABLES lit_xml             STRUCTURE zretposdm003s01
                                  lit_zzlineiteimdisc STRUCTURE ZZPOSDWE1BPLINEITEMDISCOUNT.

  DATA: lf_start.

  CLEAR: lit_zzlineiteimdisc.
  REFRESH: lit_zzlineiteimdisc.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</ZZPOSDWE1BPLINEITEMDISCOUNT>'.
      APPEND lit_zzlineiteimdisc.
      CLEAR lf_start.
    ENDIF.

    IF lit_xml-linea = '<ZZPOSDWE1BPLINEITEMDISCOUNT SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS 'RETAILSTOREID'.
      REPLACE '<RETAILSTOREID>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSTOREID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-retailstoreid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'BUSINESSDAYDATE'.
      REPLACE '<BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.
      REPLACE '</BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-businessdaydate = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONTYPECODE'.
      REPLACE '<TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-transactiontypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'WORKSTATIONID'.
      REPLACE '<WORKSTATIONID>' IN lit_xml-linea WITH ''.
      REPLACE '</WORKSTATIONID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-workstationid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONSEQUENCENUMBER'.
      REPLACE '<TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-transactionsequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'RETAILSEQUENCENUMBER'.
      REPLACE '<RETAILSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-RETAILSEQUENCENUMBER = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DISCOUNTSEQUENCENUMBER'.
      REPLACE '<DISCOUNTSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</DISCOUNTSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-DISCOUNTSEQUENCENUMBER = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DISCOUNTTYPECODE'.
      REPLACE '<DISCOUNTTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</DISCOUNTTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-DISCOUNTTYPECODE = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DISCOUNTREASONCODE'.
      REPLACE '<DISCOUNTREASONCODE>' IN lit_xml-linea WITH ''.
      REPLACE '</DISCOUNTREASONCODE>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-DISCOUNTREASONCODE = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'REDUCTIONAMOUNT'.
      REPLACE '<REDUCTIONAMOUNT>' IN lit_xml-linea WITH ''.
      REPLACE '</REDUCTIONAMOUNT>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-REDUCTIONAMOUNT = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'STOREFINANCIALLEDGERACCOUNTID'.
      REPLACE '<STOREFINANCIALLEDGERACCOUNTID>' IN lit_xml-linea WITH ''.
      REPLACE '</STOREFINANCIALLEDGERACCOUNTID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-STOREFINANCIALLEDGERACCOUNTID = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DISCOUNTID'.
      REPLACE '<DISCOUNTID>' IN lit_xml-linea WITH ''.
      REPLACE '</DISCOUNTID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-DISCOUNTID = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DISCOUNTIDQUALIFIER'.
      REPLACE '<DISCOUNTIDQUALIFIER>' IN lit_xml-linea WITH ''.
      REPLACE '</DISCOUNTIDQUALIFIER>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-DISCOUNTIDQUALIFIER = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'BONUSBUYID'.
      REPLACE '<BONUSBUYID>' IN lit_xml-linea WITH ''.
      REPLACE '</BONUSBUYID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-BONUSBUYID = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'OFFERID'.
      REPLACE '<OFFERID>' IN lit_xml-linea WITH ''.
      REPLACE '</OFFERID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdisc-OFFERID = lit_xml-linea.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM f_fill_zzlineitemdiscex TABLES lit_xml             STRUCTURE zretposdm003s01
                                  lit_zzlineiteimdiscex STRUCTURE ZZPOSDWE1BPLINEITEMDISCEXT.

  DATA: lf_start.

  CLEAR: lit_zzlineiteimdiscex.
  REFRESH: lit_zzlineiteimdiscex.

  LOOP AT lit_xml.
    IF lit_xml-linea = '</ZZPOSDWE1BPLINEITEMDISCOUNT>'.
      APPEND lit_zzlineiteimdiscex.
      CLEAR lf_start.
    ENDIF.

    IF lit_xml-linea = '<ZZPOSDWE1BPLINEITEMDISCOUNT SEGMENT="1">'.
      lf_start = 'X'.
      CONTINUE.
    ENDIF.

    IF lf_start = ''.
      CONTINUE.
    ENDIF.

    IF lit_xml-linea CS 'RETAILSTOREID'.
      REPLACE '<RETAILSTOREID>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSTOREID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-retailstoreid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'BUSINESSDAYDATE'.
      REPLACE '<BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.
      REPLACE '</BUSINESSDAYDATE>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-businessdaydate = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONTYPECODE'.
      REPLACE '<TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONTYPECODE>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-transactiontypecode = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'WORKSTATIONID'.
      REPLACE '<WORKSTATIONID>' IN lit_xml-linea WITH ''.
      REPLACE '</WORKSTATIONID>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-workstationid = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'TRANSACTIONSEQUENCENUMBER'.
      REPLACE '<TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</TRANSACTIONSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-transactionsequencenumber = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'RETAILSEQUENCENUMBER'.
      REPLACE '<RETAILSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</RETAILSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-RETAILSEQUENCENUMBER = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'DISCOUNTSEQUENCENUMBER'.
      REPLACE '<DISCOUNTSEQUENCENUMBER>' IN lit_xml-linea WITH ''.
      REPLACE '</DISCOUNTSEQUENCENUMBER>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-DISCOUNTSEQUENCENUMBER = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'FIELDGROUP'.
      REPLACE '<FIELDGROUP>' IN lit_xml-linea WITH ''.
      REPLACE '</FIELDGROUP>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-FIELDGROUP = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'FIELDNAME'.
      REPLACE '<FIELDNAME>' IN lit_xml-linea WITH ''.
      REPLACE '</FIELDNAME>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-FIELDNAME = lit_xml-linea.
    ENDIF.

    IF lit_xml-linea CS 'FIELDVALUE'.
      REPLACE '<FIELDVALUE>' IN lit_xml-linea WITH ''.
      REPLACE '</FIELDVALUE>' IN lit_xml-linea WITH ''.

      lit_zzlineiteimdiscex-FIELDVALUE = lit_xml-linea.
    ENDIF.

  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_end_of_selection
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_end_of_selection .
  PERFORM f_listar_datos
    USING
      'ZRETPOSDM003S02'       "Estructura columnas ALV
      ''                      "Form STATUS
      'F_UCOMM_MONITOR'       "Form UCOMM
      ''                      "Form cabecera clásica
      ''                      "Form cabecera HTML
      'GIT_MONITOR[]'         "Tabla de datos
      ''                      "Campo info color linea
      ''.                     "Seleccionable
ENDFORM.

*===================================================================================================
*&      Form   f_ucomm_monitor
*===================================================================================================
FORM f_ucomm_monitor USING pe_ucomm   LIKE sy-ucomm
                                   rs_selfield TYPE slis_selfield.

* 0.- Declaración de variables
*===================================================================================================
  DATA: ref_grid              TYPE REF TO cl_gui_alv_grid.

* 1.- Lógica
*===================================================================================================
  DATA: l_valid TYPE c.

  rs_selfield-refresh = 'X'.
  rs_selfield-col_stable = 'X'.
  rs_selfield-row_stable = 'X'.

* Code to reflect the changes done in the internal table
  IF ref_grid IS INITIAL.
    CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
      IMPORTING
        e_grid = ref_grid.
  ENDIF.

  IF NOT ref_grid IS INITIAL.
    CALL METHOD ref_grid->check_changed_data
      IMPORTING
        e_valid = l_valid.
  ENDIF.

  IF l_valid = 'X'.
    CASE pe_ucomm.
      WHEN '&IC1'.
        READ TABLE git_monitor INDEX rs_selfield-tabindex.

        CASE rs_selfield-fieldname.
          when 'DOCNUM'.
            perform f_goto_idoc using git_monitor-docnum.
        ENDCASE.
    ENDCASE.
  ENDIF.
ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_GOTO_IDOC
*&---------------------------------------------------------------------*
*       Visualiza IDOC en WE02
*----------------------------------------------------------------------*
*      -->P_GIT_MONITOR_DOCNUM  text
*----------------------------------------------------------------------*
FORM F_GOTO_IDOC  USING    pe_docnum.
  SUBMIT rseidoc2
    WITH credat BETWEEN '' AND sy-datum
    WITH docnum BETWEEN pe_docnum AND ''
     AND RETURN.
ENDFORM.                    " F_GOTO_IDOC
*===================================================================================================
*&      Form  f_listar_datos
*===================================================================================================
FORM f_listar_datos USING     pe_estructura     LIKE  dd02l-tabname
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

        lr_layout        TYPE         lvc_s_layo,
        lit_sort         TYPE         slis_t_sortinfo_alv,
        wa_sort          TYPE         slis_sortinfo_alv,
        ld_index         LIKE         sy-tabix,
        lit_sort_lvc     TYPE         lvc_t_sort,
        wa_sort_lvc      TYPE         lvc_s_sort,
        lit_events       TYPE         slis_t_event,
        wa_events        TYPE         slis_alv_event.

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


  lr_layout-zebra             = 'X'.
* lr_layout-no_hgridln  = 'X'.
*  lr_layout-stylefname = 'FIELD_STYLE'.
* lr_layout-cwidth_opt = 'X'.
*  lr_layout-edit = 'X'.
  IF pe_sel = 'X'.
    lr_layout-box_fname = 'SEL'.
  ENDIF.



  IF pe_color_line <> ''.
    lr_layout-info_fname = pe_color_line.
  ENDIF.

*  lr_layout-ctab_fname = 'CELLCOLR'.

  PERFORM f_listar_datos_mapping TABLES lit_fieldcatalog.


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
      it_sort_lvc                 = lit_sort_lvc
*     IT_FILTER_LVC               =
*     IT_HYPERLINK                =
*     IS_SEL_HIDE                 =
      i_default                   = 'X'
      i_save                      = 'A'
*      is_variant                 =
      it_events                   = lit_events
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

*===================================================================================================
*& Form f_listar_datos_mapping
*===================================================================================================
FORM f_listar_datos_mapping  TABLES   lit_fieldcatalog TYPE         lvc_t_fcat.
*===================================================================================================
* 0.- Declaración de variables
*===================================================================================================
  DATA: wa_fieldcatalog TYPE LINE OF lvc_t_fcat,
        ld_index        LIKE sy-tabix.

*===================================================================================================
* 1.- Lógica
*===================================================================================================
  LOOP AT lit_fieldcatalog INTO wa_fieldcatalog.
    ld_index = sy-tabix.

    CASE wa_fieldcatalog-fieldname.
      WHEN 'SEL'.
        DELETE lit_fieldcatalog INDEX ld_index.
        CONTINUE.
      WHEN 'NAME'.
        wa_fieldcatalog-reptext    = 'Fichero'.
        wa_fieldcatalog-scrtext_l  = 'Fichero'.
        wa_fieldcatalog-scrtext_m  = 'Fichero'.
        wa_fieldcatalog-scrtext_s  = 'Fichero'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C711'.
      WHEN 'RETAILSTOREID'.
        wa_fieldcatalog-reptext    = 'Tienda'.
        wa_fieldcatalog-scrtext_l  = 'Tienda'.
        wa_fieldcatalog-scrtext_m  = 'Tienda'.
        wa_fieldcatalog-scrtext_s  = 'Tienda'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C711'.
      WHEN 'BUSINESSDAYDATE'.
        wa_fieldcatalog-reptext    = 'Fecha Ticket'.
        wa_fieldcatalog-scrtext_l  = 'Fecha Ticket'.
        wa_fieldcatalog-scrtext_m  = 'Fecha Ticket'.
        wa_fieldcatalog-scrtext_s  = 'Fecha Ticket'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C711'.
      WHEN 'TRANSACTIONTYPECODE'.
        wa_fieldcatalog-reptext    = 'Tipo Ticket'.
        wa_fieldcatalog-scrtext_l  = 'Tipo Ticket'.
        wa_fieldcatalog-scrtext_m  = 'Tipo Ticket'.
        wa_fieldcatalog-scrtext_s  = 'Tipo Ticket'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C711'.
      WHEN 'WORKSTATIONID'.
        wa_fieldcatalog-reptext    = 'Caja'.
        wa_fieldcatalog-scrtext_l  = 'Caja'.
        wa_fieldcatalog-scrtext_m  = 'Caja'.
        wa_fieldcatalog-scrtext_s  = 'Caja'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C711'.
      WHEN 'TRANSACTIONSEQUENCENUMBER'.
        wa_fieldcatalog-reptext    = 'Número de Ticket'.
        wa_fieldcatalog-scrtext_l  = 'Nº Ticket'.
        wa_fieldcatalog-scrtext_m  = 'Nº Ticket'.
        wa_fieldcatalog-scrtext_s  = 'Nº Ticket'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C711'.
      WHEN 'DOCNUM'.
        wa_fieldcatalog-reptext    = 'Idoc'.
        wa_fieldcatalog-scrtext_l  = 'Idoc'.
        wa_fieldcatalog-scrtext_m  = 'Idoc'.
        wa_fieldcatalog-scrtext_s  = 'Idoc'.
        wa_fieldcatalog-hotspot    = 'X'.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C411'.
      WHEN 'DOCNUMS'.
        wa_fieldcatalog-reptext    = 'Status Idoc - Código'.
        wa_fieldcatalog-scrtext_l  = 'SI[C]'.
        wa_fieldcatalog-scrtext_m  = 'SI[C]'.
        wa_fieldcatalog-scrtext_s  = 'SI[C]'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = ''.
        wa_fieldcatalog-emphasize  = 'C411'.
      WHEN 'DOCNUMI'.
        wa_fieldcatalog-reptext    = 'Status Idoc - Semáforo'.
        wa_fieldcatalog-scrtext_l  = 'SI[S]'.
        wa_fieldcatalog-scrtext_m  = 'SI[S]'.
        wa_fieldcatalog-scrtext_s  = 'SI[S]'.
        wa_fieldcatalog-hotspot    = ''.
        wa_fieldcatalog-edit       = ''.
        wa_fieldcatalog-just       = 'C'.
        wa_fieldcatalog-emphasize  = 'C411'.
    ENDCASE.

    MODIFY lit_fieldcatalog FROM wa_fieldcatalog.
  ENDLOOP.









ENDFORM.
