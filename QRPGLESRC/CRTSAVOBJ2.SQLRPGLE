**Free
ctl-opt dftactgrp(*no);

dcl-pr SavPFs extpgm('SAVPFS');
  *n char(10) const; // Lib_In
  *n char(10) const; // SavF_In
end-pr;

dcl-pi SavPFs;
  Lib_In char(10) const;
  SavF_In char(10) const;
end-pi;


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

/copy qsysinc/qrpglesrc,qsr
/copy qsysinc/qrpglesrc,qusec
/copy qsysinc/qrpglesrc,qusgen
/copy qsysinc/qrpglesrc,quslobj

// Lecture de la liste des PF stockés dans le User space qui a reçu le résultat
// l'API List Objects QUSLOBJ
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
  // Set Object Information

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

  // Pavé de création de LstObjSpc user space QTEMP/PFLIST utilisé par l'API List Objects
  // QUSLOBJ
  // Vérification que le User space n'existe pas avec l'API Retrieve Pointer to User Space
  // QUSPTRUS
  // S'il n'existe pas, il est créé avec l'API Create User Space (QUSCRTUS)
  // et récupére le pointeur du User space
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

  // Alimentation du User space LstObjSpc user space QTEMP/PFLIST
  // avec l'API List Objects (QUSLOBJ)
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

  // Pavé de création de SavObjSpc user space QTEMP/SAVLIST utilisé par l'API Save Objects
  // List QSRSAVO
  // Vérification que le User space n'existe pas avec l'API Retrieve Pointer to User Space
  // QUSPTRUS
  // S'il n'existe pas, il est créé avec l'API Create User Space (QUSCRTUS)
  // Modification des attributs du User Space avec l'API Change User Space Attributes
  // QUSCUSAT : Il est rendu autoextensible
  // et récupére le pointeur du User space
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

dcl-proc FmtSavList;
  dcl-pi FmtSavList end-pi;

  // Numéro d'enregistrement mis à 0
  // de la DS utilisée par QSRSAVO
  SavHdr.QSRNbrR = 0;
  // Positionnement du pointeur SavRcdPtr qui s'aligne sur la DS Qsrr à partir du pointeur du
  // user space SavHdrPtr du user space QTEMP/SAVLIST
  SavRcdPtr = SavHdrPtr + %size(SavHdr);

  // Set Library Information
  // Le paramètre bibliothèque de l'objet à sauvegarder correspond à la clé 2 dans l'usage de
  // l'API QSRSAVO
  SavRcd.QSRKNbr = 2;
  SavRcd.QSRDL = %size(LibEntry);
  LibEntryPtr = SavRcdPtr + %size(SavRcd);
  LibEntry.Nbr = 1;
  LibEntry.Library = Lib_In;
  FinishEntry();

  // Set Device Information
  // Le paramètre Device récipiendaire de la sauvegarde correspond à la clef 2 dans l'usage de
  // l'API QSRSAVO
  // Ici on paramètre un fichier SAVF
  SavRcd.QSRKNbr = 3;
  SavRcd.QSRDL = %size(DevEntry);
  DevEntryPtr = SavRcdPtr + %size(SavRcd);
  DevEntry.Nbr = 1;
  DevEntry.Device = '*SAVF';
  FinishEntry();

  // Set SavF Information
  // Puisque que le device est un SAVF, la clef 4 permet d'indiquer l'emplacement de la SAVF
  SavRcd.QSRKNbr = 4;
  SavRcd.QSRDL = %size(SavFEntry);
  SavFEntryPtr = SavRcdPtr + %size(SavRcd);
  SavFEntry = SavF_In + '*LIBL';
  FinishEntry();

  // Set Logical File Information
  // Les objets sauvegardés sont des PF. LA clef 18 indique s'il faut sauvegarder les logiques
  // liés au PF
  // La valeur 0 indique qu'il ne faut pas sauvegarder les logiques
  SavRcd.QSRKNbr = 18;
  SavRcd.QSRDL = %size(SavLFEntry);
  SavLFEntryPtr = SavRcdPtr + %size(SavRcd);
  SavLFEntry = '0';

  FinishEntry();

end-proc;

dcl-proc FinishEntry;
  dcl-pi FinishEntry end-pi;

  if %rem(SavRcd.QSRDL :AlignOn) <> 0;
    SavRcd.QSRRL00 = %size(SavRcd) + SavRcd.QSRDL +
                         (AlignOn - %rem(SavRcd.QSRDL :AlignOn));
  else;
    SavRcd.QSRRL00 = %size(SavRcd) + SavRcd.QSRDL;
  endif;

  SavHdr.QSRNbrR += 1;
  SavRcdPtr += SavRcd.QSRRL00;
end-proc;

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
