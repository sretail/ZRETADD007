FUNCTION zidoc_input_zzcreatemultiple .
*"----------------------------------------------------------------------
*"*"Interfase global
*"  IMPORTING
*"     VALUE(INPUT_METHOD) LIKE  BDWFAP_PAR-INPUTMETHD
*"     VALUE(MASS_PROCESSING) LIKE  BDWFAP_PAR-MASS_PROC
*"  EXPORTING
*"     VALUE(WORKFLOW_RESULT) LIKE  BDWFAP_PAR-RESULT
*"     VALUE(APPLICATION_VARIABLE) LIKE  BDWFAP_PAR-APPL_VAR
*"     VALUE(IN_UPDATE_TASK) LIKE  BDWFAP_PAR-UPDATETASK
*"     VALUE(CALL_TRANSACTION_DONE) LIKE  BDWFAP_PAR-CALLTRANS
*"  TABLES
*"      IDOC_CONTRL STRUCTURE  EDIDC
*"      IDOC_DATA STRUCTURE  EDIDD
*"      IDOC_STATUS STRUCTURE  BDIDOCSTAT
*"      RETURN_VARIABLES STRUCTURE  BDWFRETVAR
*"      SERIALIZATION_INFO STRUCTURE  BDI_SER
*"  EXCEPTIONS
*"      WRONG_FUNCTION_CALLED
*"----------------------------------------------------------------------
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_zztransaction              LIKE zztransaction     OCCURS 0 WITH HEADER LINE,
        lit_zzlineitem                 LIKE zzlineitem        OCCURS 0 WITH HEADER LINE,
        lit_zzlineitemdisc             LIKE zzlineitemdisc    OCCURS 0 WITH HEADER LINE,
        lit_zztender                   LIKE zztender          OCCURS 0 WITH HEADER LINE,
        lit_zzlineitemdiscex           LIKE zzlineitemdiscex  OCCURS 0 WITH HEADER LINE,
        lit_zzcustdetails              LIKE zzcustdetails     OCCURS 0 WITH HEADER LINE,
        lit_zzlineitem2web             LIKE zzlineitem2web    OCCURS 0 WITH HEADER LINE,
        lr_zzposdwe1bpsourcedocumentli LIKE zzposdwe1bpsourcedocumentli,
        lr_zzposdwe1bptransaction      LIKE zzposdwe1bptransaction,
        lr_zzposdwe1bpretaillineitem   LIKE zzposdwe1bpretaillineitem,
        lr_zzposdwe1bplineitemdiscount LIKE zzposdwe1bplineitemdiscount,
        lr_zzposdwe1bptender           LIKE zzposdwe1bptender,
        lr_zzposdwe1bplineitemdiscext  LIKE zzposdwe1bplineitemdiscext,
        lr_zzposdwe1bpcustomerdetails  LIKE zzposdwe1bpcustomerdetails,
        lr_datos_cliente               LIKE zretposdm001s24,
        ld_sap_code                    LIKE t006-msehi,
        ld_iso_code                    LIKE t006-isocode,
        ld_menge_in                    LIKE ekpo-menge,
        ld_menge_out                   LIKE ekpo-menge,
        ld_l02oripvo                   LIKE zposdm001-l02oripvo,
        ld_salesamount(10),
        ld_salesamountsiva(10),
        ld_salesamount_abs             TYPE zzsalesamount,
        ld_salesamountsiva_abs         TYPE zzsalesamountsiva,
        lf_check_errores               LIKE zhardcodes-valor,
        ld_matkl                       LIKE mara-matkl,
        ld_pltyp                       LIKE wrf6-pltyp_p,
        ld_sum_salesamount             LIKE zzlineitem-salesamount,
        ld_sum_tenderamount            LIKE zztender-tenderamount,
        wa_mean                        LIKE mean,
        ld_meins                       LIKE mara-meins,
        ld_taklv                       LIKE mara-taklv,
        lf_error                       TYPE char1,
        lf_noval_imp                   TYPE char1,
        lf_catalogado                  TYPE char1,
        ld_verpr                       LIKE mbew-verpr,
        ld_stprs                       LIKE mbew-stprs,
        ld_vprsv                       LIKE mbew-vprsv,
        ld_bukrs                       TYPE bukrs,
        ld_zpr1                        LIKE konp-kbetr,
        ld_kunnr_con_desc              TYPE kunnr,
        BEGIN OF lit_descuentos OCCURS 0,
          kschl LIKE a986-kschl,
          kbetr LIKE konp-kbetr,
          konwa LIKE konp-konwa,
        END OF lit_descuentos,
        ld_pbcs        TYPE zretcan004_zzpbcs,
        ld_sydatum(10),
        ld_costt(12).

  RANGES: lran_kschl_con_desc FOR a986-kschl.

* 1.- Lógica
*==========================================================================
* Recuperamos datos de control del idoc
  READ TABLE idoc_contrl INDEX 1.

*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> APRADAS @ 14.05.2024 18:45:04 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Inicio
* Obtener cliente "genérico" que contiene los descuentos
  CLEAR ld_kunnr_con_desc.
  SELECT SINGLE valor
    FROM zhardcodes
    INTO ld_kunnr_con_desc
   WHERE programa = 'ZRETCAN005'
     AND param    = 'CLI_CON_DESC'.

* Obtener clases de condición a tener en cuenta
  REFRESH lran_kschl_con_desc.
  lran_kschl_con_desc-sign = 'I'.
  lran_kschl_con_desc-option = 'EQ'.

  SELECT valor
    FROM zhardcodes
    INTO lran_kschl_con_desc-low
   WHERE programa = 'ZRETCAN005'
     AND param    = 'KSCHL_CON_DESC'.
    APPEND lran_kschl_con_desc.
  ENDSELECT.
*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< APRADAS @ 14.05.2024 18:45:04 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Fin

* APRADAS-Inicio-22.04.2019 09:33:43>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
* Precargamos datos del cliente recibidos en el ticket de venta para despues
* pasárselos a la rutina de verificación de ticket
  LOOP AT idoc_data WHERE segnam = 'ZZPOSDWE1BPCUSTOMERDETAILS'.
    lr_zzposdwe1bpcustomerdetails = idoc_data-sdata.

    CASE lr_zzposdwe1bpcustomerdetails-dataelementid.
      WHEN 'NOMBRE'.
        lr_datos_cliente-nombre = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
      WHEN 'APELLIDOS'.
        lr_datos_cliente-apellidos = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
      WHEN 'RAZONSOCIAL'.
        lr_datos_cliente-razonsocial = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
      WHEN 'POBLACION'.
        lr_datos_cliente-poblacion = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
      WHEN 'CP'.
        lr_datos_cliente-cp = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
*       APRADAS-Inicio-07.05.2019 06:59:04>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        IF strlen( lr_datos_cliente-cp ) = 4.
          CONCATENATE '0' lr_datos_cliente-cp INTO lr_datos_cliente-cp.
        ENDIF.
