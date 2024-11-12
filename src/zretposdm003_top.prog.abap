*&---------------------------------------------------------------------*
*& Include          ZRETPOSDM003_TOP
*&---------------------------------------------------------------------*
*===================================================================================================
* CONSTANTES
*===================================================================================================
CONSTANTS: gc_semaforo_verde        TYPE icon_d VALUE '@08@',
           gc_semaforo_ambar        TYPE icon_d VALUE '@09@',
           gc_semaforo_rojo         TYPE icon_d VALUE '@0A@',
           gc_semaforo_inactivo     TYPE icon_d VALUE '@EB@',
           gc_minisemaforo_verde    TYPE icon_d VALUE '@5B@',
           gc_minisemaforo_ambar    TYPE icon_d VALUE '@5D@',
           gc_minisemaforo_rojo     TYPE icon_d VALUE '@5C@',
           gc_minisemaforo_inactivo TYPE icon_d VALUE '@BZ@',
           gc_icono_warning         type icon_d value '@1A@',
           gc_icono_detalle         TYPE icon_d VALUE '@FB@',
           gc_icono_papelera        TYPE icon_d VALUE '@11@',
           gc_icono_okay            TYPE icon_d VALUE '@0V@',
           gc_icono_crear           TYPE icon_d VALUE '@0Y@',
           gc_icono_modif           TYPE icon_d VALUE '@0Z@'.

data: git_monitor like ZRETPOSDM003S02 occurs 0 WITH HEADER LINE.
