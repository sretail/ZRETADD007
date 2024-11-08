*----------------------------------------------------------------------*
***INCLUDE LZGF_POS00F01.
*----------------------------------------------------------------------*
*-----------------------------------------------------------------------
*        Form IDOC_STATUS_FUELLEN
*-----------------------------------------------------------------------
*        Beim 1. Fehler RETURN_VARIABLES stellen (Fehlerfall trat auf).
*        Konkreten Fehler in Tabelle IDOC_STATUS stellen.
*        geg: Using
*        zur: X-ERROR = 'X' - Fehler-KZ
*-----------------------------------------------------------------------
FORM idoc_status_fuellen USING isf_msgty isf_msgid isf_msgno
                               isf_msgv1 isf_msgv2 isf_msgv3 isf_msgv4.

  CLEAR idoc_status.
  idoc_status-docnum = idoc_contrl-docnum.
  IF isf_msgty = 'E'.
    idoc_status-status = '51'.
  ELSE.
    idoc_status-status = '53'.
  ENDIF.
  idoc_status-msgty  = isf_msgty.
  idoc_status-msgid  = isf_msgid.
  idoc_status-msgno  = isf_msgno.
  idoc_status-msgv1  = isf_msgv1.
  idoc_status-msgv2  = isf_msgv2.
  idoc_status-msgv3  = isf_msgv3.
  idoc_status-msgv4  = isf_msgv4.
  APPEND idoc_status.

ENDFORM.                    "IDOC_STATUS_FUELLEN



*&---------------------------------------------------------------------*
*& Form F_GET_TIENDA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_WA_ZPOSDM001_01_L01NUMCAJA  text
*      <--P_LD_TIENDA  text
*&---------------------------------------------------------------------*
FORM f_get_tienda  USING    pe_numcaja
                   CHANGING ps_tienda.

  SELECT SINGLE werks
    FROM zposdm001p01
    INTO ps_tienda
   WHERE numcaja = pe_numcaja.

  IF sy-subrc <> 0.
    SELECT SINGLE werks
      FROM zposdm001p01
      INTO ps_tienda
     WHERE numcaja = 'RES'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_MATNR_FROM_EAN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LR_ZPOS0013_SERIALNUMBER  text
*      <--P_LIT_ZPOSDM102_ITEMID  text
*&---------------------------------------------------------------------*
FORM f_get_matnr_from_ean  USING    pe_ean
                           CHANGING ps_matnr.

* 0.- Declaración de variables
*==========================================================================
  DATA: ld_ean LIKE mean-ean11.

* 1.- Lógica
*==========================================================================
  CLEAR ps_matnr.

* Determinamos articulo a partir del EAN
  SELECT SINGLE matnr
    FROM mean
    INTO ps_matnr
   WHERE ean11 = pe_ean.

  IF sy-subrc <> 0.
*   Si articulo no encontrado, volvemos a intentar encontrarlo, pero esta vez
*   quitando los ceros del inicio al EAN.

    ld_ean = pe_ean.

    WHILE ld_ean(1) = '0'.
      ld_ean = ld_ean+1.
    ENDWHILE.

    SELECT SINGLE matnr
      FROM mean
      INTO ps_matnr
     WHERE ean11 = ld_ean.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_FILL_ZZTRANSACTION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LIT_ZZTRANSACTION
*&      --> IDOC_DATA_SDATA
*&---------------------------------------------------------------------*
FORM f_fill_zztransaction  TABLES   it_zztransaction STRUCTURE zztransaction
                           USING    pe_zzposdwe1bpsourcedocumentli LIKE zzposdwe1bpsourcedocumentli
                                    pe_sdata
                                    pe_docnum
                                    pe_datos_cliente               like ZRETPOSDM001S24.

* 0.- Declaración de variables
*==========================================================================
  DATA: lr_zzposdwe1bptransaction LIKE zzposdwe1bptransaction,
        lr_personaldata           like BAPIKNA101_1,
        lr_personaldatax          like BAPIKNA101_1x,
        ld_ticket_duplicado       TYPE edi_stapa1,
        ld_kunnr                  LIKE kna1-kunnr,
        lr_return                 like BAPIRETURN1,
        ld_error                  type char03,            "APRADAS-22.04.2019
        begin of lit_addrnumber occurs 0,
          addrnumber              like adrc-addrnumber,   "APRADAS-22.04.2019
        end of lit_addrnumber,
        ld_kunnr_new              like kna1-kunnr,
        wa_adr6                   like adr6,
        lit_adr6                  like adr6 occurs 0 WITH HEADER LINE,

        ld_businesspartner LIKE  BAPIBUS1006_HEAD-BPARTNER,
        lit_bapiadsmtp     like BAPIADSMTP occurs 0 with header line,
        lit_BAPIADSMT_X    like BAPIADSMTX occurs 0 WITH HEADER LINE,
        lit_return         like BAPIRET2 occurs 0 WITH HEADER LINE.
* 1.- Lógica
*==========================================================================
* Inicializaciones
  CLEAR it_zztransaction.

  lr_zzposdwe1bptransaction = idoc_data-sdata.

* Registrar cabecera ticket
  it_zztransaction-retailstoreid             = lr_zzposdwe1bptransaction-retailstoreid.
  it_zztransaction-workstationid             = lr_zzposdwe1bptransaction-workstationid.
  it_zztransaction-businessdaydate           = lr_zzposdwe1bptransaction-businessdaydate.
  it_zztransaction-transactionsequencenumber = lr_zzposdwe1bptransaction-transactionsequencenumber.
  it_zztransaction-transactiontypecode       = lr_zzposdwe1bptransaction-transactiontypecode.
  it_zztransaction-operatorid                = lr_zzposdwe1bptransaction-operatorid.
  it_zztransaction-begindatetimestamp        = lr_zzposdwe1bptransaction-begindatetimestamp.
  it_zztransaction-enddatetimestamp          = lr_zzposdwe1bptransaction-enddatetimestamp.
  it_zztransaction-department                = lr_zzposdwe1bptransaction-department.
  it_zztransaction-operatorqualifier         = lr_zzposdwe1bptransaction-operatorqualifier.
  it_zztransaction-transactioncurrency       = lr_zzposdwe1bptransaction-transactioncurrency.
  it_zztransaction-transactioncurrency_iso   = lr_zzposdwe1bptransaction-transactioncurrency_iso.
  it_zztransaction-partnerqualifier          = lr_zzposdwe1bptransaction-partnerqualifier.
  it_zztransaction-partnerid                 = lr_zzposdwe1bptransaction-partnerid.
  it_zztransaction-zkey                      = pe_zzposdwe1bpsourcedocumentli-key.
  it_zztransaction-type                      = pe_zzposdwe1bpsourcedocumentli-type.
  it_zztransaction-docnum                    = pe_docnum.