*       APRADAS-Fin-07.05.2019 06:59:04<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      WHEN 'IDFISCAL'.
        lr_datos_cliente-idfiscal = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
        TRANSLATE lr_datos_cliente-idfiscal TO UPPER CASE.
      WHEN 'CALLE'.
        lr_datos_cliente-calle = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
      WHEN 'NUMERO'.
        lr_datos_cliente-numero = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
      WHEN 'PISO'.
        lr_datos_cliente-piso = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
      WHEN 'EMAIL'.
        lr_datos_cliente-email = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
*     APRADAS-20.04.2020 12:40:54-Inicio
      WHEN 'TELEFONO'.
        lr_datos_cliente-telefono = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
*     APRADAS-20.04.2020 12:40:54-Fin
    ENDCASE.
  ENDLOOP.
* APRADAS-Fin-22.04.2019 09:33:43<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

* Registramos en BBDD el ticket
  LOOP AT idoc_data.
    CASE idoc_data-segnam.
      WHEN 'ZZPOSDWE1BPSOURCEDOCUMENTLI'.
        lr_zzposdwe1bpsourcedocumentli  = idoc_data-sdata.
      WHEN 'ZZPOSDWE1BPTRANSACTION'.
*       Cabecera ticket
        lr_zzposdwe1bptransaction = idoc_data-sdata.
        PERFORM f_fill_zztransaction TABLES lit_zztransaction USING lr_zzposdwe1bpsourcedocumentli idoc_data-sdata idoc_contrl-docnum lr_datos_cliente.

      WHEN 'ZZPOSDWE1BPRETAILLINEITEM'.
*       Linea ticket

        lr_zzposdwe1bpretaillineitem = idoc_data-sdata.

        CLEAR lit_zzlineitem.
        lit_zzlineitem-retailstoreid             = lr_zzposdwe1bpretaillineitem-retailstoreid.
        lit_zzlineitem-operatorid                = lr_zzposdwe1bptransaction-operatorid.
        lit_zzlineitem-businessdaydate           = lr_zzposdwe1bpretaillineitem-businessdaydate.
        lit_zzlineitem-transactionsequencenumber = lr_zzposdwe1bpretaillineitem-transactionsequencenumber.
        lit_zzlineitem-retailsequencenumber      = lr_zzposdwe1bpretaillineitem-retailsequencenumber.
        lit_zzlineitem-transactiontypecode       = lit_zztransaction-transactiontypecode.
        lit_zzlineitem-workstationid             = lr_zzposdwe1bpretaillineitem-workstationid.
        lit_zzlineitem-retailtypecode            = lr_zzposdwe1bpretaillineitem-retailtypecode.
        lit_zzlineitem-retailreasoncode          = lr_zzposdwe1bpretaillineitem-retailreasoncode.
        lit_zzlineitem-itemidqualifier           = lr_zzposdwe1bpretaillineitem-itemidqualifier.
        lit_zzlineitem-waers                     = lr_zzposdwe1bptransaction-transactioncurrency.
        lit_zzlineitem-normalsalesamount         = lr_zzposdwe1bpretaillineitem-normalsalesamount.
        lit_zzlineitem-normalsalesamountsiva     = lr_zzposdwe1bpretaillineitem-cost.
        lit_zzlineitem-salesamount               = lr_zzposdwe1bpretaillineitem-salesamount.
        lit_zzlineitem-batchid                   = lr_zzposdwe1bpretaillineitem-batchid.
        lit_zzlineitem-serialnumber              = lr_zzposdwe1bpretaillineitem-serialnumber.
        lit_zzlineitem-itemidentrymethodcode     = lr_zzposdwe1bpretaillineitem-itemidentrymethodcode.
        lit_zzlineitem-units                     = lr_zzposdwe1bpretaillineitem-units.
        lit_zzlineitem-scantime                  = lr_zzposdwe1bpretaillineitem-scantime.
        lit_zzlineitem-itemidt                   = lr_zzposdwe1bpretaillineitem-itemidt.
        lit_zzlineitem-actualunitprice           = lr_zzposdwe1bpretaillineitem-actualunitprice.



*>>>>>>>Verificación código de artículo
        IF lit_zztransaction-transactiontypecode <> 'ZCCJ' AND
           lit_zztransaction-transactiontypecode <> 'ZBCJ'.
*         Solo veirificaremos el artículo cuando no sea un cierre de caja,
*         ya que en el cierre de caja el artículo es ficticio
          CASE lr_zzposdwe1bpretaillineitem-itemidqualifier.
            WHEN ''.
*             Error: Linea & con ITEMIDQUALIFIER sin informar
              PERFORM idoc_status_fuellen USING 'E'
                                                'ZRETPOSDM001'
                                                '035'
                                                lit_zzlineitem-retailsequencenumber
                                                ''
                                                ''
                                                ''.
            WHEN '2'.
*             Si nos llega un EAN...

*             Asignamos EAN en el campo correcto
              lit_zzlineitem-serialnumber = lr_zzposdwe1bpretaillineitem-itemid.
              CLEAR lit_zzlineitem-itemid.

*             Obtener artículo asociado al EAN
              PERFORM f_get_matnr_from_ean USING lit_zzlineitem-serialnumber CHANGING lit_zzlineitem-itemid.

              IF lit_zzlineitem-itemid IS INITIAL.
*               Msg: Para el código EAN &-& no se ha podido determinar ningun artículo.
                PERFORM idoc_status_fuellen USING 'E'
                                                  'ZRETPOSDM001'
                                                  '011'
                                                  lit_zzlineitem-serialnumber
                                                  lr_zzposdwe1bpretaillineitem-itemidt
                                                  ''
                                                  ''.
              ENDIF.
            WHEN '1'.
*             Si nos llega un código de articulo...
              lit_zzlineitem-itemid                    = lr_zzposdwe1bpretaillineitem-itemid.

*             Verificar código de artículo existe
              SELECT SINGLE matnr
                FROM mara
                INTO lit_zzlineitem-itemid
               WHERE matnr = lit_zzlineitem-itemid
                 AND lvorm = ''.

              IF sy-subrc <> 0.
*               Msg: El artículo &-& no existe en el sistema.
                PERFORM idoc_status_fuellen USING 'E'
                                                  'ZRETPOSDM001'
                                                  '012'
                                                  lit_zzlineitem-itemid
                                                  lr_zzposdwe1bpretaillineitem-itemidt
                                                  ''
                                                  ''.

              ELSE.
                CLEAR lf_error.
                IF lr_zzposdwe1bpretaillineitem-salesunitofmeasure IS NOT INITIAL.
*                 Si llega unidad, verificar que el articulo la tenga dada de alta y con ean
                  CALL FUNCTION 'CONVERSION_EXIT_CUNIT_INPUT'
                    EXPORTING
                      input          = lr_zzposdwe1bpretaillineitem-salesunitofmeasure
