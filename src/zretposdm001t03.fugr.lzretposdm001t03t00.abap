*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZRETPOSDM001T03.................................*
DATA:  BEGIN OF STATUS_ZRETPOSDM001T03               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZRETPOSDM001T03               .
CONTROLS: TCTRL_ZRETPOSDM001T03
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZRETPOSDM001T03               .
TABLES: ZRETPOSDM001T03                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
