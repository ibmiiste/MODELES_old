      //=================================================================
      // Source for module FMTPROCS.  This module does not have a
      // main procedure, as indicated by the keyword NOMAIN.
      //=================================================================
       ctl-opt nomain;
      //-----------------------------------------------------------------
      // The prototype must be available to EACH module containing
      // a prototyped procedure.  The /COPY pulls in the prototype
      // for FmtAddr.
      //-----------------------------------------------------------------
      /COPY QRPGLESRC,FMTPROC_P
       dcl-proc FmtAddr export;
       dcl-pi FmtAddr varchar(100);
        streetNum int(10) const;
        streetName char(50) const;
        city char(20) const;
        state char(15) const;
        zip packed(5) const;
       end-pi;

          //--------------------------------------------------------------
          // STREETNUM, STREETNAME, CITY, STATE, and ZIP are formatted to
          // look like:
          //   27 Garbanzo Avenue, Smallville IN 51423
          //--------------------------------------------------------------
          return  %char(streetNum) + ' ' + %trimr(streetName)
                        + ', ' + %trim(city) + ' ' + %trim(state)
                       + ' ' + %editc(zip : 'X');
       end-proc;
