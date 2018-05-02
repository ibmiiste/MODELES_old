000100180502      //=================================================================
000200180502      // Source for module FMTPROCS.  This module does not have a
000300180502      // main procedure, as indicated by the keyword NOMAIN.
000400180502      //=================================================================
000500180502       ctl-opt nomain;
000600180502      //-----------------------------------------------------------------
000700180502      // The prototype must be available to EACH module containing
000800180502      // a prototyped procedure.  The /COPY pulls in the prototype
000900180502      // for FmtAddr.
001000180502      //-----------------------------------------------------------------
001100180502      /COPY QRPGLESRC,FMTPROC_P
001200180502       dcl-proc FmtAddr export;
001300180502       dcl-pi FmtAddr varchar(100);
001400180502        streetNum int(10) const;
001500180502        streetName char(50) const;
001600180502        city char(20) const;
001700180502        state char(15) const;
001800180502        zip packed(5) const;
001900180502       end-pi;
002000180502
002100180502          //--------------------------------------------------------------
002200180502          // STREETNUM, STREETNAME, CITY, STATE, and ZIP are formatted to
002300180502          // look like:
002400180502          //   27 Garbanzo Avenue, Smallville IN 51423
002500180502          //--------------------------------------------------------------
002600180502          return  %char(streetNum) + ' ' + %trimr(streetName)
002700180502                        + ', ' + %trim(city) + ' ' + %trim(state)
002800180502                       + ' ' + %editc(zip : 'X');
002900180502       end-proc;