*>Validar duplicidad tiquet
  SELECT SINGLE transactionsequencenumber
    FROM zztransaction
    INTO it_zztransaction-transactionsequencenumber
   WHERE retailstoreid = it_zztransaction-retailstoreid
     AND businessdaydate = it_zztransaction-businessdaydate
     AND transactiontypecode = it_zztransaction-transactiontypecode
     AND workstationid = it_zztransaction-workstationid
     AND transactionsequencenumber = it_zztransaction-transactionsequencenumber.

  IF sy-subrc = 0.
    CONCATENATE it_zztransaction-retailstoreid
                it_zztransaction-businessdaydate
                it_zztransaction-transactiontypecode
                it_zztransaction-workstationid
                it_zztransaction-transactionsequencenumber
           INTO ld_ticket_duplicado SEPARATED BY '-'.

*   Error: Ticket duplicado: &
    PERFORM idoc_status_fuellen USING 'E'
                                      'ZRETPOSDM001'
                                      '025'
                                      ld_ticket_duplicado
                                      ''
                                      ''
                                      ''.
  ENDIF.

*>Validar tienda válida
  SELECT SINGLE werks
    FROM t001w
    INTO it_zztransaction-retailstoreid
   WHERE werks = it_zztransaction-retailstoreid
     AND vlfkz = 'A'.

  IF sy-subrc <> 0.
*   Error: Ticket duplicado: &
    PERFORM idoc_status_fuellen USING 'E'
                                      'ZRETPOSDM001'
                                      '026'
                                      it_zztransaction-retailstoreid
                                      ''
                                      ''
                                      ''.
  ENDIF.


* APRADAS-Inicio-26.11.2018 14:08:37>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*>Conversión a factura
  IF ( it_zztransaction-transactiontypecode = 'ZVTA' OR
       it_zztransaction-transactiontypecode = 'ZBTK' ) AND
       it_zztransaction-partnerid IS NOT INITIAL.
*   Si la transacción es un ticket y nos llega informado el numero de cliente

    CASE it_zztransaction-partnerqualifier.
      WHEN '1'.
*       Si nos llega el código de cliente

*       Añadimos ceros al cliente hasta llegar a longitud 10
        WHILE strlen( it_zztransaction-partnerid ) < 10.
          CONCATENATE '0' it_zztransaction-partnerid INTO it_zztransaction-partnerid.
        ENDWHILE.

*       Miramos si el cliente es ZFAC/ZNAC
        SELECT SINGLE kunnr
          FROM kna1
          INTO it_zztransaction-partnerid
         WHERE kunnr = it_zztransaction-partnerid
           AND ( ktokd = 'ZFAC'  OR
                 ktokd = 'ZNAC' OR "APRADAS-04.12.2018
                 ktokd = 'ZGRN' OR "LFR
                 ktokd = 'ZVIN' ).

        IF sy-subrc = 0.
*         Si el cliente es ZFAC/ZNAC
          IF it_zztransaction-transactiontypecode = 'ZVTA'.
*           Si la transacción es ZVTA, la convertimos a ZVTF
            it_zztransaction-transactiontypecode = 'ZVTF'.
          ELSEIF it_zztransaction-transactiontypecode = 'ZBTK'.
*           Si la transacción es ZBTK, la convertimos a ZBCF
            it_zztransaction-transactiontypecode = 'ZBFC'.
          ENDIF.
        ENDIF.
      WHEN '2'.
*       Si nos llega el NIF

*       Recuperamos cliente asociado al NIF
        SELECT SINGLE kunnr
          FROM kna1
          INTO ld_kunnr
         WHERE stcd1 = it_zztransaction-partnerid.

        IF sy-subrc = 0.
*         Si encontramos cliente...

*         Miramos si el cliente es ZFAC/ZNAC
          SELECT SINGLE kunnr
            FROM kna1
            INTO ld_kunnr
           WHERE kunnr = ld_kunnr
             AND ( ktokd = 'ZFAC' OR
                   ktokd = 'ZNAC' OR "APRADAS-04.12.2018
                   ktokd = 'ZGRN' OR "LFR
                   ktokd = 'ZVIN' ).

          IF sy-subrc = 0.
*           Si es un cliente ZFAC/ZNAC, convertimos ticket a factura
            IF it_zztransaction-transactiontypecode = 'ZVTA'.
*             Si la transacción es ZVTA, la convertimos a ZVTF
              it_zztransaction-transactiontypecode = 'ZVTF'.
            ELSEIF it_zztransaction-transactiontypecode = 'ZBTK'.
*             Si la transacción es ZBTK, la convertimos a ZBCF
              it_zztransaction-transactiontypecode = 'ZBFC'.
            ENDIF.
          ENDIF.
        ENDIF.
    ENDCASE.
  ENDIF.
* APRADAS-Fin-26.11.2018 14:08:37<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

*>Validar cliente
  IF it_zztransaction-transactiontypecode = 'ZVTF' OR
     it_zztransaction-transactiontypecode = 'ZFAC' OR
     it_zztransaction-transactiontypecode = 'ZANT' OR "APRADAS-12.12.2021
     it_zztransaction-transactiontypecode = 'ZBFC'.

    CASE it_zztransaction-partnerqualifier.
      WHEN '1'.
*       Si nos llega el código de cliente

*       Añadimos ceros al cliente hasta llegar a longitud 10
        WHILE strlen( it_zztransaction-partnerid ) < 10.
          CONCATENATE '0' it_zztransaction-partnerid INTO it_zztransaction-partnerid.
        ENDWHILE.

*       Validamos que el cliente exista
        SELECT SINGLE kunnr
          FROM kna1
          INTO it_zztransaction-partnerid
         WHERE kunnr = it_zztransaction-partnerid.

        IF sy-subrc <> 0.
*         Si cliente no existe => Error 028
          ld_error = '028'. "APRADAS-22.04.2019
        ENDIF.
      WHEN '2'.
*       Si nos llega el NIF
*      >APRADAS-21.04.2021 11:32:44-Inicio
        if it_zztransaction-partnerid is initial.
          ld_error = '040'.
        else.
*      <APRADAS-21.04.2021 11:32:44-Fin

          translate it_zztransaction-partnerid to upper case.

*         Validamos que el NIF se corresponda con un cliente y modificar el partnerid
*         por el código de cliente
          SELECT SINGLE kunnr
            FROM kna1
            INTO it_zztransaction-partnerid
           WHERE stcd1 = it_zztransaction-partnerid.

          IF sy-subrc <> 0.
*           Si NIF no existe => Error 027
            ld_error = '027'. "APRADAS-22.04.2019
          ENDIF.
        endif. "APRADAS-21.04.2021
    ENDCASE.

*   APRADAS-Inicio-22.04.2019 09:52:14>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    if ld_error is not initial.
*     Si no se ha superado la validación del cliente...
      if pe_datos_cliente-nombre        is not initial and
         pe_datos_cliente-POBLACION     is not initial and
         pe_datos_cliente-CP            is not initial and
         pe_datos_cliente-IDFISCAL      is not initial and
         pe_datos_cliente-CALLE         is not initial.
*         pe_datos_cliente-EMAIL         is not initial.