*                     LANGUAGE       = SY-LANGU
                    IMPORTING
                      output         = lr_zzposdwe1bpretaillineitem-salesunitofmeasure
                    EXCEPTIONS
                      unit_not_found = 1
                      OTHERS         = 2.
                  IF sy-subrc <> 0. ENDIF.

                  SELECT SINGLE matnr
                    FROM mean
                    INTO lit_zzlineitem-itemid
                   WHERE matnr = lit_zzlineitem-itemid
                     AND meinh = lr_zzposdwe1bpretaillineitem-salesunitofmeasure
                     AND ean11 <> ''.

                  IF sy-subrc <> 0.
                    lf_error = 'X'.

*                   Error: El artículo &-& no está dado de alta para la unidad de medida &.
                    PERFORM idoc_status_fuellen USING 'E'
                                                      'ZRETPOSDM001'
                                                      '029'
                                                      lit_zzlineitem-itemid
                                                      lr_zzposdwe1bpretaillineitem-itemidt
                                                      lr_zzposdwe1bpretaillineitem-salesunitofmeasure
                                                      ''.
                  ENDIF.
                ELSE.
*                 Si no llega unidad, verificar que el articulo la tenga dada de alta con EAN
                  SELECT SINGLE meins
                    FROM mara
                    INTO ld_meins
                   WHERE matnr = lit_zzlineitem-itemid.

                  SELECT SINGLE matnr
                   FROM mean
                   INTO lit_zzlineitem-itemid
                  WHERE matnr = lit_zzlineitem-itemid
                    AND meinh = ld_meins
                    AND ean11 <> ''.

                  IF sy-subrc <> 0.
                    lf_error = 'X'.

                    CALL FUNCTION 'CONVERSION_EXIT_CUNIT_OUTPUT'
                      EXPORTING
                        input          = ld_meins
*                       LANGUAGE       = SY-LANGU
                      IMPORTING
*                       LONG_TEXT      =
                        output         = ld_meins
*                       SHORT_TEXT     =
                      EXCEPTIONS
                        unit_not_found = 1
                        OTHERS         = 2.

                    IF sy-subrc <> 0. ENDIF.

*                   El artículo &-& no está dado de alta para la unidad de medida &.
                    PERFORM idoc_status_fuellen USING 'E'
                                                      'ZRETPOSDM001'
                                                      '029'
                                                      lit_zzlineitem-itemid
                                                      lr_zzposdwe1bpretaillineitem-itemidt
                                                      ld_meins
                                                      ''.
                  ENDIF.
                ENDIF.

                IF lf_error IS INITIAL.
*                 Recuperar UMB del artículo
                  SELECT SINGLE meins
                    FROM mara
                    INTO ld_meins
                   WHERE matnr = lit_zzlineitem-itemid.

                  IF lr_zzposdwe1bpretaillineitem-salesunitofmeasure IS NOT INITIAL AND
                     ld_meins <> lr_zzposdwe1bpretaillineitem-salesunitofmeasure.
*                   Si nos llega del TPV la unidad de venta y ésta difiere de la UMB del articulo
*                   recuperamos el EAN de la unidad de venta recibida
                    SELECT SINGLE ean11
                      INTO lit_zzlineitem-serialnumber
                      FROM mean
                     WHERE matnr = lit_zzlineitem-itemid
                       AND meinh = lr_zzposdwe1bpretaillineitem-salesunitofmeasure.
                  ELSE.
*                   Recuperar EAN asociado al artículo (UMB)
                    SELECT SINGLE mean~ean11
                      INTO lit_zzlineitem-serialnumber
                      FROM mean JOIN mara ON mara~matnr = mean~matnr AND mean~meinh = mara~meins
                     WHERE mara~matnr = lit_zzlineitem-itemid.
                  ENDIF.
                ENDIF.
              ENDIF.
          ENDCASE.
        ENDIF.

*       APRADAS-Inicio-04.12.2018
*>>>>>>>Verificación artículo catalogado en la tienda
        PERFORM f_check_art_catalog USING lit_zzlineitem-itemid lit_zzlineitem-retailstoreid CHANGING lf_catalogado.

        IF lf_catalogado = ''.
*         Art. &-& no catalogado en tienda &.
          PERFORM f_get_matnrt USING lit_zzlineitem-itemid CHANGING lit_zzlineitem-itemidt.
          PERFORM idoc_status_fuellen USING 'E'
                                            'ZRETPOSDM001'
                                            '036'
                                            lit_zzlineitem-itemid
                                            lit_zzlineitem-itemidt
                                            lit_zzlineitem-retailstoreid
                                            ''.
        ENDIF.
*       APRADAS-Fin-04.12.2018

*>>>>>>>Recuperar UMB del articulo
        SELECT SINGLE meins
          FROM mara
          INTO lit_zzlineitem-salesunitofmeasure
         WHERE matnr = lit_zzlineitem-itemid.

*>>>>>>>Recuperar UMB en código ISO
        CLEAR ld_iso_code.
        ld_sap_code = lit_zzlineitem-salesunitofmeasure.
        CALL FUNCTION 'UNIT_OF_MEASURE_SAP_TO_ISO'
          EXPORTING
            sap_code    = ld_sap_code
          IMPORTING
            iso_code    = ld_iso_code
          EXCEPTIONS
            not_found   = 1
            no_iso_code = 2
            OTHERS      = 3.
        IF sy-subrc <> 0. ENDIF.

        lit_zzlineitem-salesunitofmeasure_iso = ld_iso_code.

*>>>>>>>Determinar precio de venta actual
*       Obtener grupo de articulos del artículo
        CLEAR ld_matkl.
        SELECT SINGLE matkl
          FROM mara
          INTO ld_matkl
         WHERE matnr = lit_zzlineitem-itemid.

*       Obtener lista de precios
        SELECT SINGLE pltyp_p
          FROM wrf6
          INTO ld_pltyp
         WHERE locnr = lr_zzposdwe1bpretaillineitem-retailstoreid
           AND matkl = ld_matkl.

*       Obtener precio de venta actual
        IF lit_zzlineitem-actualunitprice IS INITIAL.
          SELECT SINGLE bukrs
            FROM t001k
            INTO ld_bukrs
           WHERE bwkey = lit_zzlineitem-retailstoreid.

          SELECT SINGLE konp~kbetr
            FROM a073 JOIN konp ON konp~knumh = a073~knumh
            INTO lit_zzlineitem-actualunitprice
           WHERE a073~kappl = 'V'
             AND a073~kschl = 'VKP0'
             AND a073~vkorg = ld_bukrs
             AND a073~vtweg = '10'
             AND a073~matnr = lit_zzlineitem-itemid
             AND a073~vrkme = lit_zzlineitem-salesunitofmeasure
             AND a073~datbi >= lit_zzlineitem-businessdaydate
             AND a073~datab <= lit_zzlineitem-businessdaydate
             AND konp~loevm_ko = ''.
        ENDIF.

