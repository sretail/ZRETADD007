*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM001_FORMS
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form F_SELECCIONAR_DATOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleccionar_datos_pi.
  IF p_tpv01 = 'X'.
    PERFORM f_seleccionar_datos_pdt.
  ELSEIF p_tpv02 = 'X'.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_INCORPORAR_TICKETS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_incorporar_tickets .
  IF p_tpv01 = 'X'.
*   Evolutel
    PERFORM f_incorporar_tickets_pdt.
  ELSEIF p_tpv02 = 'X'.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_INCORPORAR_TICKETS_PDT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_incorporar_tickets_pdt .
* 0.- Declaración de variables
*=======================================================================
  DATA: lit_dir_list         LIKE eps2fili OCCURS 0 WITH HEADER LINE,
        wa_zposdm001         LIKE zposdm001,
        lit_zposdm001        LIKE zposdm001 OCCURS 0 WITH HEADER LINE,
        lit_zposdm001t       LIKE zposdm001 OCCURS 0 WITH HEADER LINE,
        ld_index             LIKE sy-tabix,
        lf_error(1),
        ld_linea(100000),
        ld_fichero(1000),
        ld_split001(1000),
        ld_split002(1000),
        ld_split003(1000),
        ld_split004(1000),
        ld_split005(1000),
        ld_split006(1000),
        ld_split007(1000),
        ld_split008(1000),
        ld_split009(1000),
        ld_split010(1000),
        ld_split011(1000),
        ld_split012(1000),
        ld_split013(1000),
        ld_split014(1000),
        ld_split015(1000),
        ld_split016(1000),
        ld_split017(1000),
        ld_split018(1000),
        ld_split019(1000),
        ld_split020(1000),
        ld_split021(1000),
        ld_split022(1000),
        ld_split023(1000),
        ld_split024(1000),
        ld_split025(1000),
        ld_split026(1000),
        ld_split027(1000),
        ld_split028(1000),
        ld_split029(1000),
        ld_split030(1000),
        ld_split031(1000),
        ld_split032(1000),
        ld_split033(1000),
        ld_split034(1000),
        ld_split035(1000),
        ld_split036(1000),
        ld_split037(1000),
        ld_split038(1000),
        ld_split039(1000),
        ld_split040(1000),
        ld_split041(1000),
        ld_split042(1000),
        ld_split043(1000),
        ld_split044(1000),
        ld_split045(1000),
        ld_split046(1000),
        ld_split047(1000),
        ld_split048(1000),
        ld_split049(1000),
        ld_split050(1000),
        ld_split051(1000),
        ld_split052(1000),
        ld_split053(1000),
        ld_split054(1000),
        ld_split055(1000),
        ld_split056(1000),
        ld_split057(1000),
        ld_split058(1000),
        ld_split059(1000),
        ld_split060(1000),
        ld_split061(1000),
        ld_split062(1000),
        ld_split063(1000),
        ld_split064(1000),
        ld_split065(1000),
        ld_split066(1000),
        ld_split067(1000),
        ld_split068(1000),
        ld_split069(1000),
        ld_split070(1000),
        ld_split071(1000),
        ld_split072(1000),
        ld_split073(1000),
        ld_split074(1000),
        ld_split075(1000),
        ld_split076(1000),
        ld_split077(1000),
        ld_split078(1000),
        ld_split079(1000),
        ld_split080(1000),
        ld_split081(1000),
        ld_split082(1000),
        ld_split083(1000),
        ld_split084(1000),
        ld_split085(1000),
        ld_split086(1000),
        ld_split087(1000),
        ld_split088(1000),
        ld_split089(1000),
        ld_split090(1000),
        ld_split091(1000),
        ld_split092(1000),
        ld_split093(1000),
        ld_split094(1000),
        ld_split095(1000),
        ld_split096(1000),
        ld_split097(1000),
        ld_split098(1000),
        ld_split099(1000),
        ld_split100(1000),
        ld_split101(1000),
        ld_split102(1000),
        ld_split103(1000),
        ld_split104(1000),
        ld_split105(1000),
        ld_split106(1000),
        ld_split107(1000),
        ld_split108(1000),
        ld_split109(1000),
        ld_split110(1000),
        ld_split111(1000),
        ld_split112(1000),
        ld_split113(1000),
        ld_split114(1000),
        ld_split115(1000),
        ld_split116(1000),
        ld_split117(1000),
        ld_split118(1000),
        ld_split119(1000),
        ld_split120(1000),
        ld_split121(1000),
        ld_split122(1000),
        ld_split123(1000),
        ld_split124(1000),
        ld_split125(1000),
        ld_split126(1000),
        ld_split127(1000),
        ld_split128(1000),
        ld_split129(1000),
        ld_split130(1000),
        ld_split131(1000),
        ld_split132(1000),
        ld_split133(1000),
        ld_split134(1000),
        ld_split135(1000),
        ld_split136(1000),
        ld_split137(1000),
        ld_split138(1000),
        ld_split139(1000),
        ld_split140(1000),
        ld_split141(1000),
        ld_split142(1000),
        ld_split143(1000),
        ld_split144(1000),
        ld_split145(1000),
        ld_split146(1000),
        ld_split147(1000),
        ld_split148(1000),
        ld_split149(1000),
        ld_split150(1000),
        ld_split151(1000),
        ld_split152(1000),
        ld_split153(1000),
        ld_split154(1000),
        ld_split155(1000),
        ld_split156(1000),
        ld_split157(1000),
        ld_split158(1000),
        ld_split159(1000),
        ld_split160(1000),
        ld_split161(1000),
        ld_split162(1000),
        ld_split163(1000),
        ld_split164(1000),
        ld_split165(1000),
        ld_split166(1000),
        ld_split167(1000),
        ld_split168(1000),
        ld_split169(1000),
        ld_split170(1000),
        ld_split171(1000),
        ld_split172(1000),
        ld_split173(1000),
        ld_split174(1000),
        ld_split175(1000),
        ld_split176(1000),
        ld_split177(1000),
        ld_split178(1000),
        ld_split179(1000),
        ld_split180(1000),
        ld_split181(1000),
        ld_split182(1000),
        ld_split183(1000),
        ld_split184(1000),
        ld_split185(1000),
        ld_split186(1000),
        ld_split187(1000),
        ld_split188(1000),
        ld_split189(1000),
        ld_split190(1000),
        ld_split191(1000),
        ld_split192(1000),
        ld_split193(1000),
        ld_split194(1000),
        ld_split195(1000),
        ld_split196(1000),
        ld_split197(1000),
        ld_split198(1000),
        ld_split199(1000),
        ld_split200(1000),
        ld_split201(1000),
        ld_split202(1000),
        ld_split203(1000),
        ld_split204(1000),
        ld_split205(1000),
        ld_split206(1000),
        ld_split207(1000),
        ld_split208(1000),
        ld_split209(1000),
        ld_split210(1000),
        ld_split211(1000),
        ld_split212(1000),
        ld_split213(1000),
        ld_split214(1000),
        ld_split215(1000),
        ld_split216(1000),
        ld_split217(1000),
        ld_split218(1000),
        ld_split219(1000),
        ld_split220(1000),
        ld_split221(1000),
        ld_split222(1000),
        ld_split223(1000),
        ld_split224(1000),
        ld_split225(1000),
        ld_split226(1000),
        ld_split227(1000),
        ld_split228(1000),
        ld_split229(1000),
        ld_split230(1000),
        ld_split231(1000),
        ld_split232(1000),
        ld_split233(1000),
        ld_split234(1000),
        ld_split235(1000),
        ld_split236(1000),
        ld_split237(1000),
        ld_split238(1000),
        ld_split239(1000),
        ld_split240(1000),
        ld_split241(1000),
        ld_split242(1000),
        ld_split243(1000),
        ld_split244(1000),
        ld_split245(1000),
        ld_split246(1000),
        ld_split247(1000),
        ld_split248(1000),
        ld_split249(1000),
        ld_split250(1000),
        ld_split251(1000),
        ld_split252(1000),
        ld_split253(1000),
        ld_split254(1000),
        ld_split255(1000),
        ld_split256(1000),
        ld_split257(1000),
        ld_split258(1000),
        ld_split259(1000),
        ld_split260(1000),
        ld_split261(1000),
        ld_split262(1000),
        ld_split263(1000),
        ld_split264(1000),
        ld_split265(1000),
        ld_split266(1000),
        ld_split267(1000),
        ld_split268(1000),
        ld_split269(1000),
        ld_split270(1000),
        ld_split271(1000),
        ld_split272(1000),
        ld_split273(1000),
        ld_split274(1000),
        ld_split275(1000),
        ld_split276(1000),
        ld_split277(1000),
        ld_split278(1000),
        ld_split279(1000),
        ld_split280(1000),
        ld_split281(1000),
        ld_split282(1000),
        ld_split283(1000),
        ld_split284(1000),
        ld_split285(1000),
        ld_split286(1000),
        ld_split287(1000),
        ld_split288(1000),
        ld_split289(1000),
        ld_split290(1000),
        ld_split291(1000),
        ld_split292(1000),
        ld_split293(1000),
        ld_split294(1000),
        ld_split295(1000),
        ld_split296(1000),
        ld_split297(1000),
        ld_split298(1000),
        ld_split299(1000),
        ld_split300(1000),
        ld_split301(1000),
        ld_split302(1000),
        ld_split303(1000),
        ld_split304(1000),
        ld_split305(1000),
        ld_split306(1000),
        ld_split307(1000),
        ld_split308(1000),
        ld_split309(1000),
        ld_split310(1000),
        ld_split311(1000),
        ld_split312(1000),
        ld_split313(1000),
        ld_split314(1000),
        ld_split315(1000),
        ld_split316(1000),
        ld_split317(1000),
        ld_split318(1000),
        ld_split319(1000),
        ld_split320(1000),
        ld_split321(1000),
        ld_split322(1000),
        ld_split323(1000),
        ld_split324(1000),
        ld_split325(1000),
        ld_split326(1000),
        ld_split327(1000),
        ld_split328(1000),
        ld_split329(1000),
        ld_split330(1000),
        ld_split331(1000),
        ld_split332(1000),
        ld_split333(1000),
        ld_split334(1000),
        ld_split335(1000),
        ld_split336(1000),
        ld_split337(1000),
        ld_split338(1000),
        ld_split339(1000),
        ld_split340(1000),
        ld_split341(1000),
        ld_split342(1000),
        ld_split343(1000),
        ld_split344(1000),
        ld_split345(1000),
        ld_split346(1000),
        ld_split347(1000),
        ld_split348(1000),
        ld_split349(1000),
        ld_split350(1000),
        ld_split351(1000),
        ld_split352(1000),
        ld_split353(1000),
        ld_split354(1000),
        ld_split355(1000),
        ld_split356(1000),
        ld_split357(1000),
        ld_split358(1000),
        ld_split359(1000),
        ld_split360(1000),
        ld_split361(1000),
        ld_split362(1000),
        ld_split363(1000),
        ld_split364(1000),
        ld_split365(1000),
        ld_split366(1000),
        ld_split367(1000),
        ld_split368(1000),
        ld_split369(1000),
        ld_split370(1000),
        ld_split371(1000),
        ld_split372(1000),
        ld_split373(1000),
        ld_split374(1000),
        ld_split375(1000),
        ld_split376(1000),
        ld_split377(1000),
        ld_split378(1000),
        ld_split379(1000),
        ld_split380(1000),
        ld_split381(1000),
        ld_split382(1000),
        ld_split383(1000),
        ld_split384(1000),
        ld_split385(1000),
        ld_split386(1000),
        ld_split387(1000),
        ld_split388(1000),
        ld_split389(1000),
        ld_split390(1000),
        ld_split391(1000),
        ld_split392(1000),
        ld_split393(1000),
        ld_split394(1000),
        ld_split395(1000),
        ld_split396(1000),
        ld_split397(1000),
        ld_split398(1000),
        ld_split399(1000),
        ld_split400(1000),
        ld_split(1000),
        ld_cont_split        TYPE numc3 VALUE 03,
        ld_split_puntero(20),
        ld_len               TYPE int4,
        ld_off               TYPE int4,
        ld_hex_soh           TYPE x VALUE '0100',
        ld_cont              TYPE numc3,
        ld_cont_75           TYPE numc3,
        ld_cont_10           TYPE numc3,
        ld_cont_14           TYPE numc3,
        ld_cont_24           TYPE numc3,
        ld_cont_20           TYPE numc3,
        ld_cont_33           TYPE numc3,
        ld_cont_46           TYPE numc3,
        ld_cont_47           TYPE numc3,
        ld_cont_31           TYPE numc3,
        ld_docnum_ini        LIKE edidc-docnum,
        ld_tabix(6),
        ld_tabix_tot(6),
        ld_docnum_fin        LIKE edidc-docnum.

  FIELD-SYMBOLS: <fs>       TYPE any,
                 <fs_split> TYPE any.

* 1.- Lógica
*=======================================================================
* Obtener ficheros a tratar
  PERFORM f_get_ficheros_tpv TABLES lit_dir_list
                              USING p_folin.

* Descartar ficheros tratados
  PERFORM f_descartar_ficheros_tpv TABLES lit_dir_list.


  DESCRIBE TABLE lit_dir_list LINES ld_tabix_tot.
  loop_at lit_dir_list.
  CLEAR git_listado.

  git_listado-filename = lit_dir_list-name.


  CLEAR ld_cont.

  CONCATENATE p_folin lit_dir_list-name INTO ld_fichero.

  OPEN DATASET ld_fichero FOR INPUT IN TEXT MODE ENCODING NON-UNICODE.

  DO.
    READ DATASET ld_fichero INTO ld_linea.

    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    CLEAR:  ld_split001,
            ld_split002,
            ld_split003,
            ld_split004,
            ld_split005,
            ld_split006,
            ld_split007,
            ld_split008,
            ld_split009,
            ld_split010,
            ld_split011,
            ld_split012,
            ld_split013,
            ld_split014,
            ld_split015,
            ld_split016,
            ld_split017,
            ld_split018,
            ld_split019,
            ld_split020,
            ld_split021,
            ld_split022,
            ld_split023,
            ld_split024,
            ld_split025,
            ld_split026,
            ld_split027,
            ld_split028,
            ld_split029,
            ld_split030,
            ld_split031,
            ld_split032,
            ld_split033,
            ld_split034,
            ld_split035,
            ld_split036,
            ld_split037,
            ld_split038,
            ld_split039,
            ld_split040,
            ld_split041,
            ld_split042,
            ld_split043,
            ld_split044,
            ld_split045,
            ld_split046,
            ld_split047,
            ld_split048,
            ld_split049,
            ld_split050,
            ld_split051,
            ld_split052,
            ld_split053,
            ld_split054,
            ld_split055,
            ld_split056,
            ld_split057,
            ld_split058,
            ld_split059,
            ld_split060,
            ld_split061,
            ld_split062,
            ld_split063,
            ld_split064,
            ld_split065,
            ld_split066,
            ld_split067,
            ld_split068,
            ld_split069,
            ld_split070,
            ld_split071,
            ld_split072,
            ld_split073,
            ld_split074,
            ld_split075,
            ld_split076,
            ld_split077,
            ld_split078,
            ld_split079,
            ld_split080,
            ld_split081,
            ld_split082,
            ld_split083,
            ld_split084,
            ld_split085,
            ld_split086,
            ld_split087,
            ld_split088,
            ld_split089,
            ld_split090,
            ld_split091,
            ld_split092,
            ld_split093,
            ld_split094,
            ld_split095,
            ld_split096,
            ld_split097,
            ld_split098,
            ld_split099,
            ld_split100,
            ld_split101,
            ld_split102,
            ld_split103,
            ld_split104,
            ld_split105,
            ld_split106,
            ld_split107,
            ld_split108,
            ld_split109,
            ld_split110,
            ld_split111,
            ld_split112,
            ld_split113,
            ld_split114,
            ld_split115,
            ld_split116,
            ld_split117,
            ld_split118,
            ld_split119,
            ld_split120,
            ld_split121,
            ld_split122,
            ld_split123,
            ld_split124,
            ld_split125,
            ld_split126,
            ld_split127,
            ld_split128,
            ld_split129,
            ld_split130,
            ld_split131,
            ld_split132,
            ld_split133,
            ld_split134,
            ld_split135,
            ld_split136,
            ld_split137,
            ld_split138,
            ld_split139,
            ld_split140,
            ld_split141,
            ld_split142,
            ld_split143,
            ld_split144,
            ld_split145,
            ld_split146,
            ld_split147,
            ld_split148,
            ld_split149,
            ld_split150,
            ld_split151,
            ld_split152,
            ld_split153,
            ld_split154,
            ld_split155,
            ld_split156,
            ld_split157,
            ld_split158,
            ld_split159,
            ld_split160,
            ld_split161,
            ld_split162,
            ld_split163,
            ld_split164,
            ld_split165,
            ld_split166,
            ld_split167,
            ld_split168,
            ld_split169,
            ld_split170,
            ld_split171,
            ld_split172,
            ld_split173,
            ld_split174,
            ld_split175,
            ld_split176,
            ld_split177,
            ld_split178,
            ld_split179,
            ld_split180,
            ld_split181,
            ld_split182,
            ld_split183,
            ld_split184,
            ld_split185,
            ld_split186,
            ld_split187,
            ld_split188,
            ld_split189,
            ld_split190,
            ld_split191,
            ld_split192,
            ld_split193,
            ld_split194,
            ld_split195,
            ld_split196,
            ld_split197,
            ld_split198,
            ld_split199,
            ld_split200,
            ld_split201,
            ld_split202,
            ld_split203,
            ld_split204,
            ld_split205,
            ld_split206,
            ld_split207,
            ld_split208,
            ld_split209,
            ld_split210,
            ld_split211,
            ld_split212,
            ld_split213,
            ld_split214,
            ld_split215,
            ld_split216,
            ld_split217,
            ld_split218,
            ld_split219,
            ld_split220,
            ld_split221,
            ld_split222,
            ld_split223,
            ld_split224,
            ld_split225,
            ld_split226,
            ld_split227,
            ld_split228,
            ld_split229,
            ld_split230,
            ld_split231,
            ld_split232,
            ld_split233,
            ld_split234,
            ld_split235,
            ld_split236,
            ld_split237,
            ld_split238,
            ld_split239,
            ld_split240,
            ld_split241,
            ld_split242,
            ld_split243,
            ld_split244,
            ld_split245,
            ld_split246,
            ld_split247,
            ld_split248,
            ld_split249,
            ld_split250,
            ld_split251,
            ld_split252,
            ld_split253,
            ld_split254,
            ld_split255,
            ld_split256,
            ld_split257,
            ld_split258,
            ld_split259,
            ld_split260,
            ld_split261,
            ld_split262,
            ld_split263,
            ld_split264,
            ld_split265,
            ld_split266,
            ld_split267,
            ld_split268,
            ld_split269,
            ld_split270,
            ld_split271,
            ld_split272,
            ld_split273,
            ld_split274,
            ld_split275,
            ld_split276,
            ld_split277,
            ld_split278,
            ld_split279,
            ld_split280,
            ld_split281,
            ld_split282,
            ld_split283,
            ld_split284,
            ld_split285,
            ld_split286,
            ld_split287,
            ld_split288,
            ld_split289,
            ld_split290,
            ld_split291,
            ld_split292,
            ld_split293,
            ld_split294,
            ld_split295,
            ld_split296,
            ld_split297,
            ld_split298,
            ld_split299,
            ld_split300,
            ld_split301,
            ld_split302,
            ld_split303,
            ld_split304,
            ld_split305,
            ld_split306,
            ld_split307,
            ld_split308,
            ld_split309,
            ld_split310,
            ld_split311,
            ld_split312,
            ld_split313,
            ld_split314,
            ld_split315,
            ld_split316,
            ld_split317,
            ld_split318,
            ld_split319,
            ld_split320,
            ld_split321,
            ld_split322,
            ld_split323,
            ld_split324,
            ld_split325,
            ld_split326,
            ld_split327,
            ld_split328,
            ld_split329,
            ld_split330,
            ld_split331,
            ld_split332,
            ld_split333,
            ld_split334,
            ld_split335,
            ld_split336,
            ld_split337,
            ld_split338,
            ld_split339,
            ld_split340,
            ld_split341,
            ld_split342,
            ld_split343,
            ld_split344,
            ld_split345,
            ld_split346,
            ld_split347,
            ld_split348,
            ld_split349,
            ld_split350,
            ld_split351,
            ld_split352,
            ld_split353,
            ld_split354,
            ld_split355,
            ld_split356,
            ld_split357,
            ld_split358,
            ld_split359,
            ld_split360,
            ld_split361,
            ld_split362,
            ld_split363,
            ld_split364,
            ld_split365,
            ld_split366,
            ld_split367,
            ld_split368,
            ld_split369,
            ld_split370,
            ld_split371,
            ld_split372,
            ld_split373,
            ld_split374,
            ld_split375,
            ld_split376,
            ld_split377,
            ld_split378,
            ld_split379,
            ld_split380,
            ld_split381,
            ld_split382,
            ld_split383,
            ld_split384,
            ld_split385,
            ld_split386,
            ld_split387,
            ld_split388,
            ld_split389,
            ld_split390,
            ld_split391,
            ld_split392,
            ld_split393,
            ld_split394,
            ld_split395,
            ld_split396,
            ld_split397,
            ld_split398,
            ld_split399,
            ld_split400,
            ld_len,
            ld_off.

    REFRESH lit_zposdm001t.

    ld_len = strlen( ld_linea ).

    WHILE ld_off LT ld_len.
      ASSIGN ld_linea+ld_off(1) TO <fs> CASTING TYPE x.
      IF <fs> = ld_hex_soh.
        ld_linea+ld_off(1) = ';'.
      ENDIF.
      ADD 1 TO ld_off.
    ENDWHILE.

    SPLIT ld_linea AT ';'  INTO ld_split001
                                ld_split002
                                ld_split003
                                ld_split004
                                ld_split005
                                ld_split006
                                ld_split007
                                ld_split008
                                ld_split009
                                ld_split010
                                ld_split011
                                ld_split012
                                ld_split013
                                ld_split014
                                ld_split015
                                ld_split016
                                ld_split017
                                ld_split018
                                ld_split019
                                ld_split020
                                ld_split021
                                ld_split022
                                ld_split023
                                ld_split024
                                ld_split025
                                ld_split026
                                ld_split027
                                ld_split028
                                ld_split029
                                ld_split030
                                ld_split031
                                ld_split032
                                ld_split033
                                ld_split034
                                ld_split035
                                ld_split036
                                ld_split037
                                ld_split038
                                ld_split039
                                ld_split040
                                ld_split041
                                ld_split042
                                ld_split043
                                ld_split044
                                ld_split045
                                ld_split046
                                ld_split047
                                ld_split048
                                ld_split049
                                ld_split050
                                ld_split051
                                ld_split052
                                ld_split053
                                ld_split054
                                ld_split055
                                ld_split056
                                ld_split057
                                ld_split058
                                ld_split059
                                ld_split060
                                ld_split061
                                ld_split062
                                ld_split063
                                ld_split064
                                ld_split065
                                ld_split066
                                ld_split067
                                ld_split068
                                ld_split069
                                ld_split070
                                ld_split071
                                ld_split072
                                ld_split073
                                ld_split074
                                ld_split075
                                ld_split076
                                ld_split077
                                ld_split078
                                ld_split079
                                ld_split080
                                ld_split081
                                ld_split082
                                ld_split083
                                ld_split084
                                ld_split085
                                ld_split086
                                ld_split087
                                ld_split088
                                ld_split089
                                ld_split090
                                ld_split091
                                ld_split092
                                ld_split093
                                ld_split094
                                ld_split095
                                ld_split096
                                ld_split097
                                ld_split098
                                ld_split099
                                ld_split100
                                ld_split101
                                ld_split102
                                ld_split103
                                ld_split104
                                ld_split105
                                ld_split106
                                ld_split107
                                ld_split108
                                ld_split109
                                ld_split110
                                ld_split111
                                ld_split112
                                ld_split113
                                ld_split114
                                ld_split115
                                ld_split116
                                ld_split117
                                ld_split118
                                ld_split119
                                ld_split120
                                ld_split121
                                ld_split122
                                ld_split123
                                ld_split124
                                ld_split125
                                ld_split126
                                ld_split127
                                ld_split128
                                ld_split129
                                ld_split130
                                ld_split131
                                ld_split132
                                ld_split133
                                ld_split134
                                ld_split135
                                ld_split136
                                ld_split137
                                ld_split138
                                ld_split139
                                ld_split140
                                ld_split141
                                ld_split142
                                ld_split143
                                ld_split144
                                ld_split145
                                ld_split146
                                ld_split147
                                ld_split148
                                ld_split149
                                ld_split150
                                ld_split151
                                ld_split152
                                ld_split153
                                ld_split154
                                ld_split155
                                ld_split156
                                ld_split157
                                ld_split158
                                ld_split159
                                ld_split160
                                ld_split161
                                ld_split162
                                ld_split163
                                ld_split164
                                ld_split165
                                ld_split166
                                ld_split167
                                ld_split168
                                ld_split169
                                ld_split170
                                ld_split171
                                ld_split172
                                ld_split173
                                ld_split174
                                ld_split175
                                ld_split176
                                ld_split177
                                ld_split178
                                ld_split179
                                ld_split180
                                ld_split181
                                ld_split182
                                ld_split183
                                ld_split184
                                ld_split185
                                ld_split186
                                ld_split187
                                ld_split188
                                ld_split189
                                ld_split190
                                ld_split191
                                ld_split192
                                ld_split193
                                ld_split194
                                ld_split195
                                ld_split196
                                ld_split197
                                ld_split198
                                ld_split199
                                ld_split200
                                ld_split201
                                ld_split202
                                ld_split203
                                ld_split204
                                ld_split205
                                ld_split206
                                ld_split207
                                ld_split208
                                ld_split209
                                ld_split210
                                ld_split211
                                ld_split212
                                ld_split213
                                ld_split214
                                ld_split215
                                ld_split216
                                ld_split217
                                ld_split218
                                ld_split219
                                ld_split220
                                ld_split221
                                ld_split222
                                ld_split223
                                ld_split224
                                ld_split225
                                ld_split226
                                ld_split227
                                ld_split228
                                ld_split229
                                ld_split230
                                ld_split231
                                ld_split232
                                ld_split233
                                ld_split234
                                ld_split235
                                ld_split236
                                ld_split237
                                ld_split238
                                ld_split239
                                ld_split240
                                ld_split241
                                ld_split242
                                ld_split243
                                ld_split244
                                ld_split245
                                ld_split246
                                ld_split247
                                ld_split248
                                ld_split249
                                ld_split250
                                ld_split251
                                ld_split252
                                ld_split253
                                ld_split254
                                ld_split255
                                ld_split256
                                ld_split257
                                ld_split258
                                ld_split259
                                ld_split260
                                ld_split261
                                ld_split262
                                ld_split263
                                ld_split264
                                ld_split265
                                ld_split266
                                ld_split267
                                ld_split268
                                ld_split269
                                ld_split270
                                ld_split271
                                ld_split272
                                ld_split273
                                ld_split274
                                ld_split275
                                ld_split276
                                ld_split277
                                ld_split278
                                ld_split279
                                ld_split280
                                ld_split281
                                ld_split282
                                ld_split283
                                ld_split284
                                ld_split285
                                ld_split286
                                ld_split287
                                ld_split288
                                ld_split289
                                ld_split290
                                ld_split291
                                ld_split292
                                ld_split293
                                ld_split294
                                ld_split295
                                ld_split296
                                ld_split297
                                ld_split298
                                ld_split299
                                ld_split300
                                ld_split301
                                ld_split302
                                ld_split303
                                ld_split304
                                ld_split305
                                ld_split306
                                ld_split307
                                ld_split308
                                ld_split309
                                ld_split310
                                ld_split311
                                ld_split312
                                ld_split313
                                ld_split314
                                ld_split315
                                ld_split316
                                ld_split317
                                ld_split318
                                ld_split319
                                ld_split320
                                ld_split321
                                ld_split322
                                ld_split323
                                ld_split324
                                ld_split325
                                ld_split326
                                ld_split327
                                ld_split328
                                ld_split329
                                ld_split330
                                ld_split331
                                ld_split332
                                ld_split333
                                ld_split334
                                ld_split335
                                ld_split336
                                ld_split337
                                ld_split338
                                ld_split339
                                ld_split340
                                ld_split341
                                ld_split342
                                ld_split343
                                ld_split344
                                ld_split345
                                ld_split346
                                ld_split347
                                ld_split348
                                ld_split349
                                ld_split350
                                ld_split351
                                ld_split352
                                ld_split353
                                ld_split354
                                ld_split355
                                ld_split356
                                ld_split357
                                ld_split358
                                ld_split359
                                ld_split360
                                ld_split361
                                ld_split362
                                ld_split363
                                ld_split364
                                ld_split365
                                ld_split366
                                ld_split367
                                ld_split368
                                ld_split369
                                ld_split370
                                ld_split371
                                ld_split372
                                ld_split373
                                ld_split374
                                ld_split375
                                ld_split376
                                ld_split377
                                ld_split378
                                ld_split379
                                ld_split380
                                ld_split381
                                ld_split382
                                ld_split383
                                ld_split384
                                ld_split385
                                ld_split386
                                ld_split387
                                ld_split388
                                ld_split389
                                ld_split390
                                ld_split391
                                ld_split392
                                ld_split393
                                ld_split394
                                ld_split395
                                ld_split396
                                ld_split397
                                ld_split398
                                ld_split399
                                ld_split400.


    IF ld_split001+10(2)  = '05'.
      ADD 1 TO git_listado-numtrans.

      CLEAR lit_zposdm001.
      lit_zposdm001-idcaja             = ld_split003+14(3).
      CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
      lit_zposdm001-idoperacion        = ld_split001(10).
      lit_zposdm001-idtransaccion      = '00'.
      lit_zposdm001-conttransaccion    = 1.
      lit_zposdm001-l00codoperacion    = ld_split001+10(2).
      lit_zposdm001-l00idsistema       = ld_split001+12(3).
      lit_zposdm001-l00fechaoperacion  = ld_split002(12).
      lit_zposdm001-l00fichero         = lit_dir_list-name.
      lit_zposdm001-l00fechainc        = sy-datlo.
      lit_zposdm001-l00horainc         = sy-timlo.
      lit_zposdm001-l00usuarioinc      = sy-uname.
      git_listado-fechainc = lit_zposdm001-l00fechainc.
      git_listado-horainc = lit_zposdm001-l00horainc.
      git_listado-usuarioinc = lit_zposdm001-l00usuarioinc.
      APPEND lit_zposdm001 TO lit_zposdm001t.

      ld_cont_split = 02.

      IF ld_split003(2) = '02'.
        CLEAR lit_zposdm001.
        lit_zposdm001-idcaja             = ld_split003+14(3).
        CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
        lit_zposdm001-idoperacion        = ld_split001(10).
        lit_zposdm001-idtransaccion      = '02'.
        lit_zposdm001-conttransaccion    = 1.
        lit_zposdm001-l0205_valtrans     = ld_split003+22(10).
        lit_zposdm001-l0205_fpagoori     = ld_split003+32(2).
        lit_zposdm001-l0205_fpagodes     = ld_split003+34(2).
        lit_zposdm001-l01numcaja         = ld_split003+14(3).
        lit_zposdm001-l01numcajero       = ld_split003+17(4).
        lit_zposdm001-l01fechatransaccion   = ld_split003+2(12).
        APPEND lit_zposdm001 TO lit_zposdm001t.
      ENDIF.
    ELSEIF ld_split001+10(2) = '03'.
      ADD 1 TO git_listado-numtrans.

      CLEAR lit_zposdm001.
      lit_zposdm001-idcaja             = ld_split003+14(3).
      CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
      lit_zposdm001-idoperacion        = ld_split001(10).
      lit_zposdm001-idtransaccion      = '00'.
      lit_zposdm001-conttransaccion    = 1.
      lit_zposdm001-l00codoperacion    = ld_split001+10(2).
      lit_zposdm001-l00idsistema       = ld_split001+12(3).
      lit_zposdm001-l00fechaoperacion  = ld_split002(12).
      lit_zposdm001-l00fichero         = lit_dir_list-name.
      lit_zposdm001-l00fechainc        = sy-datlo.
      lit_zposdm001-l00horainc         = sy-timlo.
      lit_zposdm001-l00usuarioinc      = sy-uname.
      git_listado-fechainc = lit_zposdm001-l00fechainc.
      git_listado-horainc = lit_zposdm001-l00horainc.
      git_listado-usuarioinc = lit_zposdm001-l00usuarioinc.
      APPEND lit_zposdm001 TO lit_zposdm001t.

      CLEAR lit_zposdm001.
      lit_zposdm001-idcaja             = ld_split003+14(3).
      CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
      lit_zposdm001-idoperacion           = ld_split001(10).
      lit_zposdm001-idtransaccion         = '01'.
      lit_zposdm001-l01fechatransaccion   = ld_split003+2(12).
      lit_zposdm001-l01numcaja            = ld_split003+14(3).
      lit_zposdm001-l01numcajero          = ld_split003+17(4).
      lit_zposdm001-l01cajaformacion      = ld_split003+21(1).
      lit_zposdm001-l01tipoticketcliente  = ld_split003+22(1).
      lit_zposdm001-l01ticketabandonado   = ld_split003+23(1).
      lit_zposdm001-l01nummesarest        = ld_split003+24(3).
      IF strlen( ld_split003 ) > 27.
        lit_zposdm001-l01codimpred          = ld_split003+27(1).
        lit_zposdm001-l01pocimpred          = ld_split003+28(5).
      ENDIF.
      APPEND lit_zposdm001 TO lit_zposdm001t.

      CLEAR: ld_cont,
             ld_cont_75,
             ld_cont_10,
             ld_cont_14,
             ld_cont_33,
             ld_cont_31,
             ld_cont_46,
             ld_cont_47,
             ld_cont_24.

      ld_cont_split = 03.

      DO 400 TIMES.
        ADD 1 TO ld_cont_split.


        CONCATENATE 'LD_SPLIT' ld_cont_split INTO ld_split_puntero.

        ASSIGN (ld_split_puntero) TO <fs_split>.

        ld_split = <fs_split>.

        IF ld_split IS INITIAL.
          EXIT.
        ENDIF.

        IF ld_split(2) = '02'.
          ADD 1 TO ld_cont.
          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja             = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                 = ld_split001(10).
          lit_zposdm001-idtransaccion               = '02'.
          lit_zposdm001-conttransaccion             = ld_cont.
          lit_zposdm001-l02anulacionarticulo        = ld_split+2(1).
          lit_zposdm001-l02codart                   = ld_split+3(13).
          lit_zposdm001-l02codartt                  = ld_split+16(31).
          lit_zposdm001-l02metobt                   = ld_split+47(1).
          lit_zposdm001-l02pvpuniincimp             = ld_split+48(1).
          lit_zposdm001-l02cantvend                 = ld_split+56(10).
          lit_zposdm001-l02oripvo                   = ld_split+66(1).
          lit_zposdm001-l02codimpart                = ld_split+67(1).
          lit_zposdm001-l02numrayon                 = ld_split+68(2).
          lit_zposdm001-l02numfamilia               = ld_split+70(3).
          lit_zposdm001-l02numsubfamilia            = ld_split+73(4).
          lit_zposdm001-l02consigna                 = ld_split+77(1).
          lit_zposdm001-l02preccompleido            = ld_split+78(1).
          lit_zposdm001-l02preccompleidouno         = ld_split+79(8).
          lit_zposdm001-l02anulinmed                = ld_split+87(1).
          lit_zposdm001-l02importeconimpsindesc     = ld_split+88(10).
          lit_zposdm001-l02descotorgart             = ld_split+98(1).
          lit_zposdm001-l02imptotrebconc            = ld_split+99(10).
          lit_zposdm001-l02descotcualqcli           = ld_split+109(1).
          lit_zposdm001-l02cantremcualquiercliente  = ld_split+110(10).
          lit_zposdm001-l02desccontarjcli           = ld_split+120(1).
          lit_zposdm001-l02impdesctarjcli           = ld_split+121(10).
          lit_zposdm001-l02tasaimp                  = ld_split+131(5).
          lit_zposdm001-l02codgest                  = ld_split+136(1).
          lit_zposdm001-l02codest                   = ld_split+137(40).
          lit_zposdm001-l02cancinmedultart          = ld_split+177(1).
          lit_zposdm001-l02codventaestart           = ld_split+178(13).
          lit_zposdm001-l02cantori                  = ld_split+191(1).
          lit_zposdm001-l02cantvendumv              = ld_split+192(10).
          lit_zposdm001-l02horaventa                = ld_split+202(6).
          lit_zposdm001-l02aplicent                 = ld_split+208(1).
          lit_zposdm001-l02tratesp                  = ld_split+209(1).
          lit_zposdm001-l02codtratesp               = ld_split+210(3).
          lit_zposdm001-l02calcbeneficios           = ld_split+213(1).
          lit_zposdm001-l02calcbrii                 = ld_split+214(1).
          lit_zposdm001-l02vendatribart             = ld_split+215(4).
          lit_zposdm001-l02importeimpuni            = ld_split+219(8).
          lit_zposdm001-l02tipoigiasoraee           = ld_split+227(5).
          lit_zposdm001-l02codaagregarprensa        = ld_split+232(5).
          lit_zposdm001-l02artretmastarde           = ld_split+237(1).
          lit_zposdm001-l02artmulttasimp            = ld_split+238(1).
          lit_zposdm001-l02archcodimp               = ld_split+239(1).
          lit_zposdm001-l02archtasaimp              = ld_split+240(5).

          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '03'.
          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja             = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '03'.
          lit_zposdm001-l03fecha                   = ld_split+2(12).
          lit_zposdm001-l03importe                 = ld_split+14(10).
          lit_zposdm001-l03tipototal               = ld_split+24(1).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '07'.
          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja             = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '07'.
          lit_zposdm001-l07horaabandono            = ld_split+2(12).
          lit_zposdm001-l07abandonoauto            = ld_split+14(1).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '75'.
          ADD 1 TO ld_cont_75.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '75'.
          lit_zposdm001-conttransaccion            = ld_cont_75.
          lit_zposdm001-l75porciva                 = ld_split+15(5).
          lit_zposdm001-l75base                    = ld_split+20(10).
          lit_zposdm001-l75iva                     = ld_split+30(10).
          lit_zposdm001-l75total                   = ld_split+40(10).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '10'.
          ADD 1 TO ld_cont_10.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '10'.
          lit_zposdm001-conttransaccion            = ld_cont_10.
          lit_zposdm001-l10subidtrans              = ld_split+35(2). "01.02.2018
          lit_zposdm001-l10total                   = ld_split+14(10).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '14'.
          ADD 1 TO ld_cont_14.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '14'.
          lit_zposdm001-conttransaccion            = ld_cont_14.
          lit_zposdm001-l14total                   = ld_split+14(10).
          lit_zposdm001-l14subidtrans              = ld_split+25(2). "17.01.2018
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '24'.
          ADD 1 TO ld_cont_24.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '24'.
          lit_zposdm001-conttransaccion            = ld_cont_24.
          lit_zposdm001-l24subidtrans              = ld_split+25(2). "01.02.2018
          lit_zposdm001-l24total                   = ld_split+14(10).
          lit_zposdm001-l24tarjeta                 = ld_split+27(19).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '20'.
          ADD 1 TO ld_cont_20.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '20'.
          lit_zposdm001-conttransaccion            = ld_cont_20.
          lit_zposdm001-l20numcliente              = ld_split+26(13).
          lit_zposdm001-l20metodoid                = ld_split+39(1).
          lit_zposdm001-l20apellidos               = ld_split+41(25).
          lit_zposdm001-l20nombre                  = ld_split+66(20).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '33'.
          ADD 1 TO ld_cont_33.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '33'.
          lit_zposdm001-conttransaccion            = ld_cont_33.
          lit_zposdm001-l33total                   = ld_split+14(10).
          lit_zposdm001-l33numcli                  = ld_split+39(6).
          lit_zposdm001-l33subidtrans              = ld_split+25(2). "01.02.2018
          lit_zposdm001-l33nombre                  = ld_split+45(20).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '46'.
          ADD 1 TO ld_cont_46.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '46'.
          lit_zposdm001-conttransaccion            = ld_cont_46.
          lit_zposdm001-l46total                   = ld_split+14(10).
          lit_zposdm001-l46subidtrans              = ld_split+25(2). "17.01.2018
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '47'.
          ADD 1 TO ld_cont_47.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '47'.
          lit_zposdm001-conttransaccion            = ld_cont_47.
          lit_zposdm001-l47total                   = ld_split+14(10).
          lit_zposdm001-l47subidtrans              = ld_split+25(2). "17.01.2018
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '31'.
          ADD 1 TO ld_cont_31.

          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '31'.
          lit_zposdm001-conttransaccion            = ld_cont_31.
          lit_zposdm001-l31subidtrans              = ld_split+32(2). "01.02.2018
          lit_zposdm001-l31total                   = ld_split+47(10).
          APPEND lit_zposdm001 TO lit_zposdm001t.
        ELSEIF ld_split(2) = '99'.
          CLEAR lit_zposdm001.
          lit_zposdm001-idcaja                     = ld_split003+14(3).
          CONCATENATE '20' ld_split003+2(8) INTO lit_zposdm001-idfecha.
          lit_zposdm001-idoperacion                = ld_split001(10).
          lit_zposdm001-idtransaccion              = '99'.
          APPEND lit_zposdm001 TO lit_zposdm001t.

        ENDIF.
      ENDDO.
    ELSE.
      CONTINUE.
    ENDIF.

    PERFORM f_validar_ticket_individual TABLES lit_zposdm001t.

    APPEND LINES OF lit_zposdm001t TO lit_zposdm001.
  ENDDO.

  CLOSE DATASET ld_fichero.

  git_listado-tickets = gc_icono_tickets.

  APPEND git_listado.

  WRITE d_tabix TO ld_tabix LEFT-JUSTIFIED.
  CONCATENATE '(' ld_tabix '/' ld_tabix_tot ')' INTO ld_tabix.

  endloop_at 'Cargando Ficheros' ' ' ld_tabix '' ''.

  git_zposdm001[] = lit_zposdm001[].

* Validamos ticket a ticket y determinamos a nivel de fichero si es valido
* o no
***  DESCRIBE TABLE git_listado LINES ld_tabix_tot.
***  loop_at git_listado.
***    git_listado-valido = gc_minisemaforo_verde.
***
***    loop at git_ZPOSDM001 where L00FICHERO = git_listado-filename
***                            and IDTRANSACCION = '00'.
***
***      ld_index = sy-tabix.
***      perform f_validar_transaccion_pdt using git_listado-filename
***                                              git_zposdm001-IDCAJA
***                                              git_zposdm001-IDFECHA
***                                              git_zposdm001-IDOPERACION
***                                     CHANGING lf_error.
***
***      if lf_error = 'X' or lf_error = 'D'.
***        git_zposdm001-l00valido = gc_minisemaforo_rojo.
***        git_listado-valido = gc_minisemaforo_rojo.
***        add 1 to git_listado-numtranserr.
***      elseif lf_error = 'A'.
***        git_zposdm001-l00valido = gc_minisemaforo_ambar.
***        if git_listado-valido <> gc_minisemaforo_rojo.
***          git_listado-valido = gc_minisemaforo_ambar.
***        endif.
***        add 1 to git_listado-numtransdesc.
***      else.
***        git_zposdm001-l00valido = gc_minisemaforo_verde.
***        add 1 to git_listado-numtransok.
***      endif.
***
***      MODIFY git_zposdm001 index ld_index.
***    endloop.
***
***    MODIFY git_listado.
***
***    WRITE d_tabix TO ld_tabix LEFT-JUSTIFIED.
***    CONCATENATE '(' ld_tabix '/' ld_tabix_tot ')' into ld_tabix.
***
***  endloop_at 'Validando tickets' ' ' ld_tabix ' ' ''.

  DESCRIBE TABLE git_listado LINES ld_tabix_tot.
  loop_at git_listado.
  git_listado-valido = gc_minisemaforo_verde.

  LOOP AT git_zposdm001 WHERE l00fichero = git_listado-filename
                          AND idtransaccion = '00'.


    IF git_zposdm001-l00valido = gc_minisemaforo_rojo.
      git_listado-valido = gc_minisemaforo_rojo.
      ADD 1 TO git_listado-numtranserr.
    ELSEIF git_zposdm001-l00valido = gc_minisemaforo_ambar.
      IF git_listado-valido <> gc_minisemaforo_rojo.
        git_listado-valido = gc_minisemaforo_ambar.
      ENDIF.
      ADD 1 TO git_listado-numtransdesc.
    ELSE.
      git_zposdm001-l00valido = gc_minisemaforo_verde.
      ADD 1 TO git_listado-numtransok.
    ENDIF.
  ENDLOOP.

  MODIFY git_listado.

  WRITE d_tabix TO ld_tabix LEFT-JUSTIFIED.
  CONCATENATE '(' ld_tabix '/' ld_tabix_tot ')' INTO ld_tabix.

  endloop_at 'Validando tickets' ' ' ld_tabix ' ' ''.

* Creamos idocs
  loop_at git_listado.
  IF NOT ( git_listado-valido = gc_minisemaforo_verde OR
           git_listado-valido = gc_minisemaforo_ambar ).
    CONTINUE.
  ENDIF.

  LOOP AT git_zposdm001 WHERE l00fichero = git_listado-filename
                          AND idtransaccion = '00'
                          AND l00valido = gc_minisemaforo_verde.
    ld_index = sy-tabix.

    PERFORM f_crear_idoc_posdm_pdt USING git_zposdm001-idcaja
                                         git_zposdm001-idfecha
                                         git_zposdm001-idoperacion
                                CHANGING git_zposdm001-docnum.

    IF ld_docnum_ini IS INITIAL.
      ld_docnum_ini = git_zposdm001-docnum.
    ENDIF.

    MODIFY git_zposdm001 INDEX ld_index.
  ENDLOOP.
  endloop_at 'Generando Idocs ZZCREATEMULTIPLE' '' '' '' ''.

  ld_docnum_fin = git_zposdm001-docnum.

* Procesamos IDOC
  IF p_proc = 'X' AND ld_docnum_ini IS NOT INITIAL.
    SUBMIT rbdapp01
      WITH docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
      WITH p_output = space
      AND RETURN.

    COMMIT WORK AND WAIT.
  ENDIF.

* Calculamos Idocs
  CLEAR: gd_num_idocs_51,
         gd_num_idocs_53,
         gd_num_idocs_64.


  SELECT COUNT( * )
    FROM edidc
    INTO gd_num_idocs_51
   WHERE docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
     AND status = '51'.

  SELECT COUNT( * )
    FROM edidc
    INTO gd_num_idocs_53
   WHERE docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
     AND status = '53'.

  SELECT COUNT( * )
    FROM edidc
    INTO gd_num_idocs_64
   WHERE docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
     AND status = '64'.

  REFRESH lit_zposdm001.

  LOOP AT git_listado WHERE valido = gc_minisemaforo_verde
                         OR valido = gc_minisemaforo_ambar.
    LOOP AT git_zposdm001 INTO wa_zposdm001 WHERE l00fichero = git_listado-filename.
      LOOP AT git_zposdm001 WHERE idcaja      = wa_zposdm001-idcaja
                              AND idfecha     = wa_zposdm001-idfecha
                              AND idoperacion = wa_zposdm001-idoperacion.
        APPEND git_zposdm001 TO lit_zposdm001.
      ENDLOOP.
    ENDLOOP.
  ENDLOOP.

  MODIFY zposdm001 FROM TABLE lit_zposdm001.

* Movemos a la carpeta de procesados los ficheros incorporados correctamente
  IF gf_mover_procesados = 'X'.
    LOOP AT git_listado WHERE valido = gc_minisemaforo_verde
                           OR valido = gc_minisemaforo_ambar.
      PERFORM f_copiar_fichero USING p_folin
                                     p_folpr
                                     git_listado-filename
                            CHANGING lf_error.

      IF lf_error = ''.
        PERFORM f_borrar_fichero USING p_folin
                                       git_listado-filename
                              CHANGING lf_error.
      ENDIF.
    ENDLOOP.
  ENDIF.
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
        ld_fichero_destino(200).

  CLEAR: ps_error.

  CONCATENATE pe_carpeta_origen
              pe_fichero
         INTO ld_fichero_origen.

  CONCATENATE pe_carpeta_destino
              pe_fichero
     INTO     ld_fichero_destino.


* Primero se copia el fichero al destino
  CALL FUNCTION 'ZARCHIVFILE_SERVER'
    EXPORTING
      sourcepath = ld_fichero_origen
      targetpath = ld_fichero_destino
*   IMPORTING
*     LENGTH     =
    EXCEPTIONS
      error_file = 1
      OTHERS     = 2.

  IF sy-subrc <> 0.
    ps_error = 'X'.
  ELSE.
    ps_error = ''.
  ENDIF.
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
*& Form F_AT_SELECTION_SCREEN_OUTPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_at_selection_screen_output .
* APRADAS-Inicio-09.10.2018 10:36:15>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
* Ocultar los dos primeros y los dos ultimos radiobuttons porque en Ametller
* no tenemos ZPI
  LOOP AT SCREEN.
    IF screen-name CS 'P_R01' OR
       screen-name CS 'P_R02' OR
       screen-name CS 'P_TPV01' OR
       screen-name CS 'P_TPV02' OR
       screen-name CS 'P_R04' OR
       screen-name CS 'P_R08'.
      screen-input = 0.
      screen-invisible = 1.

      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

* APRADAS-Fin-09.10.2018 10:36:15<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  IF ( p_r01 = '' AND
       p_r02 = '' AND
       p_r03 = '' AND
       p_r04 = '' AND
       p_r05 = '' AND
       p_r06 = '' AND
       p_r07 = '' AND
       p_r08 = '' AND
       p_r09 = '' AND
       p_r10 = '' ).
    p_r03 = 'X'.
  ENDIF.

  IF p_r01 = 'X'.
    LOOP AT SCREEN.

      IF screen-name CS 'P_FOL'.
        screen-input = 0.
      ENDIF.

      IF screen-name CS 'S_FIC' OR
         screen-name CS 'S_DOCNUM' OR
         screen-name CS 'S_RSI' OR
         screen-name CS 'S_BDD' OR
         screen-name CS 'S_TTT' OR
         screen-name CS 'S_WSID' OR
         screen-name CS 'S_TSN' OR
         screen-name CS 'S_BDTS' OR
         screen-name CS 'S_EDTS' OR
         screen-name CS 'S_DEP' OR
         screen-name CS 'S_OPQ' OR
         screen-name CS 'S_OPID' OR
         screen-name CS 'S_TCURR' OR
         screen-name CS 'S_PQ' OR
         screen-name CS 'S_FECI' OR
         screen-name CS 'TABB1' OR
         screen-name CS 'B004' OR
         screen-name CS 'P005020' OR
         screen-name CS 'P006021' OR
         screen-name CS 'S_PID'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.

      IF screen-name CS 'S_2'.
        screen-invisible = 1.
        screen-input = 0.
      ENDIF.

      MODIFY SCREEN.
    ENDLOOP.
  ELSEIF p_r02 = 'X'.
    LOOP AT SCREEN.
      IF screen-name CS 'P_FOL'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.

      IF screen-name CS 'S_FIC' OR
         screen-name CS 'S_DOCNUM' OR
         screen-name CS 'S_RSI' OR
         screen-name CS 'S_BDD' OR
         screen-name CS 'S_TTT' OR
         screen-name CS 'S_WSID' OR
         screen-name CS 'S_TSN' OR
         screen-name CS 'S_BDTS' OR
         screen-name CS 'S_EDTS' OR
         screen-name CS 'S_DEP' OR
         screen-name CS 'S_OPQ' OR
         screen-name CS 'S_OPID' OR
         screen-name CS 'S_TCURR' OR
         screen-name CS 'S_PQ' OR
         screen-name CS 'S_FECI' OR
         screen-name CS 'TABB1' OR
         screen-name CS 'B004' OR
         screen-name CS 'P005020' OR
         screen-name CS 'P006021' OR
         screen-name CS 'P_PROC' OR
         screen-name CS 'S_PID'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.


      MODIFY SCREEN.
    ENDLOOP.
  ELSEIF p_r04 = 'X' OR
         p_r05 = 'X' OR
         p_r06 = 'X' OR
         p_r07 = 'X' OR
         p_r08 = 'X' OR
         p_r09 = 'X' OR
         p_r10 = 'X'.
    LOOP AT SCREEN.

      IF screen-name CS 'P_FOL'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.


      IF screen-name CS 'S_FIC' OR
         screen-name CS 'S_DOCNUM' OR
         screen-name CS 'S_RSI' OR
         screen-name CS 'S_BDD' OR
         screen-name CS 'S_TTT' OR
         screen-name CS 'S_WSID' OR
         screen-name CS 'S_TSN' OR
         screen-name CS 'S_BDTS' OR
         screen-name CS 'S_EDTS' OR
         screen-name CS 'S_DEP' OR
         screen-name CS 'S_OPQ' OR
         screen-name CS 'S_OPID' OR
         screen-name CS 'S_TCURR' OR
         screen-name CS 'S_PQ' OR
         screen-name CS 'TABB1' OR
         screen-name CS 'B004' OR
         screen-name CS 'P005022' OR
         screen-name CS 'P006023' OR
         ( screen-name CS 'P_PROC' AND p_r04 = 'X' ) OR
         screen-name CS 'S_PID' OR
         screen-name CS 'P_TPV' OR
         screen-name CS 'S_2'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.


      MODIFY SCREEN.
    ENDLOOP.
  ELSEIF p_r03 = 'X'.
    LOOP AT SCREEN.
      IF screen-name CS 'P_TPV' OR
         screen-name CS 'P_PROC' OR
         screen-name CS 'S_FECI' OR
         screen-name CS 'P_FOL'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.

      IF screen-name CS 'S_2'.
        screen-invisible = 1.
        screen-input = 0.
      ENDIF.

      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

  LOOP AT SCREEN.
    IF screen-name CS 'P_PROC'.
      screen-invisible = 1.
      screen-input = 0.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_INITIALIZATION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_initialization .
* Carpeta donde están ubicados los ficheros de TPV a incorporar
  SELECT SINGLE descr
    FROM zhardcodes
    INTO p_folin
   WHERE programa = 'ZRETPOSDM001'
     AND param    = 'CARPETA_ENTRADA'.

* Carpeta donde se han de mover los ficheros imcorporados correctamente
  SELECT SINGLE descr
    FROM zhardcodes
    INTO p_folpr
   WHERE programa = 'ZRETPOSDM001'
     AND param    = 'CARPETA_PROCESADOS'.

* Flag de movimiento de ficheros procesados a carpeta correspondiente
  SELECT SINGLE valor
    FROM zhardcodes
    INTO gf_mover_procesados
   WHERE programa = 'ZRETPOSDM001'
     AND param    = 'MOVER_PROCESADOS'.

  sscrfields-functxt_01 = '@BC@ Cierre de caja'.


ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  f_mostrar_datos
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_listar_datos CHANGING  pe_estructura     LIKE  dd02l-tabname
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
        lit_sort         TYPE         slis_t_sortinfo_alv,
        wa_sort          TYPE         slis_sortinfo_alv,
        lr_is_print_lvc  TYPE         lvc_s_prnt,
        ld_index         LIKE         sy-tabix,
        lit_events       TYPE         slis_t_event,
        wa_events        TYPE         slis_alv_event.

* 1.- Logica
*======================================================================
  wa_events-name = 'CALLER_EXIT'.
  wa_events-form = 'CALLER_EXIT'.
  APPEND wa_events TO lit_events.

  wa_events-name = 'DATA_CHANGED'.
  wa_events-form = 'F_DATA_CHANGED'.
  APPEND wa_events TO lit_events.

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
  lr_layout-stylefname = 'FIELD_STYLE'.
  lr_layout-cwidth_opt = 'X'.
  IF pe_sel = 'X'.
    lr_layout-box_fname = 'SEL'.
  ENDIF.

  IF pe_color_line <> ''.
    lr_layout-info_fname = pe_color_line.
  ENDIF.

  lr_layout-ctab_fname = 'CELLCOLR'.

  LOOP AT lit_fieldcatalog INTO wa_fieldcatalog.
    ld_index = sy-tabix.

    CASE wa_fieldcatalog-fieldname.
      WHEN 'SEL'.
        DELETE lit_fieldcatalog INDEX ld_index.
        CONTINUE.
      WHEN 'EBELN'.
        wa_fieldcatalog-hotspot = 'X'.
      WHEN 'FECHAINC'.
        wa_fieldcatalog-reptext    = 'Fecha Incorporación'.
        wa_fieldcatalog-scrtext_l  = 'FechaI'.
        wa_fieldcatalog-scrtext_m  = 'FechaI'.
        wa_fieldcatalog-scrtext_s  = 'FechaI'.
      WHEN 'HORAINC'.
        wa_fieldcatalog-reptext    = 'Hora Incorporación'.
        wa_fieldcatalog-scrtext_l  = 'HoraI'.
        wa_fieldcatalog-scrtext_m  = 'HoraI'.
        wa_fieldcatalog-scrtext_s  = 'HoraI'.
      WHEN 'USUARIOINC'.
        wa_fieldcatalog-reptext    = 'Usuario Incorporación'.
        wa_fieldcatalog-scrtext_l  = 'UsuI'.
        wa_fieldcatalog-scrtext_m  = 'UsuI'.
        wa_fieldcatalog-scrtext_s  = 'UsuI'.
      WHEN 'LIFNR'.
        wa_fieldcatalog-reptext    = 'Proveedor'.
        wa_fieldcatalog-scrtext_l  = 'Proveedor'.
        wa_fieldcatalog-scrtext_m  = 'Proveedor'.
        wa_fieldcatalog-scrtext_s  = 'Proveedor'.
      WHEN 'NUMTRANS'.
        wa_fieldcatalog-reptext    = 'Número transacciones'.
        wa_fieldcatalog-scrtext_l  = 'NumT'.
        wa_fieldcatalog-scrtext_m  = 'NumT'.
        wa_fieldcatalog-scrtext_s  = 'NumT'.
      WHEN 'NUMTRANSOK'.
        wa_fieldcatalog-reptext    = 'Número transacciones Validas'.
        wa_fieldcatalog-scrtext_l  = 'NumTOK'.
        wa_fieldcatalog-scrtext_m  = 'NumTOK'.
        wa_fieldcatalog-scrtext_s  = 'NumTOK'.
      WHEN 'NUMTRANSDESC'.
        wa_fieldcatalog-reptext    = 'Número transacciones Descartadas'.
        wa_fieldcatalog-scrtext_l  = 'NumTDes'.
        wa_fieldcatalog-scrtext_m  = 'NumTDes'.
        wa_fieldcatalog-scrtext_s  = 'NumTDes'.
      WHEN 'NUMTRANSERR'.
        wa_fieldcatalog-reptext    = 'Número transacciones erróneas'.
        wa_fieldcatalog-scrtext_l  = 'NumTErr'.
        wa_fieldcatalog-scrtext_m  = 'NumTErr'.
        wa_fieldcatalog-scrtext_s  = 'NumTErr'.
      WHEN 'VALIDO'.
        wa_fieldcatalog-reptext    = 'Fichero valido'.
        wa_fieldcatalog-scrtext_l  = 'Válido'.
        wa_fieldcatalog-scrtext_m  = 'Válido'.
        wa_fieldcatalog-scrtext_s  = 'Válido'.
        wa_fieldcatalog-just       = 'C'.
      WHEN 'TICKETS'.
        wa_fieldcatalog-reptext    = 'Detalle Tickets'.
        wa_fieldcatalog-scrtext_l  = 'Tickets'.
        wa_fieldcatalog-scrtext_m  = 'Tickets'.
        wa_fieldcatalog-scrtext_s  = 'Tickets'.
        wa_fieldcatalog-hotspot    = 'X'.
        wa_fieldcatalog-just       = 'C'.
      WHEN 'DETTICKET'.
        wa_fieldcatalog-reptext    = 'Detalle Ticket'.
        wa_fieldcatalog-scrtext_l  = 'DetTick'.
        wa_fieldcatalog-scrtext_m  = 'DetTick'.
        wa_fieldcatalog-scrtext_s  = 'DetTick'.
        wa_fieldcatalog-hotspot    = 'X'.
        wa_fieldcatalog-just       = 'C'.
      WHEN 'IDOPERACION'.
        wa_fieldcatalog-reptext    = 'ID Operación'.
        wa_fieldcatalog-scrtext_l  = 'IDOp.'.
        wa_fieldcatalog-scrtext_m  = 'IDOp.'.
        wa_fieldcatalog-scrtext_s  = 'IDOp.'.
      WHEN 'IDCAJA'.
        wa_fieldcatalog-reptext    = 'ID Caja'.
        wa_fieldcatalog-scrtext_l  = 'ID Caja'.
        wa_fieldcatalog-scrtext_m  = 'ID Caja'.
        wa_fieldcatalog-scrtext_s  = 'ID Caja'.
      WHEN 'IDFECHA'.
        wa_fieldcatalog-reptext    = 'ID Fecha'.
        wa_fieldcatalog-scrtext_l  = 'ID Fecha'.
        wa_fieldcatalog-scrtext_m  = 'ID Fecha'.
        wa_fieldcatalog-scrtext_s  = 'ID Fecha'.
      WHEN 'L00IDSISTEMA'.
        wa_fieldcatalog-reptext    = 'ID Sistema'.
        wa_fieldcatalog-scrtext_l  = 'IDSist.'.
        wa_fieldcatalog-scrtext_m  = 'IDSist.'.
        wa_fieldcatalog-scrtext_s  = 'IDSist.'.
      WHEN 'L00FECHAOPERACION'.
        wa_fieldcatalog-reptext    = 'Fecha Operación'.
        wa_fieldcatalog-scrtext_l  = 'FeOp'.
        wa_fieldcatalog-scrtext_m  = 'FeOp'.
        wa_fieldcatalog-scrtext_s  = 'FeOp'.
      WHEN 'DOCNUM'.
        wa_fieldcatalog-reptext    = 'Idoc ZZCREATEMULTIPLE'.
        wa_fieldcatalog-scrtext_l  = 'Idoc ZZCREATEMULTIPLE'.
        wa_fieldcatalog-scrtext_m  = 'Idoc ZZCREATEMULTIPLE'.
        wa_fieldcatalog-scrtext_s  = 'Idoc ZZCREATEMULTIPLE'.
        wa_fieldcatalog-hotspot    = 'X'.
      WHEN 'STATUS_IDOC'.
        wa_fieldcatalog-reptext    = 'Status Idoc'.
        wa_fieldcatalog-scrtext_l  = 'StatI'.
        wa_fieldcatalog-scrtext_m  = 'StatI'.
        wa_fieldcatalog-scrtext_s  = 'StatI'.
        wa_fieldcatalog-icon       = 'X'.
        wa_fieldcatalog-just       = 'C'.
    ENDCASE.

    MODIFY lit_fieldcatalog FROM wa_fieldcatalog.
  ENDLOOP.

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
      i_background_id             = 'FONDO_HOSS'
*     I_GRID_TITLE                =
*     I_GRID_SETTINGS             =
      is_layout_lvc               = lr_layout
      it_fieldcat_lvc             = lit_fieldcatalog
*     IT_EXCLUDING                =
*     IT_SPECIAL_GROUPS_LVC       =
*     IT_SORT_LVC                 =
*     IT_FILTER_LVC               =
*     IT_HYPERLINK                =
*     IS_SEL_HIDE                 =
      i_default                   = 'X'
      i_save                      = 'A'
*     is_variant                  =
      it_events                   = lit_events
*     IT_EVENT_EXIT               =
      is_print_lvc                = lr_is_print_lvc
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

FORM f_top_of_paget_html USING top TYPE REF TO cl_dd_document.
  DATA: ld_contador   TYPE int4,
        ld_texto(255).

  IF p_r01 = 'X'.
    CALL METHOD top->add_text
      EXPORTING
        text      = 'MONITOR INCORPORACION TICKETS TPV'
*       TEXT_TABLE    =
*       FIX_LINES =
        sap_style = 'HEADING'.
*       SAP_COLOR     =
*       SAP_FONTSIZE  =
*       SAP_FONTSTYLE =
*       SAP_EMPHASIS  =
*       STYLE_CLASS   =
*       A11Y_TOOLTIP  =
*     CHANGING
*       DOCUMENT      =
    .
  ELSEIF p_r02 = 'X'.
    CALL METHOD top->add_text
      EXPORTING
        text      = 'MONITOR TICKETS TPV'
*       TEXT_TABLE    =
*       FIX_LINES =
        sap_style = 'HEADING'.
*       SAP_COLOR     =
*       SAP_FONTSIZE  =
*       SAP_FONTSTYLE =
*       SAP_EMPHASIS  =
*       STYLE_CLASS   =
*       A11Y_TOOLTIP  =
*     CHANGING
*       DOCUMENT      =
    .
  ENDIF.

  CALL METHOD top->new_line( ).
  CALL METHOD top->new_line( ).

  CALL METHOD top->add_text
    EXPORTING
      text         = 'Fichero:'
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
*     SAP_COLOR    =
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = 'STRONG'
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*   CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_gap EXPORTING width = 15.

  ld_texto = git_listado-filename.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
*     SAP_COLOR    =
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*   CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->new_line( ).

  CALL METHOD top->add_text
    EXPORTING
      text         = 'Transacciones:'
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
*     SAP_COLOR    =
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = 'STRONG'
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*   CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_gap EXPORTING width = 2.

  IF p_r01 = 'X'.
    CALL METHOD top->add_icon
      EXPORTING
        sap_icon  = 'ICON_LED_RED'
*       SAP_SIZE  = 'EXTRA_LARGE'
        sap_style = ''
        sap_color = ''
*       ALTERNATIVE_TEXT =
*       TABINDEX  =
      .

    CLEAR ld_contador.
    LOOP AT git_listadot WHERE valido = gc_minisemaforo_rojo.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = 'LIST_NEGATIVE_INT'
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .
  ENDIF.

  CALL METHOD top->add_icon
    EXPORTING
      sap_icon  = 'ICON_LED_YELLOW'
*     SAP_SIZE  = 'EXTRA_LARGE'
      sap_style = ''
      sap_color = ''
*     ALTERNATIVE_TEXT =
*     TABINDEX  =
    .

  CLEAR ld_contador.
  LOOP AT git_listadot WHERE valido = gc_minisemaforo_ambar.
    ADD 1 TO ld_contador.
  ENDLOOP.

  WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = 'LIST_TOTAL_INT'
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*    CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_icon
    EXPORTING
      sap_icon  = 'ICON_LED_GREEN'
*     SAP_SIZE  = 'EXTRA_LARGE'
      sap_style = ''
      sap_color = ''
*     ALTERNATIVE_TEXT =
*     TABINDEX  =
    .

  CLEAR ld_contador.
  LOOP AT git_listadot WHERE valido = gc_minisemaforo_verde.
    ADD 1 TO ld_contador.
  ENDLOOP.

  WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = 'LIST_POSITIVE_INT'
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*    CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_gap EXPORTING width = 14.

  CALL METHOD top->add_text
    EXPORTING
      text         = 'Total transacciones:'
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = ''
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = 'STRONG'
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*   CHANGING
*     DOCUMENT     =
    .

  CLEAR ld_contador.
  LOOP AT git_listadot.
    ADD 1 TO ld_contador.
  ENDLOOP.

  WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = ''
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*    CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->new_line( ).

  CALL METHOD top->add_text
    EXPORTING
      text         = 'Idocs:'
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = ''
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = 'STRONG'
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*   CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_gap EXPORTING width = 18.

  CALL METHOD top->add_icon
    EXPORTING
      sap_icon  = 'ICON_LED_RED'
*     SAP_SIZE  = 'EXTRA_LARGE'
      sap_style = ''
      sap_color = ''
*     ALTERNATIVE_TEXT =
*     TABINDEX  =
    .

  WRITE gd_num_idocs_51 TO ld_texto LEFT-JUSTIFIED.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = 'LIST_NEGATIVE_INT'
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*    CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_icon
    EXPORTING
      sap_icon  = 'ICON_LED_YELLOW'
*     SAP_SIZE  = 'EXTRA_LARGE'
      sap_style = ''
      sap_color = ''
*     ALTERNATIVE_TEXT =
*     TABINDEX  =
    .

  WRITE gd_num_idocs_64 TO ld_texto LEFT-JUSTIFIED.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = 'LIST_TOTAL_INT'
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*    CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_icon
    EXPORTING
      sap_icon  = 'ICON_LED_GREEN'
*     SAP_SIZE  = 'EXTRA_LARGE'
      sap_style = ''
      sap_color = ''
*     ALTERNATIVE_TEXT =
*     TABINDEX  =
    .

  WRITE gd_num_idocs_53 TO ld_texto LEFT-JUSTIFIED.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = 'LIST_POSITIVE_INT'
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*    CHANGING
*     DOCUMENT     =
    .

  CALL METHOD top->add_gap EXPORTING width = 5.

  CALL METHOD top->add_text
    EXPORTING
      text         = 'Total idocs:'
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = ''
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = 'STRONG'
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*   CHANGING
*     DOCUMENT     =
    .

  WRITE gd_num_idocs TO ld_texto LEFT-JUSTIFIED.
  CALL METHOD top->add_text
    EXPORTING
      text         = ld_texto
*     TEXT_TABLE   =
*     FIX_LINES    =
      sap_style    = ''
      sap_color    = ''
*     SAP_FONTSIZE =
*     SAP_FONTSTYLE =
      sap_emphasis = ''
*     STYLE_CLASS  =
*     A11Y_TOOLTIP =
*    CHANGING
*     DOCUMENT     =
    .
ENDFORM.

FORM f_top_of_page_html USING top TYPE REF TO cl_dd_document.
  DATA: ld_contador   TYPE int4,
        ld_texto(255).

  IF p_r01 = 'X'.
    CALL METHOD top->add_text
      EXPORTING
        text      = 'MONITOR INCORPORACION TICKETS TPV'
*       TEXT_TABLE    =
*       FIX_LINES =
        sap_style = 'HEADING'.
*       SAP_COLOR     =
*       SAP_FONTSIZE  =
*       SAP_FONTSTYLE =
*       SAP_EMPHASIS  =
*       STYLE_CLASS   =
*       A11Y_TOOLTIP  =
*     CHANGING
*       DOCUMENT      =
    .
  ELSEIF p_r02 = 'X'.
    CALL METHOD top->add_text
      EXPORTING
        text      = 'MONITOR TICKETS TPV'
*       TEXT_TABLE    =
*       FIX_LINES =
        sap_style = 'HEADING'.
*       SAP_COLOR     =
*       SAP_FONTSIZE  =
*       SAP_FONTSTYLE =
*       SAP_EMPHASIS  =
*       STYLE_CLASS   =
*       A11Y_TOOLTIP  =
*     CHANGING
*       DOCUMENT      =
    .
  ENDIF.

  CALL METHOD top->new_line( ).
  CALL METHOD top->new_line( ).

  IF p_r01 = 'X'.
    CALL METHOD top->add_text
      EXPORTING
        text         = 'Ficheros incorporados:'
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
*       SAP_COLOR    =
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = 'STRONG'
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*     CHANGING
*       DOCUMENT     =
      .

    CALL METHOD top->add_gap EXPORTING width = 2.

    CALL METHOD top->add_icon
      EXPORTING
        sap_icon  = 'ICON_LED_RED'
*       SAP_SIZE  = 'EXTRA_LARGE'
        sap_style = ''
        sap_color = ''
*       ALTERNATIVE_TEXT =
*       TABINDEX  =
      .

    CLEAR ld_contador.
    LOOP AT git_listado WHERE valido = gc_minisemaforo_rojo.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = 'LIST_NEGATIVE_INT'
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .

    CALL METHOD top->add_icon
      EXPORTING
        sap_icon  = 'ICON_LED_YELLOW'
*       SAP_SIZE  = 'EXTRA_LARGE'
        sap_style = ''
        sap_color = ''
*       ALTERNATIVE_TEXT =
*       TABINDEX  =
      .

    CLEAR ld_contador.
    LOOP AT git_listado WHERE valido = gc_minisemaforo_ambar.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = 'LIST_TOTAL_INT'
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .

    CALL METHOD top->add_icon
      EXPORTING
        sap_icon  = 'ICON_LED_GREEN'
*       SAP_SIZE  = 'EXTRA_LARGE'
        sap_style = ''
        sap_color = ''
*       ALTERNATIVE_TEXT =
*       TABINDEX  =
      .

    CLEAR ld_contador.
    LOOP AT git_listado WHERE valido = gc_minisemaforo_verde.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = 'LIST_POSITIVE_INT'
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .

    CALL METHOD top->add_gap EXPORTING width = 5.

    CALL METHOD top->add_text
      EXPORTING
        text         = 'Total ficheros:'
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = ''
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = 'STRONG'
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*     CHANGING
*       DOCUMENT     =
      .

    CLEAR ld_contador.
    LOOP AT git_listado.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = ''
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .

  ELSEIF p_r02 = 'X'.
    CALL METHOD top->add_text
      EXPORTING
        text         = 'Ficheros seleccionados:'
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = ''
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = 'STRONG'
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*     CHANGING
*       DOCUMENT     =
      .

    CALL METHOD top->add_gap EXPORTING width = 2.

    CALL METHOD top->add_icon
      EXPORTING
        sap_icon  = 'ICON_LED_YELLOW'
*       SAP_SIZE  = 'EXTRA_LARGE'
        sap_style = ''
        sap_color = ''
*       ALTERNATIVE_TEXT =
*       TABINDEX  =
      .

    CLEAR ld_contador.
    LOOP AT git_listado WHERE valido = gc_minisemaforo_ambar.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = 'LIST_TOTAL_INT'
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .

    CALL METHOD top->add_icon
      EXPORTING
        sap_icon  = 'ICON_LED_GREEN'
*       SAP_SIZE  = 'EXTRA_LARGE'
        sap_style = ''
        sap_color = ''
*       ALTERNATIVE_TEXT =
*       TABINDEX  =
      .

    CLEAR ld_contador.
    LOOP AT git_listado WHERE valido = gc_minisemaforo_verde.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = 'LIST_POSITIVE_INT'
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .

    CALL METHOD top->add_gap EXPORTING width = 5.

    CALL METHOD top->add_text
      EXPORTING
        text         = 'Total ficheros:'
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = ''
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = 'STRONG'
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*     CHANGING
*       DOCUMENT     =
      .

    CLEAR ld_contador.
    LOOP AT git_listado.
      ADD 1 TO ld_contador.
    ENDLOOP.

    WRITE ld_contador TO ld_texto LEFT-JUSTIFIED.
    CALL METHOD top->add_text
      EXPORTING
        text         = ld_texto
*       TEXT_TABLE   =
*       FIX_LINES    =
        sap_style    = ''
        sap_color    = ''
*       SAP_FONTSIZE =
*       SAP_FONTSTYLE =
        sap_emphasis = ''
*       STYLE_CLASS  =
*       A11Y_TOOLTIP =
*      CHANGING
*       DOCUMENT     =
      .
  ENDIF.


ENDFORM.


FORM f_ucomm USING pe_ucomm   LIKE sy-ucomm
                                   rs_selfield TYPE slis_selfield.

  DATA : ref_grid TYPE REF TO cl_gui_alv_grid.

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
        IF rs_selfield-fieldname = 'TICKETS'.
          READ TABLE git_listado INDEX rs_selfield-tabindex.

          PERFORM f_tickets.
        ENDIF.
    ENDCASE.
  ENDIF.
ENDFORM.                    "F_UCOMM


FORM f_ucommt USING pe_ucomm   LIKE sy-ucomm
                                   rs_selfield TYPE slis_selfield.

  DATA : ref_grid TYPE REF TO cl_gui_alv_grid.

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
        IF rs_selfield-fieldname = 'DETTICKET'.
          READ TABLE git_listadot INDEX rs_selfield-tabindex.

          PERFORM f_tickets_det.
        ELSEIF rs_selfield-fieldname = 'DOCNUM'.
          READ TABLE git_listadot INDEX rs_selfield-tabindex.

          PERFORM f_visualizar_idoc USING git_listadot-docnum.
        ENDIF.
    ENDCASE.
  ENDIF.
ENDFORM.                    "F_UCOMM


*&---------------------------------------------------------------------*
*&      Form  F_VISUALIZAR_IDOC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_ZRETBAR001S05_DOCNUM  text
*----------------------------------------------------------------------*
FORM f_visualizar_idoc  USING pe_docnum.
  SUBMIT rseidoc2
    WITH credat BETWEEN '00000000' AND sy-datum
    WITH docnum BETWEEN pe_docnum AND space
     AND RETURN.
ENDFORM.                    " F_VISUALIZAR_IDOC


FORM caller_exit USING is_data TYPE slis_data_caller_exit.
* THIS FORM IS CALLED ONCE BEFORE THE ALV GRID IS SHOWN ON DYNPRO!!!!
* Switch to OO_ALV:
  DATA: lr_alv TYPE REF TO cl_gui_alv_grid.
  CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
    IMPORTING
      e_grid = lr_alv.
* Register ENTER as edit event:
  CALL METHOD lr_alv->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter.
* pls. use MC_EVT_MODIFIED if leaving the cell should trigger the edit event!
ENDFORM. "CALLER_EXIT

FORM f_data_changed USING ir_data_changed TYPE REF TO cl_alv_changed_data_protocol.
* 0.- Declaración de variables
*=======================================================================
  DATA: ls_modi      TYPE lvc_s_modi,
        ld_inco1     TYPE inco1,
        ld_inco2     TYPE inco2,
        ld_inco1n    TYPE inco1,
        ld_inco1nr1  TYPE inco1,
        ld_werks     LIKE marc-werks,
        lr_is_stable TYPE lvc_s_stbl.

* 1.- Lógica
*=======================================================================
  lr_is_stable-row = 'X'.
  lr_is_stable-col = 'X'.


  IF ir_data_changed->mt_protocol[] IS NOT INITIAL.
    EXIT.
  ENDIF.

* Actualizamos valores modificados en el ALV
*  LOOP AT ir_data_changed->mt_mod_cells INTO ls_modi.
*    CASE ls_modi-fieldname.
*      WHEN 'EINDT'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        CONCATENATE ls_modi-value+6(4)
*                    ls_modi-value+3(2)
*                    ls_modi-value(2)
*               INTO git_listado-eindt.
*
*        PERFORM f_calcular_fecha  USING git_listado-zzruta git_listado-eindt CHANGING git_listado-eta git_listado-etaw.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'KBETR'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        REPLACE ALL OCCURRENCES OF '.' IN ls_modi-value WITH ''.
*        REPLACE ALL OCCURRENCES OF ',' IN ls_modi-value WITH '.'.
*        git_listado-kbetr = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T0'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t0 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T1'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t1 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T2'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t2 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T3'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t3 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T4'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t4 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T5'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t5 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T6'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t6 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'T7'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-t7 = ls_modi-value.
*        MODIFY git_listado INDEX ls_modi-row_id.
*      WHEN 'ZZRUTA'.
*        READ TABLE git_listado INDEX ls_modi-row_id.
*        git_listado-zzruta = ls_modi-value.
*
*        CLEAR git_listado-inco1n.
*
*        SPLIT git_listado-incoterm AT space INTO ld_inco1 ld_inco2.
*
*        ld_werks = git_listado-werks.
*        IF ld_werks(1) = 'C'.
*          ld_werks(1) = 'H'.
*        ENDIF.
*
*        SELECT SINGLE inco1
*                      inco1nr1
*          FROM zrethosst52a
*          INTO (ld_inco1n,
*                ld_inco1nr1)
*         WHERE saiso = git_listado-zzsaiso
*           AND saisj = git_listado-zzsaisj
*           AND bsart = git_listado-bsart
*           AND werksd = ld_werks
*           AND lgort = git_listado-lgort
*           AND ruta1 = git_listado-zzruta.
*
*        IF sy-subrc <> 0.
*          SELECT SINGLE inco1
*                        inco1nr1
*            FROM zrethosst52
*            INTO (ld_inco1n,
*                  ld_inco1nr1)
*           WHERE saiso = git_listado-zzsaiso
*             AND saisj = git_listado-zzsaisj
*             AND bsart = git_listado-bsart
*             AND werksd = ld_werks
*             AND ruta1 = git_listado-zzruta.
*        ENDIF.
*
*        IF sy-subrc <> 0.
**         Msg: La ruta & no es valida para el centro & y almacén &.
*          CALL METHOD ir_data_changed->add_protocol_entry
*            EXPORTING
*              i_msgid     = 'ZRETHOSS002'
*              i_msgty     = 'E'
*              i_msgno     = '033'
*              i_msgv1     = git_listado-zzruta
*              i_msgv2     = git_listado-werks
*              i_msgv3     = git_listado-lgort
*              i_msgv4     = ''
*              i_fieldname = ls_modi-fieldname
*              i_row_id    = ls_modi-row_id.
*
*        ELSE.
*          IF ld_inco1nr1 IS NOT INITIAL.
**           Si la nueva ruta tiene incoterm1 nuevo parametrizado, entonces
**           verificamos si difiere con respecto a este el incoterm1 original
*            IF ld_inco1 <> ld_inco1nr1.
*              git_listado-inco1n = ld_inco1nr1.
*            ENDIF.
*          ELSE.
**           Si la nueva ruta no tiene incoterm1 nuevo parametrizado, entonces
**           si difiere el incoterm1 de la parametrizacion respecto al incoterm1
**           original
*            IF ld_inco1n <> ld_inco1.
*              git_listado-inco1n = ld_inco1n.
*            ENDIF.
*          ENDIF.
*          PERFORM f_get_routet      USING git_listado-zzruta CHANGING git_listado-zzrutat.
*          PERFORM f_get_icono_ruta  USING git_listado-zzruta CHANGING git_listado-mt.
*          PERFORM f_calcular_fecha  USING git_listado-zzruta git_listado-eindt CHANGING git_listado-eta git_listado-etaw.
*
*          MODIFY git_listado INDEX ls_modi-row_id.
*        ENDIF.
*    ENDCASE.
*
*    git_listado-mod_tot = git_listado-t0 + git_listado-t1 + git_listado-t2 +
*                          git_listado-t3 + git_listado-t4 + git_listado-t5 +
*                          git_listado-t6 + git_listado-t7.
*
*    MODIFY git_listado INDEX ls_modi-row_id.
*  ENDLOOP.
*
*  DATA: lr_alv TYPE REF TO cl_gui_alv_grid.
*  DATA: l_valid TYPE c.
*
*  CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
*    IMPORTING
*      e_grid = lr_alv.
*
** Register ENTER as edit event:
*  CALL METHOD lr_alv->refresh_table_display
*    EXPORTING
*      is_stable      = lr_is_stable
*      i_soft_refresh = 'X'
*    EXCEPTIONS
*      finished       = 1
*      OTHERS         = 2.
*  IF sy-subrc <> 0.
**    Implement suitable error handling here
*  ENDIF.

ENDFORM.                    "data_changed

FORM data_changed_finished.

ENDFORM.

FORM f_status USING extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_ALV'.
ENDFORM.                    "F_STATUS_S02

FORM f_statust USING extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_ALVT'.
ENDFORM.                    "F_STATUS_S02

*---------------------------------------------------------------------*
*       FORM F_TOP_OF_PAGE                                            *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
FORM f_top_of_page.
* 0.- Declaración de variables
*=========================================================================
  DATA: lit_cabecera TYPE slis_t_listheader,
        wa_cabecera  TYPE LINE OF slis_t_listheader,
        wa_t001      LIKE t001,
        wa_t024e     LIKE t024e,
        wa_t161t     LIKE t161t,
        ld_sortl     LIKE lfa1-sortl,
        wa_lfa1      LIKE lfa1,
        ld_contador  TYPE int4.

* 1.- Lógica
*=========================================================================

* Titulo
  wa_cabecera-typ  = 'H'.
  IF p_r01 = 'X'.
    wa_cabecera-info = 'MONITOR INCORPORACION TICKETS TPV'.
    APPEND wa_cabecera TO lit_cabecera.

    DESCRIBE TABLE git_listado LINES ld_contador.
    wa_cabecera-typ = 'S'.
    wa_cabecera-key = 'Fich.Incorporados:'.
    wa_cabecera-info = ld_contador.
    APPEND wa_cabecera TO lit_cabecera.

  ELSEIF p_r02 = 'X'.
    wa_cabecera-info = 'MONITOR TICKETS TPV'.
    APPEND wa_cabecera TO lit_cabecera.

    DESCRIBE TABLE git_listado LINES ld_contador.
    wa_cabecera-typ = 'S'.
    wa_cabecera-key = 'Fich.seleccionados:'.
    wa_cabecera-info = ld_contador.
    APPEND wa_cabecera TO lit_cabecera.

  ENDIF.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lit_cabecera
      i_logo             = 'ZINTROPIA_BACK'.

ENDFORM.                    "f_top_of_page_cabecera

*---------------------------------------------------------------------*
*       FORM F_TOP_OF_PAGE                                            *
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
FORM f_top_of_paget.
* 0.- Declaración de variables
*=========================================================================
  DATA: lit_cabecera TYPE slis_t_listheader,
        wa_cabecera  TYPE LINE OF slis_t_listheader,
        wa_t001      LIKE t001,
        wa_t024e     LIKE t024e,
        wa_t161t     LIKE t161t,
        ld_sortl     LIKE lfa1-sortl,
        wa_lfa1      LIKE lfa1.

* 1.- Lógica
*=========================================================================

* Titulo
  wa_cabecera-typ  = 'H'.
  IF p_r01 = 'X'.
    wa_cabecera-info = 'MONITOR INCORPORACION TICKETS TPV'.
    APPEND wa_cabecera TO lit_cabecera.

    CLEAR wa_cabecera.
    wa_cabecera-typ = 'S'.
    wa_cabecera-key = 'Fichero:'.
    wa_cabecera-info = git_listado-filename.
    APPEND wa_cabecera TO lit_cabecera.

  ELSEIF p_r02 = 'X'.
    wa_cabecera-info = 'MONITOR TICKETS TPV'.
    APPEND wa_cabecera TO lit_cabecera.

    CLEAR wa_cabecera.
    wa_cabecera-typ = 'S'.
    wa_cabecera-key = 'Fichero:'.
    wa_cabecera-info = git_listado-filename.
    APPEND wa_cabecera TO lit_cabecera.


  ENDIF.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lit_cabecera
      i_logo             = 'ZINTROPIA_BACK'.

ENDFORM.                    "f_top_of_page_cabecera

*&---------------------------------------------------------------------*
*& Form F_TICKETS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_tickets .
* 0.- Declaración de variables
*==========================================================================
  DATA: lf_error(1).

* 1.- Lógica
*==========================================================================
* Inicializamos datos ALV
  REFRESH git_listadot.

* Inicializamos contadores de idocs
  CLEAR: gd_num_idocs_51,
         gd_num_idocs_53,
         gd_num_idocs_64,
         gd_num_idocs.

* Recorremos todas las transacciones del fichero seleccionado
  LOOP AT git_zposdm001 WHERE l00fichero = git_listado-filename AND
                              idtransaccion = '00'.
*   Registramos entrada
    CLEAR git_listadot.
    git_listadot-idcaja       = git_zposdm001-idcaja.
    git_listadot-idfecha      = git_zposdm001-idfecha.
    git_listadot-idoperacion = git_zposdm001-idoperacion.
    git_listadot-l00idsistema = git_zposdm001-l00idsistema.
    git_listadot-l00fechaoperacion = git_zposdm001-l00fechaoperacion.
    git_listadot-detticket = gc_icono_detalle_ticket.
    git_listadot-docnum    = git_zposdm001-docnum.
    PERFORM f_get_status_idoc USING git_zposdm001-docnum CHANGING git_listadot-status_idoc.

    IF git_listadot-status_idoc IS NOT INITIAL.
      ADD 1 TO gd_num_idocs.

      CASE git_listadot-status_idoc.
        WHEN gc_minisemaforo_rojo.
          ADD 1 TO gd_num_idocs_51.
        WHEN gc_minisemaforo_ambar.
          ADD 1 TO gd_num_idocs_64.
        WHEN gc_minisemaforo_verde.
          ADD 1 TO gd_num_idocs_53.
      ENDCASE.
    ENDIF.

    git_listadot-valido = git_zposdm001-l00valido.

    APPEND git_listadot.
  ENDLOOP.

  PERFORM f_listar_datos USING 'ZRETPOSDM001S02'
                               'F_STATUST'
                               'F_UCOMMT'
                               ''
                               'F_TOP_OF_PAGET_HTML'
                               'GIT_LISTADOT[]'
                               ''
                               ''.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_TICKETS_DET
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_tickets_det .
  DATA: lf_error(1).

  REFRESH: git_ticket_01,
           git_ticket_02,
           git_ticket_03,
           git_ticket_04,
           git_ticket_05,
           git_ticket_06,
           git_ticket_07,
           git_ticket_08,
           git_ticket_09.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND idtransaccion = '00'.
    MOVE-CORRESPONDING git_zposdm001 TO gr_ticket_01.
    APPEND gr_ticket_01 TO git_ticket_01.
  ENDLOOP.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND idtransaccion = '01'.
    MOVE-CORRESPONDING git_zposdm001 TO gr_ticket_02.
    APPEND gr_ticket_02 TO git_ticket_02.
  ENDLOOP.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND idtransaccion = '02'.
    MOVE-CORRESPONDING git_zposdm001 TO gr_ticket_03.
    APPEND gr_ticket_03 TO git_ticket_03.
  ENDLOOP.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND idtransaccion = '03'.
    MOVE-CORRESPONDING git_zposdm001 TO gr_ticket_04.
    APPEND gr_ticket_04 TO git_ticket_04.
  ENDLOOP.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND idtransaccion = '07'.
    MOVE-CORRESPONDING git_zposdm001 TO gr_ticket_05.
    APPEND gr_ticket_05 TO git_ticket_05.
  ENDLOOP.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND ( idtransaccion = '24' OR
                                idtransaccion = '10' OR
                                idtransaccion = '14' OR
                                idtransaccion = '33' OR
                                idtransaccion = '31' OR
                                idtransaccion = '46' OR
                                idtransaccion = '47' ).

    CASE git_zposdm001-idtransaccion.
      WHEN '10'.
        PERFORM f_get_formapagot USING git_zposdm001-idtransaccion '' CHANGING gr_ticket_07-formapago.
        gr_ticket_07-total      = git_zposdm001-l10total.
      WHEN '14'.
        PERFORM f_get_formapagot USING git_zposdm001-idtransaccion git_zposdm001-l14subidtrans CHANGING gr_ticket_07-formapago.
        gr_ticket_07-total      = git_zposdm001-l14total.
      WHEN '33'.
        PERFORM f_get_formapagot USING git_zposdm001-idtransaccion '' CHANGING gr_ticket_07-formapago.
        gr_ticket_07-total      = git_zposdm001-l33total.
        gr_ticket_07-l33nombre  = git_zposdm001-l33nombre.
        gr_ticket_07-l33numcli  = git_zposdm001-l33numcli.
      WHEN '24'.
        PERFORM f_get_formapagot USING git_zposdm001-idtransaccion '' CHANGING gr_ticket_07-formapago.
        gr_ticket_07-total      = git_zposdm001-l24total.
        gr_ticket_07-numtarjeta = git_zposdm001-l24tarjeta.
      WHEN '46'.
        PERFORM f_get_formapagot USING git_zposdm001-idtransaccion git_zposdm001-l46subidtrans CHANGING gr_ticket_07-formapago.
        gr_ticket_07-total      = git_zposdm001-l46total.
      WHEN '31'.
        gr_ticket_07-total      = git_zposdm001-l31total.
      WHEN '47'.
        PERFORM f_get_formapagot USING git_zposdm001-idtransaccion git_zposdm001-l47subidtrans CHANGING gr_ticket_07-formapago.
        gr_ticket_07-total      = git_zposdm001-l47total.
    ENDCASE.

    APPEND gr_ticket_07 TO git_ticket_07.
  ENDLOOP.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND idtransaccion = '75'.
    MOVE-CORRESPONDING git_zposdm001 TO gr_ticket_08.
    APPEND gr_ticket_08 TO git_ticket_08.
  ENDLOOP.

  LOOP AT git_zposdm001 WHERE idcaja = git_listadot-idcaja
                          AND idfecha = git_listadot-idfecha
                          AND idoperacion = git_listadot-idoperacion
                          AND idtransaccion = '20'.
    MOVE-CORRESPONDING git_zposdm001 TO gr_ticket_09.
    APPEND gr_ticket_09 TO git_ticket_09.
  ENDLOOP.

  PERFORM f_validar_transaccion_pdt_log USING git_listado-filename git_listadot-idcaja git_listadot-idfecha git_listadot-idoperacion.

  CALL SCREEN 0300 STARTING AT 1 1.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_USER_COMMAND_9000
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_user_command_9000 .
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_okcode LIKE sy-ucomm.

* 1.- Lógica
*==========================================================================
  ld_okcode = gd_ockode_9000.

  CASE ld_okcode.
    WHEN 'ACEPTAR'.
      PERFORM f_free_alv USING gr_grid_01 gr_container_01.
      PERFORM f_free_alv USING gr_grid_02 gr_container_02.
      PERFORM f_free_alv USING gr_grid_03 gr_container_03.
      PERFORM f_free_alv USING gr_grid_04 gr_container_04.
      PERFORM f_free_alv USING gr_grid_05 gr_container_05.
      PERFORM f_free_alv USING gr_grid_13 gr_container_13.
      PERFORM f_free_alv USING gr_grid_14 gr_container_14.
      PERFORM f_free_alv USING gr_grid_15 gr_container_15.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDFORM.



*&---------------------------------------------------------------------*
*&      Form  f_9106_free_alv_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_free_alv USING pe_alv        TYPE REF TO cl_gui_alv_grid
                      pe_container  TYPE REF TO cl_gui_custom_container.

  IF pe_alv IS NOT INITIAL.
    CALL METHOD pe_alv->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    FREE pe_alv.
  ENDIF.


  IF pe_container IS NOT INITIAL.

    CALL METHOD pe_container->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                  WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    FREE pe_container.
  ENDIF.

ENDFORM.                    "f_9000_free_files_detail






*&---------------------------------------------------------------------*
*&      Form  f_9106_free_alv_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_9000_free_alv_06.

  IF gr_grid_06 IS NOT INITIAL.
    CALL METHOD gr_grid_06->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    FREE gr_grid_06.
  ENDIF.


  IF gr_container_06 IS NOT INITIAL.

    CALL METHOD gr_container_06->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                  WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    FREE gr_container_06.
  ENDIF.

ENDFORM.                    "f_9000_free_files_detail

*&---------------------------------------------------------------------*
*&      Form  f_9106_free_alv_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_0100_free_alv_07.

  IF gr_grid_07 IS NOT INITIAL.
    CALL METHOD gr_grid_07->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    FREE gr_grid_07.
  ENDIF.


  IF gr_container_07 IS NOT INITIAL.

    CALL METHOD gr_container_07->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                  WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    FREE gr_container_07.
  ENDIF.

ENDFORM.                    "f_9000_free_files_detail


*&---------------------------------------------------------------------*
*& Form F_9000_PBO_INIT_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_9000_pbo_init_alv .

  IF gr_grid_01 IS INITIAL.
    PERFORM f_9000_init_alv_01.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_01 'X' 'X' 'X' ''.
  ENDIF.

  IF gr_grid_02 IS INITIAL.
    PERFORM f_9000_init_alv_02.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_02 'X' 'X' 'X' ''.
  ENDIF.

  IF gr_grid_03 IS INITIAL.
    PERFORM f_9000_init_alv_03.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_03 'X' 'X' 'X' ''.
  ENDIF.

  IF gr_grid_04 IS INITIAL.
    PERFORM f_9000_init_alv_04.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_04 'X' 'X' 'X' ''.

  ENDIF.

  IF gr_grid_05 IS INITIAL.
    PERFORM f_9000_init_alv_05.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_05 'X' 'X' 'X' ''.
  ENDIF.

  IF gr_grid_06 IS INITIAL.
    PERFORM f_9000_init_alv_06.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_06 'X' 'X' 'X' ''.
  ENDIF.


  IF gr_grid_13 IS INITIAL.
    PERFORM f_9000_init_alv_13.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_13 'X' 'X' 'X' ''.
  ENDIF.

  IF gr_grid_14 IS INITIAL.
    PERFORM f_9000_init_alv_14.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_14 'X' 'X' 'X' ''.
  ENDIF.

  IF gr_grid_15 IS INITIAL.
    PERFORM f_9000_init_alv_15.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_15 'X' 'X' 'X' ''.
  ENDIF.


ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_9000_PBO_INIT_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_0200_pbo_init_alv .

  IF gr_grid_08 IS INITIAL.
    PERFORM f_0200_init_alv_08.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_08 'X' 'X' 'X' 'X'.
  ENDIF.

  IF gf_0200_ticket = 'X'.
*   Lineas ticket
    IF gf_refresh_posdm_popup_l = 'X' AND gr_grid_10 IS NOT INITIAL.
      PERFORM f_free_alv USING gr_grid_10 gr_container_10.

      CLEAR gf_refresh_posdm_popup_l.
    ENDIF.

    IF gr_grid_10 IS INITIAL.
      PERFORM f_0200_init_alv_10.
    ELSE.
      PERFORM f_refresh_alv USING gr_grid_10 'X' 'X' 'X' ''.
    ENDIF.

*   Descuentos ticket
    IF gf_call_t4 = ''.
      IF gr_grid_11 IS INITIAL.
        PERFORM f_0200_init_alv_11.
      ELSE.
        PERFORM f_refresh_alv USING gr_grid_11 'X' 'X' 'X' ''.
      ENDIF.
    ENDIF.

*   Formas de pago ticket
    IF gr_grid_12 IS INITIAL.
      PERFORM f_0200_init_alv_12.
    ELSE.
      PERFORM f_refresh_alv USING gr_grid_12 'X' 'X' 'X' ''.
    ENDIF.

*   Tareas Ticket
    IF gr_grid_09 IS INITIAL.
      PERFORM f_0200_init_alv_09.
    ELSE.
      PERFORM f_refresh_alv USING gr_grid_09 'X' 'X' 'X' ''.
    ENDIF.


  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_9000_PBO_INIT_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_0100_pbo_init_alv .

  IF gr_grid_07 IS INITIAL.
    PERFORM f_0100_init_alv_07.
  ELSE.
    PERFORM f_0100_refresh_alv_07 USING 'X' 'X' 'X'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_01 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_01
    EXPORTING
      container_name = 'CONTAINER_01'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_01
    EXPORTING
      i_parent = gr_container_01.

* Configurar layout
  PERFORM f_gen_layout_01.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_01.

* Cargar el alv
  CALL METHOD gr_grid_01->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_01
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_01
      it_fieldcatalog = git_fieldcatalog_01.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_0100_init_alv_07 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_07
    EXPORTING
      container_name = 'CONTAINER_07'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_07
    EXPORTING
      i_parent = gr_container_07.

* Configurar layout
  PERFORM f_gen_layout_07.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_07.

* Cargar el alv
  CALL METHOD gr_grid_07->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_07
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_descarte_fic
      it_fieldcatalog = git_fieldcatalog_07.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_02 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_02
    EXPORTING
      container_name = 'CONTAINER_02'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_02
    EXPORTING
      i_parent = gr_container_02.

* Configurar layout
  PERFORM f_gen_layout_02.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_02.

* Cargar el alv
  CALL METHOD gr_grid_02->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_02
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_02
      it_fieldcatalog = git_fieldcatalog_02.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_03 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_03
    EXPORTING
      container_name = 'CONTAINER_03'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_03
    EXPORTING
      i_parent = gr_container_03.

* Configurar layout
  PERFORM f_gen_layout_03.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_03.

* Cargar el alv
  CALL METHOD gr_grid_03->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_03
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_03
      it_fieldcatalog = git_fieldcatalog_03.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_04 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_04
    EXPORTING
      container_name = 'CONTAINER_04'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_04
    EXPORTING
      i_parent = gr_container_04.

* Configurar layout
  PERFORM f_gen_layout_04.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_04.

* Cargar el alv
  CALL METHOD gr_grid_04->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_04
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_04
      it_fieldcatalog = git_fieldcatalog_04.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_13 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_13
    EXPORTING
      container_name = 'CONTAINER_13'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_13
    EXPORTING
      i_parent = gr_container_13.

* Configurar layout
  PERFORM f_gen_layout_13.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_13.

* Cargar el alv
  CALL METHOD gr_grid_13->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_13
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_07
      it_fieldcatalog = git_fieldcatalog_13.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_14 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_14
    EXPORTING
      container_name = 'CONTAINER_14'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_14
    EXPORTING
      i_parent = gr_container_14.

* Configurar layout
  PERFORM f_gen_layout_14.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_14.

* Cargar el alv
  CALL METHOD gr_grid_14->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_14
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_08
      it_fieldcatalog = git_fieldcatalog_14.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_15 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_15
    EXPORTING
      container_name = 'CONTAINER_15'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_15
    EXPORTING
      i_parent = gr_container_15.

* Configurar layout
  PERFORM f_gen_layout_15.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_15.

* Cargar el alv
  CALL METHOD gr_grid_15->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_15
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_09
      it_fieldcatalog = git_fieldcatalog_15.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_05 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_05
    EXPORTING
      container_name = 'CONTAINER_05'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_05
    EXPORTING
      i_parent = gr_container_05.

* Configurar layout
  PERFORM f_gen_layout_05.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_05.

* Cargar el alv
  CALL METHOD gr_grid_05->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_05
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_05
      it_fieldcatalog = git_fieldcatalog_05.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9000_init_alv_06 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_06
    EXPORTING
      container_name = 'CONTAINER_06'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_06
    EXPORTING
      i_parent = gr_container_06.

* Configurar layout
  PERFORM f_gen_layout_06.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_06.

* Cargar el alv
  CALL METHOD gr_grid_06->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_06
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_ticket_06
      it_fieldcatalog = git_fieldcatalog_06.
  " f_9000_init_alv_1
ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_0200_init_alv_08 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_08
    EXPORTING
      container_name = 'CONTAINER_08'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_08
    EXPORTING
      i_parent = gr_container_08.

* Configurar layout
  PERFORM f_gen_layout_08.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_08.

* Cargar el alv
  CALL METHOD gr_grid_08->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_08
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_posdm_popup_c
      it_fieldcatalog = git_fieldcatalog_08.

* Crear e activar eventos para el ALV
  CREATE OBJECT gr_event_handler_08.
  SET HANDLER gr_event_handler_08->handle_hotspot_click_alv_08 FOR gr_grid_08.

ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9002_init_alv_16 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_16
    EXPORTING
      container_name = 'CONTAINER_16'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_16
    EXPORTING
      i_parent = gr_container_16.

* Configurar layout
  PERFORM f_gen_layout_16.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_16.

* Cargar el alv
  CALL METHOD gr_grid_16->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_16
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_cierre_dias
      it_fieldcatalog = git_fieldcatalog_16.

* Crear e activar eventos para el ALV
  CREATE OBJECT gr_event_handler_16.
  SET HANDLER gr_event_handler_16->handle_hotspot_click_alv_16 FOR gr_grid_16.

ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_9002_init_alv_17 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_17
    EXPORTING
      container_name = 'CONTAINER_17'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_17
    EXPORTING
      i_parent = gr_container_17.

* Configurar layout
  PERFORM f_gen_layout_17.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_17.


  CALL METHOD gr_grid_17->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  CALL METHOD gr_grid_17->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter.


* Cargar el alv
  CALL METHOD gr_grid_17->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_17
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_cierre_det
      it_fieldcatalog = git_fieldcatalog_17.

* Crear e activar eventos para el ALV
  CREATE OBJECT gr_event_handler_17.
  SET HANDLER gr_event_handler_17->handle_data_changed_alv_17    FOR gr_grid_17.
  SET HANDLER gr_event_handler_17->handle_data_changed_f_alv_17  FOR gr_grid_17.
ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_0200_init_alv_09 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_09
    EXPORTING
      container_name = 'CONTAINER_09'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_09
    EXPORTING
      i_parent = gr_container_09.

* Configurar layout
  PERFORM f_gen_layout_09.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_09.

* Cargar el alv
  CALL METHOD gr_grid_09->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_09
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_posdm_popup_t
      it_fieldcatalog = git_fieldcatalog_09.

ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_0200_init_alv_10 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_10
    EXPORTING
      container_name = 'CONTAINER_10'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_10
    EXPORTING
      i_parent = gr_container_10.

* Configurar layout
  PERFORM f_gen_layout_10.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_10.

  CALL METHOD gr_grid_10->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  CALL METHOD gr_grid_10->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter.

* Cargar el alv
  CALL METHOD gr_grid_10->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_10
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_posdm_popup_l
      it_fieldcatalog = git_fieldcatalog_10.


* Crear e activar eventos para el ALV
  CREATE OBJECT gr_event_handler_10.
  SET HANDLER gr_event_handler_10->handle_data_changed_alv_10    FOR gr_grid_10.
  SET HANDLER gr_event_handler_10->handle_data_changed_f_alv_10  FOR gr_grid_10.

ENDFORM.                    " F_9001_INIT_ALV_01

*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_0200_init_alv_11 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_11
    EXPORTING
      container_name = 'CONTAINER_11'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_11
    EXPORTING
      i_parent = gr_container_11.

* Configurar layout
  PERFORM f_gen_layout_11.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_11.

* Cargar el alv
  CALL METHOD gr_grid_11->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_11
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_posdm_popup_d
      it_fieldcatalog = git_fieldcatalog_11.

ENDFORM.                    " F_9001_INIT_ALV_01


*&---------------------------------------------------------------------*
*&      Form  F_9001_INIT_ALV_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_0200_init_alv_12 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Logica
*--------------------------------------------------------------------*

* Crear el contenedor en el control de la pantalla
  CREATE OBJECT gr_container_12
    EXPORTING
      container_name = 'CONTAINER_12'.

* Crear el ALV en el container
  CREATE OBJECT gr_grid_12
    EXPORTING
      i_parent = gr_container_12.

* Configurar layout
  PERFORM f_gen_layout_12.

* Configurar fieldcatalog
  PERFORM f_gen_fieldcatalog_12.

* Cargar el alv
  CALL METHOD gr_grid_12->set_table_for_first_display
    EXPORTING
      i_buffer_active = 'X'
      is_layout       = gr_layout_12
*     i_save          = 'A'
*     is_variant      = lr_variant
*     it_toolbar_excluding =
    CHANGING
      it_outtab       = git_posdm_popup_m
      it_fieldcatalog = git_fieldcatalog_12.

ENDFORM.                    " F_9001_INIT_ALV_01




*&---------------------------------------------------------------------*
*&      Form  f_9000_refresh_alv_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->E_ROW            text
*      -->E_COLUMN         text
*      -->PE_SOFT_REFRESH  text
*----------------------------------------------------------------------*
FORM f_0100_refresh_alv_07 USING e_row e_column pe_soft_refresh.

  DATA: ld_lvc    TYPE lvc_s_stbl,
        it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        ld_col    TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

  ld_lvc-row = e_row.
  ld_lvc-col = e_column.

* Recuperar donde esta el cursor en el ALV
  CALL METHOD gr_grid_07->get_current_cell
    IMPORTING
      e_row = ld_fila
*     e_value   =
      e_col = ld_col
*     es_row_id =
*     es_col_id =
*     es_row_no =
    .

* Refrescar la tabla para actualizar los cambios
  CALL METHOD gr_grid_07->refresh_table_display
    EXPORTING
      is_stable      = ld_lvc
      i_soft_refresh = pe_soft_refresh
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2.
ENDFORM.                    " f_9000_refresh_alv_1









*&---------------------------------------------------------------------*
*&      Form  f_refresh_alv
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->E_ROW            text
*      -->E_COLUMN         text
*      -->PE_SOFT_REFRESH  text
*----------------------------------------------------------------------*
FORM f_refresh_alv USING pe_alv TYPE REF TO cl_gui_alv_grid
                         e_row
                         e_column
                         pe_soft_refresh
                         pe_sel_row.

* 0.- Declaración de variables
*==========================================================================
  DATA: ld_lvc    TYPE lvc_s_stbl,
        it_filas  TYPE lvc_t_roid,
        ld_fila   TYPE int4,
        ld_col    TYPE int4,
        lr_filas  TYPE lvc_s_roid,
        lit_filas TYPE lvc_t_roid.

* 1.- Lógica
*==========================================================================
  ld_lvc-row = e_row.
  ld_lvc-col = e_column.

* Recuperar donde esta el cursor en el ALV
  CALL METHOD pe_alv->get_current_cell
    IMPORTING
      e_row = ld_fila
*     e_value   =
      e_col = ld_col
*     es_row_id =
*     es_col_id =
*     es_row_no =
    .

* Refrescar la tabla para actualizar los cambios
  CALL METHOD pe_alv->refresh_table_display
    EXPORTING
      is_stable = ld_lvc
*     i_soft_refresh = pe_soft_refresh
    EXCEPTIONS
      finished  = 1
      OTHERS    = 2.


  IF pe_sel_row = 'X'.
    DATA: lit_row_no TYPE lvc_t_row,
          wa_row_no  TYPE lvc_s_row.

    wa_row_no-index = ld_fila.
    APPEND wa_row_no TO lit_row_no.

    CALL METHOD pe_alv->set_selected_rows
      EXPORTING
        it_index_rows = lit_row_no
*       it_row_no     = lit_row_no
*       is_keep_other_selections =
      .
  ENDIF.

ENDFORM.                    " f_9000_refresh_alv_1



*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_01 .
  gr_layout_01-no_toolbar = 'X'.
  gr_layout_01-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_02 .
  gr_layout_02-no_toolbar = 'X'.
  gr_layout_02-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01



*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_03 .
  gr_layout_03-no_toolbar = 'X'.
  gr_layout_03-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
  gr_layout_03-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01



*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_04 .
  gr_layout_04-no_toolbar = 'X'.
  gr_layout_04-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_13 .
  gr_layout_13-no_toolbar = 'X'.
  gr_layout_13-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01


*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_14 .
  gr_layout_14-no_toolbar = 'X'.
  gr_layout_14-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01


*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_15 .
  gr_layout_15-no_toolbar = 'X'.
  gr_layout_15-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01


*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_05 .
  gr_layout_05-no_toolbar = 'X'.
  gr_layout_05-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_06 .
  gr_layout_06-no_toolbar = 'X'.
  gr_layout_06-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_08 .
  gr_layout_08-no_toolbar = 'X'.
*  gr_layout_08-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*   gr_layout_08-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01


*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_16 .
  gr_layout_16-no_toolbar = 'X'.
*  gr_layout_16-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_17 .
  gr_layout_17-no_toolbar = 'X'.
*  gr_layout_16-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01


*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_09 .
  gr_layout_09-no_toolbar = 'X'.
  gr_layout_09-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01


*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_10 .
  gr_layout_10-no_toolbar = 'X'.
*  gr_layout_10-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_11 .
  gr_layout_11-no_toolbar = 'X'.
  gr_layout_11-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_12 .
  gr_layout_12-no_toolbar = 'X'.
  gr_layout_12-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  f_gen_layout_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f_gen_layout_07 .
  gr_layout_07-no_toolbar = 'X'.
  gr_layout_07-zebra = 'X'.
*   gr_layout_01-no_rowmark = 'X'.
*  gr_layout_01-cwidth_opt = 'X'.
*  gr_layout_01-info_fname  = 'ROW_COLOR'.
*  gr_layout_01-sel_mode     = 'A'.
*  gr_layout_01-box_fname = 'SEL'.
*  gr_layout_01-stylefname = 'CELLSTYLES'.
ENDFORM.                    " f_gen_layout_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_01.
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_01,
        ld_index        LIKE sy-tabix.

* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_01.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S03'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_01
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_01 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'IDCAJA'.
        wa_fieldcatalog-reptext   = 'Caja'.
        wa_fieldcatalog-scrtext_l = 'Caja'.
        wa_fieldcatalog-scrtext_m = 'Caja'.
        wa_fieldcatalog-scrtext_s = 'Caja'.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'IDFECHA'.
        wa_fieldcatalog-reptext   = 'Fecha Ticket'.
        wa_fieldcatalog-scrtext_l = 'FechaT'.
        wa_fieldcatalog-scrtext_m = 'FechaT'.
        wa_fieldcatalog-scrtext_s = 'FechaT'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'IDOPERACION'.
        wa_fieldcatalog-reptext   = 'Número Ticket'.
        wa_fieldcatalog-scrtext_l = 'NumTicket'.
        wa_fieldcatalog-scrtext_m = 'NumTicket'.
        wa_fieldcatalog-scrtext_s = 'NumTicket'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L00FECHAINC'.
        wa_fieldcatalog-reptext   = 'Fecha Incorporación'.
        wa_fieldcatalog-scrtext_l = 'FechaI'.
        wa_fieldcatalog-scrtext_m = 'FechaI'.
        wa_fieldcatalog-scrtext_s = 'FechaI'.
        wa_fieldcatalog-outputlen = 9.
      WHEN 'L00HORAINC'.
        wa_fieldcatalog-reptext   = 'Hora Incorporación'.
        wa_fieldcatalog-scrtext_l = 'HoraI'.
        wa_fieldcatalog-scrtext_m = 'HoraI'.
        wa_fieldcatalog-scrtext_s = 'HoraI'.
        wa_fieldcatalog-outputlen = 7.
      WHEN 'L00USUARIOINC'.
        wa_fieldcatalog-reptext   = 'Usuario Incorporación'.
        wa_fieldcatalog-scrtext_l = 'UsuarioI'.
        wa_fieldcatalog-scrtext_m = 'UsuarioI'.
        wa_fieldcatalog-scrtext_s = 'UsuarioI'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L00CODOPERACION'.
        wa_fieldcatalog-reptext   = 'Código operación'.
        wa_fieldcatalog-scrtext_l = 'CodOper'.
        wa_fieldcatalog-scrtext_m = 'CodOper'.
        wa_fieldcatalog-scrtext_s = 'CodOper'.
        wa_fieldcatalog-outputlen = 7.
      WHEN 'L00IDSISTEMA'.
        wa_fieldcatalog-reptext   = 'ID Sistema'.
        wa_fieldcatalog-scrtext_l = 'IDSist'.
        wa_fieldcatalog-scrtext_m = 'IDSist'.
        wa_fieldcatalog-scrtext_s = 'IDSist'.
        wa_fieldcatalog-outputlen = 7.
      WHEN 'L00FECHAOPERACION'.
        wa_fieldcatalog-reptext   = 'Fecha Operación'.
        wa_fieldcatalog-scrtext_l = 'FechaOp'.
        wa_fieldcatalog-scrtext_m = 'FechaOp'.
        wa_fieldcatalog-scrtext_s = 'FechaOp'.
        wa_fieldcatalog-outputlen = 12.
      WHEN 'L00FICHERO'.
        wa_fieldcatalog-reptext   = 'Fichero'.
        wa_fieldcatalog-scrtext_l = 'Fichero'.
        wa_fieldcatalog-scrtext_m = 'Fichero'.
        wa_fieldcatalog-scrtext_s = 'Fichero'.
        wa_fieldcatalog-outputlen = 45.
    ENDCASE.

    MODIFY git_fieldcatalog_01 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_02.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_02,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_02.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S04'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_02
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_02 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'L01FECHATRANSACCION'.
        wa_fieldcatalog-reptext   = 'Fecha Transacción'.
        wa_fieldcatalog-scrtext_l = 'FeTrans'.
        wa_fieldcatalog-scrtext_m = 'FeTrans'.
        wa_fieldcatalog-scrtext_s = 'FeTrans'.
        wa_fieldcatalog-outputlen = 12.
      WHEN 'L01NUMCAJA'.
        wa_fieldcatalog-reptext   = 'Número de caja'.
        wa_fieldcatalog-scrtext_l = 'NumCaja'.
        wa_fieldcatalog-scrtext_m = 'NumCaja'.
        wa_fieldcatalog-scrtext_s = 'NumCaja'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L01NUMCAJERO'.
        wa_fieldcatalog-reptext   = 'Número del cajero'.
        wa_fieldcatalog-scrtext_l = 'NumCajer'.
        wa_fieldcatalog-scrtext_m = 'NumCajer'.
        wa_fieldcatalog-scrtext_s = 'NumCajer'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L01CAJAFORMACION'.
        wa_fieldcatalog-reptext   = 'Caja de formación'.
        wa_fieldcatalog-scrtext_l = 'CajForm'.
        wa_fieldcatalog-scrtext_m = 'CajForm'.
        wa_fieldcatalog-scrtext_s = 'CajForm'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L01TIPOTICKETCLIENTE'.
        wa_fieldcatalog-reptext   = 'Tipo ticket cliente'.
        wa_fieldcatalog-scrtext_l = 'TipTickCli'.
        wa_fieldcatalog-scrtext_m = 'TipTickCli'.
        wa_fieldcatalog-scrtext_s = 'TipTickCli'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L01TICKETABANDONADO'.
        wa_fieldcatalog-reptext   = 'Ticket abandonado'.
        wa_fieldcatalog-scrtext_l = 'TickAbo'.
        wa_fieldcatalog-scrtext_m = 'TickAbo'.
        wa_fieldcatalog-scrtext_s = 'TickAbo'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L01NUMMESAREST'.
        wa_fieldcatalog-reptext   = 'Número de mesa del restaurante'.
        wa_fieldcatalog-scrtext_l = 'NumMesRest'.
        wa_fieldcatalog-scrtext_m = 'NumMesRest'.
        wa_fieldcatalog-scrtext_s = 'NumMesRest'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L01CODIMPRED'.
        wa_fieldcatalog-reptext   = 'Código impuesto reducido'.
        wa_fieldcatalog-scrtext_l = 'CódImpRed'.
        wa_fieldcatalog-scrtext_m = 'CódImpRed'.
        wa_fieldcatalog-scrtext_s = 'CódImpRed'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L01POCIMPRED'.
        wa_fieldcatalog-reptext   = 'Porcentaje impuesto reducido'.
        wa_fieldcatalog-scrtext_l = 'PorcImpRed'.
        wa_fieldcatalog-scrtext_m = 'PorcImpRed'.
        wa_fieldcatalog-scrtext_s = 'PorcImpRed'.
        wa_fieldcatalog-outputlen = 10.
    ENDCASE.

    MODIFY git_fieldcatalog_02 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_03.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_03,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_03.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S05'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_03
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_03 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'L02ANULACIONARTICULO'.
        wa_fieldcatalog-reptext   = 'Anulación artículo'.
        wa_fieldcatalog-scrtext_l = 'AA'.
        wa_fieldcatalog-scrtext_m = 'AA'.
        wa_fieldcatalog-scrtext_s = 'AA'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'L02CODART'.
        wa_fieldcatalog-reptext   = 'Código artículo'.
        wa_fieldcatalog-scrtext_l = 'CódArt'.
        wa_fieldcatalog-scrtext_m = 'CódArt'.
        wa_fieldcatalog-scrtext_s = 'CódArt'.
        wa_fieldcatalog-outputlen = 13.
      WHEN 'L02CODARTT'.
        wa_fieldcatalog-reptext   = 'DenominaciónCódigo artículo'.
        wa_fieldcatalog-scrtext_l = 'CódArtT'.
        wa_fieldcatalog-scrtext_m = 'CódArtT'.
        wa_fieldcatalog-scrtext_s = 'CódArtT'.
        wa_fieldcatalog-outputlen = 20.
      WHEN 'L02METOBT'.
        wa_fieldcatalog-reptext   = 'Método obtención'.
        wa_fieldcatalog-scrtext_l = 'MO'.
        wa_fieldcatalog-scrtext_m = 'MO'.
        wa_fieldcatalog-scrtext_s = 'MO'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'L02PVPUNIINCIMP'.
        wa_fieldcatalog-reptext   = 'Precio venta unitario incluido impuesto'.
        wa_fieldcatalog-scrtext_l = 'PVUII'.
        wa_fieldcatalog-scrtext_m = 'PVUII'.
        wa_fieldcatalog-scrtext_s = 'PVUII'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L02CANTVEND'.
        wa_fieldcatalog-reptext   = 'Cantidad vendida'.
        wa_fieldcatalog-scrtext_l = 'CV'.
        wa_fieldcatalog-scrtext_m = 'CV'.
        wa_fieldcatalog-scrtext_s = 'CV'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'L02ORIPVO'.
        wa_fieldcatalog-reptext   = 'Origen del precio de venta'.
        wa_fieldcatalog-scrtext_l = 'OPV'.
        wa_fieldcatalog-scrtext_m = 'OPV'.
        wa_fieldcatalog-scrtext_s = 'OPV'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L02CODIMPART'.
        wa_fieldcatalog-reptext   = 'Código del impuesto del artículo'.
        wa_fieldcatalog-scrtext_l = 'CIA'.
        wa_fieldcatalog-scrtext_m = 'CIA'.
        wa_fieldcatalog-scrtext_s = 'CIA'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L02NUMRAYON'.
        wa_fieldcatalog-reptext   = 'Número de rayon'.
        wa_fieldcatalog-scrtext_l = 'NR'.
        wa_fieldcatalog-scrtext_m = 'NR'.
        wa_fieldcatalog-scrtext_s = 'NR'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'L02NUMFAMILIA'.
        wa_fieldcatalog-reptext   = 'Número de familia'.
        wa_fieldcatalog-scrtext_l = 'NF'.
        wa_fieldcatalog-scrtext_m = 'NF'.
        wa_fieldcatalog-scrtext_s = 'NF'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L02NUMSUBFAMILIA'.
        wa_fieldcatalog-reptext   = 'Número de subfamilia'.
        wa_fieldcatalog-scrtext_l = 'NS'.
        wa_fieldcatalog-scrtext_m = 'NS'.
        wa_fieldcatalog-scrtext_s = 'NS'.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'L02CONSIGNA'.
        wa_fieldcatalog-reptext   = 'Consigna'.
        wa_fieldcatalog-scrtext_l = 'C'.
        wa_fieldcatalog-scrtext_m = 'C'.
        wa_fieldcatalog-scrtext_s = 'C'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'L02PRECCOMPLEIDO'.
        wa_fieldcatalog-reptext   = 'Precio de compra leído en gencod'.
        wa_fieldcatalog-scrtext_l = 'PCLGC'.
        wa_fieldcatalog-scrtext_m = 'PCLGC'.
        wa_fieldcatalog-scrtext_s = 'PCLGC'.
        wa_fieldcatalog-outputlen = 6.
      WHEN 'L02PRECCOMPLEIDOUNO'.
        wa_fieldcatalog-reptext   = 'Precio de compra unitario leído en gencod'.
        wa_fieldcatalog-scrtext_l = 'PCULGC'.
        wa_fieldcatalog-scrtext_m = 'PCULGC'.
        wa_fieldcatalog-scrtext_s = 'PCULGC'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L02ANULINMED'.
        wa_fieldcatalog-reptext   = 'Anulación inmediata'.
        wa_fieldcatalog-scrtext_l = 'AI'.
        wa_fieldcatalog-scrtext_m = 'AI'.
        wa_fieldcatalog-scrtext_s = 'AI'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L02IMPORTECONIMPSINDESC'.
        wa_fieldcatalog-reptext   = 'Importe con impuesto y sin descuento'.
        wa_fieldcatalog-scrtext_l = 'ICISD'.
        wa_fieldcatalog-scrtext_m = 'ICISD'.
        wa_fieldcatalog-scrtext_s = 'ICISD'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L02DESCOTORGART'.
        wa_fieldcatalog-reptext   = 'Descuento otorgado en este artículo'.
        wa_fieldcatalog-scrtext_l = 'DOA'.
        wa_fieldcatalog-scrtext_m = 'DOA'.
        wa_fieldcatalog-scrtext_s = 'DOA'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L02IMPTOTREBCONC'.
        wa_fieldcatalog-reptext   = 'Importe total de la rebaja concedida'.
        wa_fieldcatalog-scrtext_l = 'ITRC'.
        wa_fieldcatalog-scrtext_m = 'ITRC'.
        wa_fieldcatalog-scrtext_s = 'ITRC'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L02DESCOTCUALQCLI'.
        wa_fieldcatalog-reptext   = 'Descuento otorgado cualquier cliente'.
        wa_fieldcatalog-scrtext_l = 'DOCC'.
        wa_fieldcatalog-scrtext_m = 'DOCC'.
        wa_fieldcatalog-scrtext_s = 'DOCC'.
        wa_fieldcatalog-outputlen = 6.
      WHEN 'L02CANTREMCUALQUIERCLIENTE'.
        wa_fieldcatalog-reptext   = 'Cantidad remitida cualquier cliente'.
        wa_fieldcatalog-scrtext_l = 'CRCC'.
        wa_fieldcatalog-scrtext_m = 'CRCC'.
        wa_fieldcatalog-scrtext_s = 'CRCC'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L02DESCCONTARJCLI'.
        wa_fieldcatalog-reptext   = 'Descuento con tarjeta de cliente'.
        wa_fieldcatalog-scrtext_l = 'DTC'.
        wa_fieldcatalog-scrtext_m = 'DTC'.
        wa_fieldcatalog-scrtext_s = 'DTC'.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'L02IMPDESCTARJCLI'.
        wa_fieldcatalog-reptext   = 'Importe descuento tarjeta cliente'.
        wa_fieldcatalog-scrtext_l = 'IDTC'.
        wa_fieldcatalog-scrtext_m = 'IDTC'.
        wa_fieldcatalog-scrtext_s = 'IDTC'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L02TASAIMP'.
        wa_fieldcatalog-reptext   = 'Tasa de impuesto'.
        wa_fieldcatalog-scrtext_l = 'TI'.
        wa_fieldcatalog-scrtext_m = 'TI'.
        wa_fieldcatalog-scrtext_s = 'TI'.
        wa_fieldcatalog-outputlen = 7.
      WHEN 'L02CODGEST'.
        wa_fieldcatalog-reptext   = 'Código gestión'.
        wa_fieldcatalog-scrtext_l = 'CG'.
        wa_fieldcatalog-scrtext_m = 'CG'.
        wa_fieldcatalog-scrtext_s = 'CG'.
        wa_fieldcatalog-outputlen = 7.
      WHEN 'L02CODEST'.
        wa_fieldcatalog-reptext   = 'Código estandarizado'.
        wa_fieldcatalog-scrtext_l = 'CE'.
        wa_fieldcatalog-scrtext_m = 'CE'.
        wa_fieldcatalog-scrtext_s = 'CE'.
        wa_fieldcatalog-outputlen = 40.
      WHEN 'L02CANCINMEDULTART'.
        wa_fieldcatalog-reptext   = 'Cancelación Inmediata Ultimo Artículo'.
        wa_fieldcatalog-scrtext_l = 'CIUA'.
        wa_fieldcatalog-scrtext_m = 'CIUA'.
        wa_fieldcatalog-scrtext_s = 'CIUA'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'L02CODVENTAESTART'.
        wa_fieldcatalog-reptext   = 'Código de venta estándar del artículo'.
        wa_fieldcatalog-scrtext_l = 'CVEA'.
        wa_fieldcatalog-scrtext_m = 'CVEA'.
        wa_fieldcatalog-scrtext_s = 'CVEA'.
        wa_fieldcatalog-outputlen = 13.
      WHEN 'L02CANTORI'.
        wa_fieldcatalog-reptext   = 'Cantidad de origen'.
        wa_fieldcatalog-scrtext_l = 'CO'.
        wa_fieldcatalog-scrtext_m = 'CO'.
        wa_fieldcatalog-scrtext_s = 'CO'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'L02CANTVENDUMV'.
        wa_fieldcatalog-reptext   = 'Cantidad vendida (en unidad de venta)'.
        wa_fieldcatalog-scrtext_l = 'CVUMV'.
        wa_fieldcatalog-scrtext_m = 'CVUMV'.
        wa_fieldcatalog-scrtext_s = 'CVUMV'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L02HORAVENTA'.
        wa_fieldcatalog-reptext   = 'Hora de la venta'.
        wa_fieldcatalog-scrtext_l = 'HV'.
        wa_fieldcatalog-scrtext_m = 'HV'.
        wa_fieldcatalog-scrtext_s = 'HV'.
        wa_fieldcatalog-outputlen = 12.
      WHEN 'L02APLICENT'.
        wa_fieldcatalog-reptext   = 'Aplicación de entrega'.
        wa_fieldcatalog-scrtext_l = 'AE'.
        wa_fieldcatalog-scrtext_m = 'AE'.
        wa_fieldcatalog-scrtext_s = 'AE'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L02TRATESP'.
        wa_fieldcatalog-reptext   = 'Tratamiento especial'.
        wa_fieldcatalog-scrtext_l = 'TE'.
        wa_fieldcatalog-scrtext_m = 'TE'.
        wa_fieldcatalog-scrtext_s = 'TE'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L02CODTRATESP'.
        wa_fieldcatalog-reptext   = 'Código tratamiento especial'.
        wa_fieldcatalog-scrtext_l = 'CTE'.
        wa_fieldcatalog-scrtext_m = 'CTE'.
        wa_fieldcatalog-scrtext_s = 'CTE'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L02CALCBENEFICIOS'.
        wa_fieldcatalog-reptext   = 'Cálculo de los beneficios'.
        wa_fieldcatalog-scrtext_l = 'CB'.
        wa_fieldcatalog-scrtext_m = 'CB'.
        wa_fieldcatalog-scrtext_s = 'CB'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'L02CALCBRII'.
        wa_fieldcatalog-reptext   = 'Cálculo de BRII'.
        wa_fieldcatalog-scrtext_l = 'CBRII'.
        wa_fieldcatalog-scrtext_m = 'CBRII'.
        wa_fieldcatalog-scrtext_s = 'CBRII'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'L02VENDATRIBART'.
        wa_fieldcatalog-reptext   = 'Vendedora atribuida al artículo'.
        wa_fieldcatalog-scrtext_l = 'VAA'.
        wa_fieldcatalog-scrtext_m = 'VAA'.
        wa_fieldcatalog-scrtext_s = 'VAA'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L02IMPORTEIMPUNI'.
        wa_fieldcatalog-reptext   = 'Importe del impuesto unitario del impuesto RAEE (Ecoparticipación)'.
        wa_fieldcatalog-scrtext_l = 'IIUIRAEE'.
        wa_fieldcatalog-scrtext_m = 'IIUIRAEE'.
        wa_fieldcatalog-scrtext_s = 'IIUIRAEE'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L02TIPOIGIASORAEE'.
        wa_fieldcatalog-reptext   = 'Tipo de IGI asociado con el impuesto RAEE'.
        wa_fieldcatalog-scrtext_l = 'TIGIRAEE'.
        wa_fieldcatalog-scrtext_m = 'TIGIRAEE'.
        wa_fieldcatalog-scrtext_s = 'TIGIRAEE'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L02CODAAGREGARPRENSA'.
        wa_fieldcatalog-reptext   = 'Código a agregar en prensa'.
        wa_fieldcatalog-scrtext_l = 'CAP'.
        wa_fieldcatalog-scrtext_m = 'CAP'.
        wa_fieldcatalog-scrtext_s = 'CAP'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L02ARTRETMASTARDE'.
        wa_fieldcatalog-reptext   = 'Artículo que se retirará más tarde'.
        wa_fieldcatalog-scrtext_l = 'AQSRMT'.
        wa_fieldcatalog-scrtext_m = 'AQSRMT'.
        wa_fieldcatalog-scrtext_s = 'AQSRMT'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L02ARTMULTTASIMP'.
        wa_fieldcatalog-reptext   = 'Artículo con múltiples tasas de impuesto'.
        wa_fieldcatalog-scrtext_l = 'ACMTI'.
        wa_fieldcatalog-scrtext_m = 'ACMTI'.
        wa_fieldcatalog-scrtext_s = 'ACMTI'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'L02ARCHCODIMP'.
        wa_fieldcatalog-reptext   = 'Archivo de código de impuesto'.
        wa_fieldcatalog-scrtext_l = 'ACI'.
        wa_fieldcatalog-scrtext_m = 'ACI'.
        wa_fieldcatalog-scrtext_s = 'ACI'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L02ARCHTASAIMP'.
        wa_fieldcatalog-reptext   = 'Archivo de tasa de impuesto  '.
        wa_fieldcatalog-scrtext_l = 'ATI'.
        wa_fieldcatalog-scrtext_m = 'ATI'.
        wa_fieldcatalog-scrtext_s = 'ATI'.
        wa_fieldcatalog-outputlen = 5.
    ENDCASE.

    MODIFY git_fieldcatalog_03 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_04.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_04,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_03.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S06'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_04
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_04 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.



      WHEN 'L03FECHA'.
        wa_fieldcatalog-reptext   = 'Fecha y Hora'.
        wa_fieldcatalog-scrtext_l = 'FechaHora'.
        wa_fieldcatalog-scrtext_m = 'FechaHora'.
        wa_fieldcatalog-scrtext_s = 'FechaHora'.
        wa_fieldcatalog-outputlen = 12.
      WHEN 'L03IMPORTE'.
        wa_fieldcatalog-reptext   = 'Importe'.
        wa_fieldcatalog-scrtext_l = 'Importe'.
        wa_fieldcatalog-scrtext_m = 'Importe'.
        wa_fieldcatalog-scrtext_s = 'Importe'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L03TIPOTOTAL'.
        wa_fieldcatalog-reptext   = 'Tipo Total'.
        wa_fieldcatalog-scrtext_l = 'TipTot'.
        wa_fieldcatalog-scrtext_m = 'TipTot'.
        wa_fieldcatalog-scrtext_s = 'TipTot'.
        wa_fieldcatalog-outputlen = 10.
    ENDCASE.

    MODIFY git_fieldcatalog_04 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_13.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_13,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_13.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S16'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_13
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_13 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'FORMAPAGO'.
        wa_fieldcatalog-reptext   = 'Forma de pago'.
        wa_fieldcatalog-scrtext_l = 'FormaP'.
        wa_fieldcatalog-scrtext_m = 'FormaP'.
        wa_fieldcatalog-scrtext_s = 'FormaP'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'TOTAL'.
        wa_fieldcatalog-reptext   = 'Total'.
        wa_fieldcatalog-scrtext_l = 'Total'.
        wa_fieldcatalog-scrtext_m = 'Total'.
        wa_fieldcatalog-scrtext_s = 'Total'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L33NOMBRE'.
        wa_fieldcatalog-reptext   = 'Nombre cliente pago a cuenta'.
        wa_fieldcatalog-scrtext_l = 'NCPAC'.
        wa_fieldcatalog-scrtext_m = 'NCPAC'.
        wa_fieldcatalog-scrtext_s = 'NCPAC'.
        wa_fieldcatalog-outputlen = 20.
      WHEN 'L33NUMCLI'.
        wa_fieldcatalog-reptext   = 'Número cliente pago a cuenta'.
        wa_fieldcatalog-scrtext_l = 'NCPAC'.
        wa_fieldcatalog-scrtext_m = 'NCPAC'.
        wa_fieldcatalog-scrtext_s = 'NCPAC'.
        wa_fieldcatalog-outputlen = 6.
      WHEN 'NUMTARJETA'.
        wa_fieldcatalog-reptext   = 'Número de tarjeta'.
        wa_fieldcatalog-scrtext_l = 'NumTarj'.
        wa_fieldcatalog-scrtext_m = 'NumTarj'.
        wa_fieldcatalog-scrtext_s = 'NumTarj'.
        wa_fieldcatalog-outputlen = 19.
    ENDCASE.

    MODIFY git_fieldcatalog_13 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_14.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_14,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_14.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S15'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_14
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_14 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'L75PORCIVA'.
        wa_fieldcatalog-reptext   = 'Porcentaje IVA'.
        wa_fieldcatalog-scrtext_l = 'PorcIVA'.
        wa_fieldcatalog-scrtext_m = 'PorcIVA'.
        wa_fieldcatalog-scrtext_s = 'PorcIVA'.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'L75BASE'.
        wa_fieldcatalog-reptext   = 'Importe Basre'.
        wa_fieldcatalog-scrtext_l = 'Base'.
        wa_fieldcatalog-scrtext_m = 'Base'.
        wa_fieldcatalog-scrtext_s = 'Base'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L75IVA'.
        wa_fieldcatalog-reptext   = 'Importe IVA'.
        wa_fieldcatalog-scrtext_l = 'ImpIVA'.
        wa_fieldcatalog-scrtext_m = 'ImpIVA'.
        wa_fieldcatalog-scrtext_s = 'ImpIVA'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'L75TOTAL'.
        wa_fieldcatalog-reptext   = 'Importe Total'.
        wa_fieldcatalog-scrtext_l = 'Total'.
        wa_fieldcatalog-scrtext_m = 'Total'.
        wa_fieldcatalog-scrtext_s = 'Total'.
        wa_fieldcatalog-outputlen = 10.
    ENDCASE.

    MODIFY git_fieldcatalog_14 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_15.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_15,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_15.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S17'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_15
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_15 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.



      WHEN 'L20NUMCLIENTE'.
        wa_fieldcatalog-reptext   = 'Número de cliente'.
        wa_fieldcatalog-scrtext_l = 'Núm.Cliente'.
        wa_fieldcatalog-scrtext_m = 'Núm.Cliente'.
        wa_fieldcatalog-scrtext_s = 'Núm.Cliente'.
        wa_fieldcatalog-outputlen = 13.
      WHEN 'L20METODOID'.
        wa_fieldcatalog-reptext   = 'Método identificación'.
        wa_fieldcatalog-scrtext_l = 'MI'.
        wa_fieldcatalog-scrtext_m = 'MI'.
        wa_fieldcatalog-scrtext_s = 'MI'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'L20APELLIDOS'.
        wa_fieldcatalog-reptext   = 'Apellidos'.
        wa_fieldcatalog-scrtext_l = 'Apellidos'.
        wa_fieldcatalog-scrtext_m = 'Apellidos'.
        wa_fieldcatalog-scrtext_s = 'Apellidos'.
        wa_fieldcatalog-outputlen = 25.
      WHEN 'L20NOMBRE'.
        wa_fieldcatalog-reptext   = 'Nombre'.
        wa_fieldcatalog-scrtext_l = 'Nombre'.
        wa_fieldcatalog-scrtext_m = 'Nombre'.
        wa_fieldcatalog-scrtext_s = 'Nombre'.
        wa_fieldcatalog-outputlen = 20.

    ENDCASE.

    MODIFY git_fieldcatalog_15 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01



*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_05.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_05,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_05.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S07'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_05
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_05 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'L07HORAABANDONO'.
        wa_fieldcatalog-reptext   = 'Fecha/Hora Abandono'.
        wa_fieldcatalog-scrtext_l = 'FechaHora'.
        wa_fieldcatalog-scrtext_m = 'FechaHora'.
        wa_fieldcatalog-scrtext_s = 'FechaHora'.
        wa_fieldcatalog-outputlen = 12.
      WHEN 'L07ABANDONOAUTO'.
        wa_fieldcatalog-reptext   = 'Abandono Automático'.
        wa_fieldcatalog-scrtext_l = 'AbaAuto'.
        wa_fieldcatalog-scrtext_m = 'AbaAuto'.
        wa_fieldcatalog-scrtext_s = 'AbaAuto'.
        wa_fieldcatalog-outputlen = 8.
    ENDCASE.

    MODIFY git_fieldcatalog_05 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_06.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_06,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_06.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S08'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_06
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_06 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'STATUS'.
        wa_fieldcatalog-reptext   = 'Status'.
        wa_fieldcatalog-scrtext_l = 'St'.
        wa_fieldcatalog-scrtext_m = 'St'.
        wa_fieldcatalog-scrtext_s = 'St'.
        wa_fieldcatalog-outputlen = 3.
        wa_fieldcatalog-icon      = 'X'.
        wa_fieldcatalog-just      = 'C'.
      WHEN 'MENSAJE'.
        wa_fieldcatalog-reptext   = 'Mensaje'.
        wa_fieldcatalog-scrtext_l = 'Mensaje'.
        wa_fieldcatalog-scrtext_m = 'Mensaje'.
        wa_fieldcatalog-scrtext_s = 'Mensaje'.
        wa_fieldcatalog-outputlen = 100.
    ENDCASE.

    MODIFY git_fieldcatalog_06 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_08.
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_08,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_08.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S11'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_08
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_08 INTO wa_fieldcatalog.
    ld_index = sy-tabix.

    CASE wa_fieldcatalog-fieldname.
      WHEN 'BUSINESSDAYDATE'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 11.
        IF gr_alv_posdm-businessdaydate IS NOT INITIAL.
          wa_fieldcatalog-emphasize = 'C311'.
        ENDIF.
      WHEN 'HORATICKET'.
        wa_fieldcatalog-reptext   = 'Hora Ticket'.
        wa_fieldcatalog-scrtext_l = 'Hora'.
        wa_fieldcatalog-scrtext_m = 'Hora'.
        wa_fieldcatalog-scrtext_s = 'Hora'.
        wa_fieldcatalog-outputlen = 7.
        IF gr_alv_posdm-businessdaydate IS NOT INITIAL.
          wa_fieldcatalog-emphasize = 'C311'.
        ENDIF.
      WHEN 'RETAILSTOREID'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 5.
        IF gr_alv_posdm-retailstoreid IS NOT INITIAL.
          wa_fieldcatalog-emphasize = 'C311'.
        ENDIF.
      WHEN 'OPERATORID'.
        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = ''.
        wa_fieldcatalog-scrtext_m = ''.
        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 5.
        IF gr_alv_posdm-operatorid IS NOT INITIAL.
          wa_fieldcatalog-emphasize = 'C311'.
        ENDIF.
      WHEN 'WORKSTATIONID'.
        wa_fieldcatalog-reptext   = 'Número de Caja'.
        wa_fieldcatalog-scrtext_l = 'Caja'.
        wa_fieldcatalog-scrtext_m = 'Caja'.
        wa_fieldcatalog-scrtext_s = 'Caja'.
        wa_fieldcatalog-outputlen = 4.
        IF gr_alv_posdm-workstationid IS NOT INITIAL.
          wa_fieldcatalog-emphasize = 'C311'.
        ENDIF.
      WHEN 'TRANSACTIONSEQUENCENUMBER'.
        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = ''.
        wa_fieldcatalog-scrtext_m = ''.
        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 15.
        wa_fieldcatalog-hotspot   = 'X'.
      WHEN 'TRANSACTIONTYPECODE'.
        wa_fieldcatalog-reptext   = 'Tipo transacción'.
        wa_fieldcatalog-scrtext_l = 'Tipo'.
        wa_fieldcatalog-scrtext_m = 'Tipo'.
        wa_fieldcatalog-scrtext_s = 'Tipo'.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'TRANSACTIONTYPECODET'.
        wa_fieldcatalog-reptext   = 'Denominación Tipo transacción'.
        wa_fieldcatalog-scrtext_l = 'Denominación'.
        wa_fieldcatalog-scrtext_m = 'Denominación'.
        wa_fieldcatalog-scrtext_s = 'Denominación'.
        wa_fieldcatalog-outputlen = 12.

      WHEN 'BEGINDATETIMESTAMP'.
        DELETE git_fieldcatalog_08 INDEX ld_index.
        CONTINUE.

        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = ''.
        wa_fieldcatalog-scrtext_m = ''.
        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 14.
      WHEN 'ENDDATETIMESTAMP'.
        DELETE git_fieldcatalog_08 INDEX ld_index.
        CONTINUE.

        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = ''.
        wa_fieldcatalog-scrtext_m = ''.
        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 14.
      WHEN 'DEPARTMENT'.
        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = 'D'.
        wa_fieldcatalog-scrtext_m = 'D'.
        wa_fieldcatalog-scrtext_s = 'D'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'OPERATORQUALIFIER'.
        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = 'CC'.
        wa_fieldcatalog-scrtext_m = 'CC'.
        wa_fieldcatalog-scrtext_s = 'CC'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'TRANSACTIONCURRENCY'.
        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = 'Mon'.
        wa_fieldcatalog-scrtext_m = 'Mon'.
        wa_fieldcatalog-scrtext_s = 'Mon'.
        wa_fieldcatalog-outputlen = 4.
*        wa_fieldcatalog-icon      = 'X'.
*        wa_fieldcatalog-just      = 'C'.
      WHEN 'PARTNERQUALIFIER'.
        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = 'CI'.
        wa_fieldcatalog-scrtext_m = 'CI'.
        wa_fieldcatalog-scrtext_s = 'CI'.
        wa_fieldcatalog-outputlen = 2.
      WHEN 'PARTNERID'.
        wa_fieldcatalog-reptext   = ''.
        wa_fieldcatalog-scrtext_l = 'Núm.Int.'.
        wa_fieldcatalog-scrtext_m = 'Núm.Int.'.
        wa_fieldcatalog-scrtext_s = 'Núm.Int.'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'T1'.
        wa_fieldcatalog-reptext   = 'T1: Mov. salida por venta'.
        wa_fieldcatalog-scrtext_l = 'T1'.
        wa_fieldcatalog-scrtext_m = 'T1'.
        wa_fieldcatalog-scrtext_s = 'T1'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'T2'.
        wa_fieldcatalog-reptext   = 'T2: Agrup. Tickets anonim'.
        wa_fieldcatalog-scrtext_l = 'T2'.
        wa_fieldcatalog-scrtext_m = 'T2'.
        wa_fieldcatalog-scrtext_s = 'T2'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'T21'.
        wa_fieldcatalog-reptext   = 'T2-1: Cierre caja parcial Baluart'.
        wa_fieldcatalog-scrtext_l = 'T2-1'.
        wa_fieldcatalog-scrtext_m = 'T2-1'.
        wa_fieldcatalog-scrtext_s = 'T2-1'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
        wa_fieldcatalog-no_out = 'X'.
      WHEN 'T3'.
        wa_fieldcatalog-reptext   = 'T3: Vta a clientes a cta'.
        wa_fieldcatalog-scrtext_l = 'T3'.
        wa_fieldcatalog-scrtext_m = 'T3'.
        wa_fieldcatalog-scrtext_s = 'T3'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'T31'.
        wa_fieldcatalog-reptext   = 'T3-1: Cierre caja parcial Baluart'.
        wa_fieldcatalog-scrtext_l = 'T3-1'.
        wa_fieldcatalog-scrtext_m = 'T3-1'.
        wa_fieldcatalog-scrtext_s = 'T3-1'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
        wa_fieldcatalog-no_out = 'X'.
      WHEN 'T4'.
        wa_fieldcatalog-reptext   = 'T4: Cierre de caja'.
        wa_fieldcatalog-scrtext_l = 'T4'.
        wa_fieldcatalog-scrtext_m = 'T4'.
        wa_fieldcatalog-scrtext_s = 'T4'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'T5'.
        wa_fieldcatalog-reptext   = 'T5: Creación cliente auto'.
        wa_fieldcatalog-scrtext_l = 'T5'.
        wa_fieldcatalog-scrtext_m = 'T5'.
        wa_fieldcatalog-scrtext_s = 'T5'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'T6'.
        wa_fieldcatalog-reptext   = 'T6: Anticipo'.
        wa_fieldcatalog-scrtext_l = 'T6'.
        wa_fieldcatalog-scrtext_m = 'T6'.
        wa_fieldcatalog-scrtext_s = 'T6'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.

    ENDCASE.

    MODIFY git_fieldcatalog_08 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_16.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_16,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_16.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S18'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_16
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_16 INTO wa_fieldcatalog.
    ld_index = sy-tabix.

    CASE wa_fieldcatalog-fieldname.
      WHEN 'BUSINESSDAYDATE'.
        wa_fieldcatalog-reptext   = 'Día Cierre'.
        wa_fieldcatalog-scrtext_l = 'Día Cierre'.
        wa_fieldcatalog-scrtext_m = 'Día Cierre'.
        wa_fieldcatalog-scrtext_s = 'Día Cierre'.
        wa_fieldcatalog-outputlen = 10.
        wa_fieldcatalog-hotspot   = 'X'.
      WHEN 'STATUS'.
        wa_fieldcatalog-reptext   = 'Status'.
        wa_fieldcatalog-scrtext_l = 'Stat'.
        wa_fieldcatalog-scrtext_m = 'Stat'.
        wa_fieldcatalog-scrtext_s = 'Stat'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'STATUS_IDOC'.
        wa_fieldcatalog-reptext   = 'Status Idoc'.
        wa_fieldcatalog-scrtext_l = 'StId'.
        wa_fieldcatalog-scrtext_m = 'StId'.
        wa_fieldcatalog-scrtext_s = 'StId'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'CIERRE'.
        wa_fieldcatalog-reptext   = 'Cierre de caja'.
        wa_fieldcatalog-scrtext_l = 'Cierre'.
        wa_fieldcatalog-scrtext_m = 'Cierre'.
        wa_fieldcatalog-scrtext_s = 'Cierre'.
        wa_fieldcatalog-outputlen = 7.
        wa_fieldcatalog-hotspot   = 'X'.
      WHEN 'DOCNUM'.
        DELETE git_fieldcatalog_16 INDEX ld_index.
        CONTINUE.
    ENDCASE.

    MODIFY git_fieldcatalog_16 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_17.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_17,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_17.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S19'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_17
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_17 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'TENDERTYPECODE'.
        wa_fieldcatalog-reptext   = 'Medio de pago'.
        wa_fieldcatalog-scrtext_l = 'Medio Pago'.
        wa_fieldcatalog-scrtext_m = 'Medio Pago'.
        wa_fieldcatalog-scrtext_s = 'Medio Pago'.
        wa_fieldcatalog-outputlen = 14.
      WHEN 'TENDERTYPECODET'.
        wa_fieldcatalog-reptext   = 'Denominación medio de pago'.
        wa_fieldcatalog-scrtext_l = 'Denominación'.
        wa_fieldcatalog-scrtext_m = 'Denominación'.
        wa_fieldcatalog-scrtext_s = 'Denominación'.
        wa_fieldcatalog-outputlen = 40.
      WHEN 'TENDERAMOUNT'.
        wa_fieldcatalog-reptext   = 'Valor Inicial'.
        wa_fieldcatalog-scrtext_l = 'Valor Ini.'.
        wa_fieldcatalog-scrtext_m = 'Valor Ini.'.
        wa_fieldcatalog-scrtext_s = 'Valor Ini.'.
        wa_fieldcatalog-do_sum    = 'X'.
        wa_fieldcatalog-outputlen = 16.
      WHEN 'TENDERAMOUNTF'.
        wa_fieldcatalog-reptext   = 'Valor Final'.
        wa_fieldcatalog-scrtext_l = 'Valor Fin.'.
        wa_fieldcatalog-scrtext_m = 'Valor Fin.'.
        wa_fieldcatalog-scrtext_s = 'Valor Fin.'.
        wa_fieldcatalog-do_sum    = 'X'.
        IF gr_cierre_dias-status = gc_minisemaforo_inactivo.
          wa_fieldcatalog-edit      = 'X'.
        ENDIF.
        wa_fieldcatalog-outputlen = 16.
      WHEN 'HKONT'.
        wa_fieldcatalog-reptext   = 'Cuenta asociada'.
        wa_fieldcatalog-scrtext_l = 'Nº Cuenta'.
        wa_fieldcatalog-scrtext_m = 'Nº Cuenta'.
        wa_fieldcatalog-scrtext_s = 'Nº Cuenta'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'TENDERCURRENCY'.
        wa_fieldcatalog-reptext   = 'Moneda'.
        wa_fieldcatalog-scrtext_l = 'Mon.'.
        wa_fieldcatalog-scrtext_m = 'Mon.'.
        wa_fieldcatalog-scrtext_s = 'Mon.'.
        wa_fieldcatalog-do_sum    = 'X'.
        wa_fieldcatalog-outputlen = 5.
    ENDCASE.

    MODIFY git_fieldcatalog_17 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01


*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_09.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_09,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_09.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S20'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_09
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_09 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'TAREA'.
        wa_fieldcatalog-reptext   = 'Tarea'.
        wa_fieldcatalog-scrtext_l = 'Tarea'.
        wa_fieldcatalog-scrtext_m = 'Tarea'.
        wa_fieldcatalog-scrtext_s = 'Tarea'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'TAREAT'.
        wa_fieldcatalog-reptext   = 'Denominación tarea'.
        wa_fieldcatalog-scrtext_l = 'Denominación'.
        wa_fieldcatalog-scrtext_m = 'Denominación'.
        wa_fieldcatalog-scrtext_s = 'Denominación'.
        wa_fieldcatalog-outputlen = 60.
      WHEN 'STATUS'.
        wa_fieldcatalog-reptext   = 'Status Tarea'.
        wa_fieldcatalog-scrtext_l = 'ST'.
        wa_fieldcatalog-scrtext_m = 'ST'.
        wa_fieldcatalog-scrtext_s = 'ST'.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-outputlen = 3.
      WHEN 'DOCNUM'.
        wa_fieldcatalog-reptext   = 'Idoc'.
        wa_fieldcatalog-scrtext_l = 'Idoc'.
        wa_fieldcatalog-scrtext_m = 'Idoc'.
        wa_fieldcatalog-scrtext_s = 'Idoc'.
        wa_fieldcatalog-outputlen = 10.
    ENDCASE.

    MODIFY git_fieldcatalog_09 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01


*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_10.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_10,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_10.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S12'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_10
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_10 INTO wa_fieldcatalog.
    ld_index = sy-tabix.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'RETAILSEQUENCENUMBER'.
        wa_fieldcatalog-reptext   = 'Posición Ticket'.
        wa_fieldcatalog-scrtext_l = 'Pos.'.
        wa_fieldcatalog-scrtext_m = 'Pos.'.
        wa_fieldcatalog-scrtext_s = 'Pos.'.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'TRANSACTIONTYPECODE'.
        DELETE git_fieldcatalog_10 INDEX ld_index.
        CONTINUE.
        wa_fieldcatalog-reptext   = 'Tipo Transacción'.
        wa_fieldcatalog-scrtext_l = 'TipoT'.
        wa_fieldcatalog-scrtext_m = 'TìpoT'.
        wa_fieldcatalog-scrtext_s = 'TipoT'.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'WORKSTATIONID'.
        DELETE git_fieldcatalog_10 INDEX ld_index.
        CONTINUE.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'RETAILTYPECODE'.
        IF gf_call_t4 = 'X'.
          DELETE git_fieldcatalog_10 INDEX ld_index.
          CONTINUE.
        ENDIF.
        wa_fieldcatalog-reptext   = 'Tipo posición ventas'.
        wa_fieldcatalog-scrtext_l = 'Tipo'.
        wa_fieldcatalog-scrtext_m = 'Tipo'.
        wa_fieldcatalog-scrtext_s = 'Tipo'.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'ITEMIDQUALIFIER'.
        IF gf_call_t4 = 'X'.
          DELETE git_fieldcatalog_10 INDEX ld_index.
          CONTINUE.
        ENDIF.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 1.
      WHEN 'ITEMID'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 12.
      WHEN 'ITEMIDT'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 20.
      WHEN 'RETAILQUANTITY'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 6.
      WHEN 'SALESUNITOFMEASURE'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'SALESAMOUNT'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 10.
        wa_fieldcatalog-do_sum    = 'X'.
      WHEN 'NORMALSALESAMOUNT'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'SERIALNUMBER'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 13.
      WHEN 'PROMOTIONID'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'ACTUALUNITPRICE'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'WAERS'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 5.
      WHEN 'PCOSTE_UNIT'.
        IF gf_call_t4 = ''.
          DELETE git_fieldcatalog_10 INDEX ld_index.
          CONTINUE.
        ENDIF.
        wa_fieldcatalog-reptext   = 'Precio unitario refacturación'.
        wa_fieldcatalog-scrtext_l = 'PUniRef'.
        wa_fieldcatalog-scrtext_m = 'PUniRef'.
        wa_fieldcatalog-scrtext_s = 'PUniRef'.
        IF gr_posdm_popup_c-t4 <> gc_minisemaforo_verde.
          wa_fieldcatalog-edit      = 'X'.
        ENDIF.
        wa_fieldcatalog-outputlen = 8.
      WHEN 'PCOSTE_UNIT_WAERS'.
        IF gf_call_t4 = ''.
          DELETE git_fieldcatalog_10 INDEX ld_index.
          CONTINUE.
        ENDIF.
      WHEN 'PCOSTE'.
        IF gf_call_t4 = ''.
          DELETE git_fieldcatalog_10 INDEX ld_index.
          CONTINUE.
        ENDIF.
        wa_fieldcatalog-reptext   = 'PrcTotRef'.
        wa_fieldcatalog-scrtext_l = 'PrcTotRef'.
        wa_fieldcatalog-scrtext_m = 'PrcTotRef'.
        wa_fieldcatalog-scrtext_s = 'PrcTotRef'.
        wa_fieldcatalog-outputlen = 10.
        wa_fieldcatalog-do_sum    = 'X'.
      WHEN 'PCOSTE_WAERS'.
        IF gf_call_t4 = ''.
          DELETE git_fieldcatalog_10 INDEX ld_index.
          CONTINUE.
        ENDIF.
    ENDCASE.

    MODIFY git_fieldcatalog_10 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_11.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_11,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_11.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S13'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_11
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_11 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'BUSINESSDAYDATE'.
*        wa_fieldcatalog-reptext   = ''.
*        wa_fieldcatalog-scrtext_l = ''.
*        wa_fieldcatalog-scrtext_m = ''.
*        wa_fieldcatalog-scrtext_s = ''.
        wa_fieldcatalog-outputlen = 10.
        IF gr_alv_posdm-businessdaydate IS NOT INITIAL.
          wa_fieldcatalog-emphasize = 'C311'.
        ENDIF.
      WHEN 'REDUCTIONAMOUNT'.
        wa_fieldcatalog-do_sum = 'X'.
    ENDCASE.

    MODIFY git_fieldcatalog_11 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_12.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_12,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_12.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S14'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_12
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_12 INTO wa_fieldcatalog.
    ld_index = sy-tabix.

    CASE wa_fieldcatalog-fieldname.
      WHEN 'TENDERSEQUENCENUMBER'.
        wa_fieldcatalog-reptext   = 'Posición método Pago'.
        wa_fieldcatalog-scrtext_l = 'Pos.'.
        wa_fieldcatalog-scrtext_m = 'Pos.'.
        wa_fieldcatalog-scrtext_s = 'Pos.'.
        wa_fieldcatalog-outputlen = 4.
      WHEN 'TRANSACTIONTYPECODE'.
        wa_fieldcatalog-outputlen = 4.
        DELETE git_fieldcatalog_12 INDEX ld_index.
        CONTINUE.
      WHEN 'WORKSTATIONID'.
        DELETE git_fieldcatalog_12 INDEX ld_index.
        CONTINUE.
      WHEN 'TENDERTYPECODE'.
        wa_fieldcatalog-reptext   = 'Código de medio de pago'.
        wa_fieldcatalog-scrtext_l = 'Cód.Medio Pago'.
        wa_fieldcatalog-scrtext_m = 'Cód.Medio Pago'.
        wa_fieldcatalog-scrtext_s = 'Cód.Medio Pago'.
        wa_fieldcatalog-outputlen = 15.
      WHEN 'TENDERTYPECODET'.
        wa_fieldcatalog-reptext   = 'Denominación medio de pago'.
        wa_fieldcatalog-scrtext_l = 'Denominación'.
        wa_fieldcatalog-scrtext_m = 'Denominación'.
        wa_fieldcatalog-scrtext_s = 'Denominación'.
        wa_fieldcatalog-outputlen = 30.
      WHEN 'TENDERAMOUNT'.
        wa_fieldcatalog-reptext   = 'Valor medio de pago'.
        wa_fieldcatalog-scrtext_l = 'Valor'.
        wa_fieldcatalog-scrtext_m = 'Valor'.
        wa_fieldcatalog-scrtext_s = 'Valor'.
        wa_fieldcatalog-do_sum    = 'X'.
        wa_fieldcatalog-outputlen = 10.
      WHEN 'TENDERCURRENCY'.
        wa_fieldcatalog-outputlen = 5.
    ENDCASE.

    MODIFY git_fieldcatalog_12 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01

*&---------------------------------------------------------------------*
*&      Form  F_GEN_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_gen_fieldcatalog_07.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_fieldcatalog_07,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_fieldcatalog_07.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S09'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_fieldcatalog_07
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_fieldcatalog_07 INTO wa_fieldcatalog.
    CASE wa_fieldcatalog-fieldname.
      WHEN 'Filename'.
        wa_fieldcatalog-reptext   = 'Fichero'.
        wa_fieldcatalog-scrtext_l = 'Fichero'.
        wa_fieldcatalog-scrtext_m = 'Fichero'.
        wa_fieldcatalog-scrtext_s = 'Fichero'.
        wa_fieldcatalog-outputlen = 60.
    ENDCASE.

    MODIFY git_fieldcatalog_07 FROM wa_fieldcatalog.
  ENDLOOP.

ENDFORM.                    " f_gen_fieldcatalog_01


*&---------------------------------------------------------------------*
*& Form F_VALIDAR_TRANSACCION_PDT_LOG
*&---------------------------------------------------------------------*
*& Valida si la transacción es válida:
*   Rellena la tabla de logs del detalle del ticjet GIT_TICKETS_06 con
*   mensajes de validación del ticket.
*&---------------------------------------------------------------------*
*      -->P_GIT_ZPOSDM001_IDOPERACION  text
*      <--P_LF_ERROR  text
*&---------------------------------------------------------------------*
FORM f_validar_transaccion_pdt_log  USING    pe_fichero
                                             pe_idcaja
                                             pe_idfecha
                                             pe_idoperacion.
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_fichero             LIKE zposdm001-l00fichero,
        wa_zposdm001           LIKE git_zposdm001,
        lf_forma_pago_otros(1),
        ld_tienda              LIKE marc-werks.

* Si estamos en la opción de incorporación de ficheros, verificamos la duplicidad
* del ticket
  IF p_r01 = 'X'.
*   Miramos si la operación ya está registrada en la BBDD
    SELECT SINGLE idoperacion
      FROM zposdm001
      INTO pe_idoperacion
     WHERE idcaja      = pe_idcaja
       AND idfecha     = pe_idfecha
       AND idoperacion = pe_idoperacion.

    IF sy-subrc = 0 .
*     Miramos si el fichero que registró la operación es el mismo que el fichero
*     de la operación que estamos validando
      SELECT SINGLE l00fichero
        FROM zposdm001
        INTO pe_fichero
       WHERE idcaja      = pe_idcaja
         AND idfecha     = pe_idfecha
         AND idoperacion = pe_idoperacion
         AND idtransaccion = '00'
         AND l00fichero = pe_fichero.

      IF sy-subrc <> 0.
*       Si no lo es, quiere decir que la operación está llegando en otro fichero
*       y por lo tanto es duplicado => Error
        SELECT SINGLE l00fichero
          FROM zposdm001
          INTO ld_fichero
         WHERE idcaja      = pe_idcaja
           AND idfecha     = pe_idfecha
           AND idoperacion = pe_idoperacion
           AND idtransaccion = '00'.

        CLEAR gr_ticket_06.
        gr_ticket_06-status = gc_minisemaforo_rojo.
        MESSAGE s001(zretposdm001) WITH pe_idoperacion ld_fichero INTO gr_ticket_06-mensaje.
        APPEND gr_ticket_06 TO git_ticket_06.

        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

  LOOP AT git_zposdm001 INTO wa_zposdm001
                       WHERE idcaja      = pe_idcaja
                         AND idfecha     = pe_idfecha
                         AND idoperacion = pe_idoperacion
                         AND ( idtransaccion = '14' OR idtransaccion = '46' ).
    lf_forma_pago_otros = 'X'.
    EXIT.
  ENDLOOP.


  READ TABLE   git_zposdm001 WITH KEY idcaja        = pe_idcaja
                                      idfecha       = pe_idfecha
                                      idoperacion   = pe_idoperacion
                                     idtransaccion = '99'
                             TRANSPORTING NO FIELDS.

  IF sy-subrc = 0.
    CLEAR gr_ticket_06.
    gr_ticket_06-status = gc_minisemaforo_ambar.
    MESSAGE s023(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
    APPEND gr_ticket_06 TO git_ticket_06.
  ENDIF.

* Verificamos que la operación no haya sido abandonada
  READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                    idfecha     = pe_idfecha
                                    idoperacion = pe_idoperacion
                                    idtransaccion = '07'
                           TRANSPORTING NO FIELDS.

  IF sy-subrc = 0.
    CLEAR gr_ticket_06.
    gr_ticket_06-status = gc_minisemaforo_ambar.
    MESSAGE s002(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
    APPEND gr_ticket_06 TO git_ticket_06.
  ENDIF.


* Validamos que la operación tenga id 01
  READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                    idfecha     = pe_idfecha
                                    idoperacion = pe_idoperacion
                                    idtransaccion = '01'
                           INTO wa_zposdm001.

  IF sy-subrc <> 0.
    CLEAR gr_ticket_06.
    gr_ticket_06-status = gc_minisemaforo_rojo.
    MESSAGE s003(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
    APPEND gr_ticket_06 TO git_ticket_06.
  ENDIF.

  READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                    idfecha     = pe_idfecha
                                    idoperacion = pe_idoperacion
                                    idtransaccion = '02'
                            TRANSPORTING NO FIELDS.


  IF sy-subrc <> 0 AND lf_forma_pago_otros = space.
    CLEAR gr_ticket_06.
    gr_ticket_06-status = gc_minisemaforo_rojo.
    MESSAGE s004(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
    APPEND gr_ticket_06 TO git_ticket_06.
  ENDIF.

  READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                    idfecha     = pe_idfecha
                                    idoperacion = pe_idoperacion
                                    idtransaccion = '03'
                          TRANSPORTING NO FIELDS.

  IF sy-subrc <> 0.
    CLEAR gr_ticket_06.
    gr_ticket_06-status = gc_minisemaforo_rojo.
    MESSAGE s005(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
    APPEND gr_ticket_06 TO git_ticket_06.
  ENDIF.

  READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                    idfecha     = pe_idfecha
                                    idoperacion = pe_idoperacion
                                    idtransaccion = '75'
                          TRANSPORTING NO FIELDS.

  IF sy-subrc <> 0 AND lf_forma_pago_otros = space.
    READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                      idfecha     = pe_idfecha
                                      idoperacion = pe_idoperacion
                                      idtransaccion = '03'
                                      l03importe = '0.00'
                            TRANSPORTING NO FIELDS.

    IF sy-subrc = 0.
      CLEAR gr_ticket_06.
      gr_ticket_06-status = gc_minisemaforo_ambar.
      MESSAGE s016(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
      APPEND gr_ticket_06 TO git_ticket_06.
    ELSE.
      CLEAR gr_ticket_06.
      gr_ticket_06-status = gc_minisemaforo_rojo.
      MESSAGE s014(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
      APPEND gr_ticket_06 TO git_ticket_06.
    ENDIF.
  ENDIF.

  READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                    idfecha     = pe_idfecha
                                    idoperacion = pe_idoperacion
                                    idtransaccion = '10'
                          TRANSPORTING NO FIELDS.

  IF sy-subrc <> 0.
    READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                      idfecha     = pe_idfecha
                                      idoperacion = pe_idoperacion
                                      idtransaccion = '24'
                          TRANSPORTING NO FIELDS.

    IF sy-subrc <> 0.
      READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                        idfecha     = pe_idfecha
                                        idoperacion = pe_idoperacion
                                        idtransaccion = '14'
                          TRANSPORTING NO FIELDS.

      IF sy-subrc <> 0.
        READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                          idfecha     = pe_idfecha
                                          idoperacion = pe_idoperacion
                                          idtransaccion = '33'
                          TRANSPORTING NO FIELDS.

        IF sy-subrc <> 0.
          READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                            idfecha     = pe_idfecha
                                            idoperacion = pe_idoperacion
                                            idtransaccion = '46'
                                  TRANSPORTING NO FIELDS.

          IF sy-subrc <> 0.
            READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                              idfecha     = pe_idfecha
                                              idoperacion = pe_idoperacion
                                              idtransaccion = '31'
                                  TRANSPORTING NO FIELDS.

            IF sy-subrc <> 0.
              READ TABLE git_zposdm001 WITH KEY idcaja      = pe_idcaja
                                              idfecha     = pe_idfecha
                                              idoperacion = pe_idoperacion
                                              idtransaccion = '47'
                                  TRANSPORTING NO FIELDS.
              IF sy-subrc <> 0.
                CLEAR gr_ticket_06.
                gr_ticket_06-status = gc_minisemaforo_rojo.
                MESSAGE s015(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
                APPEND gr_ticket_06 TO git_ticket_06.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  IF git_ticket_06[] IS INITIAL.
    CLEAR gr_ticket_06.
    gr_ticket_06-status = gc_minisemaforo_verde.
    MESSAGE s006(zretposdm001) WITH pe_idoperacion INTO gr_ticket_06-mensaje.
    APPEND gr_ticket_06 TO git_ticket_06.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_CREAR_IDOC_POSDM_PDT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_GIT_ZPOSDM001_IDOPERACION  text
*      <--P_GIT_ZPOSDM001_DOCNUM  text
*&---------------------------------------------------------------------*
FORM f_crear_idoc_posdm_pdt  USING    pe_idcaja
                                      pe_idfecha
                                      pe_idoperacion
                             CHANGING ps_docnum.
* 0.- Declaración de variables
*==========================================================================
  DATA: wa_zposdm001_00                LIKE zposdm001,
        wa_zposdm001_01                LIKE zposdm001,
        wa_zposdm001_02                LIKE zposdm001,
        wa_zposdm001_20                LIKE zposdm001,
        wa_zposdm001_03                LIKE zposdm001,
        lr_idoc_control                LIKE edidc,
        ld_identifier                  LIKE edidc-docnum,
        lit_idoc_containers            LIKE edidd OCCURS 0 WITH HEADER LINE,
        lr_idoc_control_new            LIKE edidc,
        lr_zzposdwe1postr_createmultip LIKE zzposdwe1postr_createmultip,
        lr_zzposdwe1bpsourcedocumentli LIKE zzposdwe1bpsourcedocumentli,
        lr_zzposdwe1bptransaction      LIKE zzposdwe1bptransaction,
        lr_zzposdwe1bpretaillineitem   LIKE zzposdwe1bpretaillineitem,
        lr_zzposdwe1bplineitemdiscount LIKE zzposdwe1bplineitemdiscount,
        lr_zzposdwe1bptender           LIKE zzposdwe1bptender,
        ld_segnum                      TYPE idocdsgnum,
        ld_segnum_cab                  TYPE idocdsgnum,
        ld_cont                        TYPE int4,
        lf_error(1).

* 1.- Lógica
*==========================================================================
* Abrimos IDOC
  PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_ZZCREATEMULTIPLE'
                                ''
                       CHANGING lr_idoc_control
                                ld_identifier
                                lf_error.

* IDOC: Segmento ZZPOSDWE1POSTR_CREATEMULTIP
  lr_zzposdwe1postr_createmultip-i_lockwait = '10'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'ZZPOSDWE1POSTR_CREATEMULTIP'.
  lit_idoc_containers-sdata   = lr_zzposdwe1postr_createmultip.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_cab.
  APPEND lit_idoc_containers.

  ld_segnum_cab = ld_segnum.

* Cargamos datos id transaccion 02
  LOOP AT git_zposdm001 INTO wa_zposdm001_00 WHERE idcaja = pe_idcaja
                                               AND idfecha = pe_idfecha
                                               AND idoperacion = pe_idoperacion
                                               AND idtransaccion = '00'.
    EXIT.
  ENDLOOP.

* IDOC: Segmento ZZPOSDWE1BPSOURCEDOCUMENTLI
  lr_zzposdwe1bpsourcedocumentli-key = wa_zposdm001_00-l00fichero.
  lr_zzposdwe1bpsourcedocumentli-type = '/POSDW/EXT'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'ZZPOSDWE1BPSOURCEDOCUMENTLI'.
  lit_idoc_containers-sdata   = lr_zzposdwe1bpsourcedocumentli.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_cab.
  APPEND lit_idoc_containers.

  IF wa_zposdm001_00-l00codoperacion = '05'.
*   Si el codigo de operacion es de transferencia de formas de pago

*   Cargamos datos id transaccion 02
    LOOP AT git_zposdm001 INTO wa_zposdm001_02 WHERE idcaja = pe_idcaja
                                                 AND idfecha = pe_idfecha
                                                 AND idoperacion = pe_idoperacion
                                                 AND idtransaccion = '02'.
      EXIT.
    ENDLOOP.

*   IDOC: Segmento ZZPOSDWE1BPTRANSACTION
*   =====================================
    PERFORM f_get_tienda USING lr_zzposdwe1bptransaction-workstationid
                      CHANGING lr_zzposdwe1bptransaction-retailstoreid.
    CONCATENATE '20' wa_zposdm001_02-l01fechatransaccion(6)
           INTO lr_zzposdwe1bptransaction-businessdaydate.
    lr_zzposdwe1bptransaction-transactiontypecode       = wa_zposdm001_00-l00codoperacion.
    lr_zzposdwe1bptransaction-workstationid             = wa_zposdm001_02-l01numcaja.
    lr_zzposdwe1bptransaction-transactionsequencenumber = wa_zposdm001_00-idoperacion.
    CONCATENATE '20' wa_zposdm001_02-l01fechatransaccion
           INTO lr_zzposdwe1bptransaction-begindatetimestamp.
    CONCATENATE '20' wa_zposdm001_02-l01fechatransaccion
           INTO lr_zzposdwe1bptransaction-enddatetimestamp.
    lr_zzposdwe1bptransaction-department                = wa_zposdm001_00-l00codoperacion.
    lr_zzposdwe1bptransaction-operatorqualifier         = '1'.
    lr_zzposdwe1bptransaction-operatorid                = wa_zposdm001_02-l01numcajero.
    lr_zzposdwe1bptransaction-transactioncurrency       = 'EUR'.
    lr_zzposdwe1bptransaction-partnerqualifier          = ''.
    lr_zzposdwe1bptransaction-partnerid                 = ''.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'ZZPOSDWE1BPTRANSACTION'.
    lit_idoc_containers-sdata   = lr_zzposdwe1bptransaction.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

*   IDOC: Segmento ZZPOSDWE1BPTENDER
    ADD 1 TO ld_cont.
    CLEAR lr_zzposdwe1bptender.
    lr_zzposdwe1bptender-retailstoreid                 = lr_zzposdwe1bptransaction-retailstoreid.
    CONCATENATE '20' wa_zposdm001_02-l01fechatransaccion(6) INTO lr_zzposdwe1bptender-businessdaydate.
    lr_zzposdwe1bptender-transactiontypecode           = wa_zposdm001_00-l00codoperacion.
    lr_zzposdwe1bptender-workstationid                 = wa_zposdm001_02-l01numcaja.
    lr_zzposdwe1bptender-transactionsequencenumber     = wa_zposdm001_00-idoperacion.
    WRITE ld_cont TO lr_zzposdwe1bptender-tendersequencenumber LEFT-JUSTIFIED.
    PERFORM f_get_tendertypecode_pdt_05 USING wa_zposdm001_02-l0205_fpagoori CHANGING lr_zzposdwe1bptender-tendertypecode.
    lr_zzposdwe1bptender-tenderamount                  = wa_zposdm001_02-l0205_valtrans.
    lr_zzposdwe1bptender-tenderamount                  = lr_zzposdwe1bptender-tenderamount * ( -1 ).
    lr_zzposdwe1bptender-tendercurrency                = 'EUR'.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'ZZPOSDWE1BPTENDER'.
    lit_idoc_containers-sdata   = lr_zzposdwe1bptender.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

    ADD 1 TO ld_cont.
    CLEAR lr_zzposdwe1bptender.
    lr_zzposdwe1bptender-retailstoreid                 = lr_zzposdwe1bptransaction-retailstoreid.
    CONCATENATE '20' wa_zposdm001_02-l01fechatransaccion(6) INTO lr_zzposdwe1bptender-businessdaydate..
    lr_zzposdwe1bptender-transactiontypecode           = wa_zposdm001_00-l00codoperacion.
    lr_zzposdwe1bptender-workstationid                 = wa_zposdm001_02-l01numcaja.
    lr_zzposdwe1bptender-transactionsequencenumber     = wa_zposdm001_00-idoperacion.
    WRITE ld_cont TO lr_zzposdwe1bptender-tendersequencenumber LEFT-JUSTIFIED.
    PERFORM f_get_tendertypecode_pdt_05 USING wa_zposdm001_02-l0205_fpagodes CHANGING lr_zzposdwe1bptender-tendertypecode.
    lr_zzposdwe1bptender-tenderamount                  = wa_zposdm001_02-l0205_valtrans.
    lr_zzposdwe1bptender-tendercurrency                = 'EUR'.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'ZZPOSDWE1BPTENDER'.
    lit_idoc_containers-sdata   = lr_zzposdwe1bptender.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

  ELSEIF wa_zposdm001_00-l00codoperacion = '03'.
*   IDOC: Segmento ZZPOSDWE1BPTRANSACTION
    LOOP AT git_zposdm001 INTO wa_zposdm001_01 WHERE idcaja = pe_idcaja
                                                 AND idfecha = pe_idfecha
                                                 AND idoperacion = pe_idoperacion
                                                 AND idtransaccion = '01'.
      EXIT.
    ENDLOOP.

    CLEAR wa_zposdm001_20.
    LOOP AT git_zposdm001 INTO wa_zposdm001_20 WHERE idcaja = pe_idcaja
                                                 AND idfecha = pe_idfecha
                                                 AND idoperacion = pe_idoperacion
                                                 AND idtransaccion = '20'.
      EXIT.
    ENDLOOP.

    CONCATENATE '20' wa_zposdm001_01-l01fechatransaccion(6) INTO lr_zzposdwe1bptransaction-businessdaydate.
    lr_zzposdwe1bptransaction-transactiontypecode       = wa_zposdm001_00-l00codoperacion.
    CONCATENATE lr_zzposdwe1bptransaction-transactiontypecode wa_zposdm001_01-l01tipoticketcliente INTO lr_zzposdwe1bptransaction-transactiontypecode.
    lr_zzposdwe1bptransaction-workstationid             = wa_zposdm001_01-l01numcaja.
    PERFORM f_get_tienda USING lr_zzposdwe1bptransaction-workstationid CHANGING lr_zzposdwe1bptransaction-retailstoreid.
    lr_zzposdwe1bptransaction-transactionsequencenumber = wa_zposdm001_00-idoperacion.
    CONCATENATE '20' wa_zposdm001_01-l01fechatransaccion INTO lr_zzposdwe1bptransaction-begindatetimestamp.
    CONCATENATE '20' wa_zposdm001_01-l01fechatransaccion INTO lr_zzposdwe1bptransaction-enddatetimestamp.
    lr_zzposdwe1bptransaction-department                = wa_zposdm001_00-l00codoperacion.
    lr_zzposdwe1bptransaction-operatorqualifier         = '1'.
    lr_zzposdwe1bptransaction-operatorid                = wa_zposdm001_01-l01numcajero.
    lr_zzposdwe1bptransaction-transactioncurrency       = 'EUR'.
    lr_zzposdwe1bptransaction-partnerqualifier          = '1'.
*   Numero de cliente del ticket
*   Determinamos primero numero de cliente a cuenta
    LOOP AT git_zposdm001 INTO wa_zposdm001_03 WHERE idcaja        = pe_idcaja
                                                 AND idfecha       = pe_idfecha
                                                 AND idoperacion   = pe_idoperacion
                                                 AND idtransaccion = '33'.

      lr_zzposdwe1bptransaction-partnerid = wa_zposdm001_03-l33numcli.
    ENDLOOP.

    IF sy-subrc <> 0.
      lr_zzposdwe1bptransaction-partnerid                 = wa_zposdm001_20-l20numcliente.
    ENDIF.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'ZZPOSDWE1BPTRANSACTION'.
    lit_idoc_containers-sdata   = lr_zzposdwe1bptransaction.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

*   IDOC: Segmento ZZPOSDWE1BPRETAILLINEITEM
    LOOP AT git_zposdm001 INTO wa_zposdm001_02 WHERE idcaja = pe_idcaja
                                                 AND idfecha = pe_idfecha
                                                 AND idoperacion = pe_idoperacion
                                                AND idtransaccion = '02'.

      CLEAR lr_zzposdwe1bpretaillineitem.

      CONCATENATE '20' wa_zposdm001_01-l01fechatransaccion(6) INTO lr_zzposdwe1bpretaillineitem-businessdaydate.
      lr_zzposdwe1bpretaillineitem-retailstoreid             = lr_zzposdwe1bptransaction-retailstoreid.
      lr_zzposdwe1bpretaillineitem-transactiontypecode       = wa_zposdm001_00-l00codoperacion.
      CONCATENATE lr_zzposdwe1bpretaillineitem-transactiontypecode wa_zposdm001_01-l01tipoticketcliente INTO lr_zzposdwe1bpretaillineitem-transactiontypecode.
      lr_zzposdwe1bpretaillineitem-workstationid             = wa_zposdm001_01-l01numcaja.
      lr_zzposdwe1bpretaillineitem-transactionsequencenumber = wa_zposdm001_00-idoperacion.
      lr_zzposdwe1bpretaillineitem-retailsequencenumber      = wa_zposdm001_02-conttransaccion.
      lr_zzposdwe1bpretaillineitem-retailtypecode            = wa_zposdm001_00-l00codoperacion.
      lr_zzposdwe1bpretaillineitem-itemidqualifier           = '2'.
      lr_zzposdwe1bpretaillineitem-serialnumber              = wa_zposdm001_02-l02codart.
      lr_zzposdwe1bpretaillineitem-itemidt                   = wa_zposdm001_02-l02codartt.
      lr_zzposdwe1bpretaillineitem-retailquantity            = wa_zposdm001_02-l02cantvend.
      lr_zzposdwe1bpretaillineitem-salesamount               = wa_zposdm001_02-l02importeconimpsindesc + wa_zposdm001_02-l02imptotrebconc.
      lr_zzposdwe1bpretaillineitem-normalsalesamount         = wa_zposdm001_02-l02importeconimpsindesc.
      lr_zzposdwe1bpretaillineitem-actualunitprice           = wa_zposdm001_02-l02pvpuniincimp.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'ZZPOSDWE1BPRETAILLINEITEM'.
      lit_idoc_containers-sdata   = lr_zzposdwe1bpretaillineitem.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.

      IF wa_zposdm001_02-l02imptotrebconc IS NOT INITIAL.
        CLEAR lr_zzposdwe1bplineitemdiscount.
        CONCATENATE '20' wa_zposdm001_01-l01fechatransaccion(6) INTO lr_zzposdwe1bplineitemdiscount-businessdaydate.
        lr_zzposdwe1bplineitemdiscount-retailstoreid                 = lr_zzposdwe1bptransaction-retailstoreid.
        lr_zzposdwe1bplineitemdiscount-transactiontypecode           = wa_zposdm001_00-l00codoperacion.
        CONCATENATE lr_zzposdwe1bplineitemdiscount-transactiontypecode wa_zposdm001_01-l01tipoticketcliente INTO lr_zzposdwe1bplineitemdiscount-transactiontypecode .
        lr_zzposdwe1bplineitemdiscount-workstationid                 = wa_zposdm001_01-l01numcaja.
        lr_zzposdwe1bplineitemdiscount-transactionsequencenumber     = wa_zposdm001_00-idoperacion.
        lr_zzposdwe1bplineitemdiscount-retailsequencenumber          = wa_zposdm001_02-conttransaccion.
        lr_zzposdwe1bplineitemdiscount-discountsequencenumber        = '1'.
        lr_zzposdwe1bplineitemdiscount-discounttypecode              = 'ZART'.
        lr_zzposdwe1bplineitemdiscount-reductionamount               = wa_zposdm001_02-l02imptotrebconc.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'ZZPOSDWE1BPLINEITEMDISCOUNT'.
        lit_idoc_containers-sdata   = lr_zzposdwe1bplineitemdiscount.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab.
        APPEND lit_idoc_containers.
      ENDIF.

      IF wa_zposdm001_02-l02impdesctarjcli IS NOT INITIAL.
        CLEAR lr_zzposdwe1bplineitemdiscount.
        CONCATENATE '20' wa_zposdm001_01-l01fechatransaccion(6) INTO lr_zzposdwe1bplineitemdiscount-businessdaydate.
        lr_zzposdwe1bplineitemdiscount-transactiontypecode           = wa_zposdm001_00-l00codoperacion.
        CONCATENATE lr_zzposdwe1bplineitemdiscount-transactiontypecode
                    wa_zposdm001_01-l01tipoticketcliente
               INTO lr_zzposdwe1bplineitemdiscount-transactiontypecode.
        lr_zzposdwe1bplineitemdiscount-workstationid                 = wa_zposdm001_01-l01numcaja.
        lr_zzposdwe1bplineitemdiscount-transactionsequencenumber     = wa_zposdm001_00-idoperacion.
        lr_zzposdwe1bplineitemdiscount-retailsequencenumber          = wa_zposdm001_02-conttransaccion.
        lr_zzposdwe1bplineitemdiscount-discountsequencenumber        = '2'.
        lr_zzposdwe1bplineitemdiscount-discounttypecode              = 'ZCLI'.
        lr_zzposdwe1bplineitemdiscount-reductionamount               = wa_zposdm001_02-l02impdesctarjcli.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'ZZPOSDWE1BPLINEITEMDISCOUNT'.
        lit_idoc_containers-sdata   = lr_zzposdwe1bplineitemdiscount.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab.
        APPEND lit_idoc_containers.
      ENDIF.
    ENDLOOP.


    CLEAR ld_cont.
    LOOP AT git_zposdm001 INTO wa_zposdm001_03 WHERE idcaja = pe_idcaja
                                                 AND idfecha = pe_idfecha
                                                 AND idoperacion = pe_idoperacion
                                                AND ( idtransaccion = '24' OR
                                                      idtransaccion = '10' OR
                                                      idtransaccion = '14' OR
                                                      idtransaccion = '33' OR
                                                      idtransaccion = '31' OR
                                                      idtransaccion = '46' OR
                                                      idtransaccion = '47' ).

      ADD 1 TO ld_cont.

      CLEAR lr_zzposdwe1bptender.
      CONCATENATE '20' wa_zposdm001_01-l01fechatransaccion(6) INTO lr_zzposdwe1bptender-businessdaydate..
      lr_zzposdwe1bptender-transactiontypecode           = wa_zposdm001_00-l00codoperacion.
      CONCATENATE lr_zzposdwe1bptender-transactiontypecode
                  wa_zposdm001_01-l01tipoticketcliente
             INTO lr_zzposdwe1bptender-transactiontypecode.
      lr_zzposdwe1bptender-retailstoreid                 = lr_zzposdwe1bptransaction-retailstoreid.
      lr_zzposdwe1bptender-workstationid                 = wa_zposdm001_01-l01numcaja.
      lr_zzposdwe1bptender-transactionsequencenumber     = wa_zposdm001_00-idoperacion.
      WRITE ld_cont TO lr_zzposdwe1bptender-tendersequencenumber LEFT-JUSTIFIED.
      PERFORM f_get_tendertypecode_info_pdt USING wa_zposdm001_03 CHANGING lr_zzposdwe1bptender-tendertypecode  lr_zzposdwe1bptender-tenderamount.
      lr_zzposdwe1bptender-tendercurrency                = 'EUR'.
      lr_zzposdwe1bptender-accountnumber                = wa_zposdm001_03-l24tarjeta.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'ZZPOSDWE1BPTENDER'.
      lit_idoc_containers-sdata   = lr_zzposdwe1bptender.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    ENDLOOP.
  ENDIF.

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
*   EXPORTING
*     _SYNCHRON       = ' '
    .

  ps_docnum = lr_idoc_control_new-docnum.
ENDFORM.


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
*& Form F_SELECCIONAR_DATOS_PDT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleccionar_datos_pdt .
  DATA: lf_error(1),
        lit_zposdm001 LIKE zposdm001 OCCURS  0 WITH HEADER LINE.

  SELECT *
    FROM zposdm001
    INTO TABLE lit_zposdm001
   WHERE idtransaccion = '00'
     AND l00fichero IN s_2fic
     AND l00fechainc IN s_2fi
     AND l00horainc  IN s_2hi
     AND l00usuarioinc IN s_2ui.

  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

  SELECT *
    INTO TABLE git_zposdm001
    FROM zposdm001
     FOR ALL ENTRIES IN lit_zposdm001
   WHERE idcaja  = lit_zposdm001-idcaja
     AND   idfecha = lit_zposdm001-idfecha
     AND   idoperacion = lit_zposdm001-idoperacion.



  loop_at git_zposdm001 .
  IF NOT ( git_zposdm001-idtransaccion = '00' ).
    CONTINUE.
  ENDIF.
  CLEAR git_listado.
  git_listado-fechainc = git_zposdm001-l00fechainc.
  git_listado-horainc  = git_zposdm001-l00horainc.
  git_listado-usuarioinc = git_zposdm001-l00usuarioinc.
  git_listado-filename = git_zposdm001-l00fichero.
  git_listado-tickets  = gc_icono_tickets.
  APPEND git_listado.
  endloop_at 'Agrupando Tickets' '' '' '' ''.

  SORT git_listado.
  DELETE ADJACENT DUPLICATES FROM git_listado.

  loop_at git_listado.
  git_listado-valido = gc_minisemaforo_verde.

  LOOP AT git_zposdm001 WHERE l00fichero = git_listado-filename
                          AND idtransaccion = '00'
                          AND l00valido = gc_minisemaforo_rojo.
    git_listado-valido = gc_minisemaforo_rojo.
    ADD 1 TO git_listado-numtranserr.
  ENDLOOP.

  IF sy-subrc = 0.
    git_listado-valido = gc_minisemaforo_rojo.
  ENDIF.


  LOOP AT git_zposdm001 WHERE l00fichero = git_listado-filename
                        AND idtransaccion = '00'
                        AND l00valido = gc_minisemaforo_ambar.
    IF git_listado-valido = gc_minisemaforo_verde.
      git_listado-valido = gc_minisemaforo_ambar.
    ENDIF.

    ADD 1 TO git_listado-numtransdesc.
  ENDLOOP.


  LOOP AT git_zposdm001 WHERE l00fichero = git_listado-filename
                          AND idtransaccion = '00'
                          AND l00valido = gc_minisemaforo_verde.

    ADD 1 TO git_listado-numtransok.
  ENDLOOP.

  .

  git_listado-numtrans = git_listado-numtransok + git_listado-numtransdesc + git_listado-numtranserr.

  MODIFY git_listado.
  endloop_at 'Analizando Tickets' '' '' '' ''.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_FICHEROS_TPV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LIR_DIR_LIST  text
*      -->P_LD_DIR_NAME  text
*&---------------------------------------------------------------------*
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
  IF sy-subrc <> 0. ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_DESCARTAR_FICHEROS_TPV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LIT_DIR_LIST  text
*&---------------------------------------------------------------------*
FORM f_descartar_ficheros_tpv  TABLES   it_dir_list STRUCTURE eps2fili.
* 0.- Declaración de variables
*==========================================================================

* 1.- Lógica
*==========================================================================
  DATA: ld_index LIKE sy-tabix.

  REFRESH git_descarte_fic.

  LOOP AT it_dir_list.
    ld_index = sy-tabix.

    SELECT SINGLE l00fichero
      FROM zposdm001
      INTO it_dir_list-name
     WHERE l00fichero = it_dir_list-name.

    IF sy-subrc = 0.
      gr_descarte_fic-filename = it_dir_list-name.
      APPEND gr_descarte_fic TO git_descarte_fic.

      DELETE it_dir_list INDEX ld_index.
    ENDIF.
  ENDLOOP.

  IF git_descarte_fic[] IS NOT INITIAL AND sy-batch = space.
    CALL SCREEN 0100 STARTING AT 10 10.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_USER_COMMAND_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_user_command_0100 .
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_okcode LIKE sy-ucomm.

  ld_okcode = gd_okcode_0100.
  CLEAR: gd_okcode_0100,
         sy-ucomm.

  CASE ld_okcode.
    WHEN 'ACEPTAR_0100'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_SELECCIONAR_DATOS_POSDM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleccionar_datos_posdm .

  SELECT *
    INTO TABLE git_zztransaction
    FROM zztransaction
   WHERE retailstoreid IN s_rsi
     AND businessdaydate IN s_bdd
     AND transactiontypecode IN s_ttt
     AND workstationid IN s_wsid
     AND transactionsequencenumber IN s_tsn
     AND begindatetimestamp IN s_bdts
     AND enddatetimestamp IN s_edts
     AND department IN s_dep
     AND operatorqualifier IN s_opq
     AND operatorid IN s_opid
     AND transactioncurrency IN s_tcurr
     AND partnerqualifier IN s_pq
     AND partnerid IN s_pid
     AND zkey IN s_fic
     AND docnum IN s_docnum..

  IF sy-subrc = 0.
    SELECT *
      INTO TABLE git_zzlineitem
      FROM zzlineitem
       FOR ALL ENTRIES IN git_zztransaction
     WHERE retailstoreid              = git_zztransaction-retailstoreid
       AND operatorid                 = git_zztransaction-operatorid
       AND businessdaydate            = git_zztransaction-businessdaydate
       AND transactionsequencenumber  = git_zztransaction-transactionsequencenumber.

    SELECT *
      INTO TABLE git_zzlineitemdisc
      FROM zzlineitemdisc
       FOR ALL ENTRIES IN git_zztransaction
     WHERE retailstoreid              = git_zztransaction-retailstoreid
       AND operatorid                 = git_zztransaction-operatorid
       AND businessdaydate            = git_zztransaction-businessdaydate
       AND transactionsequencenumber  = git_zztransaction-transactionsequencenumber.

    SELECT *
      INTO TABLE git_zztender
      FROM zztender
       FOR ALL ENTRIES IN git_zztransaction
     WHERE retailstoreid              = git_zztransaction-retailstoreid
       AND operatorid                 = git_zztransaction-operatorid
       AND businessdaydate            = git_zztransaction-businessdaydate
       AND transactionsequencenumber  = git_zztransaction-transactionsequencenumber.

    SORT git_zztender BY tendertypecode ASCENDING.
  ENDIF.


  SORT git_zztransaction BY businessdaydate ASCENDING
                            retailstoreid   ASCENDING
                            operatorid      ASCENDING
                            workstationid   ASCENDING.

  LOOP AT git_zztransaction.
    MODIFY git_zztransaction.
  ENDLOOP.

  CALL SCREEN 9001.


ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_9001_PBO_INIT_TREE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_9001_pbo_init_tree .
  DATA: l_hierarchy_header TYPE treev_hhdr,
        ls_variant         TYPE disvariant.

  IF gr_tree_01 IS INITIAL.
*   Creamos contenedor para el arbol
    CREATE OBJECT gr_tree_container_01
      EXPORTING
        container_name = 'CONTAINER_TREE_01'.

*   Creamos arbol
    CREATE OBJECT gr_tree_01
      EXPORTING
*       LIFETIME                    =
        parent                      = gr_tree_container_01
*       SHELLSTYLE                  =
        node_selection_mode         = cl_gui_column_tree=>node_sel_mode_single
*       HIDE_SELECTION              =
*       ITEM_SELECTION              =
        no_toolbar                  = ''
        no_html_header              = 'X'
*       I_PRINT                     =
*       I_FCAT_COMPLETE             =
*       I_MODEL_MODE                =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        illegal_node_selection_mode = 5
        failed                      = 6
        illegal_column_name         = 7
        OTHERS                      = 8.
    IF sy-subrc <> 0.
    ENDIF.

    PERFORM f_gen_tree_fieldcatalog_01.

    PERFORM f_gen_tree_hierarchy_01  CHANGING l_hierarchy_header.

    ls_variant-report = sy-repid.

*   create emty tree-control
    CALL METHOD gr_tree_01->set_table_for_first_display
      EXPORTING
*       I_STRUCTURE_NAME    =
        is_variant          = ls_variant
        i_save              = 'A'
*       I_DEFAULT           = 'X'
        is_hierarchy_header = l_hierarchy_header
*       IS_EXCEPTION_FIELD  =
*       IT_SPECIAL_GROUPS   =
*       IT_LIST_COMMENTARY  =
*       I_LOGO              =
        i_background_id     = 'ALV_BACKGROUND'
*       IT_TOOLBAR_EXCLUDING =
*       IT_EXCEPT_QINFO     =
      CHANGING
        it_outtab           = git_alv_posdm
*       IT_FILTER           =
        it_fieldcatalog     = git_tree_fieldcatalog_01.

*   create hierarchy
    PERFORM f_gen_tree_hierarchy_01d.

*   add own function codes to the toolbar
*    PERFORM change_toolbar.

*   set event-handler for toolbar-control
    CREATE OBJECT gr_event_handler_tree.
    SET HANDLER   gr_event_handler_tree->handle_item_double_click FOR gr_tree_01.
    SET HANDLER   gr_event_handler_tree->handle_node_double_click FOR gr_tree_01.


    DATA: wa_events  TYPE cntl_simple_event,
          lit_events TYPE cntl_simple_events.


    CALL METHOD gr_tree_01->get_registered_events
      IMPORTING
        events     = lit_events
      EXCEPTIONS
        cntl_error = 1
        OTHERS     = 2.
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

    wa_events-eventid = cl_gui_column_tree=>eventid_node_double_click.
    wa_events-appl_event = ' ' .

    APPEND wa_events TO lit_events .

    wa_events-eventid = cl_gui_column_tree=>eventid_item_double_click.
    wa_events-appl_event = ' ' .

    APPEND wa_events TO lit_events .


    CALL METHOD gr_tree_01->set_registered_events
      EXPORTING
        events                    = lit_events
      EXCEPTIONS
        cntl_error                = 1
        cntl_system_error         = 2
        illegal_event_combination = 3
        OTHERS                    = 4.
    IF sy-subrc <> 0. ENDIF.

*   calculate totals
    CALL METHOD gr_tree_01->update_calculations.
*   this method must be called to send the data to the frontend
    CALL METHOD gr_tree_01->frontend_update.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  change_toolbar
*&---------------------------------------------------------------------*
FORM change_toolbar.
* get toolbar control
  CALL METHOD gr_tree_01->get_toolbar_object
    IMPORTING
      er_toolbar = gr_tree_toolbar_01.
  CHECK NOT gr_tree_toolbar_01 IS INITIAL.
* add seperator to toolbar
  CALL METHOD gr_tree_toolbar_01->add_button
    EXPORTING
      fcode     = ''
      icon      = ''
      butn_type = cntb_btype_sep
      text      = ''
      quickinfo = 'This is a Seperator'.                    "#EC NOTEXT
* add Standard Button to toolbar (for Delete Subtree)
  CALL METHOD gr_tree_toolbar_01->add_button
    EXPORTING
      fcode     = 'DELETE'
      icon      = '@18@'
      butn_type = cntb_btype_button
      text      = ''
      quickinfo = 'Delete subtree'.                         "#EC NOTEXT
* add Dropdown Button to toolbar (for Insert Line)
  CALL METHOD gr_tree_toolbar_01->add_button
    EXPORTING
      fcode     = 'INSERT_LC'
      icon      = '@17@'
      butn_type = cntb_btype_dropdown
      text      = ''
      quickinfo = 'Insert Line'.                            "#EC NOTEXT
* set event-handler for toolbar-control
  CREATE OBJECT gr_tree_toolbar_er_01.
  SET HANDLER gr_tree_toolbar_er_01->on_function_selected FOR gr_tree_toolbar_01.
  SET HANDLER gr_tree_toolbar_er_01->on_toolbar_dropdown  FOR gr_tree_toolbar_01.
ENDFORM.                               " change_toolbar


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_9001 INPUT.
  PERFORM f_user_command_9001.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Form F_USER_COMMAND_9001
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_user_command_9001 .
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_okcode LIKE sy-ucomm.

* 1.- Lógica
*==========================================================================
  ld_okcode = gd_okcode_9001.

  CLEAR: sy-ucomm,
         gd_okcode_9001.

  CASE ld_okcode.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GEN_TREE_FIELDCATALOG_01
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_gen_tree_fieldcatalog_01 .
* 0.- Declaracion de variables
*--------------------------------------------------------------------*
  DATA: wa_fieldcatalog LIKE LINE OF git_tree_fieldcatalog_01,
        ld_index        LIKE sy-tabix.


* 1.- Logica
*--------------------------------------------------------------------*
  REFRESH git_tree_fieldcatalog_01.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZRETPOSDM001S10'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = git_tree_fieldcatalog_01
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT git_tree_fieldcatalog_01 INTO wa_fieldcatalog.
    ld_index = sy-tabix.

    CASE wa_fieldcatalog-fieldname.
      WHEN 'BUSINESSDAYDATE' OR
           'RETAILSTOREID' OR
           'OPERATORID' OR
           'WORKSTATIONID' OR
           'TENDERTYPECODE'.
        DELETE git_tree_fieldcatalog_01 INDEX ld_index.
        CONTINUE.
      WHEN 'STATUS'.
        wa_fieldcatalog-reptext   = 'Status total de una transacción de TPV'.
        wa_fieldcatalog-scrtext_l = 'Status'.
        wa_fieldcatalog-scrtext_m = 'Status'.
        wa_fieldcatalog-scrtext_s = 'Status'.
        wa_fieldcatalog-outputlen = 10.
        wa_fieldcatalog-just      = 'C'.
        wa_fieldcatalog-icon      = 'X'.
      WHEN 'CANTTRANS'.
        wa_fieldcatalog-reptext   = 'Cantidad de transacciones TPV'.
        wa_fieldcatalog-scrtext_l = 'Cantidad'.
        wa_fieldcatalog-scrtext_m = 'Cantidad'.
        wa_fieldcatalog-scrtext_s = 'Cantidad'.
        wa_fieldcatalog-no_zero   = 'X'.
        wa_fieldcatalog-outputlen = 15.
      WHEN 'VOLNEG'.
        wa_fieldcatalog-reptext   = 'Vol.Negocios total de transacciones TPV'.
        wa_fieldcatalog-scrtext_l = 'VolNeg.'.
        wa_fieldcatalog-scrtext_m = 'VolNeg.'.
        wa_fieldcatalog-scrtext_s = 'VolNeg.'.
        wa_fieldcatalog-outputlen = 15.
      WHEN 'WAERS'.
        wa_fieldcatalog-reptext   = 'Moneda de visualización'.
        wa_fieldcatalog-scrtext_l = 'Mon.'.
        wa_fieldcatalog-scrtext_m = 'Mon.'.
        wa_fieldcatalog-scrtext_s = 'Mon.'.
        wa_fieldcatalog-outputlen = 5.
    ENDCASE.

    MODIFY git_tree_fieldcatalog_01 FROM wa_fieldcatalog.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GEN_TREE_HIERARCHY_01
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_L_HIERARCHY_HEADER  text
*&---------------------------------------------------------------------*
FORM f_gen_tree_hierarchy_01  CHANGING c_header TYPE treev_hhdr.
  c_header-heading   = 'Selección'.
  c_header-tooltip   = ''.
  c_header-width     = 60.
  c_header-width_pix = ''.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GEN_TREE_HIERARCHY_01D
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_gen_tree_hierarchy_01d .
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_ref_fecha           TYPE lvc_nkey,
        ld_ref_tienda          TYPE lvc_nkey,
        ld_ref_inicio          TYPE lvc_nkey,
        ld_ref_cajero          TYPE lvc_nkey,
        ld_ref_caja            TYPE lvc_nkey,
        ld_ref_tender          TYPE lvc_nkey,
        ld_ref_any             TYPE lvc_nkey,
        ld_businessdaydate_ant LIKE zztransaction-businessdaydate,
        ld_retailstoreid_ant   LIKE zztransaction-retailstoreid,
        ld_operatorid_ant      LIKE zztransaction-operatorid,
        ld_workstationid_ant   LIKE zztransaction-workstationid,
        ld_tendertypecode_ant  LIKE zztender-tendertypecode,
        ld_fecha(10),
        wa_zztransaction       LIKE zztransaction,
        ld_tendertypecodet     TYPE char40,
        lf_onchange(1).

* 1.- Lógica
*==========================================================================
  CLEAR gr_alv_posdm.
  gr_alv_posdm-status = gc_minisemaforo_inactivo.
  DESCRIBE TABLE git_zztransaction LINES gr_alv_posdm-canttrans.
  LOOP AT git_zztender.
    ADD git_zztender-tenderamount TO gr_alv_posdm-volneg.
    gr_alv_posdm-waers = git_zztender-tendercurrency.
  ENDLOOP.

  PERFORM f_add_nodo  USING 'Monitor recepción'
                            ''
                            gc_icono_inbox
                   CHANGING ld_ref_inicio.

  CLEAR gr_alv_posdm.
  PERFORM f_add_nodo  USING 'Fe. Contabilización'
                            ld_ref_inicio
                            '@P8@'
                   CHANGING ld_ref_any.

  LOOP AT git_zztransaction.
    IF git_zztransaction-businessdaydate <> ld_businessdaydate_ant.
      ld_businessdaydate_ant = git_zztransaction-businessdaydate.

      CLEAR: ld_retailstoreid_ant,
             ld_operatorid_ant,
             ld_workstationid_ant.

      CLEAR gr_alv_posdm.
      gr_alv_posdm-status = gc_minisemaforo_inactivo.
      WRITE git_zztransaction-businessdaydate TO ld_fecha.
      LOOP AT git_zztransaction INTO wa_zztransaction WHERE businessdaydate = git_zztransaction-businessdaydate.
        ADD 1 TO gr_alv_posdm-canttrans.
      ENDLOOP.

      LOOP AT git_zztender WHERE businessdaydate = git_zztransaction-businessdaydate.
        ADD git_zztender-tenderamount TO gr_alv_posdm-volneg.
        gr_alv_posdm-waers = git_zztender-tendercurrency.
      ENDLOOP.

      gr_alv_posdm-businessdaydate = git_zztransaction-businessdaydate.

      PERFORM f_add_nodo USING ld_fecha
                               ld_ref_inicio
                               ''
                      CHANGING ld_ref_fecha.

      CLEAR gr_alv_posdm.
      PERFORM f_add_nodo USING 'Tienda'
                               ld_ref_fecha
                               '@P8@'
                      CHANGING ld_ref_any.
    ENDIF.

    IF git_zztransaction-retailstoreid <> ld_retailstoreid_ant.
      ld_retailstoreid_ant = git_zztransaction-retailstoreid.

      CLEAR: ld_operatorid_ant,
             ld_workstationid_ant.

      CLEAR gr_alv_posdm.
      gr_alv_posdm-status = gc_minisemaforo_inactivo.
      LOOP AT git_zztransaction INTO wa_zztransaction WHERE businessdaydate = git_zztransaction-businessdaydate
                                                AND retailstoreid   = git_zztransaction-retailstoreid.
        ADD 1 TO gr_alv_posdm-canttrans.
      ENDLOOP.

      LOOP AT git_zztender WHERE businessdaydate = git_zztransaction-businessdaydate
                              AND retailstoreid   = git_zztransaction-retailstoreid.
        ADD git_zztender-tenderamount TO gr_alv_posdm-volneg.
        gr_alv_posdm-waers = git_zztender-tendercurrency.
      ENDLOOP.

      gr_alv_posdm-businessdaydate = git_zztransaction-businessdaydate.
      gr_alv_posdm-retailstoreid   = git_zztransaction-retailstoreid.


      PERFORM f_add_nodo USING git_zztransaction-retailstoreid
                               ld_ref_fecha
                               ''
                      CHANGING ld_ref_tienda.

      CLEAR gr_alv_posdm.
      PERFORM f_add_nodo USING 'Cajero'
                               ld_ref_tienda
                               '@P8@'
                      CHANGING ld_ref_any.
    ENDIF.

    IF git_zztransaction-operatorid <> ld_operatorid_ant.
      ld_operatorid_ant = git_zztransaction-operatorid.

      CLEAR: ld_workstationid_ant.

      CLEAR gr_alv_posdm.
      gr_alv_posdm-status = gc_minisemaforo_inactivo.
      LOOP AT git_zztransaction INTO wa_zztransaction WHERE businessdaydate = git_zztransaction-businessdaydate
                                                AND retailstoreid   = git_zztransaction-retailstoreid
                                                AND operatorid      = git_zztransaction-operatorid.
        ADD 1 TO gr_alv_posdm-canttrans.
      ENDLOOP.

      LOOP AT git_zztender WHERE businessdaydate = git_zztransaction-businessdaydate
                              AND retailstoreid   = git_zztransaction-retailstoreid
                              AND operatorid      = git_zztransaction-operatorid.
        ADD git_zztender-tenderamount TO gr_alv_posdm-volneg.
        gr_alv_posdm-waers = git_zztender-tendercurrency.
      ENDLOOP.

      gr_alv_posdm-businessdaydate = git_zztransaction-businessdaydate.
      gr_alv_posdm-retailstoreid   = git_zztransaction-retailstoreid.
      gr_alv_posdm-operatorid      = git_zztransaction-operatorid.

      PERFORM f_add_nodo USING git_zztransaction-operatorid
                               ld_ref_tienda
                               ''
                      CHANGING ld_ref_cajero.

      CLEAR gr_alv_posdm.
      PERFORM f_add_nodo USING 'Caja'
                               ld_ref_cajero
                               '@P8@'
                      CHANGING ld_ref_any.
    ENDIF.

    IF git_zztransaction-workstationid <> ld_workstationid_ant.
      ld_workstationid_ant = git_zztransaction-workstationid.

      CLEAR gr_alv_posdm.
      gr_alv_posdm-status = gc_minisemaforo_inactivo.
      LOOP AT git_zztransaction INTO wa_zztransaction WHERE businessdaydate = git_zztransaction-businessdaydate
                                                AND retailstoreid   = git_zztransaction-retailstoreid
                                                AND operatorid      = git_zztransaction-operatorid
                                                AND workstationid   = git_zztransaction-workstationid.
        ADD 1 TO gr_alv_posdm-canttrans.
      ENDLOOP.

      LOOP AT git_zztender WHERE businessdaydate = git_zztransaction-businessdaydate
                              AND retailstoreid   = git_zztransaction-retailstoreid
                              AND operatorid      = git_zztransaction-operatorid
                              AND workstationid   = git_zztransaction-workstationid.
        ADD git_zztender-tenderamount TO gr_alv_posdm-volneg.
        gr_alv_posdm-waers = git_zztender-tendercurrency.
      ENDLOOP.

      gr_alv_posdm-businessdaydate = git_zztransaction-businessdaydate.
      gr_alv_posdm-retailstoreid   = git_zztransaction-retailstoreid.
      gr_alv_posdm-operatorid      = git_zztransaction-operatorid.
      gr_alv_posdm-workstationid   = git_zztransaction-workstationid.

      PERFORM f_add_nodo USING git_zztransaction-workstationid
                               ld_ref_cajero
                               ''
                      CHANGING ld_ref_caja.


      CLEAR gr_alv_posdm.
      PERFORM f_add_nodo USING 'Medio de pago'
                               ld_ref_caja
                               '@P8@'
                      CHANGING ld_ref_any.

      CLEAR git_zztender.
      CLEAR ld_tendertypecode_ant.
      LOOP AT git_zztender WHERE businessdaydate = git_zztransaction-businessdaydate
                              AND retailstoreid   = git_zztransaction-retailstoreid
                              AND operatorid      = git_zztransaction-operatorid
                              AND workstationid   = git_zztransaction-workstationid.

        IF git_zztender-tendertypecode <> ld_tendertypecode_ant.
          ld_tendertypecode_ant = git_zztender-tendertypecode.

          CLEAR gr_alv_posdm.
          gr_alv_posdm-status = gc_minisemaforo_inactivo.

          LOOP AT git_zztender WHERE businessdaydate = git_zztransaction-businessdaydate
                                   AND retailstoreid   = git_zztransaction-retailstoreid
                                   AND operatorid      = git_zztransaction-operatorid
                                   AND workstationid   = git_zztransaction-workstationid
                                   AND tendertypecode  = git_zztender-tendertypecode.
            ADD 1 TO gr_alv_posdm-canttrans.
            ADD git_zztender-tenderamount TO gr_alv_posdm-volneg.
            gr_alv_posdm-waers = git_zztender-tendercurrency.
          ENDLOOP.


          gr_alv_posdm-businessdaydate = git_zztransaction-businessdaydate.
          gr_alv_posdm-retailstoreid   = git_zztransaction-retailstoreid.
          gr_alv_posdm-operatorid      = git_zztransaction-operatorid.
          gr_alv_posdm-workstationid   = git_zztransaction-workstationid.
          gr_alv_posdm-tendertypecode  = git_zztender-tendertypecode.

          PERFORM f_get_tendertypecodet USING git_zztender-tendertypecode CHANGING ld_tendertypecodet.
          PERFORM f_add_nodo USING ld_tendertypecodet
                                   ld_ref_caja
                                   ''
                          CHANGING ld_ref_tender.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDLOOP.

****  clear lf_onchange.
****  loop at git_ZZTRANSACTION.
****    on CHANGE OF git_ZZTRANSACTION-BUSINESSDAYDATE.
****      lf_onchange = 'X'.
****
****      clear gr_alv_posdm.
****      gr_alv_posdm-status = gc_minisemaforo_inactivo.
****      write git_ZZTRANSACTION-BUSINESSDAYDATE to ld_fecha.
****      loop at git_ZZTRANSACTION into wa_ZZTRANSACTION where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****        add 1 to gr_alv_posdm-canttrans.
****      endloop.
****
****      loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****        add git_ZZTENDER-TENDERAMOUNT to gr_alv_posdm-volneg.
****        gr_alv_posdm-waers = git_ZZTENDER-TENDERCURRENCY.
****      endloop.
****
****      gr_alv_posdm-BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****
****      perform f_add_nodo using ld_fecha
****                               ld_ref_inicio
****                               ''
****                      CHANGING ld_ref_fecha.
****
****      clear gr_alv_posdm.
****      perform f_add_nodo using 'Tienda'
****                               ld_ref_fecha
****                               '@P8@'
****                      CHANGING ld_ref_any.
****    endon.
****
****    on CHANGE OF git_ZZTRANSACTION-RETAILSTOREID.
****      lf_onchange = 'X'.
****
****      clear gr_alv_posdm.
****      gr_alv_posdm-status = gc_minisemaforo_inactivo.
****      loop at git_ZZTRANSACTION into wa_ZZTRANSACTION where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                                                and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID.
****        add 1 to gr_alv_posdm-canttrans.
****      endloop.
****
****      loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                              and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID.
****        add git_ZZTENDER-TENDERAMOUNT to gr_alv_posdm-volneg.
****        gr_alv_posdm-waers = git_ZZTENDER-TENDERCURRENCY.
****      endloop.
****
****      gr_alv_posdm-BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****      gr_alv_posdm-RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID.
****
****
****      perform f_add_nodo using git_ZZTRANSACTION-RETAILSTOREID
****                               ld_ref_fecha
****                               ''
****                      CHANGING ld_ref_tienda.
****
****      clear gr_alv_posdm.
****      perform f_add_nodo using 'Cajero'
****                               ld_ref_tienda
****                               '@P8@'
****                      CHANGING ld_ref_any.
****    endon.
****
****    on CHANGE OF git_ZZTRANSACTION-OPERATORID.
****      lf_onchange = 'X'.
****
****      clear gr_alv_posdm.
****      gr_alv_posdm-status = gc_minisemaforo_inactivo.
****      loop at git_ZZTRANSACTION into wa_ZZTRANSACTION where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                                                and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID
****                                                and OPERATORID      = git_ZZTRANSACTION-OPERATORID.
****        add 1 to gr_alv_posdm-canttrans.
****      endloop.
****
****      loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                              and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID
****                              and OPERATORID      = git_ZZTRANSACTION-OPERATORID.
****        add git_ZZTENDER-TENDERAMOUNT to gr_alv_posdm-volneg.
****        gr_alv_posdm-waers = git_ZZTENDER-TENDERCURRENCY.
****      endloop.
****
****      gr_alv_posdm-BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****      gr_alv_posdm-RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID.
****      gr_alv_posdm-OPERATORID      = git_ZZTRANSACTION-OPERATORID.
****
****      perform f_add_nodo using git_ZZTRANSACTION-OPERATORID
****                               ld_ref_tienda
****                               ''
****                      CHANGING ld_ref_cajero.
****
****      clear gr_alv_posdm.
****      perform f_add_nodo using 'Caja'
****                               ld_ref_cajero
****                               '@P8@'
****                      CHANGING ld_ref_any.
****    endon.
****
****    on CHANGE OF git_ZZTRANSACTION-WORKSTATIONID.
****      lf_onchange = 'X'.
****
****      clear gr_alv_posdm.
****      gr_alv_posdm-status = gc_minisemaforo_inactivo.
****      loop at git_ZZTRANSACTION into wa_ZZTRANSACTION where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                                                and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID
****                                                and OPERATORID      = git_ZZTRANSACTION-OPERATORID
****                                                and WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID.
****        add 1 to gr_alv_posdm-canttrans.
****      endloop.
****
****      loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                              and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID
****                              and OPERATORID      = git_ZZTRANSACTION-OPERATORID
****                              and WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID.
****        add git_ZZTENDER-TENDERAMOUNT to gr_alv_posdm-volneg.
****        gr_alv_posdm-waers = git_ZZTENDER-TENDERCURRENCY.
****      endloop.
****
****      gr_alv_posdm-BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****      gr_alv_posdm-RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID.
****      gr_alv_posdm-OPERATORID      = git_ZZTRANSACTION-OPERATORID.
****      gr_alv_posdm-WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID.
****
****      perform f_add_nodo using git_ZZTRANSACTION-WORKSTATIONID
****                               ld_ref_cajero
****                               ''
****                      CHANGING ld_ref_caja.
****
****
****      clear gr_alv_posdm.
****      perform f_add_nodo using 'Medio de pago'
****                               ld_ref_caja
****                               '@P8@'
****                      CHANGING ld_ref_any.
****
****      clear git_ZZTENDER.
****      clear lf_onchange.
****      loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                              and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID
****                              and OPERATORID      = git_ZZTRANSACTION-OPERATORID
****                              and WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID.
****
****        on CHANGE OF git_ZZTENDER-TENDERTYPECODE.
****           lf_onchange = 'X'.
****
****           clear gr_alv_posdm.
****           gr_alv_posdm-status = gc_minisemaforo_inactivo.
****
****           loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                                    and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID
****                                    and OPERATORID      = git_ZZTRANSACTION-OPERATORID
****                                    and WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID
****                                    and TENDERTYPECODE  = git_ZZTENDER-TENDERTYPECODE.
****              add 1 to gr_alv_posdm-canttrans.
****              add git_ZZTENDER-TENDERAMOUNT to gr_alv_posdm-volneg.
****              gr_alv_posdm-waers = git_ZZTENDER-TENDERCURRENCY.
****           endloop.
****
****
****           gr_alv_posdm-BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****           gr_alv_posdm-RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID.
****           gr_alv_posdm-OPERATORID      = git_ZZTRANSACTION-OPERATORID.
****           gr_alv_posdm-WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID.
****           gr_alv_posdm-TENDERTYPECODE  = git_ZZTENDER-TENDERTYPECODE.
****
****           perform f_get_tendertypecodet using git_ZZTENDER-TENDERTYPECODE CHANGING ld_tendertypecodet.
****           perform f_add_nodo using ld_tendertypecodet
****                                    ld_ref_caja
****                                    ''
****                           CHANGING ld_ref_tender.
****        endon.
****
****        if lf_onchange = space.
****          lf_onchange = 'X'.
****          clear gr_alv_posdm.
****          gr_alv_posdm-status = gc_minisemaforo_inactivo.
****
****          loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE
****                                   and RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID
****                                   and OPERATORID      = git_ZZTRANSACTION-OPERATORID
****                                   and WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID
****                                   and TENDERTYPECODE  = git_ZZTENDER-TENDERTYPECODE.
****             add 1 to gr_alv_posdm-canttrans.
****             add git_ZZTENDER-TENDERAMOUNT to gr_alv_posdm-volneg.
****             gr_alv_posdm-waers = git_ZZTENDER-TENDERCURRENCY.
****          endloop.
****
****
****          gr_alv_posdm-BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****          gr_alv_posdm-RETAILSTOREID   = git_ZZTRANSACTION-RETAILSTOREID.
****          gr_alv_posdm-OPERATORID      = git_ZZTRANSACTION-OPERATORID.
****          gr_alv_posdm-WORKSTATIONID   = git_ZZTRANSACTION-WORKSTATIONID.
****          gr_alv_posdm-TENDERTYPECODE  = git_ZZTENDER-TENDERTYPECODE.
****
****          perform f_get_tendertypecodet using git_ZZTENDER-TENDERTYPECODE CHANGING ld_tendertypecodet.
****          perform f_add_nodo using ld_tendertypecodet
****                                   ld_ref_caja
****                                   ''
****                          CHANGING ld_ref_tender.
****        endif.
****      endloop.
****    endon.
****
****    if lf_onchange = space.
****      clear gr_alv_posdm.
****      gr_alv_posdm-status = gc_minisemaforo_inactivo.
****      write git_ZZTRANSACTION-BUSINESSDAYDATE to ld_fecha.
****      loop at git_ZZTRANSACTION into wa_ZZTRANSACTION where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****        add 1 to gr_alv_posdm-canttrans.
****      endloop.
****
****      loop at git_ZZTENDER where BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****        add git_ZZTENDER-TENDERAMOUNT to gr_alv_posdm-volneg.
****        gr_alv_posdm-waers = git_ZZTENDER-TENDERCURRENCY.
****      endloop.
****
****      gr_alv_posdm-BUSINESSDAYDATE = git_ZZTRANSACTION-BUSINESSDAYDATE.
****
****      perform f_add_nodo using ld_fecha
****                               ld_ref_inicio
****                               ''
****                      CHANGING ld_ref_fecha.
****
****      clear gr_alv_posdm.
****      perform f_add_nodo using 'Tienda'
****                               ld_ref_fecha
****                               '@P8@'
****                      CHANGING ld_ref_any.
****    endif.
****  endloop.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  add_carrid_line
*&---------------------------------------------------------------------*
FORM f_add_nodo USING pe_valor
                      pe_nodo_superior
                      pe_icono
             CHANGING ps_node_key  TYPE lvc_nkey.

* 0.- Declaración de variables
*==========================================================================
  DATA: l_node_text    TYPE lvc_value,
        ls_node        TYPE lvc_s_layn,
        lt_item_layout TYPE lvc_t_layi,
        ls_item_layout TYPE lvc_s_layi.

* 1.- Lógica
*==========================================================================
* Layout Nodo
*  ls_item_layout-t_image   = pe_icono.
  ls_item_layout-fieldname = gr_tree_01->c_hierarchy_column_name.
*  ls_item_layout-style = cl_gui_column_tree=>style_intensifd_critical.
  APPEND ls_item_layout TO lt_item_layout.

* Valor Nodo
  l_node_text       =  pe_valor.
  ls_node-n_image   = pe_icono.
  ls_node-exp_image = pe_icono.


* Añadir nodo al arbol
  CALL METHOD gr_tree_01->add_node
    EXPORTING
      i_relat_node_key = pe_nodo_superior
      i_relationship   = cl_gui_column_tree=>relat_last_child
      i_node_text      = l_node_text
      is_outtab_line   = gr_alv_posdm
      is_node_layout   = ls_node
      it_item_layout   = lt_item_layout
    IMPORTING
      e_new_node_key   = ps_node_key.

ENDFORM.                               " add_carrid_line

*&---------------------------------------------------------------------*
*& Form F_HANDLE_ITEM_DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_FIELDNAME  text
*      -->P_NODE_KEY  text
*&---------------------------------------------------------------------*
FORM f_handle_item_double_click  USING    pe_fieldname  TYPE  lvc_fname
                                          pe_node_key   TYPE  lvc_nkey.

* 0.- Declaración de variables
*==========================================================================
  RANGES: lran_businessdaydate FOR zztransaction-businessdaydate,
          lran_retailstoreid   FOR zztransaction-retailstoreid,
          lran_operatorid      FOR zztransaction-operatorid,
          lran_workstationid   FOR zztransaction-workstationid,
          lran_tendertypecode  FOR zztender-tendertypecode.

* 1.- Lógica
*==========================================================================

  CALL METHOD gr_tree_01->get_outtab_line
    EXPORTING
      i_node_key     = pe_node_key
    IMPORTING
      e_outtab_line  = gr_alv_posdm
*     E_NODE_TEXT    =
*     ET_ITEM_LAYOUT =
*     ES_NODE_LAYOUT =
    EXCEPTIONS
      node_not_found = 1
      OTHERS         = 2.
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

  IF gr_alv_posdm-businessdaydate IS INITIAL AND
     gr_alv_posdm-retailstoreid   IS INITIAL AND
     gr_alv_posdm-operatorid      IS INITIAL AND
     gr_alv_posdm-workstationid   IS INITIAL.
    EXIT.
  ENDIF.

  IF gr_alv_posdm-businessdaydate IS NOT INITIAL.
    lran_businessdaydate-sign = 'I'.
    lran_businessdaydate-option = 'EQ'.
    lran_businessdaydate-low = gr_alv_posdm-businessdaydate.
    APPEND lran_businessdaydate.
  ENDIF.

  IF gr_alv_posdm-retailstoreid IS NOT INITIAL.
    lran_retailstoreid-sign = 'I'.
    lran_retailstoreid-option = 'EQ'.
    lran_retailstoreid-low = gr_alv_posdm-retailstoreid.
    APPEND lran_retailstoreid.
  ENDIF.

  IF gr_alv_posdm-operatorid IS NOT INITIAL.
    lran_operatorid-sign = 'I'.
    lran_operatorid-option = 'EQ'.
    lran_operatorid-low = gr_alv_posdm-operatorid.
    APPEND lran_operatorid.
  ENDIF.

  IF gr_alv_posdm-workstationid IS NOT INITIAL.
    lran_workstationid-sign = 'I'.
    lran_workstationid-option = 'EQ'.
    lran_workstationid-low = gr_alv_posdm-workstationid.
    APPEND lran_workstationid.
  ENDIF.

  IF gr_alv_posdm-tendertypecode IS NOT INITIAL.
    lran_tendertypecode-sign = 'I'.
    lran_tendertypecode-option = 'EQ'.
    lran_tendertypecode-low = gr_alv_posdm-tendertypecode.
    APPEND lran_tendertypecode.
  ENDIF.

  REFRESH git_posdm_popup_c.

  LOOP AT git_zztransaction WHERE businessdaydate IN lran_businessdaydate
                              AND retailstoreid   IN lran_retailstoreid
                              AND operatorid      IN lran_operatorid
                              AND workstationid   IN lran_workstationid.

    MOVE-CORRESPONDING git_zztransaction TO gr_posdm_popup_c.


    IF git_zztransaction-tarea1_docnum = ''.
      gr_posdm_popup_c-t1 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea1_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t1 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t1 = gc_minisemaforo_verde.
    ENDIF.

    IF git_zztransaction-tarea2_docnum = ''.
      gr_posdm_popup_c-t2 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea2_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t2 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t2 = gc_minisemaforo_verde.
    ENDIF.

    IF git_zztransaction-tarea21_docnum = ''.
      gr_posdm_popup_c-t21 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea21_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t21 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t21 = gc_minisemaforo_verde.
    ENDIF.

    IF git_zztransaction-tarea3_docnum = ''.
      gr_posdm_popup_c-t3 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea3_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t3 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t3 = gc_minisemaforo_verde.
    ENDIF.

*   APRADAS-Inicio-20.03.2019 15:50:17>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    IF git_zztransaction-tarea31_docnum = ''.
      gr_posdm_popup_c-t31 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea31_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t31 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t31 = gc_minisemaforo_verde.
    ENDIF.
*   APRADAS-Fin-20.03.2019 15:50:17<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    IF git_zztransaction-tarea4_docnum = ''.
      gr_posdm_popup_c-t4 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea4_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t4 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t4 = gc_minisemaforo_verde.
    ENDIF.

*   APRADAS-Inicio-22.04.2019 11:18:01>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    IF git_zztransaction-tarea5_docnum = ''.
      gr_posdm_popup_c-t5 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea5_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t5 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t5 = gc_minisemaforo_verde.
    ENDIF.
*   APRADAS-Fin-22.04.2019 11:18:01<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

*>>>APRADAS-26.01.2021 10:43:56-Inicio
    IF git_zztransaction-tarea6_docnum = ''.
      gr_posdm_popup_c-t6 = gc_minisemaforo_inactivo.
    ELSEIF git_zztransaction-tarea6_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t6 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t6 = gc_minisemaforo_verde.
    ENDIF.
*<<<APRADAS-26.01.2021 10:43:56-Fin


***    SELECT SINGLE status
***      FROM zretposdm001t01
***      INTO gr_posdm_popup_c-t5
***     WHERE businessdaydate = git_zztransaction-businessdaydate.
***
***    IF sy-subrc <> 0.
***      gr_posdm_popup_c-t5 = gc_minisemaforo_inactivo.
***    ENDIF.

    gr_posdm_popup_c-horaticket = gr_posdm_popup_c-begindatetimestamp+8(6).
    PERFORM f_get_transactiontypecodet USING gr_posdm_popup_c-transactiontypecode CHANGING gr_posdm_popup_c-transactiontypecodet.

    LOOP AT git_zztender WHERE businessdaydate IN lran_businessdaydate
                            AND retailstoreid   IN lran_retailstoreid
                            AND operatorid      IN lran_operatorid
                            AND workstationid   IN lran_workstationid
                            AND transactionsequencenumber = git_zztransaction-transactionsequencenumber
                            AND tendertypecode  IN lran_tendertypecode.
      APPEND gr_posdm_popup_c TO  git_posdm_popup_c.
      EXIT.
    ENDLOOP.
  ENDLOOP.

  SORT git_posdm_popup_c.

  CALL SCREEN 0200.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_HANDLE_NODE_DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_NODE_KEY  text
*&---------------------------------------------------------------------*
FORM f_handle_node_double_click  USING    pe_node_key TYPE lvc_nkey.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_USER_COMMAND_0200
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_user_command_0200 .
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_okcode     LIKE sy-ucomm,
        ld_valid(1),
        ld_refresh(1) VALUE ''.

* 1.- Lógica
*==========================================================================

  IF gr_grid_10 IS NOT INITIAL.
    CALL METHOD gr_grid_10->check_changed_data
      IMPORTING
        e_valid = ld_valid
*      CHANGING
*       C_REFRESH = ld_refresh
      .

    IF ld_valid <> 'X'.
      EXIT.
    ENDIF.
  ENDIF.


  ld_okcode = gd_okcode_0200.

  CLEAR: gd_okcode_0200,
         sy-ucomm.

  CASE ld_okcode.
    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      PERFORM f_free_alv USING gr_grid_08 gr_container_08.
      PERFORM f_free_alv USING gr_grid_09 gr_container_09.
      PERFORM f_free_alv USING gr_grid_10 gr_container_10.
      PERFORM f_free_alv USING gr_grid_11 gr_container_11.
      PERFORM f_free_alv USING gr_grid_12 gr_container_12.

      CLEAR gf_0200_ticket.
      LEAVE TO SCREEN 0.
    WHEN 'REFACTURAR'.
      PERFORM f_refacturar.
    WHEN 'IMPRIMIR'.
      PERFORM f_imprimir.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_HANDLE_HOTSPOT_CLICK_ALV_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_ROW_ID  text
*      -->P_E_COLUMN_ID  text
*      -->P_ES_ROW_NO  text
*----------------------------------------------------------------------*
FORM f_handle_hotspot_click_alv_08  USING   e_row_id  TYPE  lvc_s_row
                                            e_column_id TYPE  lvc_s_col
                                            es_row_no TYPE  lvc_s_roid.

* 0.- Declaracion de variables
*==========================================================================
  DATA: wa_mseg            LIKE mseg,
        wa_zztransaction   LIKE zztransaction,
        wa_zretposdm001t01 LIKE zretposdm001t01,
        ld_menge_umb       LIKE ekpo-menge,
        ld_menge_meinh     LIKE ekpo-menge.

* 1.- Logica
*==========================================================================
* Recuperamos linea sobre la que se ha hecho click
  READ TABLE git_posdm_popup_c INTO gr_posdm_popup_c INDEX es_row_no-row_id.

  IF e_column_id-fieldname = 'TRANSACTIONSEQUENCENUMBER'.
    gf_0200_ticket = 'X'.

    REFRESH: git_posdm_popup_l,
             git_posdm_popup_d,
             git_posdm_popup_m.

*   Recuperar cabecera de ticket
    SELECT SINGLE *
      FROM zztransaction
      INTO wa_zztransaction
     WHERE retailstoreid = gr_posdm_popup_c-retailstoreid
       AND businessdaydate = gr_posdm_popup_c-businessdaydate
       AND transactiontypecode = gr_posdm_popup_c-transactiontypecode
       AND workstationid  = gr_posdm_popup_c-workstationid
       AND transactionsequencenumber = gr_posdm_popup_c-transactionsequencenumber.

*   Confeccionamos información tareas ticket
    REFRESH git_posdm_popup_t.
    CLEAR gr_posdm_popup_t.
    gr_posdm_popup_t-tarea  = 'T1'.
    gr_posdm_popup_t-tareat = 'Movimientos de salida por venta'.
    IF wa_zztransaction-tarea1_docnum = 'NO_APLICA'.
      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
    ELSEIF wa_zztransaction-tarea1_docnum IS NOT INITIAL.
      gr_posdm_popup_t-status = gc_minisemaforo_verde.
      gr_posdm_popup_t-docnum = wa_zztransaction-tarea1_docnum.
    ELSE.
      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
    ENDIF.
    APPEND gr_posdm_popup_t TO git_posdm_popup_t.

    CLEAR gr_posdm_popup_t.
    gr_posdm_popup_t-tarea  = 'T2'.
    gr_posdm_popup_t-tareat = 'Agrupación tickets anónimos'.
    IF wa_zztransaction-tarea2_docnum = 'NO_APLICA'.
      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
    ELSEIF wa_zztransaction-tarea2_docnum IS NOT INITIAL.
      gr_posdm_popup_t-status = gc_minisemaforo_verde.
      gr_posdm_popup_t-docnum = wa_zztransaction-tarea2_docnum.
    ELSE.
      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
    ENDIF.
    APPEND gr_posdm_popup_t TO git_posdm_popup_t.


*    CLEAR gr_posdm_popup_t.
*    gr_posdm_popup_t-tarea  = 'T2-1'.
*    gr_posdm_popup_t-tareat = 'Cierre caja parcial Baluart'.
*    IF wa_zztransaction-tarea21_docnum = 'NO_APLICA'.
*      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
*    ELSEIF wa_zztransaction-tarea21_docnum IS NOT INITIAL.
*      gr_posdm_popup_t-status = gc_minisemaforo_verde.
*      gr_posdm_popup_t-docnum = wa_zztransaction-tarea21_docnum.
*    ELSE.
*      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
*    ENDIF.
*    APPEND gr_posdm_popup_t TO git_posdm_popup_t.


    CLEAR gr_posdm_popup_t.
    gr_posdm_popup_t-tarea  = 'T3'.
    gr_posdm_popup_t-tareat = 'Ventas a clientes a cuenta'.
    IF wa_zztransaction-tarea3_docnum = 'NO_APLICA'.
      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
    ELSEIF wa_zztransaction-tarea3_docnum IS NOT INITIAL.
      gr_posdm_popup_t-status = gc_minisemaforo_verde.
      gr_posdm_popup_t-docnum = wa_zztransaction-tarea3_docnum.
    ELSE.
      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
    ENDIF.
    APPEND gr_posdm_popup_t TO git_posdm_popup_t.

*   APRADAS-Inicio-20.03.2019 15:47:03>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*    CLEAR gr_posdm_popup_t.
*    gr_posdm_popup_t-tarea  = 'T3-1'.
*    gr_posdm_popup_t-tareat = 'Cierre caja parcial Baluart'.
*    IF wa_zztransaction-tarea31_docnum = 'NO_APLICA'.
*      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
*    ELSEIF wa_zztransaction-tarea31_docnum IS NOT INITIAL.
*      gr_posdm_popup_t-status = gc_minisemaforo_verde.
*      gr_posdm_popup_t-docnum = wa_zztransaction-tarea21_docnum.
*    ELSE.
*      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
*    ENDIF.
*    APPEND gr_posdm_popup_t TO git_posdm_popup_t.
*   APRADAS-Fin-20.03.2019 15:47:03<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

* APRADAS-Inicio-09.10.2018 15:42:56>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
* Tareas 4 y 5 y no aplican

    CLEAR gr_posdm_popup_t.
    gr_posdm_popup_t-tarea  = 'T4'.
    gr_posdm_popup_t-tareat = 'Cierre de caja'.
    IF wa_zztransaction-tarea4_docnum = 'NO_APLICA'.
      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
    ELSEIF wa_zztransaction-tarea4_docnum IS NOT INITIAL.
      gr_posdm_popup_t-status = gc_minisemaforo_verde.
      gr_posdm_popup_t-docnum = wa_zztransaction-tarea4_docnum.
    ELSE.
      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
    ENDIF.
    APPEND gr_posdm_popup_t TO git_posdm_popup_t.

    CLEAR gr_posdm_popup_t.
    gr_posdm_popup_t-tarea  = 'T5'.
    gr_posdm_popup_t-tareat = 'Creación cliente auto'.
    IF wa_zztransaction-tarea5_docnum = 'NO_APLICA'.
      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
    ELSEIF wa_zztransaction-tarea5_docnum IS NOT INITIAL.
      gr_posdm_popup_t-status = gc_minisemaforo_verde.
      gr_posdm_popup_t-docnum = wa_zztransaction-tarea5_docnum.
    ELSE.
      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
    ENDIF.
    APPEND gr_posdm_popup_t TO git_posdm_popup_t.

    CLEAR gr_posdm_popup_t.
    gr_posdm_popup_t-tarea  = 'T6'.
    gr_posdm_popup_t-tareat = 'Anticipo'.
    IF wa_zztransaction-tarea6_docnum = 'NO_APLICA'.
      gr_posdm_popup_t-status = gc_minisemaforo_ambar.
    ELSEIF wa_zztransaction-tarea6_docnum IS NOT INITIAL.
      gr_posdm_popup_t-status = gc_minisemaforo_verde.
      gr_posdm_popup_t-docnum = wa_zztransaction-tarea6_docnum.
    ELSE.
      gr_posdm_popup_t-status = gc_minisemaforo_inactivo.
    ENDIF.
    APPEND gr_posdm_popup_t TO git_posdm_popup_t.


***
***    clear gr_posdm_popup_t.
***    gr_posdm_popup_t-TAREA  = 'T5'.
***    gr_posdm_popup_t-TAREAT = 'Cierre de caja'.
***    select single *
***      from ZRETPOSDM001T01
***      into wa_ZRETPOSDM001T01
***     where businessdaydate = gr_posdm_popup_c-businessdaydate.
***
***    if sy-subrc <> 0.
***      gr_posdm_popup_t-STATUS = gc_minisemaforo_inactivo.
***    else.
***      gr_posdm_popup_t-STATUS = wa_ZRETPOSDM001T01-status.
***      gr_posdm_popup_t-DOCNUM = wa_ZRETPOSDM001T01-docnum.
***    endif.
***
***    append gr_posdm_popup_t to git_posdm_popup_t.
* APRADAS-Fin-09.10.2018 15:42:56<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*   Recuperar lineas del ticket
    SELECT *
      FROM zzlineitem
      INTO CORRESPONDING FIELDS OF TABLE git_posdm_popup_l
     WHERE retailstoreid              = gr_posdm_popup_c-retailstoreid
       AND operatorid                 = gr_posdm_popup_c-operatorid
       AND businessdaydate            = gr_posdm_popup_c-businessdaydate
       AND transactionsequencenumber  = gr_posdm_popup_c-transactionsequencenumber.

*   Completar información lineas del ticket
    LOOP AT git_posdm_popup_l INTO gr_posdm_popup_l.
      gr_posdm_popup_l-pcoste_unit_waers = 'EUR'.
      gr_posdm_popup_l-pcoste_waers      = 'EUR'.

      IF gf_call_t4 = 'X' AND gr_posdm_popup_c-t4 <> gc_minisemaforo_verde.
*       Obtener ultima entrada de mercancía del artículo en el sistema
        SELECT *
          FROM mseg
          INTO wa_mseg
         WHERE mseg~matnr = gr_posdm_popup_l-itemid
           AND mseg~bwart = '101'
           AND mseg~bustw = 'WE01'
           AND mseg~lifnr <> ''
          ORDER BY budat_mkpf DESCENDING
                   mblnr DESCENDING
                   mjahr DESCENDING.
          EXIT.
        ENDSELECT.

        IF sy-subrc = 0.
*         Si la hemos encontrado...

*         Coste unitario en unidad de medida de la EM
          wa_mseg-dmbtr = wa_mseg-dmbtr / wa_mseg-menge.

*         Obtenemos la conversion a UMB de la UM de la EM
          CLEAR ld_menge_umb.
          CALL FUNCTION 'MD_CONVERT_MATERIAL_UNIT'
            EXPORTING
              i_matnr              = wa_mseg-matnr
              i_in_me              = wa_mseg-meins
              i_out_me             = gr_posdm_popup_l-salesunitofmeasure
              i_menge              = 1
            IMPORTING
              e_menge              = ld_menge_umb
            EXCEPTIONS
              error_in_application = 1
              error                = 2
              OTHERS               = 3.
          IF sy-subrc <> 0. ENDIF.

          IF ld_menge_umb IS NOT INITIAL.
*           Obtenemos coste unitario de la UMB del articulo
            wa_mseg-dmbtr = wa_mseg-dmbtr / ld_menge_umb.

*           Asignamos precio coste unitario
            gr_posdm_popup_l-pcoste_unit = wa_mseg-dmbtr.

*           Calculamos precio coste unitario
            gr_posdm_popup_l-pcoste = gr_posdm_popup_l-pcoste_unit * gr_posdm_popup_l-retailquantity.

          ENDIF.
        ENDIF.
      ENDIF.

      MODIFY git_posdm_popup_l FROM gr_posdm_popup_l.
    ENDLOOP.

    SORT git_posdm_popup_l.

    SELECT *
      FROM zzlineitemdisc
      INTO CORRESPONDING FIELDS OF TABLE git_posdm_popup_d
     WHERE retailstoreid              = gr_posdm_popup_c-retailstoreid
       AND operatorid                 = gr_posdm_popup_c-operatorid
       AND businessdaydate            = gr_posdm_popup_c-businessdaydate
       AND transactionsequencenumber  = gr_posdm_popup_c-transactionsequencenumber.

    SELECT *
      FROM zztender
      INTO CORRESPONDING FIELDS OF TABLE git_posdm_popup_m
     WHERE retailstoreid              = gr_posdm_popup_c-retailstoreid
       AND operatorid                 = gr_posdm_popup_c-operatorid
       AND businessdaydate            = gr_posdm_popup_c-businessdaydate
       AND transactionsequencenumber  = gr_posdm_popup_c-transactionsequencenumber.

    LOOP AT git_posdm_popup_m INTO gr_posdm_popup_m.
      PERFORM f_get_tendertypecodet USING gr_posdm_popup_m-tendertypecode CHANGING gr_posdm_popup_m-tendertypecodet.
      MODIFY git_posdm_popup_m FROM gr_posdm_popup_m.
    ENDLOOP.

    gf_refresh_posdm_popup_l = 'X'.

*   Forzamos codigo de función
    CALL METHOD cl_gui_cfw=>set_new_ok_code
      EXPORTING
        new_code = 'ENTER'.
  ENDIF.
ENDFORM.                    " F_HANDLE_HOTSPOT_CLICK_ALV_1

*&---------------------------------------------------------------------*
*&      Form  F_HANDLE_HOTSPOT_CLICK_ALV_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_ROW_ID  text
*      -->P_E_COLUMN_ID  text
*      -->P_ES_ROW_NO  text
*----------------------------------------------------------------------*
FORM f_handle_hotspot_click_alv_16  USING   e_row_id    TYPE  lvc_s_row
                                            e_column_id TYPE  lvc_s_col
                                            es_row_no   TYPE  lvc_s_roid.

* 0.- Declaracion de variables
*--------------------------------------------------------------------*

* 1.- Logica
*--------------------------------------------------------------------*
* Recuperamos linea sobre la que se ha hecho click
  READ TABLE git_cierre_dias INTO gr_cierre_dias INDEX es_row_no-row_id.

  CASE e_column_id-fieldname.
    WHEN 'BUSINESSDAYDATE'.
      SUBMIT zretposdm001
        WITH p_r03 = 'X'
        WITH s_bdd BETWEEN gr_cierre_dias-businessdaydate AND gr_cierre_dias-businessdaydate
         AND RETURN.
    WHEN 'CIERRE'.
      PERFORM f_cierre.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_STATUS_IDOC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_GIT_ZPOSDM001_DOCNUM  text
*      <--P_GIT_LISTADOT_STATUS_IDOC  text
*&---------------------------------------------------------------------*
FORM f_get_status_idoc  USING    pe_docnum
                        CHANGING ps_status_idoc.
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_status LIKE edidc-status.

* 1.- Lógica
*==========================================================================
  SELECT SINGLE status
    FROM edidc
    INTO ld_status
   WHERE docnum = pe_docnum.

  CASE ld_status.
    WHEN '51'.
      ps_status_idoc = gc_minisemaforo_rojo.
    WHEN '64'.
      ps_status_idoc = gc_minisemaforo_ambar.
    WHEN '53'.
      ps_status_idoc = gc_minisemaforo_verde.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_0200_PBO_CONFIG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_0200_pbo_config .
  IF gf_0200_ticket = space.
    LOOP AT SCREEN.
      IF screen-group1 = 'DET'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.

      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

  IF gf_call_t4 = 'X'.
    LOOP AT SCREEN.
      IF screen-name = 'MARC03'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.

      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_TENDERTYPECODE_INFO_PDT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_WA_ZPOSDM001_03  text
*      <--P_LR_ZPOS0015_TENDERTYPECODE  text
*      <--P_LR_ZPOS0015_TENDERAMOUNT  text
*&---------------------------------------------------------------------*
FORM f_get_tendertypecode_info_pdt  USING    wa_zposdm001 STRUCTURE zposdm001
                                    CHANGING ps_tendertypecode
                                             ps_tenderamount.

* 0.- Declaración de variables
*==========================================================================
  DATA: wa_zposdm001p02     LIKE zposdm001p02,
        ld_subidtransaccion LIKE zposdm001p02-subidtransaccion.

* 1.- Lógica
*==========================================================================
  IF wa_zposdm001-l10subidtrans IS NOT INITIAL.
    ld_subidtransaccion = wa_zposdm001-l10subidtrans.
  ELSEIF wa_zposdm001-l14subidtrans IS NOT INITIAL.
    ld_subidtransaccion = wa_zposdm001-l14subidtrans.
  ELSEIF wa_zposdm001-l31subidtrans IS NOT INITIAL.
    ld_subidtransaccion = wa_zposdm001-l31subidtrans.
  ELSEIF wa_zposdm001-l33subidtrans IS NOT INITIAL.
    ld_subidtransaccion = wa_zposdm001-l33subidtrans.
  ELSEIF wa_zposdm001-l24subidtrans IS NOT INITIAL.
    ld_subidtransaccion = wa_zposdm001-l24subidtrans.
  ELSEIF wa_zposdm001-l46subidtrans  IS NOT INITIAL.
    ld_subidtransaccion = wa_zposdm001-l46subidtrans.
  ELSEIF wa_zposdm001-l47subidtrans  IS NOT INITIAL.
    ld_subidtransaccion = wa_zposdm001-l47subidtrans.
  ENDIF.

  SELECT SINGLE *
    FROM zposdm001p02
    INTO wa_zposdm001p02
   WHERE idtransaccion    = wa_zposdm001-idtransaccion
     AND subidtransaccion = ld_subidtransaccion.

  ps_tendertypecode = wa_zposdm001p02-tendertypecode.

  CASE wa_zposdm001p02-idtransaccion.
    WHEN '10'.
      ps_tenderamount      = wa_zposdm001-l10total.
    WHEN '14'.
      ps_tenderamount      = wa_zposdm001-l14total.
    WHEN '31'.
      ps_tenderamount     = wa_zposdm001-l31total.
    WHEN '33'.
      ps_tenderamount      = wa_zposdm001-l33total.
    WHEN '24'.
      ps_tenderamount      = wa_zposdm001-l24total.
    WHEN '46'.
      ps_tenderamount     = wa_zposdm001-l46total.
    WHEN '47'.
      ps_tenderamount     = wa_zposdm001-l47total.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_TENDERTYPECODET
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_GIT_ZZTENDER_TENDERTYPECODE  text
*      <--P_LD_TENDERTYPECODET  text
*&---------------------------------------------------------------------*
FORM f_get_tendertypecodet  USING    pe_tendertypecode
                            CHANGING ps_tendertypecodet.

  DATA: wa_zposdm001p02 LIKE zposdm001p02.

  SELECT SINGLE *
    FROM zposdm001p02
    INTO wa_zposdm001p02
   WHERE tendertypecode = pe_tendertypecode.

  CONCATENATE pe_tendertypecode '-' wa_zposdm001p02-idtransacciont INTO ps_tendertypecodet SEPARATED BY space.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_FORMAPAGOT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_GIT_ZPOSDM001_IDTRANSACCION  text
*      -->P_       text
*      <--P_GR_TICKET_07_FORMAPAGO  text
*&---------------------------------------------------------------------*
FORM f_get_formapagot  USING    pe_idtransaccion
                                pe_subidtrans
                       CHANGING ps_formapago.

  CLEAR ps_formapago.

  SELECT SINGLE idtransacciont
    FROM zposdm001p02
    INTO ps_formapago
   WHERE idtransaccion    = pe_idtransaccion
     AND subidtransaccion = pe_subidtrans.


ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_VALIDAR_TICKET_INDIVIDUAL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LIT_ZPOSDM001T  text
*&---------------------------------------------------------------------*
FORM f_validar_ticket_individual  TABLES   it_zposdm001t STRUCTURE zposdm001.

* 0.- Declaración de variables
*==========================================================================
  DATA: wa_zposdm001           LIKE git_zposdm001,
        lf_forma_pago_otros(1),
        lf_supervision(1),
        ld_index               LIKE sy-tabix,
        lf_error(1),
        ld_tienda              LIKE marc-werks.

* 1.- Lógica
*==========================================================================
  READ TABLE it_zposdm001t WITH KEY idtransaccion = '00'.
  ld_index = sy-tabix.

  IF p_r01 = 'X'.
    SELECT SINGLE idoperacion
      FROM zposdm001
      INTO it_zposdm001t-idoperacion
     WHERE idcaja      = it_zposdm001t-idcaja
       AND idfecha     = it_zposdm001t-idfecha
       AND idoperacion = it_zposdm001t-idoperacion.

    IF sy-subrc = 0 .
      SELECT SINGLE l00fichero
        FROM zposdm001
        INTO it_zposdm001t-l00fichero
       WHERE idcaja        = it_zposdm001t-idcaja
         AND idfecha       = it_zposdm001t-idfecha
         AND idoperacion   = it_zposdm001t-idoperacion
         AND idtransaccion = '00'
         AND l00fichero    = it_zposdm001t-l00fichero.

      IF sy-subrc <> 0.
        lf_error = 'D'.
      ENDIF.
    ENDIF.
  ENDIF.

  IF lf_error IS INITIAL.

    IF it_zposdm001t-l00codoperacion = '05'.
      READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                        idfecha       = it_zposdm001t-idfecha
                                        idoperacion   = it_zposdm001t-idoperacion
                                        idtransaccion = '02'
                               TRANSPORTING NO FIELDS.

      IF sy-subrc <> 0.
        lf_error = 'X'.
      ENDIF.
    ELSEIF it_zposdm001t-l00codoperacion = '03'.
*     Miramos si tiene otras formas de pago
      LOOP AT it_zposdm001t INTO wa_zposdm001
                           WHERE idcaja        = it_zposdm001t-idcaja
                             AND idfecha       = it_zposdm001t-idfecha
                             AND idoperacion   = it_zposdm001t-idoperacion
                             AND ( idtransaccion = '14' OR idtransaccion = '46' ).
        lf_forma_pago_otros = 'X'.
        EXIT.
      ENDLOOP.

*     Miramos si el ticket ha sido supervisado
      READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                        idfecha       = it_zposdm001t-idfecha
                                        idoperacion   = it_zposdm001t-idoperacion
                                        idtransaccion = '99'
                           TRANSPORTING NO FIELDS.

      IF sy-subrc = 0.
        lf_supervision = 'X'.
      ENDIF.


      READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                        idfecha       = it_zposdm001t-idfecha
                                        idoperacion   = it_zposdm001t-idoperacion
                                        idtransaccion = '07'
                               TRANSPORTING NO FIELDS.

      IF sy-subrc = 0.
        lf_error = 'A'.
      ENDIF.

      IF lf_error IS INITIAL.

        READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                          idfecha       = it_zposdm001t-idfecha
                                          idoperacion   = it_zposdm001t-idoperacion
                                          idtransaccion = '01'
                                 INTO wa_zposdm001.

        IF sy-subrc <> 0.
          lf_error = 'X'.
        ENDIF.

        IF lf_error IS INITIAL.

          READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                            idfecha       = it_zposdm001t-idfecha
                                            idoperacion   = it_zposdm001t-idoperacion
                                            idtransaccion = '02'
                                    TRANSPORTING NO FIELDS.


          IF sy-subrc <> 0 AND lf_forma_pago_otros = space.
            IF lf_supervision = 'X'.
              lf_error = 'A'.
            ELSE.
              lf_error = 'X'.
            ENDIF.
          ENDIF.

          IF lf_error IS INITIAL.

            READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                              idfecha       = it_zposdm001t-idfecha
                                              idoperacion   = it_zposdm001t-idoperacion
                                              idtransaccion = '03'
                                    TRANSPORTING NO FIELDS.

            IF sy-subrc <> 0.
              IF lf_supervision = 'X'.
                lf_error = 'A'.
              ELSE.
                lf_error = 'X'.
              ENDIF.
            ENDIF.

            IF lf_error IS INITIAL.

              READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                                idfecha       = it_zposdm001t-idfecha
                                                idoperacion   = it_zposdm001t-idoperacion
                                                idtransaccion = '75'
                                      TRANSPORTING NO FIELDS.

              IF sy-subrc <> 0 AND lf_forma_pago_otros = space.
                READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                                  idfecha       = it_zposdm001t-idfecha
                                                  idoperacion   = it_zposdm001t-idoperacion
                                                  idtransaccion = '03'
                                                  l03importe    = '0.00'
                                      TRANSPORTING NO FIELDS.

                IF sy-subrc = 0.
                  lf_error = 'D'.
                ENDIF.
              ENDIF.

              IF lf_error IS INITIAL.

                READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                                  idfecha       = it_zposdm001t-idfecha
                                                  idoperacion   = it_zposdm001t-idoperacion
                                                  idtransaccion = '10'
                                        TRANSPORTING NO FIELDS.

                IF sy-subrc <> 0.
                  READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                                    idfecha       = it_zposdm001t-idfecha
                                                    idoperacion   = it_zposdm001t-idoperacion
                                                    idtransaccion = '24'
                                        TRANSPORTING NO FIELDS.

                  IF sy-subrc <> 0.
                    READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                                  idfecha           = it_zposdm001t-idfecha
                                                  idoperacion       = it_zposdm001t-idoperacion
                                                  idtransaccion = '14'
                                        TRANSPORTING NO FIELDS.
                    IF sy-subrc <> 0.
                      READ TABLE it_zposdm001t WITH KEY idcaja      = it_zposdm001t-idcaja
                                                  idfecha           = it_zposdm001t-idfecha
                                                  idoperacion       = it_zposdm001t-idoperacion
                                                  idtransaccion     = '33'
                                        TRANSPORTING NO FIELDS.

                      IF sy-subrc <> 0.
                        READ TABLE it_zposdm001t WITH KEY idcaja    = it_zposdm001t-idcaja
                                                  idfecha           = it_zposdm001t-idfecha
                                                  idoperacion       = it_zposdm001t-idoperacion
                                                  idtransaccion     = '46'
                                        TRANSPORTING NO FIELDS.

                        IF sy-subrc <> 0.
                          READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                                  idfecha       = it_zposdm001t-idfecha
                                                  idoperacion = it_zposdm001t-idoperacion
                                                  idtransaccion = '31'
                                        TRANSPORTING NO FIELDS.

                          IF sy-subrc <> 0.
                            READ TABLE it_zposdm001t WITH KEY idcaja        = it_zposdm001t-idcaja
                                                  idfecha       = it_zposdm001t-idfecha
                                                  idoperacion = it_zposdm001t-idoperacion
                                                  idtransaccion = '47'
                                        TRANSPORTING NO FIELDS.

                            IF sy-subrc <> 0.
                              IF lf_supervision = 'X'.
                                lf_error = 'A'.
                              ELSE.
                                lf_error = 'X'.
                              ENDIF.
                            ENDIF.
                          ENDIF.
                        ENDIF.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF. "
        ENDIF. "
      ENDIF.
    ENDIF.
  ENDIF.


  IF lf_error = 'X' OR lf_error = 'D'.
    it_zposdm001t-l00valido = gc_minisemaforo_rojo.
  ELSEIF lf_error = 'A'.
    it_zposdm001t-l00valido = gc_minisemaforo_ambar.
  ELSE.
    it_zposdm001t-l00valido = gc_minisemaforo_verde.
  ENDIF.

  MODIFY it_zposdm001t INDEX ld_index.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_AT_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_at_selection_screen .

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_SELECCIONAR_DATOS_CIERRE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleccionar_datos_cierre .
  DATA: ld_status LIKE edidc-status.

  SELECT DISTINCT businessdaydate
    FROM zztransaction
    INTO CORRESPONDING FIELDS OF TABLE git_cierre_dias
   WHERE businessdaydate IN s_feci.

  SORT git_cierre_dias BY businessdaydate DESCENDING.

  LOOP AT git_cierre_dias INTO gr_cierre_dias.
    SELECT SINGLE status
                  docnum
      FROM zretposdm001t01
      INTO (gr_cierre_dias-status,
            gr_cierre_dias-docnum)
     WHERE businessdaydate = gr_cierre_dias-businessdaydate.

    IF sy-subrc <> 0.
      gr_cierre_dias-status = gc_minisemaforo_inactivo.
      gr_cierre_dias-status_idoc = gc_minisemaforo_inactivo.
    ENDIF.

    IF gr_cierre_dias-docnum IS NOT INITIAL.
      SELECT SINGLE status
        FROM edidc
        INTO ld_status
       WHERE docnum = gr_cierre_dias-docnum.

      CASE ld_status.
        WHEN '53'.
          gr_cierre_dias-status_idoc = gc_minisemaforo_verde.
        WHEN '51'.
          gr_cierre_dias-status_idoc = gc_minisemaforo_rojo.
        WHEN '64'.
          gr_cierre_dias-status_idoc = gc_minisemaforo_ambar.
      ENDCASE.
    ENDIF.


    gr_cierre_dias-cierre = gc_icono_cajero.

    MODIFY git_cierre_dias FROM gr_cierre_dias.
  ENDLOOP.

  CLEAR gr_cierre_dias.

  CALL SCREEN 9002.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_USER_COMMAND_9002
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_user_command_9002 .
  DATA: ld_okcode LIKE sy-ucomm.

  ld_okcode = gd_okcode_9002.

  CLEAR: gd_okcode_9002,
         sy-ucomm.

  CASE ld_okcode.
    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      PERFORM f_free_alv USING gr_grid_16 gr_container_16.
      PERFORM f_free_alv USING gr_grid_17 gr_container_17.

      LEAVE TO SCREEN 0.
    WHEN 'CIERRE'.
      PERFORM f_cierre_exec.
    WHEN 'BTN_VIS_IDOC'.
      SUBMIT rseidoc2
        WITH credat BETWEEN '00000000' AND sy-datum
        WITH docnum BETWEEN gr_cierre_dias-docnum AND space
         AND RETURN.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_9002_PBO_INIT_ALVS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_9002_pbo_init_alvs .

  IF gr_grid_16 IS INITIAL.
    PERFORM f_9002_init_alv_16.
  ELSE.
    PERFORM f_refresh_alv USING gr_grid_16 'X' 'X' 'X' ''.
  ENDIF.

  IF gr_cierre_dias IS NOT INITIAL.
    IF gr_grid_17 IS INITIAL.
      PERFORM f_9002_init_alv_17.
    ELSE.
      PERFORM f_free_alv USING gr_grid_17 gr_container_17.
      PERFORM f_9002_init_alv_17.
    ENDIF.
  ENDIF.


ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_CIERRE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_cierre .
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_zztender     LIKE zztender OCCURS 0 WITH HEADER LINE,
        lit_zposdm001p02 LIKE zposdm001p02 OCCURS 0 WITH HEADER LINE,
        ld_index         LIKE sy-tabix.

* 1.- Lógica
*==========================================================================
  REFRESH git_cierre_det.

  IF gr_cierre_dias-status = gc_minisemaforo_inactivo.
    SELECT *
      FROM zztender
      INTO TABLE lit_zztender
     WHERE businessdaydate = gr_cierre_dias-businessdaydate.


    LOOP AT lit_zztender.
      LOOP AT git_cierre_det INTO gr_cierre_det WHERE tendertypecode = lit_zztender-tendertypecode
                                                  AND tendercurrency = lit_zztender-tendercurrency.
        ld_index = sy-tabix.
        EXIT.
      ENDLOOP.

      IF sy-subrc = 0.
        gr_cierre_det-tenderamount = gr_cierre_det-tenderamount + lit_zztender-tenderamount.
        gr_cierre_det-tenderamountf = gr_cierre_det-tenderamountf + lit_zztender-tenderamount.

        MODIFY git_cierre_det FROM gr_cierre_det INDEX ld_index.
      ELSE.
        CLEAR gr_cierre_det.

        gr_cierre_det-tendertypecode  = lit_zztender-tendertypecode.
        PERFORM f_get_tendertypecodet USING gr_cierre_det-tendertypecode CHANGING gr_cierre_det-tendertypecodet.
        PERFORM f_get_tendertypecodek USING gr_cierre_det-tendertypecode CHANGING gr_cierre_det-hkont.
        gr_cierre_det-tenderamount    = lit_zztender-tenderamount.
        gr_cierre_det-tenderamountf    = lit_zztender-tenderamount.
        gr_cierre_det-tendercurrency  = lit_zztender-tendercurrency.

        APPEND gr_cierre_det TO git_cierre_det.
      ENDIF.
    ENDLOOP.

*   Añadimos Medios de pago manuales
    SELECT *
      FROM zposdm001p02
      INTO TABLE lit_zposdm001p02
     WHERE idtransaccion = '99'.

    LOOP AT lit_zposdm001p02.
      CLEAR gr_cierre_det.

      gr_cierre_det-tendertypecode    = lit_zposdm001p02-tendertypecode.
      PERFORM f_get_tendertypecodet USING gr_cierre_det-tendertypecode CHANGING gr_cierre_det-tendertypecodet.
      gr_cierre_det-hkont             = lit_zposdm001p02-hkont.
      gr_cierre_det-tendercurrency    = 'EUR'.

      APPEND gr_cierre_det TO git_cierre_det.
    ENDLOOP.
  ELSE.

    SELECT *
      FROM zretposdm001t02
      INTO CORRESPONDING FIELDS OF TABLE git_cierre_det
     WHERE businessdaydate = gr_cierre_dias-businessdaydate.

    LOOP AT git_cierre_det INTO gr_cierre_det.
      PERFORM f_get_tendertypecodet USING gr_cierre_det-tendertypecode CHANGING gr_cierre_det-tendertypecodet.

      MODIFY git_cierre_det FROM gr_cierre_det.
    ENDLOOP.
  ENDIF.

  SORT git_cierre_det.

  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = 'ENTER'.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_9002_PBO_CONFIG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_9002_pbo_config .
  IF gr_cierre_dias IS INITIAL.
    LOOP AT SCREEN.
      IF screen-group1 = 'DET'.
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.

      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

  IF gr_cierre_dias-docnum IS INITIAL.
    LOOP AT SCREEN.
      IF screen-name = 'GR_CIERRE_DIAS-STATUS' OR
         screen-name = 'GR_CIERRE_DIAS-DOCNUM' OR
         screen-name = 'BTN_VIS_IDOC' OR
         screen-name = 'GR_CIERRE_DIAS-STATUS_IDOC' .
        screen-input = 0.
        screen-invisible = 1.
      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_STATUS_9002
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_status_9002 .
  DATA: lit_excluding LIKE sy-ucomm OCCURS 0.

  IF gr_cierre_dias-status = gc_minisemaforo_verde OR
     gr_cierre_dias IS INITIAL.
    APPEND 'CIERRE' TO lit_excluding.
  ENDIF.

  SET PF-STATUS 'STATUS_9002' EXCLUDING lit_excluding.

  SET TITLEBAR  'T02'.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_CIERRE_EXEC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_cierre_exec .
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_pregunta         TYPE string,
        ld_docnum           LIKE edidc-docnum,
        ld_respuesta(1),
        wa_zretposdm001t01  LIKE zretposdm001t01,
        lit_zretposdm001t02 LIKE zretposdm001t02 OCCURS 0 WITH HEADER LINE,
        ld_valid(1),
        ld_refresh(1)       VALUE ''.

* 1.- Lógica
*==========================================================================

* Chequeamos ultimos cambios del ALV de detalle
  CALL METHOD gr_grid_17->check_changed_data
    IMPORTING
      e_valid = ld_valid
*    CHANGING
*     C_REFRESH = ld_refresh
    .

* Si se han detectado errores en la validacion => Error
  IF ld_valid IS INITIAL.
    EXIT.
  ENDIF.

* Solicitamos confirmación
  ld_pregunta = '¿Lanzar cierre de caja para el dia seleccionado?'.
  PERFORM f_popup_to_confirm USING ld_pregunta CHANGING ld_respuesta.

  IF ld_respuesta = '1'.
*   Si el usuario confirma...

*   Crear idoc de cierre de caja
    PERFORM f_generar_wpufib01_ccaja  CHANGING ld_docnum.

*   Actualizar status del cierre de caja en bbdd
    CLEAR wa_zretposdm001t01.
    wa_zretposdm001t01-businessdaydate = gr_cierre_dias-businessdaydate.
    wa_zretposdm001t01-status          = gc_minisemaforo_verde.
    wa_zretposdm001t01-docnum          = ld_docnum.
    MODIFY zretposdm001t01 FROM wa_zretposdm001t01.

*   Actualizamos status del cierre de caja en el ALV de la derecha
    LOOP AT git_cierre_dias INTO gr_cierre_dias WHERE businessdaydate = gr_cierre_dias-businessdaydate.
      gr_cierre_dias-status = gc_minisemaforo_verde.
      gr_cierre_dias-docnum = ld_docnum.
      PERFORM f_get_status_idoc USING ld_docnum CHANGING gr_cierre_dias-status_idoc.

      MODIFY git_cierre_dias FROM gr_cierre_dias.
    ENDLOOP.

*   Grabar datos cierre de caja en bbdd
    REFRESH lit_zretposdm001t02.
    LOOP AT git_cierre_det INTO gr_cierre_det.
      CLEAR lit_zretposdm001t02.
      MOVE-CORRESPONDING gr_cierre_det TO lit_zretposdm001t02.
      lit_zretposdm001t02-businessdaydate = gr_cierre_dias-businessdaydate.
      APPEND lit_zretposdm001t02.
    ENDLOOP.

    MODIFY zretposdm001t02 FROM TABLE lit_zretposdm001t02.

*   Msg: Cierre de caja realizado.
    MESSAGE i018(zretposdm001).
  ELSE.
*   Msg: Acción cancelada
    MESSAGE i017(zretposdm001).
  ENDIF.
ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_GENERAR_WPUFIB01_CCAJA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LIT_ZRETBAR001T06  text
*      -->P_PE_FECHA  text
*      <--P_LD_DOCNUM  text
*----------------------------------------------------------------------*
FORM f_generar_wpufib01_ccaja  CHANGING ps_docnum.
* 0.- Declaracion de variables
*=======================================================================
  DATA: lr_e1wpf01          LIKE e1wpf01,
        lr_e1wpf02          LIKE e1wpf02,
        lr_e1wxx01          LIKE e1wxx01,
        ld_kwert            TYPE kwert,
        lr_idoc_control     LIKE edidc,
        ld_identifier       LIKE edidc-docnum,
        lit_idoc_containers LIKE edidd OCCURS 0 WITH HEADER LINE,
        lr_idoc_control_new LIKE edidc,
        lt_edids            TYPE TABLE OF bdidocstat WITH HEADER LINE,
        ld_segnum           TYPE idocdsgnum,
        ld_segnum_cab       TYPE idocdsgnum,
        ld_segnum_cab_2     TYPE idocdsgnum,
        ld_posnr            TYPE numc05,
        ld_matnr            LIKE mara-matnr,
        lit_ekpo            LIKE ekpo OCCURS 0 WITH HEADER LINE,
*       Usuario de la comunicacion
        ld_usuario          LIKE sy-uname,
        ld_cont             TYPE int4,
*       Tienda a la que pertenece el usuario que ha realizado la comunicación
        ld_tienda           LIKE t001w-werks,
        ld_attyp            LIKE mara-matnr,
        ld_stlnr            LIKE stpo-stlnr,
        lit_stpo            LIKE stpo OCCURS 0 WITH HEADER LINE,
        lf_error(1).


* 1.- Logica
*=======================================================================

* Abrimos IDOC
  PERFORM f_idoc_abrir USING    'ZRETBAR001_FFIN_WPUFIB01_CCAJA'
                                ''
                       CHANGING lr_idoc_control
                                ld_identifier
                                lf_error.

* Segmento E1WPF01
  CLEAR lr_e1wpf01.
  lr_e1wpf01-vorgdatum = gr_cierre_dias-businessdaydate.
  CONCATENATE 'Cier.'
              gr_cierre_dias-businessdaydate+6(2)
              '.'
              gr_cierre_dias-businessdaydate+4(2)
              '.'
              gr_cierre_dias-businessdaydate(2)
         INTO lr_e1wpf01-bonnummer.
  lr_e1wpf01-erfasser = sy-uname.
  lr_e1wpf01-vorgangart = 'ZCCJ'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1WPF01'.
  lit_idoc_containers-sdata   = lr_e1wpf01.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  APPEND lit_idoc_containers.
  ld_segnum_cab = ld_segnum.

* Segmento E1WPF02
  CLEAR ld_kwert.
  LOOP AT git_cierre_det INTO gr_cierre_det.
    IF gr_cierre_det-hkont <> '-'. "APRADAS-16.04.2018
      ld_kwert = ld_kwert + gr_cierre_det-tenderamountf.
    ENDIF. "APRADAS-16.04.2018
  ENDLOOP.

  CLEAR lr_e1wpf02.
  lr_e1wpf02-posnr = '10'.
  lr_e1wpf02-wrbtr = ld_kwert.
  lr_e1wpf02-waers = 'EUR'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1WPF02'.
  lit_idoc_containers-sdata   = lr_e1wpf02.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  APPEND lit_idoc_containers.
  ld_segnum_cab = ld_segnum.

  ld_cont = 10.

  LOOP AT git_cierre_det INTO gr_cierre_det WHERE hkont <> '-'. "APRADAS-16.04.2018
    IF gr_cierre_det-tendertypecode(2) = 'ZZ' AND
       gr_cierre_det-tenderamountf IS INITIAL.
      CONTINUE.
    ENDIF.
    ADD 10 TO ld_cont.
*   APRADAS-Inicio-16.04.2018 11:07:30
    IF gr_cierre_det-tenderamountf < 0.
      ADD 1 TO ld_cont.
    ENDIF.
*   APRADAS-Fin-16.04.2018 11:07:30

    CLEAR lr_e1wpf02.
    lr_e1wpf02-posnr = ld_cont.
*   APRADAS-Inicio-16.04.2018 11:07:30
    IF gr_cierre_det-tenderamount < 0.
      lr_e1wpf02-wrbtr = gr_cierre_det-tenderamountf * ( -1 ).
    ELSE.
      lr_e1wpf02-wrbtr = gr_cierre_det-tenderamountf.
    ENDIF.
*   APRADAS-Fin-16.04.2018 11:07:30

    lr_e1wpf02-waers = gr_cierre_det-tendercurrency.
    lr_e1wpf02-kntobject = gr_cierre_det-hkont.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPF02'.
    lit_idoc_containers-sdata   = lr_e1wpf02.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    APPEND lit_idoc_containers.
    ld_segnum_cab = ld_segnum.
  ENDLOOP.

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

  COMMIT WORK AND WAIT.

  CALL FUNCTION 'DEQUEUE_ALL'
*   EXPORTING
*     _SYNCHRON       = ' '
    .

  SUBMIT rbdapp01
    WITH docnum BETWEEN lr_idoc_control_new-docnum AND space
    WITH p_output = space
    AND RETURN.


  IF lr_idoc_control_new-docnum IS NOT INITIAL.
*   Si idoc creado correctamente...
    ps_docnum = lr_idoc_control_new-docnum.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_POPUP_TO_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LD_PREGUNTA  text
*      <--P_LD_RESPUESTA  text
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

*&---------------------------------------------------------------------*
*& Form F_GET_TENDERTYPECODE_PDT_05
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_WA_ZPOSDM001_02_L0205_FPAGOORI  text
*      -->P_       text
*      <--P_LR_ZZPOSDWE1BPTENDER_TENDERTYP  text
*      <--P_LR_ZZPOSDWE1BPTENDER_TENDERAMO  text
*&---------------------------------------------------------------------*
FORM f_get_tendertypecode_pdt_05  USING    pe_fpago
                                  CHANGING ps_cod_fpago.

  SELECT SINGLE tendertypecode
    FROM zposdm001p02
    INTO ps_cod_fpago
   WHERE subidtransaccion = pe_fpago.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_GET_TENDERTYPECODEK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GR_CIERRE_DET_TENDERTYPECODE  text
*      <--P_GR_CIERRE_DET_HKONT  text
*----------------------------------------------------------------------*
FORM f_get_tendertypecodek  USING    pe_tendertypecode
                            CHANGING ps_hkont.

  SELECT SINGLE hkont
    FROM zposdm001p02
    INTO ps_hkont
   WHERE tendertypecode = pe_tendertypecode.

ENDFORM.


FORM  f_handle_data_changed_alv_17 USING  er_data_changed  TYPE REF TO cl_alv_changed_data_protocol.

ENDFORM.


FORM f_handle_data_changed_f_alv_17  USING    e_modified    TYPE char01
                                              et_good_cells TYPE  lvc_t_modi.


* Forzamos codigo de función
  PERFORM f_refresh_alv USING gr_grid_17 'X' 'X' 'X' ''.

ENDFORM.                    " F_HANDLE_DATA_CHANGED_F_ALV_2


FORM  f_handle_data_changed_alv_10 USING  er_data_changed  TYPE REF TO cl_alv_changed_data_protocol.
* 0.- Declaración de variables
*==========================================================================
  DATA: wa_celdas      TYPE lvc_s_modi,
        ld_coste       TYPE verpr,
        ld_pcoste_unit TYPE verpr,
        ld_value       TYPE lvc_value,
        lf_es_importe  TYPE char1.

* 1.- Lógica
*==========================================================================
  LOOP AT er_data_changed->mt_mod_cells INTO wa_celdas.
*   Cargamos datos de la linea de la celda modificada
    READ TABLE git_posdm_popup_l INTO gr_posdm_popup_l INDEX wa_celdas-row_id.

*   Analizamos modificación
    CASE wa_celdas-fieldname.
      WHEN 'PCOSTE_UNIT'.
*       Precio coste unitario

*       Verificamos que el valor introducido es un importe
        PERFORM f_check_es_importe USING wa_celdas-value CHANGING lf_es_importe.

        IF lf_es_importe = 'X'.
          REPLACE ALL OCCURRENCES OF '.' IN wa_celdas-value WITH ''.
          REPLACE ALL OCCURRENCES OF ',' IN wa_celdas-value WITH '.'.
          REPLACE ALL OCCURRENCES OF '-' IN wa_celdas-value WITH ''.

          ld_pcoste_unit = wa_celdas-value.
          ld_coste = ld_pcoste_unit * gr_posdm_popup_l-retailquantity * ( -1 ).

          CALL METHOD er_data_changed->modify_cell
            EXPORTING
              i_row_id    = wa_celdas-row_id
*             i_tabix     =
              i_fieldname = 'PCOSTE'
              i_value     = ld_coste.

        ENDIF.
    ENDCASE.
  ENDLOOP.
ENDFORM.


FORM f_handle_data_changed_f_alv_10  USING    e_modified    TYPE char01
                                              et_good_cells TYPE  lvc_t_modi.


* Forzamos codigo de función
  PERFORM f_refresh_alv USING gr_grid_10 'X' 'X' 'X' ''.

ENDFORM.                    " F_HANDLE_DATA_CHANGED_F_ALV_2

*&---------------------------------------------------------------------*
*&      Form  F_T1_MOV_SALIDA_POR_VENTA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_t1_mov_salida_por_venta .
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_zztransaction   LIKE zztransaction OCCURS 0 WITH HEADER LINE,
        lit_zzlineitem      LIKE zzlineitem    OCCURS 0 WITH HEADER LINE,
        lit_idoc_containers LIKE edidd OCCURS 0 WITH HEADER LINE,
        lr_idoc_control_new LIKE edidc,
        lr_idoc_control     LIKE edidc,
        ld_identifier       LIKE edidc-docnum,
        ld_docnum_ini       TYPE edi_docnum,
        ld_docnum_fin       TYPE edi_docnum,
        lr_e1wpg01          LIKE e1wpg01,
        lr_e1wpg02          LIKE e1wpg02,
        ld_segnum           TYPE idocdsgnum,
        ld_segnum_cab       TYPE idocdsgnum,
        ld_index            LIKE sy-tabix,
        lf_tienda_i         TYPE char1,
        lf_notiene_zser,
        ld_kbetr            TYPE kbetr,
        lf_error(1).

* 1.- Lógica
*==========================================================================
* Seleccionamos todos los tickets a analizar
  SELECT *
    FROM zztransaction
    INTO TABLE lit_zztransaction
   WHERE businessdaydate IN s_feci
     AND tarea1_docnum = ''.


* Descartamos tickets
  LOOP AT lit_zztransaction.
*   Para cada ticket..
    ld_index = sy-tabix.

    IF lit_zztransaction-transactiontypecode <> 'ZVTA' AND
       lit_zztransaction-transactiontypecode <> 'ZBTK' AND
       lit_zztransaction-transactiontypecode <> 'ZTCK' AND
       lit_zztransaction-transactiontypecode <> 'ZVTF' AND
       lit_zztransaction-transactiontypecode <> 'ZBFC' AND
       lit_zztransaction-transactiontypecode <> 'ZFAC' .

*     Si es un cierre de caja, descartamos ticket
      lit_zztransaction-tarea1_docnum = 'NO_APLICA'.

      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.

      DELETE lit_zztransaction INDEX ld_index.

      CONTINUE.
    ENDIF.
  ENDLOOP.


  LOOP AT lit_zztransaction.
*   Para cada ticket seleccionado...

*   Inicializamos
    CLEAR: lr_idoc_control,
           ld_identifier,
           ld_segnum,
           ld_segnum_cab,
           lf_error.

    REFRESH: lit_idoc_containers.

*   Recuperamos todas las posiciones del ticket
    REFRESH lit_zzlineitem.
    SELECT *
      FROM zzlineitem
      INTO TABLE lit_zzlineitem
     WHERE retailstoreid = lit_zztransaction-retailstoreid
       AND businessdaydate = lit_zztransaction-businessdaydate
       AND transactiontypecode = lit_zztransaction-transactiontypecode
       AND workstationid = lit_zztransaction-workstationid
       AND transactionsequencenumber = lit_zztransaction-transactionsequencenumber.

*   APRADAS-Inicio-16.04.2018 08:34:50
*   Verificamos que el ticket no tenga lineas ZSER/ZTER
    CLEAR lf_notiene_zser.

    LOOP AT lit_zzlineitem.
*     Para cada linea de ticket

*     Miramos si el articulo es ZSER o ZTER
      SELECT SINGLE matnr
        FROM mara
        INTO lit_zzlineitem-itemid
       WHERE matnr = lit_zzlineitem-itemid
         AND ( mtart = 'ZSER' OR mtart = 'ZTER' ).

      IF sy-subrc <> 0.
*       Si el articulo no es ZTER o ZSER, debemos contemplar el ticket, por lo
*       que lo marcamos y nos salimos
        lf_notiene_zser = 'X'.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF lf_notiene_zser = ''.
*     Si todas las posiciones del ticket son ZSER o ZTER...

*     Asignamos idoc falso y saltamos ticket
      lit_zztransaction-tarea1_docnum = '6666666666'.
      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.

      CONTINUE.
    ENDIF.
*   APRADAS-Fin-16.04.2018 08:34:50

*   APRADAS-Inicio-04.12.2018
*   Determinar tienda
    CLEAR lf_tienda_i.
    IF lit_zztransaction-retailstoreid(1) = 'I'.
      SELECT SINGLE werks_tda
        FROM zretame005t01
        INTO lit_zztransaction-retailstoreid
       WHERE werks_web = lit_zztransaction-retailstoreid.

      IF sy-subrc = 0.
        lf_tienda_i = 'X'.
      ENDIF.
    ENDIF.
*   APRADAS-Fin-04.12.2018

*   Abrimos IDOC
    PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA1'
                                  lit_zztransaction-retailstoreid
                         CHANGING lr_idoc_control
                                  ld_identifier
                                  lf_error.

*   Segmento E1WPG01
    CLEAR lr_e1wpg01.
    lr_e1wpg01-belegdatum = lit_zztransaction-businessdaydate.
    lr_e1wpg01-bonnummer  = lit_zztransaction-transactionsequencenumber.
    lr_e1wpg01-kassierer  = lit_zztransaction-operatorid.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPG01'.
    lit_idoc_containers-sdata   = lr_e1wpg01.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    APPEND lit_idoc_containers.
    ld_segnum_cab = ld_segnum.

*   Posiciones
    LOOP AT lit_zzlineitem.

*     APRADAS-Inicio-16.04.2018 08:38:56
*     Si el articulo de la posición del ticket es ZSER/ZTER, la descartamos del idoc
      SELECT SINGLE matnr
        FROM mara
        INTO lit_zzlineitem-itemid
       WHERE matnr = lit_zzlineitem-itemid
         AND ( mtart = 'ZSER' OR mtart = 'ZTER' ).

      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.
*     APRADAS-Fin-16.04.2018 08:38:56

*     Segmentos E1WPG02
      CLEAR lr_e1wpg02.
      lr_e1wpg02-qualartnr = 'ARTN'.
      lr_e1wpg02-artnr     = lit_zzlineitem-itemid.
      IF lit_zzlineitem-retailquantity > 0.
        lr_e1wpg02-bewart = '251'.
      ELSEIF lit_zzlineitem-retailquantity < 0..
        lr_e1wpg02-bewart = '252'.
      ELSE.
        CONTINUE.
      ENDIF.

      lr_e1wpg02-meinh = lit_zzlineitem-salesunitofmeasure_iso.
      IF lit_zzlineitem-retailquantity < 0.
        lit_zzlineitem-retailquantity = lit_zzlineitem-retailquantity * ( -1 ).
      ENDIF.

      lr_e1wpg02-menge = lit_zzlineitem-retailquantity.
      lr_e1wpg02-waers = 'EUR'.
      lr_e1wpg02-lgort = '0001'. "APRADAS-18.10.2018

*     >APRADAS-21.06.2022 10:55:22-Inicio
      if sy-uname = 'PEPITO'.
      PERFORM f_calcular_pbfi
        USING
          lit_zzlineitem-itemid
          lit_zzlineitem-salesunitofmeasure
          lit_zzlineitem-retailstoreid
        CHANGING
          ld_kbetr.

      IF ld_kbetr IS NOT INITIAL.
        lr_e1wpg02-exbwr = ld_kbetr * lit_zzlineitem-retailquantity.
      ENDIF.
      endif.
*     <APRADAS-21.06.2022 10:55:22-Fin


      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPG02'.
      lit_idoc_containers-sdata   = lr_e1wpg02.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    ENDLOOP.

*   Añadimos segmentos
    PERFORM f_idoc_add_segmentos TABLES lit_idoc_containers
                                 USING  ld_identifier
                                 CHANGING lf_error.

*   Cerramos IDOC
    PERFORM f_idoc_cerrar USING    ld_identifier
                          CHANGING lr_idoc_control_new
                                   lf_error.

*   Cambiamos STATUS al idoc
    PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                        '64'
                                CHANGING lf_error.

    COMMIT WORK AND WAIT.

    CALL FUNCTION 'DEQUEUE_ALL'
*     EXPORTING
*       _SYNCHRON       = ' '
      .

    IF ld_docnum_ini IS INITIAL.
      ld_docnum_ini = lr_idoc_control_new-docnum.
    ELSE.
      ld_docnum_fin = lr_idoc_control_new-docnum.
    ENDIF.

    lit_zztransaction-tarea1_docnum = lr_idoc_control_new-docnum.

*   APRADAS-Inicio-07.12.2018 12:12:06>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    IF lf_tienda_i = 'X'.
      SELECT SINGLE werks_web
        FROM zretame005t01
        INTO lit_zztransaction-retailstoreid
       WHERE werks_tda = lit_zztransaction-retailstoreid.
    ENDIF.
*   APRADAS-Fin-07.12.2018 12:12:06<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    MODIFY zztransaction FROM lit_zztransaction.
    COMMIT WORK AND WAIT.
  ENDLOOP.

  IF p_proc = 'X'.
    SUBMIT rbdapp01
      WITH docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
      WITH p_output = space
      AND RETURN.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_T2_AGRUP_TICKETS_ANONIMOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_t2_agrup_tickets_anonimos .
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_zztransaction   LIKE zztransaction  OCCURS 0 WITH HEADER LINE,
        lit_zzlineitem      LIKE zzlineitem     OCCURS 0 WITH HEADER LINE,
        lit_idoc_containers LIKE edidd          OCCURS 0 WITH HEADER LINE,
        lit_zzlineitemdisc  LIKE zzlineitemdisc OCCURS 0 WITH HEADER LINE,
        lit_zztender        LIKE zztender       OCCURS 0 WITH HEADER LINE,

        lr_idoc_control_new LIKE edidc,
        lr_idoc_control     LIKE edidc,
        lr_e1wpu01          LIKE e1wpu01,
        lr_e1wpu02          LIKE e1wpu02,
        lr_e1wpu03          LIKE e1wpu03,
        lr_e1wxx01          LIKE e1wxx01,

        lr_e1wpf01          LIKE e1wpf01,
        lr_e1wpf02          LIKE e1wpf02,

        ld_index            LIKE sy-tabix,
        ld_identifier       LIKE edidc-docnum,
        ld_docnum_ini       TYPE edi_docnum,
        ld_docnum_fin       TYPE edi_docnum,
        ld_segnum           TYPE idocdsgnum,
        ld_segnum_cab       TYPE idocdsgnum,
        ld_segnum_cab_2     TYPE idocdsgnum,
        lf_error(1),

        lf_tiene_tarjeta(1),

        ld_num_art          TYPE int4,
        ld_num_art_tot      TYPE int4,

        BEGIN OF lit_idocs OCCURS 0,
          retailstoreid   TYPE zzretailstoreid,
          businessdaydate TYPE zzbusinessdaydate,
          workstationid   TYPE zzworkstationid,
        END OF lit_idocs,

        BEGIN OF lit_acumulado_articulo OCCURS 0,
          itemid              LIKE zzlineitem-itemid,
          retailquantity      LIKE zzlineitem-retailquantity,
          salesamount         LIKE zzlineitem-salesamount,
          salesamountsoloiva  LIKE zzlineitem-salesamountsoloiva,
          reductionamount     LIKE zzlineitemdisc-reductionamount,
          reductionamount_iva LIKE zzlineitemdisc-reductionamount,
          salesunitofmeasure  LIKE zzlineitem-salesunitofmeasure,
          units               LIKE zzlineitem-units,
        END OF lit_acumulado_articulo,

        BEGIN OF lit_acumulado_tender OCCURS 0,
          tendertypecode TYPE zztendertypecode,
          tenderamount   TYPE kwert,
        END OF lit_acumulado_tender,

        ld_salesamountsoloiva  TYPE p DECIMALS 2,
        ld_reductionamount     TYPE p DECIMALS 2,
        ld_reductionamount_iva TYPE p DECIMALS 2,
        ld_units               TYPE p DECIMALS 2,

        ld_primer_ticket       TYPE zztransactionsequencenumber,
        ld_ultimo_ticket       TYPE zztransactionsequencenumber,
        ld_num_tickets         TYPE int4,

        ld_total_zvta          LIKE zztender-tenderamount,

        lit_zretposdm001t03    LIKE zretposdm001t03 OCCURS 0 WITH HEADER LINE,

        "Artículos entrega domicilio
        BEGIN OF lit_articulos_entdom OCCURS 0,
          matnr LIKE mara-matnr,
        END OF lit_articulos_entdom,

        ld_bukrs TYPE bukrs,
        ld_kbetr TYPE kbetr.

* 1.- Lógica
*==========================================================================
* APRADAS-Inicio-25.03.2019 07:09:36>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
* Precargar artículos entrega domicilio
  SELECT valor
    FROM zhardcodes
    INTO TABLE lit_articulos_entdom
   WHERE programa = 'ZRETPOSDM001'
     AND param    = 'ARTENTDOM'.
* APRADAS-Fin-25.03.2019 07:09:36<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

* Precargar configuración de cuentas para el WPUFIB de Baluart
  SELECT *
    FROM zretposdm001t03
    INTO TABLE lit_zretposdm001t03
   WHERE transcactiontypecode = 'ZBCT'.

* Seleccionamos todos los tickets a analizar, que serán aquellos que tengan
* la tarea 2 en blanco
  SELECT *
    FROM zztransaction
    INTO TABLE lit_zztransaction
   WHERE businessdaydate IN s_feci
     AND tarea2_docnum = ''.

  SORT lit_zztransaction BY transactionsequencenumber ASCENDING. "APRADAS-03.12.2018-Ordenar tickets

* Descartamos tickets y nos quedamos con los distintos dias-tienda que hemos
* seleccionado
  LOOP AT lit_zztransaction.
*   Para cada ticket..
    ld_index = sy-tabix.

    IF lit_zztransaction-transactiontypecode <> 'ZVTA' AND
       lit_zztransaction-transactiontypecode <> 'ZTCK' AND
       lit_zztransaction-transactiontypecode <> 'ZBTK'.
*     Si no es un ticket de venta, lo descartamos
      lit_zztransaction-tarea2_docnum = 'NO_APLICA'.
      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.


      DELETE lit_zztransaction INDEX ld_index.
      CONTINUE.
    ENDIF.

*   Añadimos dia-tienda del ticket
    lit_idocs-retailstoreid   = lit_zztransaction-retailstoreid.
    lit_idocs-businessdaydate = lit_zztransaction-businessdaydate.
    lit_idocs-workstationid   = lit_zztransaction-workstationid.
    APPEND lit_idocs.
  ENDLOOP.

* Descartamos duplicados
  SORT lit_idocs.
  DELETE ADJACENT DUPLICATES FROM lit_idocs.

  LOOP AT lit_idocs.
*   Para cada pareja dia-tienda...

*>>>GENERACIÓN IDOC WPUUMS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

*   Inicializamos datos del idoc
    CLEAR: lr_idoc_control,
           ld_identifier,
           ld_segnum,
           ld_segnum_cab,
           lf_error,
           ld_primer_ticket,
           ld_ultimo_ticket,
           ld_num_tickets.

    REFRESH: lit_idoc_containers.

*   Abrimos IDOC
    PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA2'
                                  lit_idocs-retailstoreid "APRADAS-21.11.2018
                         CHANGING lr_idoc_control
                                  ld_identifier
                                  lf_error.

*   Segmento E1WPU01
    CLEAR lr_e1wpu01.
    lr_e1wpu01-belegdatum = lit_idocs-businessdaydate.
    lr_e1wpu01-belegwaers = 'EUR'.
    lr_e1wpu01-package_id = lit_idocs-workstationid.
    CONCATENATE sy-datum sy-uzeit INTO lr_e1wpu01-tran_datetime_min.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPU01'.
    lit_idoc_containers-sdata   = lr_e1wpu01.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    APPEND lit_idoc_containers.
    ld_segnum_cab = ld_segnum.

*   Obtenemos el acumulado por articulo para todos los tickets del dia-tienda
    REFRESH lit_acumulado_articulo.

    LOOP AT lit_zztransaction WHERE retailstoreid   = lit_idocs-retailstoreid
                                AND businessdaydate = lit_idocs-businessdaydate
                                AND workstationid   = lit_idocs-workstationid.

      IF ld_primer_ticket IS INITIAL.
        ld_primer_ticket = lit_zztransaction-transactionsequencenumber.
      ENDIF.

      ADD 1 TO ld_num_tickets.
*     Recuperamos todas las posiciones del ticket
      REFRESH lit_zzlineitem.
      SELECT *
        FROM zzlineitem
        INTO TABLE lit_zzlineitem
       WHERE retailstoreid = lit_zztransaction-retailstoreid
         AND businessdaydate = lit_zztransaction-businessdaydate
         AND transactiontypecode = lit_zztransaction-transactiontypecode
         AND workstationid = lit_zztransaction-workstationid
         AND transactionsequencenumber = lit_zztransaction-transactionsequencenumber.

*     Acumulamos cantidad y ventas de los articulos del ticket
      LOOP AT lit_zzlineitem.
*       APRADAS-Inicio-15.11.2018 14:35:20>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*       Recuperar descuentos de cabecera tipo 7/7IVA para la linea de ticket
        REFRESH lit_zzlineitemdisc.
        SELECT *
          FROM zzlineitemdisc
          INTO TABLE lit_zzlineitemdisc
         WHERE retailstoreid = lit_zztransaction-retailstoreid
           AND businessdaydate = lit_zztransaction-businessdaydate
           AND transactiontypecode = lit_zztransaction-transactiontypecode
           AND workstationid = lit_zztransaction-workstationid
           AND transactionsequencenumber = lit_zztransaction-transactionsequencenumber
           AND retailsequencenumber = lit_zzlineitem-retailsequencenumber
           AND ( discounttypecode = '7' OR
                 discounttypecode = '7IVA' ).
*       APRADAS-Fin-15.11.2018 14:35:20<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        LOOP AT lit_acumulado_articulo WHERE itemid = lit_zzlineitem-itemid.
          lit_acumulado_articulo-retailquantity = lit_acumulado_articulo-retailquantity  + lit_zzlineitem-retailquantity.
          lit_acumulado_articulo-salesamount    = lit_acumulado_articulo-salesamount     + lit_zzlineitem-salesamount.
          lit_acumulado_articulo-salesamountsoloiva = lit_acumulado_articulo-salesamountsoloiva + lit_zzlineitem-salesamountsoloiva.
          lit_acumulado_articulo-units = lit_acumulado_articulo-units + lit_zzlineitem-units.
          LOOP AT lit_zzlineitemdisc WHERE discounttypecode = '7'.
            lit_acumulado_articulo-reductionamount = lit_acumulado_articulo-reductionamount + lit_zzlineitemdisc-reductionamount.
          ENDLOOP.

          LOOP AT lit_zzlineitemdisc WHERE discounttypecode = '7IVA'.
            lit_acumulado_articulo-reductionamount_iva = lit_acumulado_articulo-reductionamount_iva + lit_zzlineitemdisc-reductionamount.
          ENDLOOP.


          MODIFY lit_acumulado_articulo.
        ENDLOOP.

        IF sy-subrc <> 0.
          CLEAR lit_acumulado_articulo.
          lit_acumulado_articulo-itemid             = lit_zzlineitem-itemid.
          lit_acumulado_articulo-retailquantity     = lit_zzlineitem-retailquantity.
          lit_acumulado_articulo-salesamount        = lit_zzlineitem-salesamount.
          lit_acumulado_articulo-salesamountsoloiva = lit_zzlineitem-salesamountsoloiva.
          lit_acumulado_articulo-units              = lit_zzlineitem-units.
          LOOP AT lit_zzlineitemdisc WHERE discounttypecode = '7'.
            lit_acumulado_articulo-reductionamount = lit_acumulado_articulo-reductionamount + lit_zzlineitemdisc-reductionamount.
          ENDLOOP.

          LOOP AT lit_zzlineitemdisc WHERE discounttypecode = '7IVA'.
            lit_acumulado_articulo-reductionamount_iva = lit_acumulado_articulo-reductionamount_iva + lit_zzlineitemdisc-reductionamount.
          ENDLOOP.
          lit_acumulado_articulo-salesunitofmeasure = lit_zzlineitem-salesunitofmeasure.

          APPEND lit_acumulado_articulo.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    ld_ultimo_ticket = lit_zztransaction-transactionsequencenumber.

*   Segmentos E1WPU02
    CLEAR ld_num_art.
    DESCRIBE TABLE lit_acumulado_articulo LINES ld_num_art_tot.
    LOOP AT lit_acumulado_articulo.
      ADD 1 TO ld_num_art.

      CLEAR lr_e1wpu02.
      lr_e1wpu02-qualartnr = 'ARTN'.
      lr_e1wpu02-artnr     = lit_acumulado_articulo-itemid.
*CCS 02.03.2022 --> para cantidad 0 e importe negativo hay que pasar el vorzmenge con + también
      IF lit_acumulado_articulo-retailquantity >= 0 AND lit_acumulado_articulo-salesamount >= 0.
        lr_e1wpu02-vorzmenge = '-'. "APRADAS-16.04.2018
      ELSEIF lit_acumulado_articulo-retailquantity = 0 AND lit_acumulado_articulo-salesamount < 0.
        lr_e1wpu02-vorzmenge = '+'.
      ELSEIF lit_acumulado_articulo-retailquantity < 0.
        lr_e1wpu02-vorzmenge = '+'. "APRADAS-16.04.2018
      ENDIF.

*     APRADAS-Inicio-25.03.2019 07:13:25>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*     Cambiar signo del VORZMENGE siempre a - si tienda web y artículo de entrega
*     a domicilio
      IF lit_idocs-retailstoreid(1) = 'I'.
*       Si tienda web...

*       Mirar si el artículo es de entrega a domicilio
        READ TABLE lit_articulos_entdom WITH KEY matnr = lr_e1wpu02-artnr.

        IF sy-subrc = 0.
*         Si lo es, cambiamos signo del vorzmenge siempre a -
          lr_e1wpu02-vorzmenge = '-'.
        ENDIF.
      ENDIF.
*     APRADAS-Fin-25.03.2019 07:13:25<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

      IF lit_acumulado_articulo-retailquantity < 0.
        lit_acumulado_articulo-retailquantity = lit_acumulado_articulo-retailquantity * ( -1 ).
      ENDIF.

      lr_e1wpu02-umsmenge = lit_acumulado_articulo-retailquantity.
*     Grabar importe en valor absoluto
      IF lit_acumulado_articulo-salesamount >= 0.
        lr_e1wpu02-umswert  = lit_acumulado_articulo-salesamount.
      ELSE.
        lr_e1wpu02-umswert  = lit_acumulado_articulo-salesamount * ( -1 ).
      ENDIF.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPU02'.
      lit_idoc_containers-sdata   = lr_e1wpu02.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.

      ld_segnum_cab_2 = ld_segnum.

      CLEAR lr_e1wpu03.
      lr_e1wpu03-kondition = 'ZMWN'.
      ld_salesamountsoloiva = lit_acumulado_articulo-salesamountsoloiva.
      IF ld_salesamountsoloiva >= 0.
        lr_e1wpu03-vorzeichen = '+'.
        lr_e1wpu03-kondvalue  = ld_salesamountsoloiva.
      ELSE.
        lr_e1wpu03-vorzeichen = '+'.
        lr_e1wpu03-kondvalue = ld_salesamountsoloiva * ( -1 ).
      ENDIF.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPU03'.
      lit_idoc_containers-sdata   = lr_e1wpu03.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
      APPEND lit_idoc_containers.


*    >APRADAS-21.06.2022 10:47:47-Inicio
      if sy-uname = 'PEPITO'.
      PERFORM f_calcular_pbfi
        USING
          lit_acumulado_articulo-itemid
          lit_acumulado_articulo-salesunitofmeasure
          lit_idocs-retailstoreid
        CHANGING
          ld_kbetr.

      IF ld_kbetr IS NOT INITIAL.
        CLEAR lr_e1wpu03.

        lr_e1wpu03-kondition = 'PBFI'.
        ld_salesamountsoloiva = ld_kbetr * lit_acumulado_articulo-retailquantity.
        IF ld_salesamountsoloiva >= 0.
          lr_e1wpu03-vorzeichen = '+'.
          lr_e1wpu03-kondvalue  = ld_salesamountsoloiva.
        ELSE.
          lr_e1wpu03-vorzeichen = '+'.
          lr_e1wpu03-kondvalue = ld_salesamountsoloiva * ( -1 ).
        ENDIF.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WPU03'.
        lit_idoc_containers-sdata   = lr_e1wpu03.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab_2.
        APPEND lit_idoc_containers.
      ENDIF.
      endif.
*    <APRADAS-21.06.2022 10:47:47-Fin
* CCOTILLA - INICIO - 21.10.2022 - Metemos un nuevo segmento para pasar la condición ZINT guardada en zzlineitem-units

        CLEAR lr_e1wpu03.
           ld_units = lit_acumulado_articulo-units.
      IF ld_units IS NOT INITIAL.
          lr_e1wpu03-kondition = 'ZINT'.

        IF ld_units >= 0.
          lr_e1wpu03-vorzeichen = '+'.
          lr_e1wpu03-kondvalue  = ld_units.
        ELSE.
          lr_e1wpu03-vorzeichen = '+'.
          lr_e1wpu03-kondvalue  = ld_units * ( -1 ).
        ENDIF.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WPU03'.
        lit_idoc_containers-sdata   = lr_e1wpu03.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab_2.
        APPEND lit_idoc_containers.
      ENDIF.

* CCOTILLA - FIN - 21.10.2022 - Metemos un nuevo segmento para pasar la condición ZINT guardada en zzlineitem-units
**     APRADAS-Inicio-15.11.2018 14:44:31>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*      CLEAR lr_e1wpu03.
*      lr_e1wpu03-kondition = 'ZDCV'.
*      ld_reductionamount = lit_acumulado_articulo-reductionamount.
*
*      if ld_reductionamount >= 0.
*        lr_e1wpu03-vorzeichen = '-'.
*        lr_e1wpu03-kondvalue = ld_reductionamount.
*      else.
*        lr_e1wpu03-vorzeichen = '-'.
*        lr_e1wpu03-kondvalue = ld_reductionamount * ( -1 ).
*      endif.
*
*      ADD 1 TO ld_segnum.
*      lit_idoc_containers-segnam  = 'E1WPU03'.
*      lit_idoc_containers-sdata   = lr_e1wpu03.
*      lit_idoc_containers-docnum  = ld_identifier.
*      lit_idoc_containers-segnum  = ld_segnum.
*      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
*      APPEND lit_idoc_containers.
*
*      CLEAR lr_e1wpu03.
*      lr_e1wpu03-kondition = 'ZDCN'.
*      ld_reductionamount = lit_acumulado_articulo-reductionamount_iva.
**      lr_e1wpu03-vorzeichen = '-'.
*      if ld_reductionamount >= 0.
*        lr_e1wpu03-vorzeichen = '+'.
*        lr_e1wpu03-kondvalue = ld_reductionamount.
*      else.
*        lr_e1wpu03-vorzeichen = '+'.
*        lr_e1wpu03-kondvalue = ld_reductionamount * ( -1 ).
*      endif.
*
*      ADD 1 TO ld_segnum.
*      lit_idoc_containers-segnam  = 'E1WPU03'.
*      lit_idoc_containers-sdata   = lr_e1wpu03.
*      lit_idoc_containers-docnum  = ld_identifier.
*      lit_idoc_containers-segnum  = ld_segnum.
*      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
*      APPEND lit_idoc_containers.
*
**     APRADAS-Fin-15.11.2018 14:44:31<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

      IF ld_num_art = ld_num_art_tot.
        CLEAR lr_e1wxx01.
        lr_e1wxx01-fldgrp = 'INFO'.
        lr_e1wxx01-fldname = 'FIRST'.
        lr_e1wxx01-fldval = ld_primer_ticket.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WXX01'.
        lit_idoc_containers-sdata   = lr_e1wxx01.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab_2.
        APPEND lit_idoc_containers.

        lr_e1wxx01-fldgrp = 'INFO'.
        lr_e1wxx01-fldname = 'LAST'.
        lr_e1wxx01-fldval = ld_ultimo_ticket.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WXX01'.
        lit_idoc_containers-sdata   = lr_e1wxx01.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab_2.
        APPEND lit_idoc_containers.

        lr_e1wxx01-fldgrp = 'INFO'.
        lr_e1wxx01-fldname = 'AMOUNT'.
        lr_e1wxx01-fldval = ld_num_tickets.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WXX01'.
        lit_idoc_containers-sdata   = lr_e1wxx01.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab_2.
        APPEND lit_idoc_containers.
      ENDIF.
    ENDLOOP.

*   APRADAS-Inicio-10.01.2019 14:07:07>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    LOOP AT lit_idoc_containers WHERE segnam = 'E1WXX01'.
      EXIT.
    ENDLOOP.

    IF sy-subrc <> 0.
      CLEAR lr_e1wxx01.
      lr_e1wxx01-fldgrp = 'INFO'.
      lr_e1wxx01-fldname = 'FIRST'.
      lr_e1wxx01-fldval = ld_primer_ticket.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WXX01'.
      lit_idoc_containers-sdata   = lr_e1wxx01.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
      APPEND lit_idoc_containers.

      lr_e1wxx01-fldgrp = 'INFO'.
      lr_e1wxx01-fldname = 'LAST'.
      lr_e1wxx01-fldval = ld_ultimo_ticket.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WXX01'.
      lit_idoc_containers-sdata   = lr_e1wxx01.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
      APPEND lit_idoc_containers.

      lr_e1wxx01-fldgrp = 'INFO'.
      lr_e1wxx01-fldname = 'AMOUNT'.
      lr_e1wxx01-fldval = ld_num_tickets.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WXX01'.
      lit_idoc_containers-sdata   = lr_e1wxx01.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
      APPEND lit_idoc_containers.
    ENDIF.
*   APRADAS-Fin-10.01.2019 14:07:07<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

*   Añadimos segmentos
    PERFORM f_idoc_add_segmentos TABLES lit_idoc_containers
                                 USING  ld_identifier
                                 CHANGING lf_error.

*   Cerramos IDOC
    PERFORM f_idoc_cerrar USING    ld_identifier
                          CHANGING lr_idoc_control_new
                                   lf_error.

*   Cambiamos STATUS al idoc
    PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                        '64'
                                CHANGING lf_error.

*   Hacemos commit
    COMMIT WORK AND WAIT.

*   Desbloqueamos idoc
    CALL FUNCTION 'DEQUEUE_ALL'
*       EXPORTING
*         _SYNCHRON       = ' '
      .

*   Grabamos primer/ultimo idoc (para procesamiento posterior)
    IF ld_docnum_ini IS INITIAL.
      ld_docnum_ini = lr_idoc_control_new-docnum.
    ELSE.
      ld_docnum_fin = lr_idoc_control_new-docnum.
    ENDIF.

*   Actualizamos los tickets en BBDD asignando el idoc generado a la tarea
    LOOP AT lit_zztransaction WHERE retailstoreid   = lit_idocs-retailstoreid
                                AND businessdaydate = lit_idocs-businessdaydate
                                AND workstationid   = lit_idocs-workstationid.
      lit_zztransaction-tarea2_docnum = lr_idoc_control_new-docnum.
      MODIFY lit_zztransaction.

      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.
    ENDLOOP.

*>>>GENERACIÓN IDOC WPUFIB>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

*   Miramos si la tienda es de Baluard
    LOOP AT lit_zztransaction WHERE retailstoreid       = lit_idocs-retailstoreid
                                AND businessdaydate     = lit_idocs-businessdaydate
                                AND workstationid       = lit_idocs-workstationid
                                AND transactiontypecode = 'ZBTK'.
      EXIT.
    ENDLOOP.

    IF sy-subrc = 0.
*     Si la tienda es de Baluard, generamos WPUFIB

*     Inicializamos datos del idoc
      CLEAR: lr_idoc_control,
             lr_idoc_control_new,
             ld_identifier,
             ld_segnum,
             ld_segnum_cab,
             lf_error,
             ld_primer_ticket,
             ld_ultimo_ticket,
             ld_num_tickets,
             lf_tiene_tarjeta. "APRADAS-04.12.2018

      REFRESH: lit_idoc_containers,
               lit_acumulado_tender.

*     Abrimos IDOC
      PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA2_1'
                                    lit_idocs-retailstoreid "APRADAS-21.11.2018
                           CHANGING lr_idoc_control
                                    ld_identifier
                                    lf_error.

*     Acumulamos por forma de pago
      LOOP AT lit_zztransaction WHERE retailstoreid       = lit_idocs-retailstoreid
                                  AND businessdaydate     = lit_idocs-businessdaydate
                                  AND workstationid       = lit_idocs-workstationid.

        REFRESH lit_zztender.
        SELECT *
          FROM zztender
          INTO TABLE lit_zztender
         WHERE retailstoreid              = lit_zztransaction-retailstoreid
           AND businessdaydate            = lit_zztransaction-businessdaydate
           AND transactiontypecode        = lit_zztransaction-transactiontypecode
           AND workstationid              = lit_zztransaction-workstationid
           AND transactionsequencenumber  = lit_zztransaction-transactionsequencenumber.

        LOOP AT lit_zztender.
*         Acumulamos importe forma de pago
          LOOP AT lit_acumulado_tender WHERE tendertypecode = lit_zztender-tendertypecode.
            ADD lit_zztender-tenderamount TO lit_acumulado_tender-tenderamount.
            MODIFY lit_acumulado_tender.
          ENDLOOP.

          IF sy-subrc <> 0.
*           Si forma de pago no se ha tratado aún, la registramos
            lit_acumulado_tender-tendertypecode = lit_zztender-tendertypecode.
            lit_acumulado_tender-tenderamount   = lit_zztender-tenderamount.
            APPEND lit_acumulado_tender.
          ENDIF.
        ENDLOOP.
      ENDLOOP.

*     Segmento E1WPF01
      CLEAR lr_e1wpf01.
      lr_e1wpf01-vorgdatum  = lit_idocs-businessdaydate.
      lr_e1wpf01-bonnummer  = 'TARJETAS'.
      lr_e1wpf01-erfasser   = 'AUTOMATICO'.
      lr_e1wpf01-vorgangart = 'ZBCT'.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPF01'.
      lit_idoc_containers-sdata   = lr_e1wpf01.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      APPEND lit_idoc_containers.
      ld_segnum_cab = ld_segnum.

*     Segmentos E1WPF02
      CLEAR ld_total_zvta.

*     >APRADAS-15.02.2021 08:30:56-Inicio
      SELECT SINGLE bukrs
        FROM t001k
        INTO ld_bukrs
       WHERE bwkey = lit_idocs-retailstoreid.
*     <APRADAS-15.02.2021 08:30:56-Fin

      LOOP AT lit_zretposdm001t03 WHERE burks = ld_bukrs. "APRADAS-15.02.2021
        LOOP AT lit_acumulado_tender WHERE tendertypecode = lit_zretposdm001t03-tendertypecode.
          EXIT.
        ENDLOOP.

        IF sy-subrc <> 0.
          CONTINUE.
        ELSE.
          lf_tiene_tarjeta = 'X'. "APRADAS-04.12.2018
          ld_total_zvta = ld_total_zvta + lit_acumulado_tender-tenderamount.
        ENDIF.

        CLEAR lr_e1wpf02.

        IF lit_acumulado_tender-tenderamount < 0.
          lit_acumulado_tender-tenderamount = lit_acumulado_tender-tenderamount * ( -1 ).

          lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_neg.
          lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_neg.
        ELSE.
          lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_pos.
          lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_pos.
        ENDIF.

        lr_e1wpf02-wrbtr = lit_acumulado_tender-tenderamount.
        lr_e1wpf02-waers = 'EUR'.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WPF02'.
        lit_idoc_containers-sdata   = lr_e1wpf02.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab.
        APPEND lit_idoc_containers.
      ENDLOOP.

      IF ld_total_zvta <> 0.
        READ TABLE lit_zretposdm001t03 WITH KEY tendertypecode = 'ZVTA' burks = ld_bukrs. "APRADAS-15.02.2021

        IF sy-subrc = 0.
          CLEAR lr_e1wpf02.

          IF ld_total_zvta < 0.
            ld_total_zvta = ld_total_zvta * ( -1 ).

            lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_neg.
            lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_neg.
          ELSE.
            lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_pos.
            lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_pos.
          ENDIF.

          lr_e1wpf02-wrbtr = ld_total_zvta.
          lr_e1wpf02-waers = 'EUR'.

          ADD 1 TO ld_segnum.
          lit_idoc_containers-segnam  = 'E1WPF02'.
          lit_idoc_containers-sdata   = lr_e1wpf02.
          lit_idoc_containers-docnum  = ld_identifier.
          lit_idoc_containers-segnum  = ld_segnum.
          lit_idoc_containers-psgnum  = ld_segnum_cab.
          APPEND lit_idoc_containers.
        ENDIF.
      ENDIF.

      IF lf_tiene_tarjeta = 'X'.
*       Añadimos segmentos
        PERFORM f_idoc_add_segmentos TABLES lit_idoc_containers
                                     USING  ld_identifier
                                     CHANGING lf_error.

*       Cerramos IDOC
        PERFORM f_idoc_cerrar USING    ld_identifier
                              CHANGING lr_idoc_control_new
                                       lf_error.

*       Cambiamos STATUS al idoc
        PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                            '64'
                                    CHANGING lf_error.

*       Hacemos commit
        COMMIT WORK AND WAIT.

*       Desbloqueamos idoc
        CALL FUNCTION 'DEQUEUE_ALL'
*           EXPORTING
*             _SYNCHRON       = ' '
          .

*       Grabamos primer/ultimo idoc (para procesamiento posterior)
        IF ld_docnum_ini IS INITIAL.
          ld_docnum_ini = lr_idoc_control_new-docnum.
        ELSE.
          ld_docnum_fin = lr_idoc_control_new-docnum.
        ENDIF.

*       Actualizamos los tickets en BBDD asignando el idoc generado a la tarea
        LOOP AT lit_zztransaction WHERE retailstoreid   = lit_idocs-retailstoreid
                                    AND businessdaydate = lit_idocs-businessdaydate
                                    AND workstationid   = lit_idocs-workstationid.
          lit_zztransaction-tarea21_docnum = lr_idoc_control_new-docnum.

          MODIFY zztransaction FROM lit_zztransaction.
          COMMIT WORK AND WAIT.
        ENDLOOP.
      ELSE.
*       Si no tiene tarjeta...

*       Actualizamos los tickets en BBDD asignando el idoc maldito
        LOOP AT lit_zztransaction WHERE retailstoreid   = lit_idocs-retailstoreid
                                    AND businessdaydate = lit_idocs-businessdaydate
                                    AND workstationid   = lit_idocs-workstationid.
          lit_zztransaction-tarea21_docnum = '6666666666'.

          MODIFY zztransaction FROM lit_zztransaction.
          COMMIT WORK AND WAIT.
        ENDLOOP.
      ENDIF.

    ELSE.
*   Actualizamos los tickets en BBDD asignando el idoc generado a la tarea
      LOOP AT lit_zztransaction WHERE retailstoreid   = lit_idocs-retailstoreid
                                  AND businessdaydate = lit_idocs-businessdaydate
                                  AND workstationid   = lit_idocs-workstationid.
        lit_zztransaction-tarea21_docnum = 'NO_APLICA'.

        MODIFY zztransaction FROM lit_zztransaction.
        COMMIT WORK AND WAIT.
      ENDLOOP.
    ENDIF.
  ENDLOOP.

* Si han marcado el flag de procesar directamente los idocs, los procesamos
  IF p_proc = 'X'.
    SUBMIT rbdapp01
      WITH docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
      WITH p_output = space
      AND RETURN.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_T3_VENTA_A_CLIENTES_A_CUENTA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_t3_venta_a_clientes_a_cuenta .
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_zztransaction   LIKE zztransaction   OCCURS 0 WITH HEADER LINE,
        lit_zzlineitem      LIKE zzlineitem      OCCURS 0 WITH HEADER LINE,
        lit_idoc_containers LIKE edidd           OCCURS 0 WITH HEADER LINE,
        lit_zzlineitemdisc  LIKE zzlineitemdisc  OCCURS 0 WITH HEADER LINE,
        lit_zretposdm001t03 LIKE zretposdm001t03 OCCURS 0 WITH HEADER LINE,
        lit_zztender        LIKE zztender       OCCURS 0 WITH HEADER LINE,
        BEGIN OF lit_acumulado_tender OCCURS 0,
          tendertypecode TYPE zztendertypecode,
          tenderamount   TYPE kwert,
        END OF lit_acumulado_tender,

        lr_idoc_control_new    LIKE edidc,
        lr_idoc_control        LIKE edidc,
        lr_e1wpb01             LIKE e1wpb01,
        lr_e1wpb02             LIKE e1wpb02,
        lr_e1wpb03             LIKE e1wpb03,
        lr_e1wpb06             LIKE e1wpb06,
        lr_e1wpf01             LIKE e1wpf01,
        lr_e1wpf02             LIKE e1wpf02,


        ld_index               LIKE sy-tabix,
        ld_identifier          LIKE edidc-docnum,
        ld_docnum_ini          TYPE edi_docnum,
        ld_docnum_fin          TYPE edi_docnum,
        ld_segnum              TYPE idocdsgnum,
        ld_segnum_cab          TYPE idocdsgnum,
        ld_segnum_cab_2        TYPE idocdsgnum,
        ld_salesamountsoloiva  TYPE p DECIMALS 2,
        ld_reductionamount     TYPE p DECIMALS 2,
        ld_reductionamount_iva TYPE p DECIMALS 2,
        ld_salesamount         TYPE p DECIMALS 2,
        ld_units               TYPE p DECIMALS 2,
        lf_tiene_tarjeta(1),
        ld_total_zvta          LIKE zztender-tenderamount,
        ld_bukrs               TYPE bukrs,

        ld_kbetr               TYPE kbetr,

        lf_error(1).

* 1.- Lógica
*==========================================================================
* APRADAS-Inicio-20.03.2019 15:25:10>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
* Precargar configuración de cuentas para el WPUFIB de Baluart
  SELECT *
    FROM zretposdm001t03
    INTO TABLE lit_zretposdm001t03
   WHERE transcactiontypecode = 'ZBCT'.
* APRADAS-Fin-20.03.2019 15:25:10<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

* Seleccionamos todos los tickets a analizar, que serán aquellos que tengan
* la tarea 3 en blanco
  SELECT *
    FROM zztransaction
    INTO TABLE lit_zztransaction
   WHERE businessdaydate IN s_feci
     AND tarea3_docnum = ''.

* Descartamos tickets y nos quedamos con los distintos dias-tienda que hemos
* seleccionado
  LOOP AT lit_zztransaction.
*   Para cada ticket..
    ld_index = sy-tabix.

    IF lit_zztransaction-transactiontypecode <> 'ZVTF' AND
       lit_zztransaction-transactiontypecode <> 'ZFAC' AND
       lit_zztransaction-transactiontypecode <> 'ZBFC'.

*     Si la forma de pago no es ZVTF ni ZFAC lo descartamos
      lit_zztransaction-tarea3_docnum = 'NO_APLICA'.
      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.

      DELETE lit_zztransaction INDEX ld_index.
      CONTINUE.
    ENDIF.
  ENDLOOP.

  LOOP AT lit_zztransaction.
*   Para cada pareja dia-tienda...

*   Inicializamos datos del idoc
    CLEAR: lr_idoc_control,
           ld_identifier,
           ld_segnum,
           ld_segnum_cab,
           lf_error.

    REFRESH: lit_idoc_containers.

*   Abrimos IDOC
    PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA3'
                                  lit_zztransaction-retailstoreid
                         CHANGING lr_idoc_control
                                  ld_identifier
                                  lf_error.

*   Segmento E1WPB01
    CLEAR lr_e1wpb01.
    lr_e1wpb01-poskreis   = 'ZVTA'.
    lr_e1wpb01-kassid     = lit_zztransaction-workstationid.
    lr_e1wpb01-vorgdatum  = lit_zztransaction-businessdaydate.
    lr_e1wpb01-vorgzeit   = lit_zztransaction-begindatetimestamp.
    lr_e1wpb01-bonnummer  = lit_zztransaction-transactionsequencenumber.
    lr_e1wpb01-qualkdnr   = '1'.
    lr_e1wpb01-kundnr     = lit_zztransaction-partnerid.
    lr_e1wpb01-kassierer  = lit_zztransaction-operatorid.
    lr_e1wpb01-belegwaers = 'EUR'.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPB01'.
    lit_idoc_containers-sdata   = lr_e1wpb01.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    APPEND lit_idoc_containers.
    ld_segnum_cab = ld_segnum.

*   Recuperamos todas las posiciones del ticket
    REFRESH lit_zzlineitem.
    SELECT *
      FROM zzlineitem
      INTO TABLE lit_zzlineitem
     WHERE retailstoreid = lit_zztransaction-retailstoreid
       AND businessdaydate = lit_zztransaction-businessdaydate
       AND transactiontypecode = lit_zztransaction-transactiontypecode
       AND workstationid = lit_zztransaction-workstationid
       AND transactionsequencenumber = lit_zztransaction-transactionsequencenumber.

    LOOP AT lit_zzlineitem.
*     Segmento E1WPB02
      CLEAR lr_e1wpb02.
      lr_e1wpb02-vorgangart = 'ZVTA'.
      lr_e1wpb02-qualartnr  = 'ARTN'.
      lr_e1wpb02-artnr      = lit_zzlineitem-itemid.
      IF lit_zzlineitem-retailquantity > 0.
        lr_e1wpb02-vorzeichen = '-'.
      ELSEIF lit_zzlineitem-retailquantity < 0..
        lr_e1wpb02-vorzeichen = '+'.
      ELSE.
        CONTINUE.
      ENDIF.

      IF lit_zzlineitem-retailquantity < 0.
        lit_zzlineitem-retailquantity = lit_zzlineitem-retailquantity * ( -1 ).
      ENDIF.

      lr_e1wpb02-menge    = lit_zzlineitem-retailquantity.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPB02'.
      lit_idoc_containers-sdata   = lr_e1wpb02.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.

      ld_segnum_cab_2 = ld_segnum.

*     Segmento E1WPB03
      CLEAR lr_e1wpb03.
      lr_e1wpb03-kondition = 'PN10'.
*     APRADAS-Inicio-09.01.2019 08:52:14>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      ld_salesamount = lit_zzlineitem-salesamount.

      IF ld_salesamount > 0.
*        lr_e1wpb03-vorzeichen = '+'.
        lr_e1wpb03-kondvalue  = ld_salesamount.
      ELSE.
*        lr_e1wpb03-vorzeichen = '-'.
        lr_e1wpb03-kondvalue  = ld_salesamount * ( -1 ).
      ENDIF.
*     APRADAS-Fin-09.01.2019 08:52:14<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPB03'.
      lit_idoc_containers-sdata   = lr_e1wpb03.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
      APPEND lit_idoc_containers.

*     Segmento E1WPB03 (IVA)
      CLEAR lr_e1wpb03.
      lr_e1wpb03-kondition  = 'ZMWN'.
      ld_salesamountsoloiva = lit_zzlineitem-salesamountsoloiva.
      IF ld_salesamountsoloiva > 0.
        lr_e1wpb03-vorzeichen = '+'.
        lr_e1wpb03-kondvalue  = ld_salesamountsoloiva.
      ELSE.
        lr_e1wpb03-vorzeichen = '+'.
        lr_e1wpb03-kondvalue  = ld_salesamountsoloiva * ( -1 ).
      ENDIF.


      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPB03'.
      lit_idoc_containers-sdata   = lr_e1wpb03.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
      APPEND lit_idoc_containers.

*     >APRADAS-21.06.2022 10:27:00-Inicio
      if sy-uname = 'PEPITO'.
      PERFORM f_calcular_pbfi
        USING
          lit_zzlineitem-itemid
          lit_zzlineitem-salesunitofmeasure
          lit_zzlineitem-retailstoreid
        CHANGING
          ld_kbetr.

      IF ld_kbetr IS NOT INITIAL.
        CLEAR lr_e1wpb03.
        lr_e1wpb03-kondition  = 'PBFI'.
        ld_salesamountsoloiva = ld_kbetr * lit_zzlineitem-retailquantity .
        IF ld_salesamountsoloiva > 0.
          lr_e1wpb03-vorzeichen = '+'.
          lr_e1wpb03-kondvalue  = ld_salesamountsoloiva.
        ELSE.
          lr_e1wpb03-vorzeichen = '+'.
          lr_e1wpb03-kondvalue  = ld_salesamountsoloiva * ( -1 ).
        ENDIF.


        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WPB03'.
        lit_idoc_containers-sdata   = lr_e1wpb03.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab_2.
        APPEND lit_idoc_containers.
      ENDIF.
      endif.
*     <APRADAS-21.06.2022 10:27:00-Fin
* CCOTILLA - INICIO - 21.10.2022 - Metemos un nuevo segmento para pasar la condición ZINT guardada en zzlineitem-units
        CLEAR lr_e1wpb03.
        ld_units = lit_zzlineitem-units.
      IF ld_units IS NOT INITIAL.
        lr_e1wpb03-kondition  = 'ZINT'.

        IF ld_units > 0.
          lr_e1wpb03-vorzeichen = '+'.
          lr_e1wpb03-kondvalue  = ld_units.
        ELSE.
          lr_e1wpb03-vorzeichen = '+'.
          lr_e1wpb03-kondvalue  = ld_units * ( -1 ).
        ENDIF.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WPB03'.
        lit_idoc_containers-sdata   = lr_e1wpb03.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab_2.
        APPEND lit_idoc_containers.
      ENDIF.
* CCOTILLA - FIN - 21.10.2022 - Metemos un nuevo segmento para pasar la condición ZINT guardada en zzlineitem-units
**     APRADAS-Inicio-15.11.2018 14:51:06>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*      REFRESH lit_zzlineitemdisc.
*      select *
*        from zzlineitemdisc
*        into table lit_zzlineitemdisc
*       where RETAILSTOREID = lit_zzlineitem-retailstoreid
*         and BUSINESSDAYDATE = lit_zzlineitem-BUSINESSDAYDATE
*         and TRANSACTIONTYPECODE = lit_zzlineitem-TRANSACTIONTYPECODE
*         and WORKSTATIONID = lit_zzlineitem-WORKSTATIONID
*         and TRANSACTIONSEQUENCENUMBER = lit_zzlineitem-TRANSACTIONSEQUENCENUMBER
*         and RETAILSEQUENCENUMBER = lit_zzlineitem-RETAILSEQUENCENUMBER
*         and ( discounttypecode = '7' or
*               discounttypecode = '7IVA' ).
*
*      clear ld_reductionamount.
*      loop at lit_zzlineitemdisc where discounttypecode = '7'.
*        add lit_zzlineitemdisc-reductionamount to ld_reductionamount.
*      endloop.
*
*      clear ld_reductionamount_iva.
*      loop at lit_zzlineitemdisc where discounttypecode = '7IVA'.
*        add lit_zzlineitemdisc-reductionamount to ld_reductionamount_iva.
*      endloop.
*
**     Segmento E1WPB03 (DESCUENTO 7)
*      CLEAR lr_e1wpb03.
*      lr_e1wpb03-kondition  = 'ZDCV'.
*      if ld_reductionamount > 0.
*        lr_e1wpb03-vorzeichen = '-'.
*        lr_e1wpb03-kondvalue  = ld_reductionamount.
*      else.
*        lr_e1wpb03-vorzeichen = '-'.
*        lr_e1wpb03-kondvalue  = ld_reductionamount * ( -1 ).
*      endif.
*
*
*      ADD 1 TO ld_segnum.
*      lit_idoc_containers-segnam  = 'E1WPB03'.
*      lit_idoc_containers-sdata   = lr_e1wpb03.
*      lit_idoc_containers-docnum  = ld_identifier.
*      lit_idoc_containers-segnum  = ld_segnum.
*      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
*      APPEND lit_idoc_containers.
*
**     Segmento E1WPB03 (DESCUENTO 7IVA)
*      CLEAR lr_e1wpb03.
*      lr_e1wpb03-kondition  = 'ZDCN'.
*      if ld_reductionamount_iva > 0.
*        lr_e1wpb03-vorzeichen = '+'.
*        lr_e1wpb03-kondvalue  = ld_reductionamount_iva.
*      else.
*        lr_e1wpb03-vorzeichen = '+'.
*        lr_e1wpb03-kondvalue  = ld_reductionamount_iva * ( -1 ).
*      endif.
*
*      ADD 1 TO ld_segnum.
*      lit_idoc_containers-segnam  = 'E1WPB03'.
*      lit_idoc_containers-sdata   = lr_e1wpb03.
*      lit_idoc_containers-docnum  = ld_identifier.
*      lit_idoc_containers-segnum  = ld_segnum.
*      lit_idoc_containers-psgnum  = ld_segnum_cab_2.
*      APPEND lit_idoc_containers.
*
**     APRADAS-Fin-15.11.2018 14:51:06<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ENDLOOP.

*   Recuperamos formas de pago del ticket
    REFRESH lit_zztender.

    SELECT *
      FROM zztender
      INTO TABLE lit_zztender
     WHERE retailstoreid = lit_zztransaction-retailstoreid
       AND businessdaydate = lit_zztransaction-businessdaydate
       AND transactiontypecode = lit_zztransaction-transactiontypecode
       AND workstationid = lit_zztransaction-workstationid
       AND transactionsequencenumber = lit_zztransaction-transactionsequencenumber.

    LOOP AT lit_zztender.
*     Para cada forma de pago encontrada...

*     Segmento E1WPB06
      CLEAR lr_e1wpb06.
      lr_e1wpb06-zahlart  = lit_zztender-tendertypecode.
      IF lr_e1wpb06-zahlart = '0030' OR
         lr_e1wpb06-zahlart = '0110' OR "APRADAS-21.02.2021
         lr_e1wpb06-zahlart = '0120'.   "APRADAS-21.02.2021
        lr_e1wpb06-summe    = 0.
      ELSE.
        lr_e1wpb06-summe    = lit_zztender-tenderamount.
      ENDIF.
      lr_e1wpb06-waehrung = 'EUR'.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPB06'.
      lit_idoc_containers-sdata   = lr_e1wpb06.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    ENDLOOP.

*   Añadimos segmentos
    PERFORM f_idoc_add_segmentos TABLES lit_idoc_containers
                                 USING  ld_identifier
                                 CHANGING lf_error.

*   Cerramos IDOC
    PERFORM f_idoc_cerrar USING    ld_identifier
                          CHANGING lr_idoc_control_new
                                   lf_error.

*   Cambiamos STATUS al idoc
    PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                        '64'
                                CHANGING lf_error.

*   Hacemos commit
    COMMIT WORK AND WAIT.

*   Desbloqueamos idoc
    CALL FUNCTION 'DEQUEUE_ALL'
*       EXPORTING
*         _SYNCHRON       = ' '
      .

*   Grabamos primer/ultimo idoc (para procesamiento posterior)
    IF ld_docnum_ini IS INITIAL.
      ld_docnum_ini = lr_idoc_control_new-docnum.
    ELSE.
      ld_docnum_fin = lr_idoc_control_new-docnum.
    ENDIF.

*   Actualizamos los tickets en BBDD asignando el idoc generado a la tarea
    lit_zztransaction-tarea3_docnum = lr_idoc_control_new-docnum.

    MODIFY zztransaction FROM lit_zztransaction.
    COMMIT WORK AND WAIT.

*   APRADAS-Inicio-20.03.2019 15:26:38>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*>>>GENERACIÓN IDOC WPUFIB>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*   Miramos si la tienda es de Baluard
    IF lit_zztransaction-transactiontypecode = 'ZBFC'.
*     Si la tienda es de Baluard, generamos WPUFIB

*     Inicializamos datos del idoc
      CLEAR: lr_idoc_control,
             lr_idoc_control_new,
             ld_identifier,
             ld_segnum,
             ld_segnum_cab,
             lf_error,
             lf_tiene_tarjeta. "APRADAS-04.12.2018

      REFRESH: lit_idoc_containers,
               lit_acumulado_tender.

*     Abrimos IDOC
      PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA2_1'
                                    lit_zztransaction-retailstoreid "APRADAS-21.11.2018
                           CHANGING lr_idoc_control
                                    ld_identifier
                                    lf_error.

*     Acumulamos por forma de pago
      REFRESH lit_zztender.
      SELECT *
        FROM zztender
        INTO TABLE lit_zztender
       WHERE retailstoreid              = lit_zztransaction-retailstoreid
         AND businessdaydate            = lit_zztransaction-businessdaydate
         AND transactiontypecode        = lit_zztransaction-transactiontypecode
         AND workstationid              = lit_zztransaction-workstationid
         AND transactionsequencenumber  = lit_zztransaction-transactionsequencenumber.

      LOOP AT lit_zztender.
*       Acumulamos importe forma de pago
        LOOP AT lit_acumulado_tender WHERE tendertypecode = lit_zztender-tendertypecode.
          ADD lit_zztender-tenderamount TO lit_acumulado_tender-tenderamount.
          MODIFY lit_acumulado_tender.
        ENDLOOP.

        IF sy-subrc <> 0.
*         Si forma de pago no se ha tratado aún, la registramos
          lit_acumulado_tender-tendertypecode = lit_zztender-tendertypecode.
          lit_acumulado_tender-tenderamount   = lit_zztender-tenderamount.
          APPEND lit_acumulado_tender.
        ENDIF.
      ENDLOOP.

*     Segmento E1WPF01
      CLEAR lr_e1wpf01.
      lr_e1wpf01-vorgdatum  = lit_zztransaction-businessdaydate.
      lr_e1wpf01-bonnummer  = 'TARJETAS'.
      lr_e1wpf01-erfasser   = 'AUTOMATICO'.
      lr_e1wpf01-vorgangart = 'ZBCT'.

      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPF01'.
      lit_idoc_containers-sdata   = lr_e1wpf01.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      APPEND lit_idoc_containers.
      ld_segnum_cab = ld_segnum.

*     Segmentos E1WPF02
      CLEAR ld_total_zvta.

*     >APRADAS-15.02.2021 08:27:43-Inicio
      SELECT SINGLE bukrs
        FROM t001k
        INTO ld_bukrs
       WHERE bwkey = lit_zztransaction-retailstoreid.
*     <APRADAS-15.02.2021 08:27:43-Fin

      LOOP AT lit_zretposdm001t03 WHERE burks = ld_bukrs. "APRADAS-15.02.2021
        LOOP AT lit_acumulado_tender WHERE tendertypecode = lit_zretposdm001t03-tendertypecode.
          EXIT.
        ENDLOOP.

        IF sy-subrc <> 0.
          CONTINUE.
        ELSE.
          lf_tiene_tarjeta = 'X'. "APRADAS-04.12.2018
          ld_total_zvta = ld_total_zvta + lit_acumulado_tender-tenderamount.
        ENDIF.

        CLEAR lr_e1wpf02.

        IF lit_acumulado_tender-tenderamount < 0.
          lit_acumulado_tender-tenderamount = lit_acumulado_tender-tenderamount * ( -1 ).

          lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_neg.
          lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_neg.
        ELSE.
          lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_pos.
          lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_pos.
        ENDIF.

        lr_e1wpf02-wrbtr = lit_acumulado_tender-tenderamount.
        lr_e1wpf02-waers = 'EUR'.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WPF02'.
        lit_idoc_containers-sdata   = lr_e1wpf02.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab.
        APPEND lit_idoc_containers.
      ENDLOOP.

      IF ld_total_zvta <> 0.
        READ TABLE lit_zretposdm001t03 WITH KEY tendertypecode = 'ZVTA' burks = ld_bukrs. "APRADAS-15.02.2021

        IF sy-subrc = 0.
          CLEAR lr_e1wpf02.

          IF ld_total_zvta < 0.
            ld_total_zvta = ld_total_zvta * ( -1 ).

            lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_neg.
            lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_neg.
          ELSE.
            lr_e1wpf02-posnr     = lit_zretposdm001t03-posnr_pos.
            lr_e1wpf02-kntobject = lit_zretposdm001t03-kntobject_pos.
          ENDIF.

          lr_e1wpf02-wrbtr = ld_total_zvta.
          lr_e1wpf02-waers = 'EUR'.

          ADD 1 TO ld_segnum.
          lit_idoc_containers-segnam  = 'E1WPF02'.
          lit_idoc_containers-sdata   = lr_e1wpf02.
          lit_idoc_containers-docnum  = ld_identifier.
          lit_idoc_containers-segnum  = ld_segnum.
          lit_idoc_containers-psgnum  = ld_segnum_cab.
          APPEND lit_idoc_containers.
        ENDIF.
      ENDIF.

      IF lf_tiene_tarjeta = 'X'.
*       Añadimos segmentos
        PERFORM f_idoc_add_segmentos TABLES lit_idoc_containers
                                     USING  ld_identifier
                                     CHANGING lf_error.

*       Cerramos IDOC
        PERFORM f_idoc_cerrar USING    ld_identifier
                              CHANGING lr_idoc_control_new
                                       lf_error.

*       Cambiamos STATUS al idoc
        PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                            '64'
                                    CHANGING lf_error.

*       Hacemos commit
        COMMIT WORK AND WAIT.

*       Desbloqueamos idoc
        CALL FUNCTION 'DEQUEUE_ALL'
*           EXPORTING
*             _SYNCHRON       = ' '
          .

*       Grabamos primer/ultimo idoc (para procesamiento posterior)
        IF ld_docnum_ini IS INITIAL.
          ld_docnum_ini = lr_idoc_control_new-docnum.
        ELSE.
          ld_docnum_fin = lr_idoc_control_new-docnum.
        ENDIF.

*       Actualizamos los tickets en BBDD asignando el idoc generado a la tarea
        lit_zztransaction-tarea31_docnum = lr_idoc_control_new-docnum.

        MODIFY zztransaction FROM lit_zztransaction.
        COMMIT WORK AND WAIT.
      ELSE.
*       Si no tiene tarjeta...

        lit_zztransaction-tarea31_docnum = '6666666666'.

        MODIFY zztransaction FROM lit_zztransaction.
        COMMIT WORK AND WAIT.
      ENDIF.
    ELSE.
*     Actualizamos los tickets en BBDD asignando el idoc generado a la tarea
      lit_zztransaction-tarea31_docnum = 'NO_APLICA'.

      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.
    ENDIF.
*   APRADAS-Fin-20.03.2019 15:26:38<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ENDLOOP.

* Si han marcado el flag de procesar directamente los idocs, los procesamos
  IF p_proc = 'X'.
    SUBMIT rbdapp01
      WITH docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
      WITH p_output = space
      AND RETURN.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_T4_FACT_CLI_ESPECIALES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_t4_fact_cli_especiales .
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_zztransaction LIKE zztransaction OCCURS 0 WITH HEADER LINE.

* 1.- Lógica
*==========================================================================
  REFRESH git_posdm_popup_c.

  SELECT *
    FROM zztransaction
    INTO TABLE lit_zztransaction
   WHERE businessdaydate IN s_feci
     AND ( transactiontypecode <> '03V' AND
           transactiontypecode <> '05' ).

  LOOP AT lit_zztransaction.
    MOVE-CORRESPONDING lit_zztransaction TO gr_posdm_popup_c.

    IF lit_zztransaction-tarea1_docnum = ''.
      gr_posdm_popup_c-t1 = gc_minisemaforo_inactivo.
    ELSEIF lit_zztransaction-tarea1_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t1 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t1 = gc_minisemaforo_verde.
    ENDIF.

    IF lit_zztransaction-tarea2_docnum = ''.
      gr_posdm_popup_c-t2 = gc_minisemaforo_inactivo.
    ELSEIF lit_zztransaction-tarea2_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t2 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t2 = gc_minisemaforo_verde.
    ENDIF.

    IF lit_zztransaction-tarea21_docnum = ''.
      gr_posdm_popup_c-t21 = gc_minisemaforo_inactivo.
    ELSEIF lit_zztransaction-tarea21_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t21 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t21 = gc_minisemaforo_verde.
    ENDIF.

    IF lit_zztransaction-tarea3_docnum = ''.
      gr_posdm_popup_c-t3 = gc_minisemaforo_inactivo.
    ELSEIF lit_zztransaction-tarea3_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t3 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t3 = gc_minisemaforo_verde.
    ENDIF.

*   APRADAS-Inicio-20.03.2019 15:49:30>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    IF lit_zztransaction-tarea31_docnum = ''.
      gr_posdm_popup_c-t31 = gc_minisemaforo_inactivo.
    ELSEIF lit_zztransaction-tarea31_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t31 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t31 = gc_minisemaforo_verde.
    ENDIF.
*   APRADAS-Fin-20.03.2019 15:49:30<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    IF lit_zztransaction-tarea4_docnum = ''.
      gr_posdm_popup_c-t4 = gc_minisemaforo_inactivo.
    ELSEIF lit_zztransaction-tarea4_docnum = 'NO_APLICA'.
      gr_posdm_popup_c-t4 = gc_minisemaforo_ambar.
    ELSE.
      gr_posdm_popup_c-t4 = gc_minisemaforo_verde.
    ENDIF.

    SELECT SINGLE status
      FROM zretposdm001t01
      INTO gr_posdm_popup_c-t5
     WHERE businessdaydate = lit_zztransaction-businessdaydate.

    IF sy-subrc <> 0.
      gr_posdm_popup_c-t5 = gc_minisemaforo_inactivo.
    ENDIF.

    gr_posdm_popup_c-horaticket = gr_posdm_popup_c-begindatetimestamp+8(6).
    PERFORM f_get_transactiontypecodet USING gr_posdm_popup_c-transactiontypecode CHANGING gr_posdm_popup_c-transactiontypecodet.

    APPEND gr_posdm_popup_c TO git_posdm_popup_c.
  ENDLOOP.

  SORT git_posdm_popup_c.

  gf_call_t4 = 'X'.
  CALL SCREEN 0200.
  gf_call_t4 = ''.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_STATUS_0200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_status_0200 .
  DATA: lit_excluding LIKE sy-ucomm OCCURS 0.

  IF gf_call_t4 = ''.
    APPEND 'REFACTURAR' TO lit_excluding.

    IF git_posdm_popup_l[] IS INITIAL.
      APPEND 'IMPRIMIR' TO lit_excluding.
    ENDIF.
  ELSE.
    IF git_posdm_popup_l[] IS INITIAL.
      APPEND 'REFACTURAR' TO lit_excluding.
    ELSE.
      IF gr_posdm_popup_c-t4 = gc_minisemaforo_verde.
        APPEND 'REFACTURAR' TO lit_excluding.
      ENDIF.
    ENDIF.

    APPEND 'IMPRIMIR' TO lit_excluding.
  ENDIF.

  SET PF-STATUS 'STATUS_0200' EXCLUDING lit_excluding.
  IF gf_call_t4 = 'X'.
    SET TITLEBAR 'T03'.
  ENDIF.
ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_GET_TRANSACTIONTYPECODET
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GR_POSDM_POPUP_C_TRANSACTIONTY  text
*      <--P_GR_POSDM_POPUP_C_TRANSACTIONTY  text
*----------------------------------------------------------------------*
FORM f_get_transactiontypecodet  USING    pe_tipo
                                 CHANGING ps_tipot.

  CASE pe_tipo.
    WHEN '03V'.
      ps_tipot = 'VENTA'.
    WHEN '03R'.
      ps_tipot = 'DEVOLUCIÓN'.
    WHEN '03A'.
      ps_tipot = 'ANULACIÓN'.
    WHEN '05'.
      ps_tipot = 'TRASPASO'.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_CHECK_ES_IMPORTE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_WA_CELDAS_VALUE  text
*      <--P_LF_ES_IMPORTE  text
*----------------------------------------------------------------------*
FORM f_check_es_importe  USING    pe_importe
                         CHANGING ps_es_importe.
  DATA: ld_value TYPE lvc_value.
  DATA: ld_string_out TYPE string,
        ld_htype      LIKE dd01v-datatype.


  ld_value = pe_importe.

  REPLACE ALL OCCURRENCES OF '.' IN ld_value WITH ''.
  REPLACE ALL OCCURRENCES OF ',' IN ld_value WITH ''.
  REPLACE ALL OCCURRENCES OF '-' IN ld_value WITH ''.

  CALL FUNCTION 'NUMERIC_CHECK'
    EXPORTING
      string_in  = ld_value
    IMPORTING
      string_out = ld_string_out
      htype      = ld_htype.

  IF ld_htype CS 'NUMC'.
    ps_es_importe = 'X'.
  ELSE.
    ps_es_importe = ''.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_REFACTURAR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_refacturar .
* 0.- Declaración de variables
*==========================================================================
  DATA: ld_respuesta(1).

* 1.- Lógica
*==========================================================================

* Validar que todas las lineas del ticket tienen precio de coste unitario
* informado
  LOOP AT git_posdm_popup_l INTO gr_posdm_popup_l WHERE pcoste_unit IS INITIAL.
    EXIT.
  ENDLOOP.

  IF sy-subrc = 0.
*   Error: Para refacturar ticket todas las lineas deben tener PCosteUnit informado.
    MESSAGE e019(zretposdm001) DISPLAY LIKE 'I'.
  ENDIF.

* Validamos que el cliente se haya identificado
  IF gr_posdm_popup_c-partnerid IS INITIAL.
*   Si cliente no identificado, preguntamos por cliente
    CLEAR: zretposdm001s11.

    CALL SCREEN 0400 STARTING AT 10 10.

    IF zretposdm001s11-partnerid IS INITIAL.
*     Info: Acción cancelada
      MESSAGE i021(zretposdm001).

      EXIT.
    ENDIF.
  ENDIF.

* Solicitamos confirmación
  PERFORM f_popup_to_confirm USING TEXT-q01 CHANGING ld_respuesta.

  IF ld_respuesta = '1'.
*   Si usuario confirma, lanzamos proceso de refacturación
    PERFORM f_refacturar_exec.
  ELSE.
*   Info: Acción cancelada
    MESSAGE i021(zretposdm001).
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_USER_COMMAND_0400
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_user_command_0400 .
  DATA: ld_okcode LIKE sy-ucomm.

  ld_okcode = gd_okcode_0400.

  CLEAR: gd_okcode_0400,
         sy-ucomm.

  CASE ld_okcode.
    WHEN 'ACEPTAR'.
      IF zretposdm001s11-partnerid IS INITIAL.
        MESSAGE i020(zretposdm001) DISPLAY LIKE 'E'.
      ELSE.
        LEAVE TO SCREEN 0.
      ENDIF.
    WHEN 'CANCELAR'.
      CLEAR zretposdm001s11.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_REFACTURAR_EXEC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_refacturar_exec .
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_idoc_containers LIKE edidd OCCURS 0 WITH HEADER LINE,

        lr_idoc_control_new LIKE edidc,
        lr_idoc_control     LIKE edidc,
        lr_e1wpb01          LIKE e1wpb01,
        lr_e1wpb02          LIKE e1wpb02,
        lr_e1wpb03          LIKE e1wpb03,
        lr_e1wpb06          LIKE e1wpb06,

        ld_index            LIKE sy-tabix,
        ld_identifier       LIKE edidc-docnum,
        ld_docnum_ini       TYPE edi_docnum,
        ld_docnum_fin       TYPE edi_docnum,
        ld_segnum           TYPE idocdsgnum,
        ld_segnum_cab       TYPE idocdsgnum,
        ld_segnum_cab_2     TYPE idocdsgnum,

        ld_pcoste_total     TYPE verpr,

        lf_error(1).

* 1.- Lógica
*==========================================================================
* Abrimos IDOC
  PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA4'
                                gr_posdm_popup_c-retailstoreid
                       CHANGING lr_idoc_control
                                ld_identifier
                                lf_error.

* Segmento E1WPB01
  CLEAR lr_e1wpb01.
  lr_e1wpb01-poskreis   = 'ZVTA'.
  lr_e1wpb01-kassid     = gr_posdm_popup_c-workstationid.
  lr_e1wpb01-vorgdatum  = gr_posdm_popup_c-businessdaydate.
  lr_e1wpb01-vorgzeit   = gr_posdm_popup_c-begindatetimestamp.
  lr_e1wpb01-bonnummer  = gr_posdm_popup_c-transactionsequencenumber.
  lr_e1wpb01-qualkdnr   = '1'.
  IF gr_posdm_popup_c-partnerid IS NOT INITIAL.
    lr_e1wpb01-kundnr     = gr_posdm_popup_c-partnerid.
  ELSE.
    lr_e1wpb01-kundnr     = zretposdm001s11-partnerid.
  ENDIF.
  lr_e1wpb01-kassierer  = gr_posdm_popup_c-operatorid.
  lr_e1wpb01-belegwaers = 'EUR'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1WPB01'.
  lit_idoc_containers-sdata   = lr_e1wpb01.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  APPEND lit_idoc_containers.
  ld_segnum_cab = ld_segnum.

* Recuperamos todas las posiciones del ticket
  LOOP AT git_posdm_popup_l INTO gr_posdm_popup_l.
*   Segmento E1WPB02
    CLEAR lr_e1wpb02.
    lr_e1wpb02-vorgangart = 'ZVTA'.
    lr_e1wpb02-qualartnr  = 'ARTN'.
    lr_e1wpb02-artnr      = gr_posdm_popup_l-itemid.
    IF gr_posdm_popup_l-retailquantity > 0.
      lr_e1wpb02-vorzeichen = '+'.
    ELSEIF gr_posdm_popup_l-retailquantity < 0..
      lr_e1wpb02-vorzeichen = '-'.
    ELSE.
      CONTINUE.
    ENDIF.

    IF gr_posdm_popup_l-retailquantity < 0.
      gr_posdm_popup_l-retailquantity = gr_posdm_popup_l-retailquantity * ( -1 ).
    ENDIF.

    lr_e1wpb02-menge    = gr_posdm_popup_l-retailquantity.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPB02'.
    lit_idoc_containers-sdata   = lr_e1wpb02.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

    ld_segnum_cab_2 = ld_segnum.

*   Segmento E1WPB03
    CLEAR lr_e1wpb03.
    lr_e1wpb03-kondition = 'PN10'.
    lr_e1wpb03-kondvalue = gr_posdm_popup_l-pcoste.
    ADD gr_posdm_popup_l-pcoste TO ld_pcoste_total.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPB03'.
    lit_idoc_containers-sdata   = lr_e1wpb03.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab_2.
    APPEND lit_idoc_containers.
  ENDLOOP.

* Segmento E1WPB06
  CLEAR lr_e1wpb06.
  lr_e1wpb06-zahlart  = 'ZP11'.
  lr_e1wpb06-summe    = ld_pcoste_total.
  lr_e1wpb06-waehrung = 'EUR'.

  ADD 1 TO ld_segnum.
  lit_idoc_containers-segnam  = 'E1WPB06'.
  lit_idoc_containers-sdata   = lr_e1wpb06.
  lit_idoc_containers-docnum  = ld_identifier.
  lit_idoc_containers-segnum  = ld_segnum.
  lit_idoc_containers-psgnum  = ld_segnum_cab.
  APPEND lit_idoc_containers.

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

* Procesamos idoc
  SUBMIT rbdapp01
    WITH docnum BETWEEN lr_idoc_control_new-docnum AND space
    WITH p_output = space
    AND RETURN.

* Actualizamos tarea 4 en el ticket con el idoc generado
  UPDATE zztransaction
     SET tarea4_docnum = lr_idoc_control_new-docnum
   WHERE retailstoreid              = gr_posdm_popup_c-retailstoreid
     AND businessdaydate            = gr_posdm_popup_c-businessdaydate
     AND transactiontypecode        = gr_posdm_popup_c-transactiontypecode
     AND workstationid              = gr_posdm_popup_c-workstationid
     AND transactionsequencenumber  = gr_posdm_popup_c-transactionsequencenumber.

* Actualizamos identificación del cliente
  IF gr_posdm_popup_c-partnerid IS INITIAL.
    UPDATE zztransaction
       SET partnerid                  = zretposdm001s11-partnerid
     WHERE retailstoreid              = gr_posdm_popup_c-retailstoreid
       AND businessdaydate            = gr_posdm_popup_c-businessdaydate
       AND transactiontypecode        = gr_posdm_popup_c-transactiontypecode
       AND workstationid              = gr_posdm_popup_c-workstationid
       AND transactionsequencenumber  = gr_posdm_popup_c-transactionsequencenumber.
  ENDIF.

* Actualizamos precios de coste en el detalle
  LOOP AT git_posdm_popup_l INTO gr_posdm_popup_l.
    UPDATE zzlineitem
       SET pcoste = gr_posdm_popup_l-pcoste
           pcoste_waers = gr_posdm_popup_l-pcoste_waers
           pcoste_unit  = gr_posdm_popup_l-pcoste_unit
           pcoste_unit_waers = gr_posdm_popup_l-pcoste_unit_waers
     WHERE retailstoreid              = gr_posdm_popup_c-retailstoreid
       AND businessdaydate            = gr_posdm_popup_c-businessdaydate
       AND transactiontypecode        = gr_posdm_popup_c-transactiontypecode
       AND workstationid              = gr_posdm_popup_c-workstationid
       AND transactionsequencenumber  = gr_posdm_popup_c-transactionsequencenumber
       AND retailsequencenumber       = gr_posdm_popup_l-retailsequencenumber.
  ENDLOOP.


* Actualizamos semáforo de la tarea en el monitor
  LOOP AT git_posdm_popup_c INTO gr_posdm_popup_c WHERE retailstoreid              = gr_posdm_popup_c-retailstoreid
                                                    AND businessdaydate            = gr_posdm_popup_c-businessdaydate
                                                    AND transactiontypecode        = gr_posdm_popup_c-transactiontypecode
                                                    AND workstationid              = gr_posdm_popup_c-workstationid
                                                    AND transactionsequencenumber  = gr_posdm_popup_c-transactionsequencenumber.

    gr_posdm_popup_c-t4 = gc_minisemaforo_verde.

    IF gr_posdm_popup_c-partnerid IS INITIAL.
      gr_posdm_popup_c-partnerid = zretposdm001s11-partnerid.
    ENDIF.

    MODIFY git_posdm_popup_c FROM gr_posdm_popup_c.
  ENDLOOP.

  LOOP AT git_posdm_popup_t INTO gr_posdm_popup_t WHERE tarea = 'T4'.
    gr_posdm_popup_t-status = gc_minisemaforo_verde.
    gr_posdm_popup_t-docnum = lr_idoc_control_new-docnum.

    MODIFY git_posdm_popup_t FROM gr_posdm_popup_t.
  ENDLOOP.

* Info: Refacturación realizada.
  MESSAGE i022(zretposdm001).

* Forzamos refresco lineas ticket
  gf_refresh_posdm_popup_l = 'X'.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_IMPRIMIR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_imprimir.
* 0.- Declaración de variables
*==========================================================================
  DATA: pc_outputarams  TYPE sfpoutputparams,
        wg_fp_docparams TYPE sfpdocparams,
        lv_fm_name      TYPE rs38l_fnam,
        lr_result       TYPE sfpjoboutput,
        l_formoutput    TYPE fpformoutput,
        lit_lineas      TYPE zretposdm001s21t,
        wa_lineas       TYPE zretposdm001s21,
        lit_formas_pago TYPE zretposdm001s22t,
        wa_formas_pago  TYPE zretposdm001s22,
        ld_cont_lineas  TYPE int4,
        lr_total        TYPE zretposdm001s23.

* 1.- Lógica
*==========================================================================
  LOOP AT git_posdm_popup_l INTO gr_posdm_popup_l.
    DO gr_posdm_popup_l-retailquantity TIMES.
      wa_lineas-matnrt      = gr_posdm_popup_l-itemidt.
      wa_lineas-salesamount = gr_posdm_popup_l-salesamount / gr_posdm_popup_l-retailquantity.
      wa_lineas-waers       = 'EUR'.

      APPEND wa_lineas TO lit_lineas.

      ADD wa_lineas-salesamount TO lr_total-salesamount.
      lr_total-waers = 'EUR'.
    ENDDO.

    ADD gr_posdm_popup_l-retailquantity TO ld_cont_lineas.
  ENDLOOP.

  WRITE ld_cont_lineas TO lr_total-total LEFT-JUSTIFIED.
  IF ld_cont_lineas = 1.
    CONCATENATE 'Total' lr_total-total 'Article' INTO lr_total-total SEPARATED BY space.
  ELSE.
    CONCATENATE 'Total' lr_total-total 'Articles' INTO lr_total-total SEPARATED BY space.
  ENDIF.

  LOOP AT git_posdm_popup_m INTO gr_posdm_popup_m.
    CLEAR wa_formas_pago.

    SPLIT gr_posdm_popup_m-tendertypecodet AT '-' INTO wa_formas_pago-tendertypecodet wa_formas_pago-tendertypecodet.
    wa_formas_pago-tendertypecodet = wa_formas_pago-tendertypecodet+1.
    wa_formas_pago-tenderamount = gr_posdm_popup_m-tenderamount.
    wa_formas_pago-tendercurrency = gr_posdm_popup_m-tendercurrency.

    APPEND wa_formas_pago TO lit_formas_pago.
  ENDLOOP.

  pc_outputarams-connection = 'ADS'. "Tipo de conexión para ADOBE este campo es fijo
  pc_outputarams-dest = 'PDF'."pe_printer."'LOCAL'. "Formato de Salida. Siempre PDF
  pc_outputarams-preview = 'X'.

  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = pc_outputarams
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = 'ZPOSDM_TICKET_FOR'
    IMPORTING
      e_funcname = lv_fm_name.

  wg_fp_docparams-langu = sy-langu.

  CALL FUNCTION lv_fm_name
    EXPORTING
      /l1bcdwb/docparams = wg_fp_docparams
      pe_total           = lr_total
      it_lineas          = lit_lineas
      it_formas_pago     = lit_formas_pago
*     i_flag_logo        = wg_flag_logo
*     zbukrs             = '1000' " necesario para obtener logo
*     XSTRING_LOGO       = pc_xstring_logo
*     STRING_MIME        = pc_string_mime
*     XSTRING_LOGO2      = pc_xstring_logo2
*     STRING_MIME2       = pc_string_mime2
    IMPORTING
      /1bcdwb/formoutput = l_formoutput
    EXCEPTIONS
      usage_error        = 1
      system_error       = 2
      internal_error     = 3
      OTHERS             = 4.

  CALL FUNCTION 'FP_JOB_CLOSE'
    IMPORTING
      e_result       = lr_result
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ELSE.
*    PERFORM retrieve_pdf_table CHANGING gt_result.
*    CLEAR total_pages.
*    ADD e_result-remaining_pages TO total_pages.
*
*    READ TABLE gt_result INDEX 1 INTO content.
*
*    PERFORM set_outpars.
*    PERFORM send_pdf_to_spool.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_T4_CIERRE_CAJA_AMETLLER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_t4_cierre_caja_ametller .
* 0.- Declaración de variables
*==========================================================================
  DATA: lit_zztransaction     LIKE zztransaction OCCURS 0 WITH HEADER LINE,
        lit_zzlineitem        LIKE zzlineitem    OCCURS 0 WITH HEADER LINE,
        lit_idoc_containers   LIKE edidd OCCURS 0 WITH HEADER LINE,

        lr_idoc_control_new   LIKE edidc,
        lr_idoc_control       LIKE edidc,

        lr_e1wpf01            LIKE e1wpf01,
        lr_e1wpf02            LIKE e1wpf02,

        ld_index              LIKE sy-tabix,
        ld_identifier         LIKE edidc-docnum,
        ld_docnum_ini         TYPE edi_docnum,
        ld_docnum_fin         TYPE edi_docnum,
        ld_segnum             TYPE idocdsgnum,
        ld_segnum_cab         TYPE idocdsgnum,
        ld_segnum_cab_2       TYPE idocdsgnum,
        lf_error(1),
        ld_partnerid          LIKE zztransaction-partnerid,
        ld_name1              LIKE kna1-name1,

        ld_num_art            TYPE int4,
        ld_num_art_tot        TYPE int4,

        lit_zztender          LIKE zztender OCCURS 0 WITH HEADER LINE,
        lit_zztender_2        LIKE zztender OCCURS 0 WITH HEADER LINE,

        ld_salesamountsoloiva TYPE p DECIMALS 2,

        ld_primer_ticket      TYPE zztransactionsequencenumber,
        ld_ultimo_ticket      TYPE zztransactionsequencenumber,
        ld_num_tickets        TYPE int4,
        BEGIN OF lit_posnr OCCURS 0,
          posnr TYPE posposi,
        END OF lit_posnr,

        wa_zretposdm001t03 LIKE zretposdm001t03,
        wa_zposdm001p02    LIKE zposdm001p02,

        ld_bukrs           TYPE bukrs,

        ld_cont_zbva       TYPE int4,
        ld_sum_zbva        LIKE zztender-tenderamount,
        lf_first_zbva,
        ld_index_zbva      LIKE sy-tabix,

        ld_cont_zibe       TYPE int4,
        ld_sum_zibe        LIKE zztender-tenderamount,
        lf_first_zibe,
        ld_index_zibe      LIKE sy-tabix.

  RANGES: lran_tendertypecode FOR zztender-tendertypecode.

* 1.- Lógica
*==========================================================================

*>Seleccionar tickets con Tarea 4 pendiente
  SELECT *
    FROM zztransaction
    INTO TABLE lit_zztransaction
   WHERE businessdaydate IN s_feci
     AND tarea4_docnum = ''.


*>Descartar tickets que no sean cierre de caja y quedarnos solo con los cierres
* de caja
  LOOP AT lit_zztransaction.
*   Para cada ticket..
    ld_index = sy-tabix.

    IF lit_zztransaction-transactiontypecode <> 'ZCCJ' AND
       lit_zztransaction-transactiontypecode <> 'ZBCJ'.
*     Si el tipo de transacción no es de cierre de caja, descartamos ticket

      lit_zztransaction-tarea4_docnum = 'NO_APLICA'.
      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.

      DELETE lit_zztransaction INDEX ld_index.
      CONTINUE.
    ENDIF.
  ENDLOOP.

*>Crear idoc de cierre de caja para cada ticket
  LOOP AT lit_zztransaction.
*   Para cada cierre de caja

*   Inicializamos datos del idoc
    CLEAR: lr_idoc_control,
           ld_identifier,
           ld_segnum,
           ld_segnum_cab,
           lf_error,
           ld_primer_ticket,
           ld_ultimo_ticket,
           ld_num_tickets,
           lit_zztender,
           lit_posnr.

    REFRESH: lit_idoc_containers,
             lit_posnr.

*   Recuperamos formas de pago del cierre de caja
    SELECT *
      FROM zztender
      INTO TABLE lit_zztender
     WHERE retailstoreid = lit_zztransaction-retailstoreid
       AND businessdaydate = lit_zztransaction-businessdaydate
       AND transactiontypecode = lit_zztransaction-transactiontypecode
       AND workstationid = lit_zztransaction-workstationid
       AND transactionsequencenumber = lit_zztransaction-transactionsequencenumber.

*  >APRADAS-29.06.2022 14:09:08-Inicio
*   Miramos cuantos ZBVA hay en el cierre de caja
    CLEAR: ld_cont_zbva,
           ld_sum_zbva,
           lf_first_zbva.

    LOOP AT lit_zztender WHERE tendertypecode = 'ZBVA'.
      ADD 1 TO ld_cont_zbva.

      ld_sum_zbva = ld_sum_zbva + lit_zztender-tenderamount.
    ENDLOOP.

    IF ld_cont_zbva > 1.
*     Si tenemos más de un ZBVA, asignamos la suma de importes al primero y nos cargamos el resto
      LOOP AT lit_zztender WHERE tendertypecode = 'ZBVA'.
        ld_index_zbva = sy-tabix.

        IF lf_first_zbva = ''.
          lf_first_zbva = 'X'.

          lit_zztender-tenderamount = ld_sum_zbva.
          MODIFY lit_zztender INDEX ld_index_zbva.
        ELSE.
          DELETE lit_zztender INDEX ld_index_zbva.
        ENDIF.
      ENDLOOP.
    ENDIF.

*   Miramos cuantos ZIBE hay en el cierre de caja
    CLEAR: ld_cont_zibe,
           ld_sum_zibe,
           lf_first_zibe.

    LOOP AT lit_zztender WHERE tendertypecode = 'ZIBE'.
      ADD 1 TO ld_cont_zibe.

      ld_sum_zibe = ld_sum_zibe + lit_zztender-tenderamount.
    ENDLOOP.

    IF ld_cont_zibe > 1.
*     Si tenemos más de un ZIBE, asignamos la suma de importes al primero y nos cargamos el resto
      LOOP AT lit_zztender WHERE tendertypecode = 'ZIBE'.
        ld_index_zibe = sy-tabix.

        IF lf_first_zibe = ''.
          lf_first_zibe = 'X'.

          lit_zztender-tenderamount = ld_sum_zibe.
          MODIFY lit_zztender INDEX ld_index_zibe.
        ELSE.
          DELETE lit_zztender INDEX ld_index_zibe.
        ENDIF.
      ENDLOOP.
    ENDIF.
*  <APRADAS-29.06.2022 14:09:08-Fin


*   Abrimos IDOC
    PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA4'
                                  lit_zztransaction-retailstoreid
                         CHANGING lr_idoc_control
                                  ld_identifier
                                  lf_error.

*   Segmento E1WPF01
    CLEAR lr_e1wpf01.
    lr_e1wpf01-vorgdatum  = lit_zztransaction-businessdaydate.
    lr_e1wpf01-bonnummer  = lit_zztransaction-transactionsequencenumber.
    lr_e1wpf01-erfasser   = lit_zztransaction-operatorid.
    lr_e1wpf01-vorgangart = lit_zztransaction-transactiontypecode.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPF01'.
    lit_idoc_containers-sdata   = lr_e1wpf01.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    APPEND lit_idoc_containers.
    ld_segnum_cab = ld_segnum.

*   Segmentos E1WPF02
    LOOP AT lit_zztender.
      CLEAR lr_e1wpf02.

*     >APRADAS-15.02.2021 08:28:45-Inicio
      SELECT SINGLE bukrs
        FROM t001k
        INTO ld_bukrs
       WHERE bwkey = lit_zztransaction-retailstoreid.
*     <APRADAS-15.02.2021 08:28:45-Fin

      SELECT SINGLE *
        FROM zretposdm001t03
        INTO wa_zretposdm001t03
       WHERE transcactiontypecode = lit_zztender-transactiontypecode
         AND tendertypecode       = lit_zztender-tendertypecode
         AND burks                = ld_bukrs.


*    >APRADAS-19.07.2021 08:02:16-Inicio
      IF lit_zztender-tendertypecode = 'ZBVA' OR
         lit_zztender-tendertypecode = 'ZFIN' OR
         lit_zztender-tendertypecode = 'ZJO1' OR "CCOTILLA - 20.02.2023 --> añadir ZJO1 como financiera (en lugar de ZFRA)
*        lit_zztender-tendertypecode = 'ZFRA' OR
         lit_zztender-tendertypecode = 'ZFSA' OR
         lit_zztender-tendertypecode = 'ZIBE' OR
         lit_zztender-tendertypecode = '2000' OR
         lit_zztender-tendertypecode = 'ZCET'. "GCX 22.01.2023 Añadimos Cetelem

*     Si el concepto de cierre de caja requiere tiene formas de pago financiadas...

*     >APRADAS-10.09.2021 08:15:29-Inicio
*     Si el concepto viene a 0, lo ignoramos
        IF lit_zztender-tenderamount = 0.
          CONTINUE.
        ENDIF.
*     <APRADAS-10.09.2021 08:15:29-Fin

*       Determinar las formas de pago financiadas a tener en cuenta en función del concepto de cierre de caja
        REFRESH lran_tendertypecode.

        lran_tendertypecode-sign = 'I'.
        lran_tendertypecode-option = 'EQ'.

        CASE lit_zztender-tendertypecode.
          WHEN 'ZBVA'.
            lran_tendertypecode-low = '0040'.
            APPEND lran_tendertypecode.
          WHEN 'ZFIN'.
            lran_tendertypecode-low = '0060'.
            APPEND lran_tendertypecode.
          WHEN 'ZJO1'.
            lran_tendertypecode-low = '0070'.
            APPEND lran_tendertypecode.
*         WHEN 'ZFRA'.
*           lran_tendertypecode-low = '0070'.
*           APPEND lran_tendertypecode.
          WHEN 'ZFSA'.
            lran_tendertypecode-low = '0080'.
            APPEND lran_tendertypecode.
          WHEN 'ZIBE'.
            lran_tendertypecode-low = '0090'.
            APPEND lran_tendertypecode.
          WHEN '2000'.
            lran_tendertypecode-low = '0110'.
            APPEND lran_tendertypecode.

            lran_tendertypecode-low = '0120'.
            APPEND lran_tendertypecode.
*->GCX.ini 22.01.2024 Añadimos Cetelem
          WHEN 'ZCET'.
            lran_tendertypecode-low = '0050'.
            APPEND lran_tendertypecode.
*<-GCX.fin 22.01.2024
        ENDCASE.

*       Determinar ventas realizadas en ese dia en la tienda con formas de pago financiadas
        IF lit_zztender-tendertypecode = '2000'.
*       Si el concepto es 2000, solo tenemos en cuenta los ZANT
          REFRESH lit_zztender_2.
          SELECT *
            FROM zztender
            INTO TABLE lit_zztender_2
           WHERE retailstoreid       = lit_zztransaction-retailstoreid
             AND businessdaydate     = lit_zztransaction-businessdaydate
             AND transactiontypecode = 'ZANT'
             AND workstationid       = lit_zztransaction-workstationid
             AND tendertypecode      IN lran_tendertypecode.
        ELSE.
*         Para el resto de conceptos, tenemos en cuenta los ZVTA, ZVTF y ZANT
          REFRESH lit_zztender_2.
          SELECT *
            FROM zztender
            INTO TABLE lit_zztender_2
           WHERE retailstoreid       = lit_zztransaction-retailstoreid
             AND businessdaydate     = lit_zztransaction-businessdaydate
             AND ( transactiontypecode = 'ZVTA' OR transactiontypecode = 'ZVTF' OR transactiontypecode = 'ZANT' )
             AND workstationid       = lit_zztransaction-workstationid
             AND tendertypecode      IN lran_tendertypecode.
        ENDIF.

*       Restamos al importe del concepto de cierre de caja los importes de las ventas con forma de
*       pago financiadas encontradas
        LOOP AT lit_zztender_2.
          lit_zztender-tenderamount = lit_zztender-tenderamount - lit_zztender_2-tenderamount.
        ENDLOOP.

        IF lit_zztender-tenderamount <> 0.
*         Solo registramos segmentos si hay importe diferente a 0

*         Añadimos segmento para el concepto de cierre de caja (al que le hemos restado los importes de las ventas con forma de pago financiadas)
          IF lit_zztender-tenderamount < 0.
            lit_zztender-tenderamount = lit_zztender-tenderamount * ( -1 ).

            lr_e1wpf02-posnr = wa_zretposdm001t03-posnr_neg.
            lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_neg.
          ELSE.
            lr_e1wpf02-posnr = wa_zretposdm001t03-posnr_pos.
            lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_pos.
          ENDIF.

          DO.
            READ TABLE lit_posnr WITH KEY posnr = lr_e1wpf02-posnr.

            IF sy-subrc <> 0.
              lit_posnr-posnr = lr_e1wpf02-posnr.
              APPEND lit_posnr.
              EXIT.
            ELSE.
              ADD 1 TO lr_e1wpf02-posnr.

              WHILE lr_e1wpf02-posnr(1) = space.
                lr_e1wpf02-posnr =  lr_e1wpf02-posnr+1.
              ENDWHILE.
            ENDIF.
          ENDDO.

*       Obtener información del método de pago
          CLEAR wa_zposdm001p02.
          SELECT SINGLE *
            FROM zposdm001p02
            INTO wa_zposdm001p02
           WHERE tendertypecode = wa_zretposdm001t03-tendertypecode.

*       lr_e1wpf02-ZUONR = lit_zztender-referenceid.
          CONCATENATE wa_zposdm001p02-tendertypecode '-' wa_zposdm001p02-idtransacciont INTO lr_e1wpf02-zuonr SEPARATED BY space.
          lr_e1wpf02-wrbtr = lit_zztender-tenderamount.
          lr_e1wpf02-waers = 'EUR'.

          ADD 1 TO ld_segnum.
          lit_idoc_containers-segnam  = 'E1WPF02'.
          lit_idoc_containers-sdata   = lr_e1wpf02.
          lit_idoc_containers-docnum  = ld_identifier.
          lit_idoc_containers-segnum  = ld_segnum.
          lit_idoc_containers-psgnum  = ld_segnum_cab.
          APPEND lit_idoc_containers.

          ld_segnum_cab = ld_segnum.
        ENDIF.

*       Añadimos formas de pago financiadas
        LOOP AT lit_zztender_2.
          CLEAR lr_e1wpf02.

          IF lit_zztender_2-tenderamount < 0.
            lit_zztender_2-tenderamount = lit_zztender_2-tenderamount * ( -1 ).

            lr_e1wpf02-posnr = wa_zretposdm001t03-posnr_neg.
            lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_neg.
          ELSE.
            lr_e1wpf02-posnr = wa_zretposdm001t03-posnr_pos.
            lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_pos.
          ENDIF.

          DO.
            READ TABLE lit_posnr WITH KEY posnr = lr_e1wpf02-posnr.

            IF sy-subrc <> 0.
              lit_posnr-posnr = lr_e1wpf02-posnr.
              APPEND lit_posnr.
              EXIT.
            ELSE.
              ADD 1 TO lr_e1wpf02-posnr.

              WHILE lr_e1wpf02-posnr(1) = space.
                lr_e1wpf02-posnr =  lr_e1wpf02-posnr+1.
              ENDWHILE.
            ENDIF.
          ENDDO.

*         Obtener cliente del pago financiado
          CLEAR ld_partnerid.

          SELECT SINGLE partnerid
            FROM zztransaction
            INTO ld_partnerid
           WHERE retailstoreid    = lit_zztender_2-retailstoreid
             AND businessdaydate = lit_zztender_2-businessdaydate
             AND transactiontypecode = lit_zztender_2-transactiontypecode
             AND workstationid = lit_zztender_2-workstationid
             AND transactionsequencenumber = lit_zztender_2-transactionsequencenumber.

*       Obtener nombre del cliente
          CLEAR ld_name1.

          SELECT SINGLE name1
            FROM kna1
            INTO ld_name1
           WHERE kunnr = ld_partnerid.

*         Determinar asignación y cuenta
          CASE lit_zztender-tendertypecode.
            WHEN 'ZBVA'.
              CONCATENATE 'ZFSC-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.

              IF ld_bukrs = 'CAN'.
                lr_e1wpf02-kntobject = '5728009284'.
              ENDIF.

              IF ld_bukrs = 'MIRO'.
                lr_e1wpf02-kntobject = '5550000006'.
              ENDIF.

            WHEN 'ZFIN'.
              CONCATENATE 'ZFIN-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
            WHEN 'ZJO1'.
              CONCATENATE 'ZJO1-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
*            WHEN 'ZFRA'.
*              CONCATENATE 'ZFRA-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
            WHEN 'ZFSA'.
              CONCATENATE 'ZFSA-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
            WHEN 'ZIBE'.
              CONCATENATE 'ZINM-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
            WHEN '2000'.
              CASE lit_zztender_2-tendertypecode.
                WHEN '0110'.
                  CONCATENATE 'ZTRA-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
                WHEN '0120'.
                  CONCATENATE 'ZCON-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
              ENDCASE.
*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> APRADAS @ 18.01.2024 06:48:12 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Inicio
            when 'ZCET'.
              CONCATENATE 'ZCET-' ld_partnerid ld_name1 INTO lr_e1wpf02-zuonr.
*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< APRADAS @ 18.01.2024 06:48:12 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Fin
          ENDCASE.

          lr_e1wpf02-wrbtr = lit_zztender_2-tenderamount.
          lr_e1wpf02-waers = 'EUR'.

          ADD 1 TO ld_segnum.
          lit_idoc_containers-segnam  = 'E1WPF02'.
          lit_idoc_containers-sdata   = lr_e1wpf02.
          lit_idoc_containers-docnum  = ld_identifier.
          lit_idoc_containers-segnum  = ld_segnum.
          lit_idoc_containers-psgnum  = ld_segnum_cab.
          APPEND lit_idoc_containers.

          ld_segnum_cab = ld_segnum.
        ENDLOOP.
      ELSE.
*     Si el concepto de cierre de caja requiere no tiene formas de pago financiadas...

*    <APRADAS-19.07.2021 08:02:16-Fin
        IF lit_zztender-tenderamount < 0.
          lit_zztender-tenderamount = lit_zztender-tenderamount * ( -1 ).

          lr_e1wpf02-posnr = wa_zretposdm001t03-posnr_neg.
          lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_neg.
        ELSE.
          lr_e1wpf02-posnr = wa_zretposdm001t03-posnr_pos.
          lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_pos.
        ENDIF.

        DO.
          READ TABLE lit_posnr WITH KEY posnr = lr_e1wpf02-posnr.

          IF sy-subrc <> 0.
            lit_posnr-posnr = lr_e1wpf02-posnr.
            APPEND lit_posnr.
            EXIT.
          ELSE.
            ADD 1 TO lr_e1wpf02-posnr.

            WHILE lr_e1wpf02-posnr(1) = space.
              lr_e1wpf02-posnr =  lr_e1wpf02-posnr+1.
            ENDWHILE.
          ENDIF.
        ENDDO.

*       Obtener información del método de pago
        CLEAR wa_zposdm001p02.
        SELECT SINGLE *
          FROM zposdm001p02
          INTO wa_zposdm001p02
         WHERE tendertypecode = wa_zretposdm001t03-tendertypecode.

*       lr_e1wpf02-ZUONR = lit_zztender-referenceid.
        CONCATENATE wa_zposdm001p02-tendertypecode '-' wa_zposdm001p02-idtransacciont INTO lr_e1wpf02-zuonr SEPARATED BY space.
        lr_e1wpf02-wrbtr = lit_zztender-tenderamount.
        lr_e1wpf02-waers = 'EUR'.

        ADD 1 TO ld_segnum.
        lit_idoc_containers-segnam  = 'E1WPF02'.
        lit_idoc_containers-sdata   = lr_e1wpf02.
        lit_idoc_containers-docnum  = ld_identifier.
        lit_idoc_containers-segnum  = ld_segnum.
        lit_idoc_containers-psgnum  = ld_segnum_cab.
        APPEND lit_idoc_containers.

        ld_segnum_cab = ld_segnum.
      ENDIF.
    ENDLOOP.

*   Añadimos segmentos
    PERFORM f_idoc_add_segmentos TABLES lit_idoc_containers
                                 USING  ld_identifier
                                 CHANGING lf_error.

*   Cerramos IDOC
    PERFORM f_idoc_cerrar USING    ld_identifier
                          CHANGING lr_idoc_control_new
                                   lf_error.

*   Cambiamos STATUS al idoc
    PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                        '64'
                                CHANGING lf_error.

*   Hacemos commit
    COMMIT WORK AND WAIT.

*   Desbloqueamos idoc
    CALL FUNCTION 'DEQUEUE_ALL'
*       EXPORTING
*         _SYNCHRON       = ' '
      .

*   Grabamos primer/ultimo idoc (para procesamiento posterior)
    IF ld_docnum_ini IS INITIAL.
      ld_docnum_ini = lr_idoc_control_new-docnum.
    ELSE.
      ld_docnum_fin = lr_idoc_control_new-docnum.
    ENDIF.


    lit_zztransaction-tarea4_docnum = lr_idoc_control_new-docnum.

    MODIFY zztransaction FROM lit_zztransaction.
    COMMIT WORK AND WAIT.
  ENDLOOP.

* Si han marcado el flag de procesar directamente los idocs, los procesamos
  IF p_proc = 'X'.
    SUBMIT rbdapp01
      WITH docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
      WITH p_output = space
      AND RETURN.
  ENDIF.

  MESSAGE s031(zretposdm001).
ENDFORM.

*===================================================================================================
*& Form f_t6_anticipos_candelsa
*===================================================================================================
* Logica asociada a la tarea de proceso de tickets de anticipos (ZANT) del ZPOSDM
*===================================================================================================
FORM f_t6_anticipos_candelsa .
* 0.- Declaración de variables
*===================================================================================================
  DATA: lit_zztransaction     LIKE zztransaction OCCURS 0 WITH HEADER LINE,
        lit_zzlineitem        LIKE zzlineitem    OCCURS 0 WITH HEADER LINE,
        lit_idoc_containers   LIKE edidd OCCURS 0 WITH HEADER LINE,

        lr_idoc_control_new   LIKE edidc,
        lr_idoc_control       LIKE edidc,

        lr_e1wpf01            LIKE e1wpf01,
        lr_e1wpf02            LIKE e1wpf02,

        ld_index              LIKE sy-tabix,
        ld_identifier         LIKE edidc-docnum,
        ld_docnum_ini         TYPE edi_docnum,
        ld_docnum_fin         TYPE edi_docnum,
        ld_segnum             TYPE idocdsgnum,
        ld_segnum_cab         TYPE idocdsgnum,
        ld_segnum_cab_2       TYPE idocdsgnum,
        lf_error(1),

        ld_num_art            TYPE int4,
        ld_num_art_tot        TYPE int4,

        lit_zztender          LIKE zztender OCCURS 0 WITH HEADER LINE,

        ld_salesamountsoloiva TYPE p DECIMALS 2,

        ld_primer_ticket      TYPE zztransactionsequencenumber,
        ld_ultimo_ticket      TYPE zztransactionsequencenumber,
        ld_num_tickets        TYPE int4,
        BEGIN OF lit_posnr OCCURS 0,
          posnr TYPE posposi,
        END OF lit_posnr,

        wa_zretposdm001t03   LIKE zretposdm001t03,
        lf_negativo_positivo,
        ld_sum_tenderamount  LIKE zztender-tenderamount,
        ld_referenceid       LIKE zztender-referenceid,

        ld_bukrs             TYPE bukrs,

        ld_cont_neg          TYPE int4,
        ld_cont_pos          TYPE int4.

* 1.- Lógica
*===================================================================================================
*>Seleccionar tickets con Tarea 6 pendiente
  SELECT *
    FROM zztransaction
    INTO TABLE lit_zztransaction
   WHERE businessdaydate IN s_feci
     AND tarea6_docnum = ''.

*>Nos quedamos con los tiquets que sean anticipos
  LOOP AT lit_zztransaction.
*   Para cada ticket..
    ld_index = sy-tabix.

    IF lit_zztransaction-transactiontypecode <> 'ZANT'.
*     Si el tipo de transacción no es de anticipo, descartamos entrada
      lit_zztransaction-tarea6_docnum = 'NO_APLICA'.
      MODIFY zztransaction FROM lit_zztransaction.
      COMMIT WORK AND WAIT.

      DELETE lit_zztransaction INDEX ld_index.
      CONTINUE.
    ENDIF.
  ENDLOOP.

*>Crear idoc de anticipo
  LOOP AT lit_zztransaction.
*   Para cada ticket de anticipos...

*   Inicializamos datos del idoc
    CLEAR: lr_idoc_control,
           ld_identifier,
           ld_segnum,
           ld_segnum_cab,
           lf_error,
           ld_primer_ticket,
           ld_ultimo_ticket,
           ld_num_tickets,
           lit_zztender,
           lit_posnr.

    REFRESH: lit_idoc_containers,
             lit_posnr.

*   Recuperamos formas de pago del anticipo
    SELECT *
      FROM zztender
      INTO TABLE lit_zztender
     WHERE retailstoreid = lit_zztransaction-retailstoreid
       AND businessdaydate = lit_zztransaction-businessdaydate
       AND transactiontypecode = lit_zztransaction-transactiontypecode
       AND workstationid = lit_zztransaction-workstationid
       AND transactionsequencenumber = lit_zztransaction-transactionsequencenumber.

*   Acumulamos el importe de todos los anticipos y nos quedamos con la primera referencia informada
    CLEAR: ld_sum_tenderamount,
           ld_referenceid.

    LOOP AT lit_zztender.
      ld_sum_tenderamount = ld_sum_tenderamount + lit_zztender-tenderamount.

      IF lit_zztender-referenceid IS NOT INITIAL AND
         ld_referenceid IS INITIAL.
        ld_referenceid = lit_zztender-referenceid.
      ENDIF.
    ENDLOOP.

*   >APRADAS-20.04.2021 13:45:00-Inicio
    IF ld_sum_tenderamount < 0.
*       Marcamos que el anticipo es negativo
      lf_negativo_positivo = 'N'.

      ld_sum_tenderamount = ld_sum_tenderamount * ( -1 ).
    ELSE.
*       Marcamos que el anticipo es positivo
      lf_negativo_positivo = 'P'.
    ENDIF.
*   <APRADAS-20.04.2021 13:45:00-Fin

*   Obtener configuración del apunte a crear
*   >APRADAS-15.02.2021 08:29:32-Inicio
    SELECT SINGLE bukrs
      FROM t001k
      INTO ld_bukrs
     WHERE bwkey = lit_zztransaction-retailstoreid.
*   <APRADAS-15.02.2021 08:29:32-Fin

*    SELECT SINGLE *
*      FROM zretposdm001t03
*      INTO wa_zretposdm001t03
*     WHERE TRANSCACTIONTYPECODE = lit_zztender-transactiontypecode
*       and burks                = ld_bukrs.

*   Abrimos IDOC
    PERFORM f_idoc_abrir USING    'ZRETPOSDM001_IDOC_TAREA4'
                                  lit_zztransaction-retailstoreid
                         CHANGING lr_idoc_control
                                  ld_identifier
                                  lf_error.

*   Segmento E1WPF01
    CLEAR lr_e1wpf01.
    lr_e1wpf01-vorgdatum  = lit_zztransaction-businessdaydate.
    lr_e1wpf01-bonnummer  = lit_zztransaction-transactionsequencenumber.
    lr_e1wpf01-erfasser   = lit_zztransaction-operatorid.
    lr_e1wpf01-vorgangart = lit_zztransaction-transactiontypecode.

    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPF01'.
    lit_idoc_containers-sdata   = lr_e1wpf01.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    APPEND lit_idoc_containers.
    ld_segnum_cab = ld_segnum.

*===================================================================================================
*   Segmentos E1WPF02 (1) >> Inicio
*===================================================================================================
    CLEAR lr_e1wpf02.
    CLEAR: ld_cont_neg,
           ld_cont_pos.

    LOOP AT lit_zztender. "APRADAS-20.04.2021

*     >APRADAS-20.04.2021 12:24:36-Inicio
      SELECT SINGLE *
        FROM zretposdm001t03
        INTO wa_zretposdm001t03
       WHERE transcactiontypecode = lit_zztender-transactiontypecode
         AND burks                = ld_bukrs
         AND tendertypecode       = lit_zztender-tendertypecode.
*     <APRADAS-20.04.2021 12:24:36-Fin

      wa_zretposdm001t03-posnr_neg = wa_zretposdm001t03-posnr_neg + ld_cont_neg.
      wa_zretposdm001t03-posnr_pos = wa_zretposdm001t03-posnr_pos + ld_cont_pos.

*     if ld_sum_TENDERAMOUNT < 0.       "APRADAS-20.04.2021
      IF lit_zztender-tenderamount < 0. "APRADAS-20.04.2021
*       Si la suma del anticipo es negativo, el numero de posición y cuenta serán las negativas

*       Marcamos que el anticipo es negativo
*        lf_negativo_positivo = 'N'. "APRADAS-20.04.2021

*       Pasamos el valor del anticipo a positivo
*        ld_sum_tenderamount = ld_sum_TENDERAMOUNT * ( -1 ).      "APRADAS-20.04.2021
        lit_zztender-tenderamount = lit_zztender-tenderamount * ( -1 ). "APRADAS-20.04.2021

*       Asignamos al segmento posición y cuenta negativas
        lr_e1wpf02-posnr     = wa_zretposdm001t03-posnr_neg. " + 10. "APRADAS-20.04.2021
        wa_zretposdm001t03-posnr_neg = wa_zretposdm001t03-posnr_neg + 1.                            "APRADAS-10.06.2022
        lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_neg.

        ADD 1 TO ld_cont_neg.
      ELSE.
*       Sino, si la suma del anticipo es positiva...

*       Marcamos que el anticipo es positivo
*        lf_negativo_positivo = 'P'. "APRADAS-20.04.2021

*       Asignamos al segmento posición y cuenta positivas
        lr_e1wpf02-posnr     = wa_zretposdm001t03-posnr_pos.
        wa_zretposdm001t03-posnr_pos = wa_zretposdm001t03-posnr_pos + 1.                            "APRADAS-10.06.2022
        lr_e1wpf02-kntobject = wa_zretposdm001t03-kntobject_pos.

        ADD 1 TO ld_cont_pos.
      ENDIF.

*     Referencia (la primera encontrada de entre los distintos anticipos del ticket)
      lr_e1wpf02-zuonr = lit_zztender-referenceid.

*     Valor del anticipo (suma)
*      lr_e1wpf02-WRBTR = ld_sum_TENDERAMOUNT.        "APRADAS-20.04.2021
      lr_e1wpf02-wrbtr = lit_zztender-tenderamount.   "APRADAS-20.04.2021
      lr_e1wpf02-waers = 'EUR'.

*     Añadir segmento
      ADD 1 TO ld_segnum.
      lit_idoc_containers-segnam  = 'E1WPF02'.
      lit_idoc_containers-sdata   = lr_e1wpf02.
      lit_idoc_containers-docnum  = ld_identifier.
      lit_idoc_containers-segnum  = ld_segnum.
      lit_idoc_containers-psgnum  = ld_segnum_cab.
      APPEND lit_idoc_containers.
    ENDLOOP. "APRADAS-20.04.2021

*---------------------------------------------------------------------------------------------------
*   Segmento E1WPF02 (1) << Fin
*---------------------------------------------------------------------------------------------------

*===================================================================================================
*   Segmento E1WPF02 (2) >> Inicio
*===================================================================================================
    CLEAR lr_e1wpf02.

*   Determinar el numero de posición del apunte
    IF lf_negativo_positivo = 'N'.
*     Si el anticipo era negativo, el numero de posición del apunte contra el cliente será el positivo
*     lr_e1wpf02-posnr     = wa_zretposdm001t03-posnr_pos + 10. "APRADAS-20.04.2021
      lr_e1wpf02-posnr     = '4010'. "APRADAS-21.06.2022
    ELSEIF lf_negativo_positivo = 'P'.
*     Si el anticipo era positivo, el numero de posición del apunte contra el cliente será el negativo
*     lr_e1wpf02-posnr     = wa_zretposdm001t03-posnr_neg.
      lr_e1wpf02-posnr     = '5010'. "APRADAS-21.06.2022
    ENDIF.

*   El objeto de imputación será el código de cliente
    lr_e1wpf02-kntobject = lit_zztransaction-partnerid.

*   Referencia (la primera encontrada de entre los distintos anticipos del ticket)
    lr_e1wpf02-zuonr = ld_referenceid.

*   Valor del anticipo (suma)
    lr_e1wpf02-wrbtr = ld_sum_tenderamount.
    lr_e1wpf02-waers = 'EUR'.

*   Añadir segmento
    ADD 1 TO ld_segnum.
    lit_idoc_containers-segnam  = 'E1WPF02'.
    lit_idoc_containers-sdata   = lr_e1wpf02.
    lit_idoc_containers-docnum  = ld_identifier.
    lit_idoc_containers-segnum  = ld_segnum.
    lit_idoc_containers-psgnum  = ld_segnum_cab.
    APPEND lit_idoc_containers.

*---------------------------------------------------------------------------------------------------
*   Segmento E1WPF02 (2) << Fin
*---------------------------------------------------------------------------------------------------

*   Añadimos segmentos al idoc
    PERFORM f_idoc_add_segmentos TABLES   lit_idoc_containers
                                 USING    ld_identifier
                                 CHANGING lf_error.

*   Cerramos IDOC
    PERFORM f_idoc_cerrar USING    ld_identifier
                          CHANGING lr_idoc_control_new
                                   lf_error.

*   Cambiamos STATUS al idoc
    PERFORM f_idoc_cambiar_status USING lr_idoc_control_new-docnum
                                        '64'
                                CHANGING lf_error.

*   Hacemos commit
    COMMIT WORK AND WAIT.

*   Desbloqueamos idoc
    CALL FUNCTION 'DEQUEUE_ALL'
*       EXPORTING
*         _SYNCHRON       = ' '
      .

*   Grabamos primer/ultimo idoc (para procesamiento posterior)
    IF ld_docnum_ini IS INITIAL.
      ld_docnum_ini = lr_idoc_control_new-docnum.
    ELSE.
      ld_docnum_fin = lr_idoc_control_new-docnum.
    ENDIF.


*   Asignamos idoc a la tarea 6 del ticket en el ZPOSDM
    lit_zztransaction-tarea6_docnum = lr_idoc_control_new-docnum.

*   Actualizamos entrada del ticket en el ZPOSDM
    MODIFY zztransaction FROM lit_zztransaction.
    COMMIT WORK AND WAIT.
  ENDLOOP.

* Si han marcado el flag de procesar directamente los idocs, los procesamos
  IF p_proc = 'X'.
    SUBMIT rbdapp01
      WITH docnum BETWEEN ld_docnum_ini AND ld_docnum_fin
      WITH p_output = space
      AND RETURN.
  ENDIF.

* Msg: Proceso de anticipos finalizado.
  MESSAGE s038(zretposdm001).
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_calcular_pbfi
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_calcular_pbfi USING pe_matnr
                           pe_meins
                           pe_werks
                  CHANGING ps_kbetr.
*===================================================================================================
* 0.- Declaración de variables
*===================================================================================================
  DATA: ld_mtart      LIKE mara-mtart,
        ld_verpr      LIKE mbew-verpr,
        ld_bukrs      LIKE t001k-bukrs,
        ld_lbkum      LIKE mbew-lbkum,
        bdcdata       LIKE bdcdata    OCCURS 0 WITH HEADER LINE,
        bdcdata_2     LIKE bdcdata    OCCURS 0 WITH HEADER LINE,
        bdcdata_3     LIKE bdcdata    OCCURS 0 WITH HEADER LINE,
        messtab       LIKE bdcmsgcoll OCCURS 0 WITH HEADER LINE,
        lf_zretcan005 TYPE char01 VALUE 'X',
        lr_options    LIKE ctu_params,
        xkomv_actual  TYPE STANDARD TABLE OF komv WITH HEADER LINE INITIAL SIZE 50,
        xkomv         TYPE STANDARD TABLE OF komv WITH HEADER LINE INITIAL SIZE 50,
        ld_condicion  TYPE kschl,
        ld_meins      LIKE mara-meins.

*===================================================================================================
* 1.- Lógica
*===================================================================================================
*>Inicializar retorno
  CLEAR ps_kbetr.

*>Determinar tipo de artículo
  SELECT SINGLE mtart
    FROM mara
    INTO ld_mtart
    WHERE matnr = pe_matnr.

*>Determinar unidad de medida en formato externo
  CALL FUNCTION 'CONVERSION_EXIT_CUNIT_OUTPUT'
    EXPORTING
      input          = pe_meins
*     LANGUAGE       = SY-LANGU
    IMPORTING
*     LONG_TEXT      =
      output         = ld_meins
*     SHORT_TEXT     =
    EXCEPTIONS
      unit_not_found = 1
      OTHERS         = 2.
  IF sy-subrc <> 0. ENDIF.

  IF ld_mtart = 'ZMER'.
*   Solo aplicamos la rutina si el tipo de artículo es ZMER

*   Asignar lógica de simulacion PB00
    ld_condicion = 'PB00'.

*   Configuramos el Batch input
    lr_options-nobinpt    = 'X'.
    lr_options-dismode    = 'N'.

*   Obtenemos PMP y Stock valorado del artículo
    SELECT SINGLE verpr
                  lbkum
      FROM mbew
      INTO (ld_verpr,
            ld_lbkum)
      WHERE matnr = pe_matnr
        AND bwkey = pe_werks.

    IF sy-subrc = 0 AND ld_lbkum LE 0.
*     Solo continuamos si el stock valorado es 0 o inferior

*     Confeccionamos batch input para los 3 intentos de simulación:
*       1.- Simulamos considerando que no va a salir la pantalla ATP
*       2.- Simulamos considerando que va a salir la pantalla ATP y tenemos que dar a continuar dos veces
*       3.- Simulamos considerando que va a salir la pantalla ATP y tenemos que dar a continuar una vez

*     Expandimos los tres bloques de la pantalla pedido
      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '=METOGGON1'.  APPEND bdcdata.

      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '=METOGGON2'.  APPEND bdcdata.

      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '=METOGGON3'.  APPEND bdcdata.

      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '=TABHDT8'.    APPEND bdcdata.

      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '=MEDOCTYPE'.  APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO_TOPLINE-BSART'.      bdcdata-fval = 'ZIC'.         APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO_TOPLINE-SUPERFIELD'. bdcdata-fval = 'CD01'.        APPEND bdcdata.

      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '/00'.         APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1222-EKORG'.          bdcdata-fval = 'CAI'.         APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1222-EKGRP'.          bdcdata-fval = '100'.         APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1222-BUKRS'.          bdcdata-fval = 'CAI'.         APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1211-EMATN(01)'.      bdcdata-fval = pe_matnr.    APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1211-NAME1(01)'.      bdcdata-fval = 'C001'.        APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1211-MENGE(01)'.      bdcdata-fval = '1'.           APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1211-MEINS(01)'.      bdcdata-fval = ld_meins.      APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1211-LGOBE(01)'.      bdcdata-fval = '0001'.        APPEND bdcdata.

*     Hasta aqui las 3 simulaciones son identicas, por lo que igualamos
      bdcdata_2[] = bdcdata_3[] = bdcdata[].


*     Para la simulación 2, añadimos la pantalla ATP dandole a continuar dos veces
      CLEAR bdcdata_2.  bdcdata_2-program  = 'SAPLATP4'.        bdcdata_2-dynpro   = '0500'.    bdcdata_2-dynbegin = 'X'. APPEND bdcdata_2.
      CLEAR bdcdata_2.  bdcdata_2-fnam = 'BDC_OKCODE'.          bdcdata_2-fval = 'WEIT'.        APPEND bdcdata_2.

      CLEAR bdcdata_2.  bdcdata_2-program  = 'SAPLATP4'.        bdcdata_2-dynpro   = '0500'.    bdcdata_2-dynbegin = 'X'. APPEND bdcdata_2.
      CLEAR bdcdata_2.  bdcdata_2-fnam = 'BDC_OKCODE'.          bdcdata_2-fval = 'WEIT'.        APPEND bdcdata_2.

*     Para la simulación 3, solo añadimos la pantalla ATP dándole a continuar una vez
      CLEAR bdcdata_3.  bdcdata_3-program  = 'SAPLATP4'.        bdcdata_3-dynpro   = '0500'.    bdcdata_3-dynbegin = 'X'. APPEND bdcdata_3.
      CLEAR bdcdata_3.  bdcdata_3-fnam = 'BDC_OKCODE'.          bdcdata_3-fval = 'WEIT'.        APPEND bdcdata_3.


*     Completamos BI
      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '/00'.         APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'MEPO1211-MENGE(01)'.      bdcdata-fval = '1'.           APPEND bdcdata.

      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '=TABIDT4'.    APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-program  = 'SAPLMEGUI'.           bdcdata-dynpro   = '0014'.    bdcdata-dynbegin = 'X'. APPEND bdcdata.
      CLEAR bdcdata.    bdcdata-fnam = 'BDC_OKCODE'.              bdcdata-fval = '=TABIDT9'.    APPEND bdcdata.

      CLEAR bdcdata_2.  bdcdata_2-program  = 'SAPLMEGUI'.           bdcdata_2-dynpro   = '0014'.    bdcdata_2-dynbegin = 'X'. APPEND bdcdata_2.
      CLEAR bdcdata_2.  bdcdata_2-fnam = 'BDC_OKCODE'.              bdcdata_2-fval = '/00'.         APPEND bdcdata_2.
      CLEAR bdcdata_2.  bdcdata_2-fnam = 'MEPO1211-MENGE(01)'.      bdcdata_2-fval = '1'.           APPEND bdcdata_2.

      CLEAR bdcdata_2.  bdcdata_2-program  = 'SAPLMEGUI'.           bdcdata_2-dynpro   = '0014'.    bdcdata_2-dynbegin = 'X'. APPEND bdcdata_2.
      CLEAR bdcdata_2.  bdcdata_2-fnam = 'BDC_OKCODE'.              bdcdata_2-fval = '=TABIDT4'.    APPEND bdcdata_2.
      CLEAR bdcdata_2.  bdcdata_2-program  = 'SAPLMEGUI'.           bdcdata_2-dynpro   = '0014'.    bdcdata_2-dynbegin = 'X'. APPEND bdcdata_2.
      CLEAR bdcdata_2.  bdcdata_2-fnam = 'BDC_OKCODE'.              bdcdata_2-fval = '=TABIDT9'.    APPEND bdcdata_2.

      CLEAR bdcdata_3.  bdcdata_3-program  = 'SAPLMEGUI'.           bdcdata_3-dynpro   = '0014'.    bdcdata_3-dynbegin = 'X'. APPEND bdcdata_3.
      CLEAR bdcdata_3.  bdcdata_3-fnam = 'BDC_OKCODE'.              bdcdata_3-fval = '/00'.         APPEND bdcdata_3.
      CLEAR bdcdata_3.  bdcdata_3-fnam = 'MEPO1211-MENGE(01)'.      bdcdata_3-fval = '1'.           APPEND bdcdata_3.

      CLEAR bdcdata_3.  bdcdata_3-program  = 'SAPLMEGUI'.           bdcdata_3-dynpro   = '0014'.    bdcdata_3-dynbegin = 'X'. APPEND bdcdata_3.
      CLEAR bdcdata_3.  bdcdata_3-fnam = 'BDC_OKCODE'.              bdcdata_3-fval = '=TABIDT4'.    APPEND bdcdata_3.
      CLEAR bdcdata_3.  bdcdata_3-program  = 'SAPLMEGUI'.           bdcdata_3-dynpro   = '0014'.    bdcdata_3-dynbegin = 'X'. APPEND bdcdata_3.
      CLEAR bdcdata_3.  bdcdata_3-fnam = 'BDC_OKCODE'.              bdcdata_3-fval = '=TABIDT9'.    APPEND bdcdata_3.


*     Lanzamos simulación 1

*     Exportar variables a memoria
      EXPORT ld_condicion  TO MEMORY ID 'ZXKOMV_ZRETCAN005_COND'.
      EXPORT lf_zretcan005 TO MEMORY ID 'ZXKOMV_ZRETCAN005'.

      CALL TRANSACTION 'ME21N' USING bdcdata MESSAGES INTO messtab OPTIONS FROM lr_options.

*     Importar variables de memoria
      IMPORT xkomv_actual FROM MEMORY ID 'ZXKOMV_ACTUAL'.

*     Vaciar variables de memoria
      FREE MEMORY ID 'ZXKOMV_ZRETCAN005_COND'.
      FREE MEMORY ID 'ZXKOMV_ZRETCAN005'.
      FREE MEMORY ID 'ZXKOMV_CONT'.
      FREE MEMORY ID 'ZXKOMV_ACTUAL'.

      IF xkomv_actual[] IS INITIAL.
*       Si ha fallado, Lanzamos simulación 2
        REFRESH messtab.

*       Exportar variables a memoria
        EXPORT ld_condicion  TO MEMORY ID 'ZXKOMV_ZRETCAN005_COND'.
        EXPORT lf_zretcan005 TO MEMORY ID 'ZXKOMV_ZRETCAN005'.

        CALL TRANSACTION 'ME21N' USING bdcdata_2 MESSAGES INTO messtab OPTIONS FROM lr_options.

*       Importar variables de memoria
        IMPORT xkomv_actual FROM MEMORY ID 'ZXKOMV_ACTUAL'.

*       Vaciar variables de memoria
        FREE MEMORY ID 'ZXKOMV_ZRETCAN005_COND'.
        FREE MEMORY ID 'ZXKOMV_ZRETCAN005'.
        FREE MEMORY ID 'ZXKOMV_CONT'.
        FREE MEMORY ID 'ZXKOMV_ACTUAL'.

        IF xkomv_actual[] IS INITIAL.
*         Si ha fallado, Lanzamos simulación 3
          REFRESH messtab.

*         Exportar variables a memoria
          EXPORT ld_condicion  TO MEMORY ID 'ZXKOMV_ZRETCAN005_COND'.
          EXPORT lf_zretcan005 TO MEMORY ID 'ZXKOMV_ZRETCAN005'.

          CALL TRANSACTION 'ME21N' USING bdcdata_3 MESSAGES INTO messtab OPTIONS FROM lr_options.

*         Importar variables de memoria
          IMPORT xkomv_actual FROM MEMORY ID 'ZXKOMV_ACTUAL'.

*         Vaciar variables de memoria
          FREE MEMORY ID 'ZXKOMV_ZRETCAN005_COND'.
          FREE MEMORY ID 'ZXKOMV_ZRETCAN005'.
          FREE MEMORY ID 'ZXKOMV_CONT'.
          FREE MEMORY ID 'ZXKOMV_ACTUAL'.
        ENDIF.
      ENDIF.

*     Calculamos valor
      SELECT SINGLE bukrs
        FROM t001k
        INTO ld_bukrs
       WHERE bwkey = pe_werks.

      IF ld_bukrs = 'CAI'.
        READ TABLE xkomv_actual WITH KEY stunr = '850'.

        IF sy-subrc = 0.
          ps_kbetr = xkomv_actual-kbetr.
*          xkwert = ( komv-kbetr * komp-mglme ) / 1000.
        ENDIF.
      ELSEIF ld_bukrs = 'CAN'.
        READ TABLE xkomv_actual WITH KEY stunr = '350'.

        IF sy-subrc = 0.
          ps_kbetr = ld_verpr + xkomv_actual-kbetr.
*          xkwert = ( xkomv-kbetr * komp-mglme ) / 1000.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
ENDFORM.
