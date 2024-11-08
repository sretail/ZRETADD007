*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZRETPOSDM001T06.................................*
DATA:  BEGIN OF STATUS_ZRETPOSDM001T06               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZRETPOSDM001T06               .
CONTROLS: TCTRL_ZRETPOSDM001T06
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZRETPOSDM001T06               .
TABLES: ZRETPOSDM001T06                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