*      >Determinar precio de coste del artículo
*       Buscar el PMP del artículo en el sistema
        CLEAR: ld_verpr,
               ld_stprs,
               ld_vprsv.

        SELECT SINGLE verpr
                      stprs
                      vprsv
          FROM mbew
          INTO (ld_verpr,
                ld_stprs,
                ld_vprsv)
         WHERE matnr = lit_zzlineitem-itemid
           AND bwkey = lit_zzlineitem-retailstoreid.

*       Asignar PMP en funcion del control de precio
        CASE ld_vprsv.
          WHEN 'V'.
*           Si control de precio es V (Precio medio variable/Precio interno periódico), asignamos PMP
*           como precio de coste
            lit_zzlineitem-cost = ld_verpr.
          WHEN 'S'.
*           Si control de precio es X (Precio estándar), asignamos Precio estándar como precio de coste
            lit_zzlineitem-cost = ld_stprs.
        ENDCASE.

        IF lit_zzlineitem-cost IS INITIAL AND
           lit_zzlineitem-itemid IS NOT INITIAL.
*         Si el coste del artículo es 0...

*         Miramos si para ese artículo se debe obviar que el coste sea 0 y no de error
          SELECT SINGLE valor
            FROM zhardcodes
            INTO lit_zzlineitem-itemid
           WHERE programa = 'ZIDOC_INPUT_ZZCREATEMULTIPLE'
             AND param    = 'PMP_DESCARTAR'
             AND valor    = lit_zzlineitem-itemid.

          IF sy-subrc <> 0.
*           Si el articulo no está dentro de los descartados para la validación...

            IF ld_vprsv = 'V'.
*             Si control de precios es V

*             Determinamos condición de precio ZPR0/ZPR1 vigente del artículo
              IF lit_zzlineitem-retailstoreid(1) = 'T'.
*               FSG ini 14.05.2024 - EVO-831 - Coste Ventas intercos (que no tienen PMP)
                "A partir de ahora seleccionaremos el pmp del almacén
                SELECT SINGLE mbew~verpr
                  INTO lit_zzlineitem-cost
                  FROM mbew
                  WHERE matnr = lit_zzlineitem-itemid
                  AND bwkey = 'CD01'.

                "" Esta es la obtención antigua del valor
*
*                  SELECT SINGLE konp~kbetr
*                  INTO lit_zzlineitem-cost
*                  FROM konp JOIN a073 ON a073~knumh = konp~knumh
*                 WHERE a073~kappl = 'V'
*                   AND a073~kschl = 'ZPR0'
*                   AND a073~vkorg = 'CAN'
*                   AND a073~vtweg = '20'
*                   AND a073~matnr = lit_zzlineitem-itemid
*                   AND a073~vrkme = lit_zzlineitem-salesunitofmeasure
*                   AND a073~datbi >= sy-datum
*                   AND a073~datab <= sy-datum.
*               FSG fin 14.05.2024 - EVO-831 - Coste Ventas intercos (que no tienen PMP)

              ELSEIF lit_zzlineitem-retailstoreid(1) = 'C' OR lit_zzlineitem-retailstoreid(1) = 'M'.
*               FSG ini 14.05.2024 - EVO-831 - Coste Ventas intercos (que no tienen PMP)
                "" Si es una tienda Caibelsa
                "" asignaremos ZPR1 menos los descuentos de venta
                "" que tiene el cliente Genérico T1

*               Obtener precio ZPR1
                CLEAR: ld_zpr1,
                       ld_pbcs.

                PERFORM f_get_zpr1 IN PROGRAM zretcan005 USING    lit_zzlineitem-itemid
                                                                  lit_zzlineitem-salesunitofmeasure
                                                         CHANGING ld_zpr1
                                                                  ld_pbcs.


*               Obtenemos descuentos para el artículo en el sistema vigentes para las clases de condición de
*               descuento y cliente "genérico" parametrizadas
                REFRESH lit_descuentos.
                SELECT a986~kschl,
                       konp~kbetr,
                       konp~konwa
                  FROM a986 JOIN konp ON konp~knumh = a986~knumh AND konp~loevm_ko = ''
                  APPENDING TABLE @lit_descuentos
                 WHERE a986~kappl = 'V'
                   AND a986~kschl IN @lran_kschl_con_desc
                   AND a986~vkorg = 'CAN'
                   AND a986~kunnr = @ld_kunnr_con_desc
                   AND a986~matnr = @lit_zzlineitem-itemid
                   AND a986~datbi >= @sy-datum
                   AND a986~datab <= @sy-datum.

*               Aplicamos descuentos
                LOOP AT lit_descuentos.
                  CASE lit_descuentos-konwa.
                    WHEN '%'.
*                     Si la condición es porcentual, descontamos en base al precio original
                      IF ld_zpr1 IS NOT INITIAL.
                        ld_zpr1 = ld_zpr1 + ( ld_zpr1 * ( lit_descuentos-kbetr / 1000 ) ).
                      ENDIF.
                    WHEN OTHERS.
*                     Si la condición es de importe, descontamos directamente el importe
                      IF ld_zpr1 IS NOT INITIAL.
                        ld_zpr1 = ld_zpr1 + lit_descuentos-kbetr.
                      ENDIF.
                  ENDCASE.
                ENDLOOP.

                lit_zzlineitem-cost = ld_zpr1.

*               FSG fin 14.05.2024 - EVO-831 - Coste Ventas intercos (que no tienen PMP)
*                SELECT SINGLE konp~kbetr
*                  INTO lit_zzlineitem-cost
*                  FROM konp JOIN a073 ON a073~knumh = konp~knumh
*                 WHERE a073~kappl = 'V'
*                   AND a073~kschl = 'ZPR1'
*                   AND a073~vkorg = 'CAN'
*                   AND a073~vtweg = '20'
*                   AND a073~matnr = lit_zzlineitem-itemid
*                   AND a073~vrkme = lit_zzlineitem-salesunitofmeasure
*                   AND a073~datbi >= sy-datum
*                   AND a073~datab <= sy-datum.
              ENDIF.

              IF lit_zzlineitem-cost IS INITIAL.
*               Si no hemos determinado condición ZPR0/ZPR1 => Error

*               MsgE: PMP del artículo &-& es 0.
                PERFORM idoc_status_fuellen USING 'E'
                                                  'ZRETPOSDM001'
                                                  '039'
                                                  lit_zzlineitem-itemid
                                                  lit_zzlineitem-itemidt
                                                  ''
                                                  ''.
              ELSE.
*               Si hemos determinado condición ZPR0/ZPR1, actualizamos el PMP del artículo en la tienda
                REFRESH: bdcdata,
                         messtab.

                WRITE sy-datum TO ld_sydatum.
                WRITE lit_zzlineitem-cost TO ld_costt LEFT-JUSTIFIED CURRENCY 'EUR' DECIMALS 2.

