       ctl-opt dftactgrp(*no);
     h
       dcl-pr SavPFs extpgm('SAVPFS');
        *n char(10) const; // Lib_In
        *n char(10) const; // SavF_In
       end-pr;

       dcl-pi SavPFs;
        Lib_In char(10) const;
        SavF_In char(10) const;
       end-pi;

      *******************************************************
       dcl-pr ChgUsrSpcA extpgm('QUSCUSAT');
        *n char(10); // RtnUsrSpcLib
        *n char(20) const; // QualUsrSpcN
        *n char(1) const options(*varsize); // UsrSpcAttrs
        *n likeds(qusec); // ErrCde
       end-pr;

       dcl-pr CrtUsrSpc extpgm('QUSCRTUS');
        *n char(20) const; // QualUsrSpcN
        *n char(10) const; // XAttr
        *n int(10) const; // IntSize
        *n char(1) const; // IntValue
        *n char(10) const; // PubAut
        *n char(50) const; // TxtDesc
        *n char(10) const options(*nopass); // ReplaceOpt
        *n likeds(qusec) options(*nopass); // ErrCde
        *n char(10) const options(*nopass); // Domain
        *n int(10) const options(*nopass); // TfrSize
        *n char(1) const options(*nopass); // OptSpcAlgn
       end-pr;



       dcl-pr LstObj extpgm('QUSLOBJ');
        *n char(20) const; // QualUsrSpcN
        *n char(8) const; // Format
        *n char(20) const; // QualObjs
        *n char(10) const; // ObjType
        *n likeds(qusec) options(*nopass); // ErrCde
        *n const likeds(quslac) options(*nopass); // AutCtl
        *n const likeds(quslsc) options(*nopass); // SelCtl
        *n const likeds(quslaspc) options(*nopass); // ASPCtl
       end-pr;

       dcl-pr RtvUsrSpcPtr extpgm('QUSPTRUS');
        *n char(20) const; // QualUsrSpcN
        *n pointer; // UsrSpcPtr
        *n likeds(qusec) options(*nopass); // ErrCde
       end-pr;

       dcl-pr SavObjLst extpgm('QSRSAVO');
        *n char(20) const; // QualUsrSpcN
        *n likeds(qusec); // ErrCde
       end-pr;



       dcl-pr SndPgmMsg extpgm('QMHSNDPM');
        *n char(7) const; // MsgID
        *n char(20) const; // QualMsgF
        *n char(256) const options(*varsize); // MsgDta
        *n int(10) const; // LenMsgDta
        *n char(10) const; // MsgType
        *n char(10) const; // CSE
        *n int(10) const; // CSECtr
        *n char(4); // MsgKey
        *n likeds(qusec); // ErrCde
        *n int(10) const options(*nopass); // LenCSE
        *n char(20) const options(*nopass); // CSEQual
        *n int(10) const options(*nopass); // DspWait
        *n char(10) const options(*nopass); // CSEType
        *n int(10) const options(*nopass); // CCSID
       end-pr;
      *******************************************************
       dcl-s ObjLHdrPtr pointer;
       dcl-ds ObjLHdr likeds(qush0100) based(objlhdrptr);

       dcl-s ObjLDtlPtr pointer;
       dcl-ds ObjLDtl likeds(qusl020002) based(objldtlptr);

       dcl-s SavHdrPtr pointer;
       dcl-ds SavHdr likeds(qsrus) based(savhdrptr);

       dcl-s SavRcdPtr pointer;
       dcl-ds SavRcd likeds(qsrr) based(savrcdptr);

       dcl-s ObjHdrPtr pointer;
       dcl-ds ObjHdr qualified based(objhdrptr);
        Nbr int(10);
       end-ds;

       dcl-s ObjEntryPtr pointer;
       dcl-ds ObjEntry qualified based(objentryptr);
        Name char(10);
        Type char(10);
       end-ds;

       dcl-s LibEntryPtr pointer;
       dcl-ds LibEntry qualified based(libentryptr);
        Nbr int(10);
        Library char(10);
       end-ds;

       dcl-s DevEntryPtr pointer;
       dcl-ds DevEntry qualified based(deventryptr);
        Nbr int(10);
        Device char(10);
       end-ds;

       dcl-ds UsrSpcAttrs qualified;
        NbrAttrs int(10) inz(1);
        AutoXtndKey int(10) inz(3);
        LenKeyVal int(10) inz(1);
        AutoXtndYes char(1) inz('1');
       end-ds;

       dcl-ds ErrCde qualified;
        Hdr likeds(qusec);
        MsgDta char(256);
       end-ds;
      *******************************************************
       dcl-s AlignOn int(10) inz(4);
       dcl-s EntriesToSave int(10);
       dcl-s LstObjSpc char(20) inz('PFLIST    QTEMP');
       dcl-s MsgKey char(4);
       dcl-s MsgTxt char(256);
       dcl-s RtnUsrSpcLib char(10);
       dcl-s SavFEntryPtr pointer;
       dcl-s SavFEntry char(20) based(savfentryptr);
       dcl-s SavLFEntryPtr pointer;
       dcl-s SavLFEntry Char(1) based(savlfentryptr);
       dcl-s SavObjSpc char(20) inz('SAVLIST   QTEMP');
       dcl-s X int(10);
      *******************************************************
      /copy qsysinc/qrpglesrc,qsr
      /copy qsysinc/qrpglesrc,qusec
      /copy qsysinc/qrpglesrc,qusgen
      /copy qsysinc/qrpglesrc,quslobj
      *******************************************************
       for X = 1 to ObjLHdr.QUSNbrLE;
           if X = 1;
                  ObjLDtlPtr = ObjLHdrPtr + ObjLHdr.QUSOLD;
                  ObjHdrPtr = SavRcdPtr + %size(SavRcd);
                  ObjHdr.Nbr = 0;
           else;
                  ObjLDtlPtr += ObjLHdr.QUSSEE;
           endif;

           if ObjLDtl.QUSEOA = 'PF';
                  if ObjHdr.Nbr = 0;
                     ObjEntryPtr = ObjHdrPtr + %size(ObjHdr);
                  else;
                     ObjEntryPtr += %size(ObjEntry);
                  endif;

                  ObjEntry.Name = ObjLDtl.QUSObjNU00;
                  ObjEntry.Type = '*FILE';
                  ObjHdr.Nbr += 1;
           endif;
       endfor;

       if ObjHdr.Nbr = 0;
          MsgTxt = 'No PFs found in library';
          SndMsg('*COMP' :'CPF9897'
                     :MsgTxt :%len(%trimr(MsgTxt)));
       else;
          // Set Library Information

          SavRcd.QSRKNbr = 1;
          SavRcd.QSRDL = (%size(ObjHdr) +
                              (%size(ObjEntry) * ObjHdr.Nbr));
          FinishEntry();

          SavObjLst(SavObjSpc :ErrCde);
          if ErrCde.Hdr.QUSBAvl <> 0;
                 MsgTxt = 'Error saving objects: ' +
                           ErrCde.Hdr.QUSEI;
                 SndMsg('*DIAG' :'CPF9897'
                        :MsgTxt :%len(%trimr(MsgTxt)));
                 SndAPIMsg();
          endif;
       endif;

       *inlr = *on;
       return;

       // **    *************************************************
       begsr *inzsr;

         QUSBPrv = 0;
         ErrCde.Hdr.QUSBPrv = %size(ErrCde);

         RtvUsrSpcPtr(LstObjSpc :ObjLHdrPtr :ErrCde);

         select;
           when ErrCde.Hdr.QUSBAvl = 0;
           // All is OK

           when ErrCde.Hdr.QUSEI = 'CPF9801';
           // UsrSpc not found, so create it

             CrtUsrSpc( LstObjSpc :'PFList' :4096
                       :x'00' :'*ALL' :'Used by SavPFs'
                       :'*YES' :QUSEC :'*DEFAULT' :0 :'1');

             RtvUsrSpcPtr(LstObjSpc :ObjLHdrPtr :QUSEC);

           other;
           // Serious problem, so report it

             MsgTxt = 'Error accessing ObjLHdrPtr: ' +
                      ErrCde.Hdr.QUSEI;
             SndMsg( '*DIAG' :'CPF9897'
                    :MsgTxt :%len(%trimr(MsgTxt)));
             SndAPIMsg();
         endsl;

         LstObj(LstObjSpc :'OBJL0200'
                    :('*ALL      ' + Lib_In) :'*FILE' :ErrCde);

         select;
                when ErrCde.Hdr.QUSBAvl <> 0;
                     MsgTxt = 'Error accessing file info: ' +
                              ErrCde.Hdr.QUSEI;
                     SndMsg('*DIAG' :'CPF9897'
                            :MsgTxt :%len(%trimr(MsgTxt)));
                     SndAPIMsg();

                when ObjLHdr.QUSIS = 'P';
                     MsgTxt = 'Only partial file info returned';
                     SndMsg('*DIAG' :'CPF9897'
                            :MsgTxt :%len(%trimr(MsgTxt)));

                when ObjLHdr.QUSNbrLE = 0;
                     MsgTxt = 'No files found in ' + Lib_In;
                     SndMsg('*ESCAPE' :'CPF9897'
                            :MsgTxt :%len(%trimr(MsgTxt)));
         endsl;

         RtvUsrSpcPtr(SavObjSpc :SavHdrPtr :ErrCde);

         select;
                when ErrCde.Hdr.QUSBAvl = 0;
                     // All is OK

                when ErrCde.Hdr.QUSEI = 'CPF9801';
                     // UsrSpc not found, so create it

                     CrtUsrSpc(SavObjSpc :'SaveList' :4096
                               :x'00' :'*ALL' :'Used by SavPFs'
                               :'*YES' :QUSEC :'*DEFAULT' :0 :'1');

                     ChgUsrSpcA(RtnUsrSpcLib :SavObjSpc
                                :UsrSpcAttrs :QUSEC);

                     RtvUsrSpcPtr(SavObjSpc :SavHdrPtr :QUSEC);

                other;
                     // Serious problem, so report it

                     MsgTxt = 'Error accessing SavHdrPtr: ' +
                              ErrCde.Hdr.QUSEI;
                     SndMsg('*DIAG' :'CPF9897'
                            :MsgTxt :%len(%trimr(MsgTxt)));
                     SndAPIMsg();
         endsl;

         FmtSavList();

       endsr;
      *******************************************************
       dcl-proc FmtSavList;
       dcl-pi FmtSavList end-pi;

       SavHdr.QSRNbrR = 0;
       SavRcdPtr = SavHdrPtr + %size(SavHdr);

       // Se    t Library Information

       SavRcd.QSRKNbr = 2;
       SavRcd.QSRDL = %size(LibEntry);
       LibEntryPtr = SavRcdPtr + %size(SavRcd);
       LibEntry.Nbr = 1;
       LibEntry.Library = Lib_In;
       FinishEntry();

       // Se    t Device Information

       SavRcd.QSRKNbr = 3;
       SavRcd.QSRDL = %size(DevEntry);
       DevEntryPtr = SavRcdPtr + %size(SavRcd);
       DevEntry.Nbr = 1;
       DevEntry.Device = '*SAVF';
       FinishEntry();

       // Se    t SavF Information

       SavRcd.QSRKNbr = 4;
       SavRcd.QSRDL = %size(SavFEntry);
       SavFEntryPtr = SavRcdPtr + %size(SavRcd);
       SavFEntry = SavF_In + '*LIBL';
       FinishEntry();

       // Se    t Logical File Information

       SavRcd.QSRKNbr = 18;
       SavRcd.QSRDL = %size(SavLFEntry);
       SavLFEntryPtr = SavRcdPtr + %size(SavRcd);
       SavLFEntry = '0';

       FinishEntry();

       end-proc;
      *******************************************************
       dcl-proc FinishEntry;
       dcl-pi FinishEntry end-pi;
     d
       if %rem(SavRcd.QSRDL :AlignOn) <> 0;
          SavRcd.QSRRL00 = %size(SavRcd) + SavRcd.QSRDL +
                               (AlignOn - %rem(SavRcd.QSRDL :AlignOn));
       else;
          SavRcd.QSRRL00 = %size(SavRcd) + SavRcd.QSRDL;
       endif;

       SavHdr.QSRNbrR += 1;
       SavRcdPtr += SavRcd.QSRRL00;
       end-proc;
      *******************************************************
       dcl-proc SndMsg;
       dcl-pi SndMsg;
        MsgType char(10) const;
        MsgID char(7) const;
        MsgDta char(256) const options(*varsize);
        LenMsgDta int(10) const;
       end-pi;

       SndPgmMsg(MsgID :'QCPFMSG   *LIBL' :MsgDta :LenMsgDta
                     :MsgType :'*PGMBDY' :1 :MsgKey :QUSEC);
       end-proc;

      *******************************************************
       dcl-proc SndAPIMsg;
       dcl-pi SndAPIMsg end-pi;

       dcl-s LenMsgDta int(10);

       select;
         when ErrCde.Hdr.QUSBAvl <= 16;
                  LenMsgDta = 0;
         when ErrCde.Hdr.QUSBAvl > %size(ErrCde);
                  LenMsgDta = %size(ErrCde.MsgDta);
         other;
                  LenMsgDta = ErrCde.Hdr.QUSBAvl - %size(ErrCde.Hdr);
       endsl;

       SndPgmMsg(ErrCde.Hdr.QUSEI :'QCPFMSG   *LIBL'
                     :ErrCde.MsgDta :LenMsgDta
                     :'*ESCAPE' :'*PGMBDY' :1 :MsgKey :QUSEC);
       end-proc;