*       Si nos llegan en el idoc los datos suficientes para crear el cliente, lo creamos
        perform f_crear_cliente using it_zztransaction-transactiontypecode pe_datos_cliente pe_docnum CHANGING it_zztransaction-tarea5_docnum.

*       Miramos si el idoc DEBMAS se ha procesado correctamente
        select single docnum
          from edidc
          into it_zztransaction-tarea5_docnum
         where docnum = it_zztransaction-tarea5_docnum
           and status = '53'.

        if sy-subrc = 0.
*         Si idoc procesado correctamente
          clear ld_error.

*         Forzado de Commit
          commit WORK and WAIT.

*         Obtener datos de direccion con numero de idoc en nombre 4
          refresh lit_addrnumber.
          select addrnumber
            from adrc
            into table lit_addrnumber
           where name4 = pe_docnum.

*         Determinar cliente a partir del numero de dirección y volver a
*         dejar el nombre 4 en blanco tanto en KNA1 como ADRC
          loop at lit_addrnumber.
*           Para cada número de dirección

*           Obtener cliente asociado
            select single kunnr
              from kna1
              into it_zztransaction-partnerid
             where adrnr = lit_addrnumber-addrnumber.

            if sy-subrc = 0.
*             Si cliente asociado encontrado, inicializamos nombre 4 en cliente
              update kna1 set name4 = '' where kunnr = it_zztransaction-partnerid.

*             APRADAS-Inicio-29.04.2019 14:31:03>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*             Damos de alta el email
              if pe_datos_cliente-EMAIL is not initial. "24.02.2021-Solo damos de alta el email si nos llega informado
                clear wa_adr6.
                wa_adr6-client     = sy-mandt.
                wa_adr6-addrnumber = lit_addrnumber-addrnumber.
                wa_adr6-date_from  = '00010101'.
                wa_adr6-consnumber = '001'.
                wa_adr6-flgdefault = 'X'.
                wa_adr6-home_flag  = 'X'.
                wa_adr6-smtp_addr  = pe_datos_cliente-email.
                wa_adr6-smtp_srch  = pe_datos_cliente-email.
                translate wa_adr6-smtp_srch to UPPER CASE.
                CONCATENATE sy-datum '000000' into wa_adr6-valid_from.
                wa_adr6-_dataaging = '00000000'.



                ld_businesspartner = it_zztransaction-partnerid.

                lit_BAPIADSMTP-e_mail = pe_datos_cliente-email.
                lit_BAPIADSMTP-EMAIL_SRCH = wa_adr6-smtp_srch.
                lit_BAPIADSMTP-consnumber = '001'.
                CONCATENATE sy-datum '000000' into lit_BAPIADSMTP-valid_from.
                lit_BAPIADSMTP-HOME_FLAG = 'X'.
                append lit_BAPIADSMTP.


                lit_BAPIADSMT_X-e_mail = 'X'.
                lit_BAPIADSMT_X-EMAIL_SRCH = 'X'.
                lit_BAPIADSMT_X-consnumber = 'X'.
                lit_BAPIADSMT_X-valid_from = 'X'.
                lit_BAPIADSMT_X-HOME_FLAG = 'X'.
                lit_BAPIADSMT_X-UPDATEFLAG = 'I'.
                append lit_BAPIADSMT_X.

                CALL FUNCTION 'BAPI_BUPA_ADDRESS_CHANGE'
                  EXPORTING
                    businesspartner              =  ld_businesspartner
*                   ADDRESSGUID                  =
*                   ADDRESSDATA                  =
*                   ADDRESSDATA_X                =
*                   DUPLICATE_MESSAGE_TYPE       =
*                   ACCEPT_ERROR                 = ' '
                  TABLES
*                   BAPIADTEL                    =
*                   BAPIADFAX                    =
*                   BAPIADTTX                    =
*                   BAPIADTLX                    =
                    BAPIADSMTP                   = lit_BAPIADSMTP
*                   BAPIADRML                    =
*                   BAPIADX400                   =
*                   BAPIADRFC                    =
*                   BAPIADPRT                    =
*                   BAPIADSSF                    =
*                   BAPIADURI                    =
*                   BAPIADPAG                    =
*                   BAPIAD_REM                   =
*                   BAPICOMREM                   =
*                   ADDRESSUSAGE                 =
*                   BAPIADVERSORG                =
*                   BAPIADVERSPERS               =
*                   BAPIADUSE                    =
*                   BAPIADTEL_X                  =
*                   BAPIADFAX_X                  =
*                   BAPIADTTX_X                  =
*                   BAPIADTLX_X                  =
                    BAPIADSMT_X                  = lit_BAPIADSMT_X
*                   BAPIADRML_X                  =
*                   BAPIADX40_X                  =
*                   BAPIADRFC_X                  =
*                   BAPIADPRT_X                  =
*                   BAPIADSSF_X                  =
*                   BAPIADURI_X                  =
*                   BAPIADPAG_X                  =
*                   BAPIAD_RE_X                  =
*                   BAPICOMRE_X                  =
*                   ADDRESSUSAGE_X               =
*                   BAPIADVERSORG_X              =
*                   BAPIADVERSPERS_X             =
*                   BAPIADUSE_X                  =
                    RETURN                       = lit_return
*                   ADDRESSDUPLICATES            =
                          .

                CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
                  EXPORTING
                    WAIT          = 'X'
*                 IMPORTING
*                   RETURN        =
                          .
              endif. "APRDAS-24.02.2021

*             APRADAS-Fin-29.04.2019 14:31:03<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            endif.

*           Inicializamos nombre 4 en dirección
            update adrc set name4 = '' where addrnumber = lit_addrnumber-addrnumber.
          endloop.
        else.
*         Si idoc DEBMAS no procesado correctamente => Error 037
          ld_error = '037'.
        endif.
      endif.


      if ld_error is not initial.
*       Si no nos llegan en el idoc los datos completos del cliente o el idoc
*       de creación del cliente ha dado error => Error
        case ld_error.
          when '027'.
*           Error: El NIF & no se corresponde con ningún cliente.
            PERFORM idoc_status_fuellen USING 'E'
                                              'ZRETPOSDM001'
                                              '027'
                                              it_zztransaction-partnerid
                                              ''
                                              ''
                                              ''.
          when '028'.
*           Error: El cliente & no existe en el sistema.
            PERFORM idoc_status_fuellen USING 'E'
                                              'ZRETPOSDM001'
                                              '028'
                                              it_zztransaction-partnerid
                                              ''
                                              ''
                                              ''.
         when '037'.
*          Error: Idoc erróneo en creación cliente automático, &.
           PERFORM idoc_status_fuellen USING 'E'
                                              'ZRETPOSDM001'
                                              '037'
                                              it_zztransaction-tarea5_docnum
                                              ''
                                              ''
                                              ''.
*       >APRADAS-21.04.2021 11:30:38-Inicio
         when '040'.
*          Error: Se ha recibido el NIF del cliente en blanco.
           PERFORM idoc_status_fuellen USING 'E'
                                              'ZRETPOSDM001'
                                              '040'
                                              it_zztransaction-tarea5_docnum
                                              ''
                                              ''
                                              ''.