*               Batch input MR21
                PERFORM bdc_dynpro      USING 'SAPRCKM_MR21'                '0201'.                       "Dynpro 201
                PERFORM bdc_field       USING 'BDC_OKCODE'                  '=ENTR'.                      "Damos a ENTER
                PERFORM bdc_field       USING 'MR21HEAD-BUDAT'              ld_sydatum.                   "Fecha contabilización
                IF lit_zzlineitem-retailstoreid(1) = 'T'.
                  PERFORM bdc_field       USING 'MR21HEAD-BUKRS'            'CAN'.                        "Sociedad para tiendas T*
                ELSEIF lit_zzlineitem-retailstoreid(1) = 'C'.
                  PERFORM bdc_field       USING 'MR21HEAD-BUKRS'            'CAI'.                        "Sociedad para tiendas C*
*               FSG ini 14.05.2024 - EVO-831 - Coste Ventas intercos (que no tienen PMP)
                ELSEIF lit_zzlineitem-retailstoreid(1) = 'M'.
                  PERFORM bdc_field       USING 'MR21HEAD-BUKRS'            'MIRO'.                        "Sociedad para tiendas M*

*               FSG fin 14.05.2024 - EVO-831 - Coste Ventas intercos (que no tienen PMP)
                ENDIF.

                PERFORM bdc_dynpro      USING 'SAPRCKM_MR21'                '0201'.                       "Dynpro 0201
                PERFORM bdc_field       USING 'BDC_OKCODE'                  '=ENTR'.                      "Damos a ENTER
                PERFORM bdc_field       USING 'CKI_MR21_0250-MATNR(01)'     lit_zzlineitem-itemid.        "Articulo
                PERFORM bdc_field       USING 'CKI_MR21_0250-BWKEY(01)'     lit_zzlineitem-retailstoreid. "Tienda

                PERFORM bdc_dynpro      USING 'SAPRCKM_MR21'                '0201'.                       "Dynpro 0201
                PERFORM bdc_field       USING 'BDC_OKCODE'                  '=ENTR'.                      "Damos a ENTER
                PERFORM bdc_field       USING 'CKI_MR21_0250-NEWVALPR(01)'  ld_costt.                     "PMP

                PERFORM bdc_dynpro      USING 'SAPRCKM_MR21' '0201'.                                      "Dynpro 0201
                PERFORM bdc_field       USING 'BDC_OKCODE'  '=SAVE'.                                      "Damos a grabar

                CALL TRANSACTION 'MR21' USING bdcdata MESSAGES INTO messtab MODE 'N'.

                COMMIT WORK AND WAIT.
              ENDIF.
            ELSE.
*             Si control de precios no es V => Error

*             MsgE: PMP del artículo &-& es 0.
              PERFORM idoc_status_fuellen USING 'E'
                                                'ZRETPOSDM001'
                                                '039'
                                                lit_zzlineitem-itemid
                                                lit_zzlineitem-itemidt
                                                ''
                                                ''.
            ENDIF.
          ENDIF.
        ENDIF.

*>>>>>>>Convertir cantidad linea de ticket a UMB

*       Recuperar datos del ean
        CLEAR wa_mean.
        SELECT SINGLE *
          FROM mean
          INTO wa_mean
         WHERE ean11 =  lit_zzlineitem-serialnumber.

        IF wa_mean-meinh <> lit_zzlineitem-salesunitofmeasure.
*         Si unidad del EAN de la venta difiere de la UMB del articulo

*         Convertir cantidad del ticket a UMB
          IF lr_zzposdwe1bpretaillineitem-retailquantity < 0.
            ld_menge_in = lr_zzposdwe1bpretaillineitem-retailquantity * ( -1 ).
          ELSE.
            ld_menge_in = lr_zzposdwe1bpretaillineitem-retailquantity.
          ENDIF.

          CALL FUNCTION 'MD_CONVERT_MATERIAL_UNIT'
            EXPORTING
              i_matnr              = wa_mean-matnr
              i_in_me              = wa_mean-meinh
              i_out_me             = lit_zzlineitem-salesunitofmeasure
              i_menge              = ld_menge_in
            IMPORTING
              e_menge              = ld_menge_out
            EXCEPTIONS
              error_in_application = 1
              error                = 2
              OTHERS               = 3.

          IF sy-subrc <> 0. ENDIF.

          IF lit_zzlineitem-retailquantity < 0.
            lit_zzlineitem-retailquantity = ld_menge_out * ( -1 ).
          ELSE.
            lit_zzlineitem-retailquantity = ld_menge_out.
          ENDIF.

        ELSE.
*         Si UMB = Unidad del ean, asignamos cantidad directamente
          lit_zzlineitem-retailquantity = lr_zzposdwe1bpretaillineitem-retailquantity.
        ENDIF.

*>>>>>>>Salesamountsiva
        CLEAR ld_taklv.
        SELECT SINGLE taklv
          FROM mara
          INTO ld_taklv
         WHERE matnr = lit_zzlineitem-itemid.

        CASE ld_taklv.
          WHEN '0'. ">>>>>>>>>>>>>CCOTILLA 10.10.2019 --> cuando IVA del artículo sea 0
            lit_zzlineitem-salesamountsiva = lit_zzlineitem-salesamount.
          WHEN '1'.
            lit_zzlineitem-salesamountsiva = lit_zzlineitem-salesamount / '1.04'. "- ( ( lit_zzlineitem-salesamount * 4 ) / 100 ).
          WHEN '2'.
            lit_zzlineitem-salesamountsiva = lit_zzlineitem-salesamount / '1.1'. "- ( ( lit_zzlineitem-salesamount * 10 ) / 100 ).
          WHEN '3'.
            lit_zzlineitem-salesamountsiva = lit_zzlineitem-salesamount / '1.21'. "- ( ( lit_zzlineitem-salesamount * 21 ) / 100 ).
          WHEN '4'. ">>>>>>>>>>>>>CCOTILLA 07.01.2020 --> Nuevo Indicador IVA
            lit_zzlineitem-salesamountsiva = lit_zzlineitem-salesamount / '1.04'. "- ( ( lit_zzlineitem-salesamount * 4 ) / 100 ).
          WHEN '5'. ">>>>>>>>>>>>>CCOTILLA 07.01.2020 --> Nuevo Indicador IVA
            lit_zzlineitem-salesamountsiva = lit_zzlineitem-salesamount / '1.1'. "- ( ( lit_zzlineitem-salesamount * 10 ) / 100 ).
          WHEN '6'. ">>>>>>>>>>>>>CCOTILLA 07.01.2020 --> Nuevo Indicador IVA
            lit_zzlineitem-salesamountsiva = lit_zzlineitem-salesamount / '1.21'. "- ( ( lit_zzlineitem-salesamount * 21 ) / 100 ).
        ENDCASE.


