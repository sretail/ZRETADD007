function ZARCHIVFILE_SERVER.
*"----------------------------------------------------------------------
*"*"Interfase local
*"  IMPORTING
*"     VALUE(SOURCEPATH) TYPE  TEXT200
*"     VALUE(TARGETPATH) TYPE  TEXT200 DEFAULT SPACE
*"  EXPORTING
*"     VALUE(LENGTH) LIKE  SAPB-LENGTH
*"  EXCEPTIONS
*"      ERROR_FILE
*"----------------------------------------------------------------------
*{   INSERT         MIDK900077                                        1
  data: begin of int_file occurs 1,
         line(1000)  type x,
        end of int_file.
  data:
        ilength      type p,
        count_table  type p,
        line         like int_file-line,
        bin_filesize type p.

  field-symbols: <f1>.
* Öffnen File auf dem Applikationsserver
  open dataset sourcepath for input
                    in binary mode.
  if sy-subrc <> 0.
    message e414 with sourcepath raising error_file.
  endif.
* read in Information File
  refresh int_file.
  bin_filesize = 0.
  do.
    read dataset sourcepath into int_file length ilength.
    if sy-subrc = 0.
      append int_file.
      bin_filesize = bin_filesize + ilength.
    else.
      if sy-subrc = 8.
* open of file failed
        message e414 with sourcepath raising error_file.
      else.
* end of file reached
        append int_file.
        bin_filesize = bin_filesize + ilength.
        exit.
      endif.
    endif.
  enddo.
* close file on application server
  close dataset sourcepath.
* correct content of last line
  describe table int_file lines count_table.
  if count_table <> 0.
    read table int_file index count_table.
    clear line.
    if ilength > 0.
      assign int_file-line(ilength) to <f1>.
      line = <f1>.
    else.
      clear line.
    endif.
    clear int_file-line.
    int_file-line = line.
    modify int_file index count_table.
  endif.
* transfer to targetfile
* open file on application server
  open dataset targetpath for output
                    in binary mode.
  if sy-subrc <> 0.
    message e415 with targetpath space raising error_file.
  endif.
* correction content of lat line
  describe table int_file lines count_table.
  ilength = bin_filesize mod 1000.
* Length file
  length = bin_filesize.
* write to file
  loop at int_file.
    if sy-tabix <> count_table.
      transfer int_file to targetpath.
    else.
      transfer int_file to targetpath length ilength.
    endif.
    if sy-subrc <> 0.
      message e415 with targetpath space raising error_file.
    endif.
  endloop.
* close file on application server
  close dataset targetpath.
*}   INSERT
endfunction.