*       <APRADAS-21.04.2021 11:30:38-Fin
        endcase.
      endif.
    else.
      it_zztransaction-tarea5_docnum = 'NO_APLICA'.
    endif.
*   APRADAS-Fin-22.04.2019 09:52:14<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ENDIF.

  APPEND it_zztransaction.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_MATNRT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LIT_ZZLINEITEM_ITEMID
*&      <-- LIT_ZZLINEITEM_ITEMIDT
*&---------------------------------------------------------------------*
FORM f_get_matnrt  USING    pe_itemid
                   CHANGING ps_itemidt.


  SELECT SINGLE maktx
    FROM makt
    INTO ps_itemidt
   WHERE spras = 'S'
     AND matnr = pe_itemid.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_CHECK_ART_CATALOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GR_STOCKS_ALL_MATNR
*&      <-- LF_CATALOGADO
*&---------------------------------------------------------------------*
FORM f_check_art_catalog  USING    pe_matnr
                                   pe_werks
                          CHANGING ps_catalogado.

* 0.- Declaración de variables
*==========================================================================
  DATA: ld_werks LIKE marc-werks.

* 1.- Lógica
*==========================================================================
  ld_werks = pe_werks.

***Inicio modificación DSS 07/12/2018.
**En los cierres de caja viene el artículo vacío
  IF NOT pe_matnr IS INITIAL.
*   Si llega código de artículo...

*   APRADAS-Inicio-10.12.2018 15:08:52>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*   Miramos si el artículo tiene entrada en la MARC
    select single matnr
      from marc
      into pe_matnr
     where matnr = pe_matnr
       and werks = pe_werks
       and LVORM = ''.
*   APRADAS-Fin-10.12.2018 15:08:52<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    IF sy-subrc = 0.
      ps_catalogado = 'X'.
    ELSE.
      ps_catalogado = ''.
    ENDIF.

**Inicio modificación DSS
  ELSE.
    ps_catalogado = 'X'.
  ENDIF.
**Fin modificación DSS
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_CREAR_CLIENTE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> PE_DATOS_CLIENTE
*&      <-- IT_ZZTRANSACTION_TAREA5_DOCNUM
*&---------------------------------------------------------------------*
FORM f_crear_cliente  USING    pe_transactiontypecode
                               pe_datos_cliente like ZRETPOSDM001S24
                               pe_docnum
                      CHANGING ps_docnum.

* 0.- Declaración de variables
*==========================================================================
  data: lit_idoc_containers     LIKE edidd           OCCURS 0 WITH HEADER LINE,

        lr_idoc_control_new     LIKE edidc,
        lr_idoc_control         LIKE edidc,
        lr_E1KNA1M              like E1KNA1M,
        lr_E1KNA11              like E1KNA11,
        lr_E1KNVVM              like E1KNVVM,
        lr_E1FSHKNVV            like E1FSHKNVV,
        lr_E1KNVPM              like E1KNVPM,
        lr_E1KNVIM              like E1KNVIM,
        lr_E1KNB1M              like E1KNB1M,
        lr_E1KNB5M              like E1KNB5M,

        ld_segnum               TYPE idocdsgnum,
        ld_segnum_E1KNA1M       TYPE idocdsgnum,
        ld_segnum_E1KNVVM       TYPE idocdsgnum,
        ld_segnum_E1KNB1M       TYPE idocdsgnum,

        ld_identifier           LIKE edidc-docnum,

        lf_error(1),

        lit_ZRETPOSDM001T06     like ZRETPOSDM001T06 occurs 0 WITH HEADER LINE,
        begin of lit_addrnumber occurs 0,
          addrnumber              like adrc-addrnumber,   "APRADAS-22.04.2019
        end of lit_addrnumber,
        ld_kunnr                like kna1-kunnr,
        ld_nif_inventado        like zhardcodes-valor.

* 1.- Lógica
*==========================================================================

* Obtener NIF inventado para el que hay que crear cliente sin nif
  select single valor
    from zhardcodes
    into ld_nif_inventado
   where programa = 'ZIDOC_INPUT_ZZCREATEMULTIPLE'
     AND param    = 'NIF_INVENTADO'.

*>Confeccionar Idoc

*>APRADAS-21.05.2020 09:58:26-Inicio
*>Cargar datos fijos para creación de clientes
  refresh lit_ZRETPOSDM001T06.

  select *
    from ZRETPOSDM001T06
    into table lit_ZRETPOSDM001T06
   where CLASF = pe_transactiontypecode.
*<APRADAS-21.05.2020 09:58:26-Fin

* Abrimos IDOC
  PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA5'
                                ''
                       CHANGING lr_idoc_control
                                ld_identifier
                                lf_error.

* Segmento E1KNA1M
  clear lr_E1KNA1M.
  lr_E1KNA1M-MSGFN = '005'.
  lr_E1KNA1M-BBBNR = '0000000'.
  lr_E1KNA1M-BBSNR = '00000'.
  lr_E1KNA1M-BUBKZ = '0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNA1-KTOKD'.
  if sy-subrc = 0.
    lr_E1KNA1M-KTOKD = lit_ZRETPOSDM001T06-VALOR.
  endif.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNA1-STKZU'.
  if sy-subrc = 0.
    lr_E1KNA1M-STKZU = lit_ZRETPOSDM001T06-VALOR.
  endif.

  lr_E1KNA1M-LAND1 = 'ES'.
  CONCATENATE pe_datos_cliente-nombre pe_datos_cliente-APELLIDOS into lr_E1KNA1M-NAME1 SEPARATED BY space.
*  lr_E1KNA1M-NAME2 = pe_datos_cliente-RAZONSOCIAL. "APRADAS-13.04.2021
  lr_E1KNA1M-name4(16) = pe_docnum.
  lr_E1KNA1M-ORT01 = pe_datos_cliente-POBLACION.
  lr_E1KNA1M-PSTLZ = pe_datos_cliente-cp.
  lr_E1KNA1M-REGIO = pe_datos_cliente-cp(2).
  if strlen( lr_E1KNA1M-NAME1 ) > 10.
    lr_E1KNA1M-SORTL = lr_E1KNA1M-NAME1(10).
  else.
    lr_E1KNA1M-SORTL = lr_E1KNA1M-NAME1.
  endif.
  lr_E1KNA1M-telf1   = pe_datos_cliente-telefono. "APRADAS-20.04.2020


  lr_E1KNA1M-SPRAS = 'S'.

  concatenate pe_datos_cliente-calle pe_datos_cliente-numero pe_datos_cliente-piso into lr_E1KNA1M-STRAS separated by space.
*  lr_E1KNA1M-TELF1 = '639048663'.
*  lr_E1KNA1M-TELF2 = '639048663'.

  if pe_transactiontypecode     = 'ZVTF' and
     pe_datos_cliente-idfiscal  = ld_nif_inventado.