*>>>>>>>Validacion PVP sin iva < PVP
        IF lit_zztransaction-transactiontypecode <> 'ZCCJ' AND
           lit_zztransaction-transactiontypecode <> 'ZBCJ'.
*         Si el ticket no es un cierre de caja...

          IF lit_zzlineitem-salesamountsiva > 0.
            ld_salesamountsiva_abs = lit_zzlineitem-salesamountsiva.
          ELSE.
            ld_salesamountsiva_abs = lit_zzlineitem-salesamountsiva * ( -1 ).
          ENDIF.

          IF lit_zzlineitem-salesamount > 0.
            ld_salesamount_abs = lit_zzlineitem-salesamount.
          ELSE.
            ld_salesamount_abs = lit_zzlineitem-salesamount * ( -1 ).
          ENDIF.


          IF ld_salesamountsiva_abs > ld_salesamount_abs.
*            Si PVP sin iva > PVP => Error --> CCOTILLA 20.11.2018 --> quitamos la igualdad
            PERFORM f_get_matnrt USING lit_zzlineitem-itemid CHANGING lit_zzlineitem-itemidt.

            WRITE lit_zzlineitem-salesamount TO ld_salesamount LEFT-JUSTIFIED.
            WRITE lit_zzlineitem-salesamountsiva TO ld_salesamountsiva LEFT-JUSTIFIED.

            PERFORM idoc_status_fuellen USING 'E'
                                              'ZRETPOSDM001'
                                              '033'
                                              lit_zzlineitem-itemid
                                              lit_zzlineitem-itemidt
                                              ld_salesamount
                                              ld_salesamountsiva.
          ENDIF.
        ENDIF.

*       APRADAS-Inicio-21.11.2018 14:43:05>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*       Validacion RETAILQUANTITY y SALESAMOUNT sean del mismo signo
        IF ( lit_zzlineitem-retailquantity > 0 AND lit_zzlineitem-salesamount < 0 ) OR
           ( lit_zzlineitem-retailquantity < 0 AND lit_zzlineitem-salesamount > 0 ).

*         Si signos cambiados, miramos si el articulo está parametrizado como de descuento
          SELECT SINGLE valor
            FROM zhardcodes
            INTO lit_zzlineitem-itemid
           WHERE programa = 'ZRETPOSDM001'
             AND param    = 'ART_DESC'
             AND valor    = lit_zzlineitem-itemid.

          IF sy-subrc <> 0.
*           Si no es un articulo no parametrizado => Error

*           Error: Linea & con diferente signo en SALESAMOUNT/RETAILQUANTITY
            PERFORM idoc_status_fuellen USING 'E'
                                              'ZRETPOSDM001'
                                              '034'
                                              lit_zzlineitem-retailsequencenumber
                                              ''
                                              ''
                                              ''.
          ELSE.
*           Si articulo parametrizado de descuento...

            IF lit_zzlineitem-retailquantity > 0 AND lit_zzlineitem-salesamount < 0.
*             Si cantidad > 0 y importe < 0, cambiamos signo de la cantidad
              lit_zzlineitem-retailquantity = lit_zzlineitem-retailquantity * ( -1 ).
            ELSE.
*             Si no, seguimos reportando error

*             Error: Linea & con diferente signo en SALESAMOUNT/RETAILQUANTITY
              PERFORM idoc_status_fuellen USING 'E'
                                                'ZRETPOSDM001'
                                                '034'
                                                lit_zzlineitem-retailsequencenumber
                                                ''
                                                ''
                                                ''.
            ENDIF.
          ENDIF.
        ENDIF.
*       APRADAS-Fin-21.11.2018 14:43:05<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

*>>>>>>>salesamountsoloiva
        lit_zzlineitem-salesamountsoloiva = lit_zzlineitem-salesamount - lit_zzlineitem-salesamountsiva.

*>>>>>>>normalsalesamountsiva
        CLEAR ld_taklv.
        SELECT SINGLE taklv
          FROM mara
          INTO ld_taklv
         WHERE matnr = lit_zzlineitem-itemid.

        CASE ld_taklv.
          WHEN '0'. ">>>>>>>>>>>>>CCOTILLA 10.10.2019 --> cuando IVA del artículo sea 0
            lit_zzlineitem-normalsalesamountsiva = lit_zzlineitem-normalsalesamount.
          WHEN '1'.
            lit_zzlineitem-normalsalesamountsiva = lit_zzlineitem-normalsalesamount / '1.04'. " - ( ( lit_zzlineitem-normalsalesamount * 4 ) / 100 ).
          WHEN '2'.
            lit_zzlineitem-normalsalesamountsiva = lit_zzlineitem-normalsalesamount / '1.1'. "- ( ( lit_zzlineitem-normalsalesamount * 10 ) / 100 ).
          WHEN '3'.
            lit_zzlineitem-normalsalesamountsiva = lit_zzlineitem-normalsalesamount / '1.21'. "- ( ( lit_zzlineitem-normalsalesamount * 21 ) / 100 ).
          WHEN '4'. ">>>>>>>>>>>>>CCOTILLA 07.01.2020 --> Nuevo Indicador IVA
            lit_zzlineitem-normalsalesamountsiva = lit_zzlineitem-normalsalesamount / '1.04'. " - ( ( lit_zzlineitem-normalsalesamount * 4 ) / 100 ).
          WHEN '5'. ">>>>>>>>>>>>>CCOTILLA 07.01.2020 --> Nuevo Indicador IVA
            lit_zzlineitem-normalsalesamountsiva = lit_zzlineitem-normalsalesamount / '1.1'. "- ( ( lit_zzlineitem-normalsalesamount * 10 ) / 100 ).
          WHEN '6'. ">>>>>>>>>>>>>CCOTILLA 07.01.2020 --> Nuevo Indicador IVA
            lit_zzlineitem-normalsalesamountsiva = lit_zzlineitem-normalsalesamount / '1.21'. "- ( ( lit_zzlineitem-normalsalesamount * 21 ) / 100 ).
        ENDCASE.

        PERFORM f_get_matnrt USING lit_zzlineitem-itemid CHANGING lit_zzlineitem-itemidt.

        APPEND lit_zzlineitem.
      WHEN 'ZZPOSDWE1BPLINEITEMDISCOUNT'.
