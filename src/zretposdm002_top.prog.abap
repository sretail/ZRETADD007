*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM002_TOP
*&---------------------------------------------------------------------*
*===================================================================================================
* DICCIONARIO DE DATOS
*===================================================================================================
tables: ZZTRANSACTION.

*===================================================================================================
* CONSTANTES
*===================================================================================================
constants: gc_icono_archivado     type icon_d value '@PO@',
           gc_icono_desarchivado  type icon_d value '@PP@'.

*===================================================================================================
* DEFINICIONES GLOBALES
*===================================================================================================
data: gd_error(1),
      git_listado          like ZRETPOSDM002S01 occurs 0 WITH HEADER LINE,
      git_zztransaction    LIKE zztransaction OCCURS 0 WITH HEADER LINE,
      git_zzlineitem       LIKE zzlineitem OCCURS 0 WITH HEADER LINE,
      git_zzlineitemdisc   LIKE zzlineitemdisc OCCURS 0 WITH HEADER LINE,
      git_zzlineitemdiscex LIKE zzlineitemdiscex OCCURS 0 WITH HEADER LINE,
      git_zztender         LIKE zztender OCCURS 0 WITH HEADER LINE,
      git_ZZCUSTDETAILS    like ZZCUSTDETAILS occurs 0 WITH HEADER LINE,
      git_ZZLINEITEM2WEB    like ZZLINEITEM2WEB occurs 0 WITH HEADER LINE.