*   Si la transaccion de venta es ZVTF y el NIF recibido coincide con el NIF inventado, creamos el cliente sin NIF
    lr_E1KNA1M-STCD1 = ''.
    lr_E1KNA1M-STCEG = ''.
  else.
    lr_E1KNA1M-STCD1 = pe_datos_cliente-idfiscal.
    concatenate 'ES' pe_datos_cliente-idfiscal into lr_E1KNA1M-STCEG.
  endif.

  lr_E1KNA1M-UMJAH = '0000'.
  lr_E1KNA1M-JMZAH = '000000'.
  lr_E1KNA1M-JMJAH = '0000'.
  lr_E1KNA1M-UMSA1 = '0'.
  lr_E1KNA1M-HZUOR = '00'.
  lr_E1KNA1M-SPRAS_ISO = 'CA'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNA1M'.
  lit_idoc_containers-sdata   = lr_E1KNA1M.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  APPEND lit_idoc_containers.
  ld_segnum_E1KNA1M = ld_segnum.

* Segmento E1KNA11
  clear lr_E1KNA11.
  lr_E1KNA11-RGDATE = '00000000'.
  lr_E1KNA11-RIC = '00000000000'.
  lr_E1KNA11-RNEDATE = '00000000'.
  lr_E1KNA11-LEGALNAT = '0000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNA11'.
  lit_idoc_containers-sdata   = lr_E1KNA11.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.

*===================================================================================================
* Area de ventas CAN/30 >> Inicio
*===================================================================================================
* Segmento E1KNVVM
  clear lr_E1KNVVM.
  lr_E1KNVVM-MSGFN = '005'.
  lr_E1KNVVM-VKORG = 'CAN'.
  lr_E1KNVVM-VTWEG = '30'.
  lr_E1KNVVM-SPART = '10'.
  lr_E1KNVVM-BZIRK = '000001'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_30-KONDA'.
  if sy-subrc = 0.
    lr_E1KNVVM-KONDA = lit_ZRETPOSDM001T06-valor.
  endif.

  lr_E1KNVVM-AWAHR = '000'.
  lr_E1KNVVM-ANTLF = '0'.
  lr_E1KNVVM-LPRIO = '00'.
  lr_E1KNVVM-WAERS = 'EUR'.
  lr_E1KNVVM-UEBTO = '0.0'.
  lr_E1KNVVM-UNTTO = '0.0'.
  lr_E1KNVVM-PODTG = '         0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_30-KALKS'.
  if sy-subrc = 0.
    lr_E1KNVVM-kalks = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_30-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNVVM-zterm = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_30-VSBED'.
  if sy-subrc = 0.
    lr_E1KNVVM-vsbed = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_30-KDGRP'.
  if sy-subrc = 0.
    lr_E1KNVVM-kdgrp = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_30-KTGRD'.
  if sy-subrc = 0.
    lr_E1KNVVM-KTGRD = lit_ZRETPOSDM001T06-valor.
  endif.


  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVVM'.
  lit_idoc_containers-sdata   = lr_E1KNVVM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_segnum_E1KNVVM = ld_segnum.