*       Descuentos lineas ticket
        lr_zzposdwe1bplineitemdiscount = idoc_data-sdata.
        CLEAR lit_zzlineitemdisc.
        lit_zzlineitemdisc-retailstoreid                 = lr_zzposdwe1bplineitemdiscount-retailstoreid .
        lit_zzlineitemdisc-operatorid                    = lr_zzposdwe1bptransaction-operatorid.
        lit_zzlineitemdisc-businessdaydate               = lr_zzposdwe1bplineitemdiscount-businessdaydate.
        lit_zzlineitemdisc-transactionsequencenumber     = lr_zzposdwe1bplineitemdiscount-transactionsequencenumber .
        lit_zzlineitemdisc-retailsequencenumber          = lr_zzposdwe1bplineitemdiscount-retailsequencenumber.
        lit_zzlineitemdisc-discountsequencenumber        = lr_zzposdwe1bplineitemdiscount-discountsequencenumber.
        lit_zzlineitemdisc-transactiontypecode           = lit_zztransaction-transactiontypecode.
        lit_zzlineitemdisc-workstationid                 = lr_zzposdwe1bplineitemdiscount-workstationid.
        lit_zzlineitemdisc-discounttypecode              = lr_zzposdwe1bplineitemdiscount-discounttypecode.
        lit_zzlineitemdisc-discountreasoncode            = lr_zzposdwe1bplineitemdiscount-discountreasoncode.
        lit_zzlineitemdisc-reductionamount               = lr_zzposdwe1bplineitemdiscount-reductionamount.
        lit_zzlineitemdisc-storefinancialledgeraccountid = lr_zzposdwe1bplineitemdiscount-storefinancialledgeraccountid.
        lit_zzlineitemdisc-discountid                    = lr_zzposdwe1bplineitemdiscount-discountid.
        lit_zzlineitemdisc-discountidqualifier           = lr_zzposdwe1bplineitemdiscount-discountidqualifier.
        lit_zzlineitemdisc-bonusbuyid                    = lr_zzposdwe1bplineitemdiscount-bonusbuyid.
        lit_zzlineitemdisc-offerid                       = lr_zzposdwe1bplineitemdiscount-offerid.
        lit_zzlineitemdisc-waers                         = lr_zzposdwe1bptransaction-transactioncurrency.
        APPEND lit_zzlineitemdisc.
      WHEN 'ZZPOSDWE1BPTENDER'.
*       Métodos de pago
        lr_zzposdwe1bptender = idoc_data-sdata.
        CLEAR lit_zztender.
        lit_zztender-retailstoreid             = lr_zzposdwe1bptender-retailstoreid.
        lit_zztender-operatorid                = lr_zzposdwe1bptransaction-operatorid.
        lit_zztender-businessdaydate           = lr_zzposdwe1bptender-businessdaydate.
        lit_zztender-transactionsequencenumber = lr_zzposdwe1bptender-transactionsequencenumber.
        lit_zztender-tendersequencenumber      = lr_zzposdwe1bptender-tendersequencenumber.
        lit_zztender-transactiontypecode       = lit_zztransaction-transactiontypecode.
        lit_zztender-workstationid             = lr_zzposdwe1bptender-workstationid.
        lit_zztender-tendertypecode            = lr_zzposdwe1bptender-tendertypecode.
        lit_zztender-tenderamount              = lr_zzposdwe1bptender-tenderamount.
        lit_zztender-tendercurrency            = lr_zzposdwe1bptender-tendercurrency.
        lit_zztender-tendercurrency_iso        = lr_zzposdwe1bptender-tendercurrency_iso.
        lit_zztender-tenderid                  = lr_zzposdwe1bptender-tenderid.
        lit_zztender-accountnumber             = lr_zzposdwe1bptender-accountnumber.
        lit_zztender-referenceid               = lr_zzposdwe1bptender-referenceid.

*CCOTILA --> 17.02.2021 --> añado transferencia 0110 y contrareembolso 0120 igual que 2000.
        IF lit_zztransaction-transactiontypecode = 'ZVTA' AND
           ( lit_zztender-tendertypecode = '2000' OR
           lit_zztender-tendertypecode = '0110' OR
           lit_zztender-tendertypecode = '0120' ) .

*         Msg: El artículo &-& no existe en el sistema.
          PERFORM idoc_status_fuellen USING 'E'
                                            'ZRETPOSDM001'
                                            '032'
                                            ''
                                            ''
                                            ''
                                            ''.
        ENDIF.

*       Si pago a fin de mes (ZVTF/ZBCF + forma pago 2000) no hay que realizar
*       la verificación de importes
        IF ( lit_zztransaction-transactiontypecode = 'ZVTF' OR lit_zztransaction-transactiontypecode = 'ZBFC' ) AND
           ( lit_zztender-tendertypecode = '2000' OR
           lit_zztender-tendertypecode = '0110' OR
           lit_zztender-tendertypecode = '0120' ) .
          lf_noval_imp = 'X'.
        ENDIF.
*CCOTILA --> 17.02.2021 --> añado transferencia 0110 y contrareembolso 0120 igual que 2000.


        APPEND lit_zztender.
      WHEN 'ZZPOSDWE1BPLINEITEMDISCEXT'.
        lr_zzposdwe1bplineitemdiscext = idoc_data-sdata.
        CLEAR lit_zzlineitemdiscex.
        lit_zzlineitemdiscex-retailstoreid              = lr_zzposdwe1bplineitemdiscext-retailstoreid.
        lit_zzlineitemdiscex-operatorid                 = lr_zzposdwe1bptransaction-operatorid.
        lit_zzlineitemdiscex-businessdaydate            = lr_zzposdwe1bplineitemdiscext-businessdaydate.
        lit_zzlineitemdiscex-transactiontypecode        = lit_zztransaction-transactiontypecode.
        lit_zzlineitemdiscex-workstationid              = lr_zzposdwe1bplineitemdiscext-workstationid.
        lit_zzlineitemdiscex-transactionsequencenumber  = lr_zzposdwe1bplineitemdiscext-transactionsequencenumber.
        lit_zzlineitemdiscex-retailsequencenumber       = lr_zzposdwe1bplineitemdiscext-retailsequencenumber.
        lit_zzlineitemdiscex-discountsequencenumber     = lr_zzposdwe1bplineitemdiscext-discountsequencenumber.
        lit_zzlineitemdiscex-fieldgroup                 = lr_zzposdwe1bplineitemdiscext-fieldgroup.
        lit_zzlineitemdiscex-fieldname                  = lr_zzposdwe1bplineitemdiscext-fieldname.
        lit_zzlineitemdiscex-fieldvalue                 = lr_zzposdwe1bplineitemdiscext-fieldvalue.
        APPEND lit_zzlineitemdiscex.

      WHEN 'ZZPOSDWE1BPCUSTOMERDETAILS'.
        lr_zzposdwe1bpcustomerdetails = idoc_data-sdata.
        CLEAR lit_zzcustdetails.
        lit_zzcustdetails-retailstoreid                 = lr_zzposdwe1bpcustomerdetails-retailstoreid.
        lit_zzcustdetails-businessdaydate                 = lr_zzposdwe1bpcustomerdetails-businessdaydate.
        lit_zzcustdetails-transactiontypecode                 = lit_zztransaction-transactiontypecode.
        lit_zzcustdetails-workstationid                 = lr_zzposdwe1bpcustomerdetails-workstationid.
        lit_zzcustdetails-transactionsequencenumber                 = lr_zzposdwe1bpcustomerdetails-transactionsequencenumber.
        lit_zzcustdetails-customerinformationtypecode                 = lr_zzposdwe1bpcustomerdetails-customerinformationtypecode.
        lit_zzcustdetails-dataelementid                 = lr_zzposdwe1bpcustomerdetails-dataelementid.
        lit_zzcustdetails-dataelementvalue                 = lr_zzposdwe1bpcustomerdetails-dataelementvalue.
        lit_zzcustdetails-operatorid                 = lr_zzposdwe1bptransaction-operatorid.
        APPEND lit_zzcustdetails.

    ENDCASE.
  ENDLOOP.

