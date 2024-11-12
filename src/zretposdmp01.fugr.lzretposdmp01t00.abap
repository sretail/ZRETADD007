*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZRETPOSDMP01....................................*
DATA:  BEGIN OF STATUS_ZRETPOSDMP01                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZRETPOSDMP01                  .
CONTROLS: TCTRL_ZRETPOSDMP01
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZRETPOSDMP01                  .
TABLES: ZRETPOSDMP01                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