* Segmento E1FSHKNVV
  clear lr_E1FSHKNVV.
  lr_E1FSHKNVV-FSH_FRATE = '000'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_30-FSH_KVGR9'.
  if sy-subrc = 0.
    lr_E1FSHKNVV-FSH_KVGR9 = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1FSHKNVV'.
  lit_idoc_containers-sdata   = lr_E1FSHKNVV.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM (WE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'WE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(AG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'AG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVIM
  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'MWST'.
  lr_E1KNVIM-TAXKD = '1'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'ZASB '.
  lr_E1KNVIM-TAXKD = '0'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

*===================================================================================================
* Area de ventas CAN/30 << Fin
*===================================================================================================

*===================================================================================================
* Area de ventas CAI/10 >> Inicio
*===================================================================================================
* Segmento E1KNVVM
  clear lr_E1KNVVM.
  lr_E1KNVVM-MSGFN = '005'.
  lr_E1KNVVM-VKORG = 'CAI'.
  lr_E1KNVVM-VTWEG = '10'.
  lr_E1KNVVM-SPART = '10'.
  lr_E1KNVVM-BZIRK = '000001'.
  lr_E1KNVVM-KONDA = '01'.
  lr_E1KNVVM-AWAHR = '000'.
  lr_E1KNVVM-ANTLF = '0'.
  lr_E1KNVVM-LPRIO = '00'.
  lr_E1KNVVM-WAERS = 'EUR'.
  lr_E1KNVVM-UEBTO = '0.0'.
  lr_E1KNVVM-UNTTO = '0.0'.
  lr_E1KNVVM-PODTG = '         0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAI_10-KALKS'.
  if sy-subrc = 0.
    lr_E1KNVVM-kalks = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAI_10-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNVVM-zterm = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAI_10-VSBED'.
  if sy-subrc = 0.
    lr_E1KNVVM-vsbed = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAI_10-KDGRP'.
  if sy-subrc = 0.
    lr_E1KNVVM-kdgrp = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAI_10-KTGRD'.
  if sy-subrc = 0.
    lr_E1KNVVM-KTGRD = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVVM'.
  lit_idoc_containers-sdata   = lr_E1KNVVM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_segnum_E1KNVVM = ld_segnum.

* Segmento E1FSHKNVV
  clear lr_E1FSHKNVV.
  lr_E1FSHKNVV-FSH_FRATE = '000'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAI_10-FSH_KVGR9'.
  if sy-subrc = 0.
    lr_E1FSHKNVV-FSH_KVGR9 = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1FSHKNVV'.
  lit_idoc_containers-sdata   = lr_E1FSHKNVV.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM (WE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'WE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(AG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'AG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVIM
  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'MWST'.
  lr_E1KNVIM-TAXKD = '1'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'ZASB '.
  lr_E1KNVIM-TAXKD = '0'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

*===================================================================================================
* Area de ventas CAI/10 << Fin
*===================================================================================================

*CCOTILLA - 20.03.2024 - añado nueva sociedad MIRO /10
*===================================================================================================
* Area de ventas MIRO/10 >> Inicio
*===================================================================================================
* Segmento E1KNVVM
  clear lr_E1KNVVM.
  lr_E1KNVVM-MSGFN = '005'.
  lr_E1KNVVM-VKORG = 'MIRO'.
  lr_E1KNVVM-VTWEG = '10'.
  lr_E1KNVVM-SPART = '10'.
  lr_E1KNVVM-BZIRK = '000001'.
  lr_E1KNVVM-KONDA = '01'.
  lr_E1KNVVM-AWAHR = '000'.
  lr_E1KNVVM-ANTLF = '0'.
  lr_E1KNVVM-LPRIO = '00'.
  lr_E1KNVVM-WAERS = 'EUR'.
  lr_E1KNVVM-UEBTO = '0.0'.
  lr_E1KNVVM-UNTTO = '0.0'.
  lr_E1KNVVM-PODTG = '         0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_10-KALKS'.
  if sy-subrc = 0.
    lr_E1KNVVM-kalks = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_10-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNVVM-zterm = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_10-VSBED'.
  if sy-subrc = 0.
    lr_E1KNVVM-vsbed = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_10-KDGRP'.
  if sy-subrc = 0.
    lr_E1KNVVM-kdgrp = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_10-KTGRD'.
  if sy-subrc = 0.
    lr_E1KNVVM-KTGRD = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVVM'.
  lit_idoc_containers-sdata   = lr_E1KNVVM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_segnum_E1KNVVM = ld_segnum.

* Segmento E1FSHKNVV
  clear lr_E1FSHKNVV.
  lr_E1FSHKNVV-FSH_FRATE = '000'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_10-FSH_KVGR9'.
  if sy-subrc = 0.
    lr_E1FSHKNVV-FSH_KVGR9 = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1FSHKNVV'.
  lit_idoc_containers-sdata   = lr_E1FSHKNVV.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM (WE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'WE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(AG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'AG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVIM
  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'MWST'.
  lr_E1KNVIM-TAXKD = '1'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'ZASB '.
  lr_E1KNVIM-TAXKD = '0'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

*===================================================================================================
* Area de ventas MIRO/10 << Fin
*===================================================================================================

*CCOTILLA - 20.03.2024 - añado nueva sociedad MIRO /10
*===================================================================================================
* Area de ventas MIRO/50 >> Inicio
*===================================================================================================
* Segmento E1KNVVM
  clear lr_E1KNVVM.
  lr_E1KNVVM-MSGFN = '005'.
  lr_E1KNVVM-VKORG = 'MIRO'.
  lr_E1KNVVM-VTWEG = '50'.
  lr_E1KNVVM-SPART = '10'.
  lr_E1KNVVM-BZIRK = '000001'.
  lr_E1KNVVM-KONDA = '01'.
  lr_E1KNVVM-AWAHR = '000'.
  lr_E1KNVVM-ANTLF = '0'.
  lr_E1KNVVM-LPRIO = '00'.
  lr_E1KNVVM-WAERS = 'EUR'.
  lr_E1KNVVM-UEBTO = '0.0'.
  lr_E1KNVVM-UNTTO = '0.0'.
  lr_E1KNVVM-PODTG = '         0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_50-KALKS'.
  if sy-subrc = 0.
    lr_E1KNVVM-kalks = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_50-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNVVM-zterm = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_50-VSBED'.
  if sy-subrc = 0.
    lr_E1KNVVM-vsbed = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_50-KDGRP'.
  if sy-subrc = 0.
    lr_E1KNVVM-kdgrp = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_50-KTGRD'.
  if sy-subrc = 0.
    lr_E1KNVVM-KTGRD = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVVM'.
  lit_idoc_containers-sdata   = lr_E1KNVVM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_segnum_E1KNVVM = ld_segnum.

* Segmento E1FSHKNVV
  clear lr_E1FSHKNVV.
  lr_E1FSHKNVV-FSH_FRATE = '000'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_MIRO_50-FSH_KVGR9'.
  if sy-subrc = 0.
    lr_E1FSHKNVV-FSH_KVGR9 = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1FSHKNVV'.
  lit_idoc_containers-sdata   = lr_E1FSHKNVV.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM (WE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'WE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(AG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'AG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVIM
  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'MWST'.
  lr_E1KNVIM-TAXKD = '1'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'ZASB '.
  lr_E1KNVIM-TAXKD = '0'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

*===================================================================================================
* Area de ventas MIRO/50 << Fin
*===================================================================================================

*===================================================================================================
* Area de ventas CAN/40 >> Inicio
*===================================================================================================
* Segmento E1KNVVM
  clear lr_E1KNVVM.
  lr_E1KNVVM-MSGFN = '005'.
  lr_E1KNVVM-VKORG = 'CAN'.
  lr_E1KNVVM-VTWEG = '40'.
  lr_E1KNVVM-SPART = '10'.
  lr_E1KNVVM-BZIRK = '000001'.
  lr_E1KNVVM-KONDA = '01'.
  lr_E1KNVVM-AWAHR = '000'.
  lr_E1KNVVM-ANTLF = '0'.
  lr_E1KNVVM-LPRIO = '00'.
  lr_E1KNVVM-WAERS = 'EUR'.
  lr_E1KNVVM-UEBTO = '0.0'.
  lr_E1KNVVM-UNTTO = '0.0'.
  lr_E1KNVVM-PODTG = '         0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_40-KALKS'.
  if sy-subrc = 0.
    lr_E1KNVVM-kalks = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_40-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNVVM-zterm = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_40-VSBED'.
  if sy-subrc = 0.
    lr_E1KNVVM-vsbed = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_40-KDGRP'.
  if sy-subrc = 0.
    lr_E1KNVVM-kdgrp = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_40-KTGRD'.
  if sy-subrc = 0.
    lr_E1KNVVM-KTGRD = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVVM'.
  lit_idoc_containers-sdata   = lr_E1KNVVM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_segnum_E1KNVVM = ld_segnum.

* Segmento E1FSHKNVV
  clear lr_E1FSHKNVV.
  lr_E1FSHKNVV-FSH_FRATE = '000'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNVV_CAN_40-FSH_KVGR9'.
  if sy-subrc = 0.
    lr_E1FSHKNVV-FSH_KVGR9 = lit_ZRETPOSDM001T06-valor.
  endif.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1FSHKNVV'.
  lit_idoc_containers-sdata   = lr_E1FSHKNVV.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM (WE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'WE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(AG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'AG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RE)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RE'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVPM(RG)
  clear lr_E1KNVPM.
  lr_E1KNVPM-MSGFN = '005'.
  lr_E1KNVPM-PARVW = 'RG'.
*  lr_E1KNVPM-KUNN2 = '0017001131'.
  lr_E1KNVPM-PARZA = '000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVPM'.
  lit_idoc_containers-sdata   = lr_E1KNVPM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

* Segmento E1KNVIM
  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'MWST'.
  lr_E1KNVIM-TAXKD = '1'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

  clear lr_E1KNVIM.

  lr_E1KNVIM-MSGFN = '005'.
  lr_E1KNVIM-ALAND = 'ES'.
  lr_E1KNVIM-TATYP = 'ZASB '.
  lr_E1KNVIM-TAXKD = '0'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNVIM'.
  lit_idoc_containers-sdata   = lr_E1KNVIM.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNVVM.
  APPEND lit_idoc_containers.

*===================================================================================================
* Area de ventas CAN/40 << Fin
*===================================================================================================

*===================================================================================================
* Sociedad CAN >> Inicio
*===================================================================================================

* Segmento E1KNB1M
  clear lr_E1KNB1M.
  lr_E1KNB1M-MSGFN = '005'.
  lr_E1KNB1M-BUKRS = 'CAN'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAN-AKONT'.
  if sy-subrc = 0.
    lr_E1KNB1M-AKONT = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAN-ZWELS'.
  if sy-subrc = 0.
    lr_E1KNB1M-ZWELS = lit_ZRETPOSDM001T06-VALOR.
  endif.
  lr_E1KNB1M-ZINDT = '00000000'.
  lr_E1KNB1M-ZINRT = '00'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAN-FDGRV'.
  if sy-subrc = 0.
    lr_E1KNB1M-FDGRV = lit_ZRETPOSDM001T06-valor.
  endif.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAN-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNB1M-ZTERM = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAN-GUZTE'.
  if sy-subrc = 0.
    lr_E1KNB1M-GUZTE = lit_ZRETPOSDM001T06-valor.
  endif.
  lr_E1KNB1M-VLIBB = '0'.
  lr_E1KNB1M-VRSZL = '0'.
  lr_E1KNB1M-VRSPR = '0'.
  lr_E1KNB1M-VERDT = '00000000'.
  lr_E1KNB1M-WEBTR = '0'.
  lr_E1KNB1M-DATLZ = '00000000'.
  lr_E1KNB1M-KULTG = '0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAN-HBKID'.
  if sy-subrc = 0.
    lr_E1KNB1M-HBKID = lit_ZRETPOSDM001T06-valor.
  endif.
  lr_E1KNB1M-PERNR = '00000000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNB1M'.
  lit_idoc_containers-sdata   = lr_E1KNB1M.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_Segnum_E1KNB1M = ld_segnum.

* Segmento E1KNB5M
*  clear lr_E1KNB5M.
*  lr_E1KNB5M-MSGFN = '005'.
*  lr_E1KNB5M-MAHNA = 'ZAME'.
*  lr_E1KNB5M-MADAT = '00000000'.
*  lr_E1KNB5M-MAHNS = '0'.
*  lr_E1KNB5M-GMVDT = '00000000'.
*
*  ADD 1 TO ld_segnum.
*  lit_idoc_containers-segnam  = 'E1KNB5M'.
*  lit_idoc_containers-sdata   = lr_E1KNB5M.
*  lit_idoc_containers-docnum  = ld_identifier.
*  lit_idoc_containers-segnum  = ld_segnum.
*  lit_idoc_containers-psgnum  = ld_segnum_E1KNB1M.
*  APPEND lit_idoc_containers.

*===================================================================================================
* Sociedad CAN >> Fin
*===================================================================================================

*===================================================================================================
* Sociedad CAI >> Inicio
*===================================================================================================

* Segmento E1KNB1M
  clear lr_E1KNB1M.
  lr_E1KNB1M-MSGFN = '005'.
  lr_E1KNB1M-BUKRS = 'CAI'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAI-AKONT'.
  if sy-subrc = 0.
    lr_E1KNB1M-AKONT = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAI-ZWELS'.
  if sy-subrc = 0.
    lr_E1KNB1M-ZWELS = lit_ZRETPOSDM001T06-VALOR.
  endif.
  lr_E1KNB1M-ZINDT = '00000000'.
  lr_E1KNB1M-ZINRT = '00'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAI-FDGRV'.
  if sy-subrc = 0.
    lr_E1KNB1M-FDGRV = lit_ZRETPOSDM001T06-valor.
  endif.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAI-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNB1M-ZTERM = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAI-GUZTE'.
  if sy-subrc = 0.
    lr_E1KNB1M-GUZTE = lit_ZRETPOSDM001T06-valor.
  endif.
  lr_E1KNB1M-VLIBB = '0'.
  lr_E1KNB1M-VRSZL = '0'.
  lr_E1KNB1M-VRSPR = '0'.
  lr_E1KNB1M-VERDT = '00000000'.
  lr_E1KNB1M-WEBTR = '0'.
  lr_E1KNB1M-DATLZ = '00000000'.
  lr_E1KNB1M-KULTG = '0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAI-HBKID'.
  if sy-subrc = 0.
    lr_E1KNB1M-HBKID = lit_ZRETPOSDM001T06-valor.
  endif.
  lr_E1KNB1M-PERNR = '00000000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNB1M'.
  lit_idoc_containers-sdata   = lr_E1KNB1M.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_Segnum_E1KNB1M = ld_segnum.

* Segmento E1KNB5M
*  clear lr_E1KNB5M.
*  lr_E1KNB5M-MSGFN = '005'.
*  lr_E1KNB5M-MAHNA = 'ZAME'.
*  lr_E1KNB5M-MADAT = '00000000'.
*  lr_E1KNB5M-MAHNS = '0'.
*  lr_E1KNB5M-GMVDT = '00000000'.
*
*  ADD 1 TO ld_segnum.
*  lit_idoc_containers-segnam  = 'E1KNB5M'.
*  lit_idoc_containers-sdata   = lr_E1KNB5M.
*  lit_idoc_containers-docnum  = ld_identifier.
*  lit_idoc_containers-segnum  = ld_segnum.
*  lit_idoc_containers-psgnum  = ld_segnum_E1KNB1M.
*  APPEND lit_idoc_containers.

*===================================================================================================
* Sociedad CAI >> Fin
*===================================================================================================

*CCOTILLA - 20.03.2024 - Añado nueva sociedad MIRO
*===================================================================================================
* Sociedad MIRO >> Inicio
*===================================================================================================

* Segmento E1KNB1M
  clear lr_E1KNB1M.
  lr_E1KNB1M-MSGFN = '005'.
  lr_E1KNB1M-BUKRS = 'MIRO'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_MIRO-AKONT'.
  if sy-subrc = 0.
    lr_E1KNB1M-AKONT = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_MIRO-ZWELS'.
  if sy-subrc = 0.
    lr_E1KNB1M-ZWELS = lit_ZRETPOSDM001T06-VALOR.
  endif.
  lr_E1KNB1M-ZINDT = '00000000'.
  lr_E1KNB1M-ZINRT = '00'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_MIRO-FDGRV'.
  if sy-subrc = 0.
    lr_E1KNB1M-FDGRV = lit_ZRETPOSDM001T06-valor.
  endif.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_MIRO-ZTERM'.
  if sy-subrc = 0.
    lr_E1KNB1M-ZTERM = lit_ZRETPOSDM001T06-valor.
  endif.

  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_MIRO-GUZTE'.
  if sy-subrc = 0.
    lr_E1KNB1M-GUZTE = lit_ZRETPOSDM001T06-valor.
  endif.
  lr_E1KNB1M-VLIBB = '0'.
  lr_E1KNB1M-VRSZL = '0'.
  lr_E1KNB1M-VRSPR = '0'.
  lr_E1KNB1M-VERDT = '00000000'.
  lr_E1KNB1M-WEBTR = '0'.
  lr_E1KNB1M-DATLZ = '00000000'.
  lr_E1KNB1M-KULTG = '0'.
  read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_MIRO-HBKID'.
  if sy-subrc = 0.
    lr_E1KNB1M-HBKID = lit_ZRETPOSDM001T06-valor.
  endif.
  lr_E1KNB1M-PERNR = '00000000'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1KNB1M'.
  lit_idoc_containers-sdata   = lr_E1KNB1M.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_E1KNA1M.
  APPEND lit_idoc_containers.
  ld_Segnum_E1KNB1M = ld_segnum.

* Segmento E1KNB5M
*  clear lr_E1KNB5M.
*  lr_E1KNB5M-MSGFN = '005'.
*  lr_E1KNB5M-MAHNA = 'ZAME'.
*  lr_E1KNB5M-MADAT = '00000000'.
*  lr_E1KNB5M-MAHNS = '0'.
*  lr_E1KNB5M-GMVDT = '00000000'.
*
*  ADD 1 TO ld_segnum.
*  lit_idoc_containers-segnam  = 'E1KNB5M'.
*  lit_idoc_containers-sdata   = lr_E1KNB5M.
*  lit_idoc_containers-docnum  = ld_identifier.
*  lit_idoc_containers-segnum  = ld_segnum.
*  lit_idoc_containers-psgnum  = ld_segnum_E1KNB1M.
*  APPEND lit_idoc_containers.

*===================================================================================================
* Sociedad MIRO >> Fin
*===================================================================================================


* Añadimos segmentos
  PERFORM f_idoc_add_segmentos TABLES lit_idoc_containers
                               USING  ld_identifier
                               CHANGING lf_error.

* Cerramos IDOC
  PERFORM f_idoc_cerrar USING    ld_identifier
                        CHANGING lr_idoc_control_new
                                 lf_error.

* Cambiamos STATUS al idoc
  PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                      '64'
                              CHANGING lf_error.




* Hacemos commit
  COMMIT WORK AND WAIT.

* Desbloqueamos idoc
  CALL FUNCTION 'DEQUEUE_ALL'
*     EXPORTING
*       _SYNCHRON       = ' '
    .

  SUBMIT rbdapp01
    WITH docnum BETWEEN lr_idoc_control_new-docnum AND ''
    WITH p_output = space
    AND RETURN.

  ps_docnum = lr_idoc_control_new-docnum.

*>APRADAS-21.05.2020 10:32:40-Inicio
* Asignar a los datos de sociedad CAM el campo ZZCONDABONO

* Obtener datos de direccion con numero de idoc en nombre 4
  refresh lit_addrnumber.
  select addrnumber
    from adrc
    into table lit_addrnumber
   where name4 = pe_docnum.

* Determinar cliente a partir del numero de dirección
  loop at lit_addrnumber.
*   Para cada número de dirección

*   Obtener cliente asociado
    select single kunnr
      from kna1
      into ld_kunnr
     where adrnr = lit_addrnumber-addrnumber.

    if sy-subrc = 0.
*     Si encontramos cliente, actualizamos ZZCONDABONO en KNB1

      read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAN-ZZCONDABONO'.
      if sy-subrc = 0.
        update knb1
           set zzcondabono = lit_ZRETPOSDM001T06-valor
         where kunnr = ld_kunnr
           and bukrs = 'CAN'.

        COMMIT WORK and WAIT.
      endif.

      read table lit_ZRETPOSDM001T06 with key CAMPS = 'KNB1_CAI-ZZCONDABONO'.
      if sy-subrc = 0.
        update knb1
           set zzcondabono = lit_ZRETPOSDM001T06-valor
         where kunnr = ld_kunnr
           and bukrs = 'CAI'.

        COMMIT WORK and WAIT.
      endif.
    endif.
  endloop.
*<APRADAS-21.05.2020 10:32:40-Fin
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_IDOC_ABRIR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_6736   text
*----------------------------------------------------------------------*
FORM f_idoc_abrir  USING pe_operacion
                         pe_tienda
                CHANGING ps_lr_idoc_control STRUCTURE edidc
                         ps_identifier
                         ps_error.

* 0.- Declaracion de variables
*=======================================================================
  DATA: lit_hardcodes LIKE zhardcodes OCCURS 0 WITH HEADER LINE.

* 1.- Logica
*=======================================================================
* Inicializamos parámetros de salida
  CLEAR: ps_lr_idoc_control,
         ps_identifier,
         ps_error.

* Recuperamos los datos de configuración del IDOC a abrir
  SELECT *
    FROM zhardcodes
    INTO TABLE lit_hardcodes
   WHERE programa = pe_operacion.

  LOOP AT lit_hardcodes.
    CASE lit_hardcodes-param.
      WHEN 'DOCREL'.
        ps_lr_idoc_control-docrel = lit_hardcodes-valor.
      WHEN 'DIRECT'.
        ps_lr_idoc_control-direct = lit_hardcodes-valor.
      WHEN 'RCVPOR'.
        ps_lr_idoc_control-rcvpor = lit_hardcodes-valor.
      WHEN 'RCVPRT'.
        ps_lr_idoc_control-rcvprt = lit_hardcodes-valor.
      WHEN 'RCVPRN'.
        ps_lr_idoc_control-rcvprn = lit_hardcodes-valor.
      WHEN 'STDVRS'.
        ps_lr_idoc_control-stdvrs = lit_hardcodes-valor.
      WHEN 'STDMES'.
        ps_lr_idoc_control-stdmes = lit_hardcodes-valor.
      WHEN 'TEST'.
        ps_lr_idoc_control-test   = lit_hardcodes-valor.
      WHEN 'SNDPOR'.
        ps_lr_idoc_control-sndpor = lit_hardcodes-valor.
      WHEN 'SNDPRT'.
        ps_lr_idoc_control-sndprt = lit_hardcodes-valor.
      WHEN 'SNDPRN'.
        IF lit_hardcodes-valor = '<<TIENDA>>'.
          ps_lr_idoc_control-sndprn = pe_tienda.
        ELSE.
          ps_lr_idoc_control-sndprn = lit_hardcodes-valor.
        ENDIF.
      WHEN 'MESTYP'.
        ps_lr_idoc_control-mestyp = lit_hardcodes-valor.
      WHEN 'IDOCTP'.
        ps_lr_idoc_control-idoctp = lit_hardcodes-valor.
      WHEN 'SNDLAD'.
        ps_lr_idoc_control-sndlad = lit_hardcodes-valor.
      WHEN 'MESCOD'.
        ps_lr_idoc_control-mescod = lit_hardcodes-valor.
      WHEN 'MESFCT'.
        ps_lr_idoc_control-mesfct = lit_hardcodes-valor.
    ENDCASE.
  ENDLOOP.

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

*&---------------------------------------------------------------------*
*&      Form  f_add_segmentos
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->PE_IT_IDOC_CONTAINERS  text
*      -->PE_IDENTIFIER          text
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
*&      Form  F_IDOC_CERRAR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
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

*&---------------------------------------------------------------------*
*&      Form  F_CAMBIAR_STATUS_IDOC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LR_IDOC_CONTROL_NEW_DOCNUM  text
*      -->P_6890   text
*----------------------------------------------------------------------*
FORM f_idoc_cambiar_status  USING    pe_numidoc
                                     pe_status
                            CHANGING ps_error.
* 0.- Declaracion de variables
*=======================================================================
  DATA: lt_edids            TYPE TABLE OF bdidocstat WITH HEADER LINE.

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


FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
    CLEAR BDCDATA.
    BDCDATA-FNAM = FNAM.
    BDCDATA-FVAL = FVAL.
    APPEND BDCDATA.
ENDFORM.