*>Obtenemos si la verificación de errores está activa
  SELECT SINGLE valor
    FROM zhardcodes
    INTO lf_check_errores
   WHERE programa = 'ZRETPOSDM001'
     AND param    = 'CHECK_ERRORES'.

  IF lf_check_errores = 'X'.
*   Si Verificación de erroes activa
    LOOP AT idoc_status WHERE status = '51'.
      EXIT.
    ENDLOOP.

    IF sy-subrc = 0.
*     Msg: Operación de ZPOSDM no registrada por errores.
      PERFORM idoc_status_fuellen USING 'E'
                                        'ZRETPOSDM001'
                                        '013'
                                        lr_zzposdwe1bptransaction-transactionsequencenumber
                                        lr_zzposdwe1bptransaction-retailstoreid
                                        ''
                                        ''.
    ELSE.
*     Si no hay errores...

*     Verificamos que la suma de importes de las lineas del ticket coincidan
*     con la suma de importes de la forma de pago
      CLEAR: ld_sum_salesamount, ld_sum_tenderamount.

      IF lit_zztransaction-transactiontypecode <> 'ZCCJ' AND
         lit_zztransaction-transactiontypecode <> 'ZBCJ' AND
         lf_noval_imp = ''.
*       La verificación de importes no aplica en el cierre de caja, y tampoco
*       si el check de no validar viene activo

*       Acumulamos importes de las lineas
        LOOP AT lit_zzlineitem.
          ADD lit_zzlineitem-salesamount TO ld_sum_salesamount.
        ENDLOOP.

*       Acumulamos importes formas de pago
        LOOP AT lit_zztender.
          ADD lit_zztender-tenderamount TO ld_sum_tenderamount.
        ENDLOOP.

*       Reducimos descuentos de cabecera al acumulado de importes de las lineas
        LOOP AT lit_zzlineitemdisc WHERE discounttypecode = '7'.
          ADD lit_zzlineitemdisc-reductionamount TO ld_sum_salesamount.
        ENDLOOP.
      ENDIF.

      IF ld_sum_salesamount <> ld_sum_tenderamount.
*       Si no coinciden importes...

*       Msg: Importe lineas <> importe formas de pago (&<>&)
        PERFORM idoc_status_fuellen USING 'E' 'ZRETPOSDM001' '030' ld_sum_salesamount ld_sum_tenderamount '' ''.

*       Msg: Operación de ZPOSDM no registrada por errores.
        PERFORM idoc_status_fuellen USING 'E' 'ZRETPOSDM001' '013' '' '' '' ''.
      ELSE.

        MODIFY zztransaction FROM TABLE lit_zztransaction.
        MODIFY zzlineitem FROM TABLE lit_zzlineitem.
        MODIFY zzlineitemdisc FROM TABLE lit_zzlineitemdisc.
        MODIFY zztender FROM TABLE lit_zztender.
        MODIFY zzlineitemdiscex FROM TABLE lit_zzlineitemdiscex.
        MODIFY zzcustdetails FROM TABLE lit_zzcustdetails.

        COMMIT WORK AND WAIT.

*       Msg: Operacion & de Tienda & registrada en POSDM.
        PERFORM idoc_status_fuellen USING 'S'
                                          'ZRETPOSDM001'
                                          '008'
                                          lr_zzposdwe1bptransaction-transactionsequencenumber
                                          lr_zzposdwe1bptransaction-retailstoreid
                                          ''
                                          ''.

*       APRADAS-Inicio-11.01.2019 09:42:49>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*>>>>>>>Almacenar datos tickets para envío web

*       Mirar si la tienda es pickinera
        READ TABLE lit_zzlineitem INDEX 1.

        SELECT SINGLE werks_tda
          FROM zretame005t01
          INTO lit_zzlineitem-retailstoreid
         WHERE werks_tda = lit_zzlineitem-retailstoreid.

        IF sy-subrc = 0.
*         Si tienda es pickinera almacenamos detalle del en tabla de envío de stock
          LOOP AT lit_zzlineitem.
            CLEAR lit_zzlineitem2web.

            MOVE-CORRESPONDING lit_zzlineitem TO lit_zzlineitem2web.

            APPEND lit_zzlineitem2web.
          ENDLOOP.

          MODIFY zzlineitem2web FROM TABLE lit_zzlineitem2web.
        ENDIF.
*       APRADAS-Fin-11.01.2019 09:42:49<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      ENDIF.
    ENDIF.

  ELSE.
    MODIFY zztransaction FROM TABLE lit_zztransaction.
    MODIFY zzlineitem FROM TABLE lit_zzlineitem.
    MODIFY zzlineitemdisc FROM TABLE lit_zzlineitemdisc.
    MODIFY zztender FROM TABLE lit_zztender.
    MODIFY zzlineitemdiscex FROM TABLE lit_zzlineitemdiscex.
    MODIFY zzcustdetails FROM TABLE lit_zzcustdetails.

    COMMIT WORK AND WAIT.

*   Msg: Operacion & de Tienda & registrada en POSDM.
    PERFORM idoc_status_fuellen USING 'S'
                                      'ZRETPOSDM001'
                                      '008'
                                      lr_zzposdwe1bptransaction-transactionsequencenumber
                                      lr_zzposdwe1bptransaction-retailstoreid
                                      ''
                                      ''.

*   APRADAS-Inicio-11.01.2019 09:42:49>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*>>>Almacenar datos tickets para envío web

*   Mirar si la tienda es pickinera
    READ TABLE lit_zzlineitem INDEX 1.

    SELECT SINGLE werks_tda
      FROM zretame005t01
      INTO lit_zzlineitem-retailstoreid
     WHERE werks_tda = lit_zzlineitem-retailstoreid.

    IF sy-subrc = 0.
*     Si tienda es pickinera almacenamos detalle del en tabla de envío de stock
      LOOP AT lit_zzlineitem.
        CLEAR lit_zzlineitem2web.

        MOVE-CORRESPONDING lit_zzlineitem TO lit_zzlineitem2web.

        APPEND lit_zzlineitem2web.
      ENDLOOP.

      MODIFY zzlineitem2web FROM TABLE lit_zzlineitem2web.
    ENDIF.
*   APRADAS-Fin-11.01.2019 09:42:49<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ENDIF.

ENDFUNCTION.
