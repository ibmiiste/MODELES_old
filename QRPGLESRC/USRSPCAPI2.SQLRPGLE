      //-----------------------------------------------------
      // API error code data structure
      //-----------------------------------------------------
       dcl-ds MyErrCode;
         BytesProv int(10) inz(%size(myerrcode));
         BytesAvail int(10) inz(0);
         MsgID char(7);
         Reserved char(1);
         MessageData char(1000);
       end-ds;

      //-----------------------------------------------------
      // Userspace variable
      //-----------------------------------------------------
      // ---User Space Générique-----------------------------
       dcl-ds UserSpace;
        SpaceName char(10);
        SpaceLib char(10);
       end-ds;

      // Paramètres conception User Space
      // Attribut du User Space
       dcl-s SpaceAttr char(10) inz;
      // Longueur du User Spa
       dcl-s SpaceLen bindec(9) inz(262144);
      // Valeur du User Space
       dcl-s SpaceValue char(1) inz(x'00');
      // Autorisation User Space
       dcl-s SpaceAuth char(10) inz('*USE');
      // Libellé User Space
       dcl-s SpaceText char(50);
      // Remplacement du User Space
       dcl-s SpaceReplc char(10) inz('*YES');
      // Position dans le User Space
       dcl-s StartPosit bindec(9);

      // Longueur dans le User Space
       dcl-s StartLen bindec(9);

      // Paramètres API liste objets
       dcl-s FormatName char(8);

      //--Description d'un composant-------------------------
       dcl-ds Composant; // Composant
        Obj char(10); // Objet
        Lib char(10); // Bibliothèque
       end-ds;
      // Type d'objet
       dcl-s ObjectType char(10) inz('*ALL');

      // Cette DS correspond au format
      // OBJL0100 de l'API QUSLJOB.
       dcl-ds OBJL0100;
         Object_name_used char(10);
         Object_library_name_used char(10);
         Object_type_used char(10);
       End-ds;


     ?**---Entête d'un User Space---------------------------------------------**
       dcl-ds GenHeadDs based(puserspace);
        InputSize int(10) pos(113); // Taille de l'entête
        *n int(10) pos(117); // Offset de l'entête H
        *n int(10) pos(121); // Taille de l'entête H
        ListOffset int(10) pos(125); // Offset des données
        *n int(10) pos(129); // Taille de la liste L
        NumberList int(10) pos(133); // Nombre de données
        EntrySize int(10) pos(137); // Taille des données
       end-ds;

      //-----------------------------------------------------
      // API error code data structure
      //-----------------------------------------------------
       dcl-pr QUsLObj extpgm('QUSLOBJ');
         UserSpace char(20); // Qualified user space object
         Format_name char(8); // Format
         Object_library char(20); // Object and library name
         Object_type char(10); // Object type
      // optional group 1:
         ErrorCode Char(8000) options(*varsize: *nopass);
       end-pr;

      //-----------------------------------------------------
      // Create User Space (QUSCRTUS) API
      //-----------------------------------------------------
       dcl-pr QUSCRTUS extpgm('QUSCRTUS');
         UserSpace char(20) const; // UserSpace
         Attrib char(10) const; // Attrib
         InitSize int(10) const; // InitSize
         InitVal char(1) const; // InitVal
         PubAuth char(10) const; // PubAuth
         Text char(50) const; // Text
      // optional group 1:
         Replace char(10) const options(*nopass); // Replace
         ErrorCode char(8000) options(*varsize: *nopass); // ErrorCode
      // optional group 2:
         Domain char(10) const options(*nopass); // Domain
      // optional group 3:
         XferSizeReq int(10) const options(*nopass); // XferSizeReq
         OptAlign char(1) const options(*nopass); // OptAlign
       end-pr;

      //-----------------------------------------------------
      // Retrieve Pointer to User Space (QUSPTRUS) API
      //-----------------------------------------------------
       dcl-pr QUSPTRUS extpgm('QUSPTRUS');
        UserSpace char(20) const; // UserSpace
        Pointer pointer; // Pointer
        ErrorCode char(8000) options(*varsize: *nopass); // ErrorCode
       end-pr;

      //---Réception d'un User Space------------------------------------------**
       dcl-pr Qusrtvus extpgm('QUSRTVUS');
        UserSpace char(20); // parm
        StartPosit bindec(9); // parm
        StartLen bindec(9); // parm
        GenHeadDs char(2000) options(*varsize); // parm
       end-pr;
      //-----------------------------------------------------
      // Main Procedure modèle API avec USRSPACE
      //-----------------------------------------------------
      //-----------------------------------------------------
      // API error code data structure
      //-----------------------------------------------------
       dcl-pi Modele_API_USRSPC_2 extpgm('USRSPCAPI2');
         P_Nom_Lib char(10); // Library Name
         P_Nom_Objet char(10); // Object Name
         P_Type_Objet char(10); // Object type
       end-pi;

      // Variable locale
       Dcl-s Msg Char(52);
       Dcl-s EntryNo int(10);

      //  Création d'un espace utilisateur pour que l'API
      //  QUSLJOB puisse y déposer ses infos
      //  La taille initiale de l'espace sera de 256Ko (256*1024 octets)
      //  L'API QUSLJOB étendra automatiquement cette limite
      //  si elle a besoin de plus de mémoire.
      //
       SpaceName='OBJLIST';
       SpaceLib='QTEMP';
       SpaceAttr='LIST_OBJ';
       SpaceText='Liste objets';
       QUSCRTUS( UserSpace
                : SpaceAttr
                : SpaceLen
                : SpaceValue
                : SpaceAuth
                : SpaceText
                : SpaceReplc
                : MyErrCode);
        if BytesAvail <> 0;
          Msg = 'QUSCRTUS API a échoué avec un ' +
                'MSGID ' + MsgID;
          dsply Msg;
          *inlr = *on;
          return;
        endif;

      // Liste tous les objets du système.
      // Le résultat ira dans l'espace utilisateur que nous
      // venons de créer
       Obj=p_Nom_Objet;
       Lib=p_Nom_lib;
       ObjectType=p_Type_objet;
       FormatName = 'OBJL0100';
       QUslObj( UserSpace
               :FormatName
               :Composant
               :ObjectType
               :MyErrCode);
       if BytesAvail <> 0;
         Msg = 'QUSLOBJ API a échoué avec un ' +
             'MSGID ' + MsgID;
         dsply '' ' ' Msg;
         *inlr = *on;
         return;
       endif;

      //  Positionne un pointeur sur le début de
      //  l'espace utilisateur.
      //  Dans cet exemple, la zone "Bytes Provided" est
      //  mise à zéro et le programme se plantera avec une
      //  erreur "CPFxxxx" si quelque chose ne va pas:
       BytesProv = 0;

       StartPosit = 1;
       StartLen = 1024;
       QUSPTRUS( UserSpace
                :pUserSpace);
       QUsRtvUs( UserSpace
                :StartPosit
                :StartLen
                :GenHeadDs);
      //---Retrieve user space Detail information--------------
         StartPosit = ListOffset + 1;
         StartLen = EntrySize;

       for EntryNo = 1 to NumberList;
      // à ce niveau, la DS JOBL0100 contient
      // l'une des entrées de la liste.
         QUsRtvUs(UserSpace:StartPosit:StartLen:OBJL0100);
         StartPosit = StartPosit + StartLen;
       endfor;

       Return;
