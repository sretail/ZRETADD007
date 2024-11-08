*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZPOSDM001P02....................................*
DATA:  BEGIN OF STATUS_ZPOSDM001P02                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZPOSDM001P02                  .
CONTROLS: TCTRL_ZPOSDM001P02
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZPOSDM001P02                  .
TABLES: ZPOSDM001P02                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
