*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZPOSDM001P01....................................*
DATA:  BEGIN OF STATUS_ZPOSDM001P01                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZPOSDM001P01                  .
CONTROLS: TCTRL_ZPOSDM001P01
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZPOSDM001P01                  .
TABLES: ZPOSDM001P01                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
