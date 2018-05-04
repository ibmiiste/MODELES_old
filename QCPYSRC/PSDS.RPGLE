      /if defined(PSDS_H)
        /eof
      /endif

      /define PSDS_H

      *
      *                            Nom de la procdure
       dcl-ds Psds PSDS;
      *                            code status
        PROCEDURE *PROC;
      *                            code status prcdent
        ERROR *STATUS;
      *                            numro line selon source
        PRV_STATUS zoned(5) pos(16);
      *                            nom routine
        LINE_NUM char(8) pos(21);
      *                            nombre de paramtres reus
        ROUTINE *ROUTINE;
      *                            type d'exception
        PARMS *PARMS;
      *                            numro d'exception
        EXCP_TYPE char(3) pos(40);
      *                            bib du programme
        EXCP_NUM char(4) pos(43);
      *                            donnes d'exception
        PGM_LIB char(10) pos(81);
      *                            ID excpption
        EXCP_DATA char(80) pos(91);
      *                            date (*DATE fmt)
        EXCP_ID char(4) pos(171);
      *                            anne (*YEAR fmt)
        DATE_JOUR char(8) pos(191);
      *                            dernier fichier utilis
        YEAR zoned(2) pos(199);
      *                            infomation erreur fichier
        LAST_FILE char(8) pos(201);
      *                            nom du travail
        FILE_INFO char(35) pos(209);
      *                            nom utilisateur
        JOB_NAME char(10) pos(244);
      *                            numro du travail
        USER char(10) pos(254);
      *                            date du travail  (UDATE fmt)
        JOB_NUM zoned(6) pos(264);
      *                            date lance travail  (UDATE fmt)
        JOB_DATE zoned(6) pos(270);
      *                            heure lance travail (UDATE fmt)
        RUN_DATE zoned(6) pos(276);
      *                            date de cration
        RUN_TIME zoned(6) pos(282);
      *                            heure de cration
        CRT_DATE char(6) pos(288);
      *                            niveau de compilation
        CRT_TIME char(6) pos(294);
      *                            fichier source
        CPL_LEVEL char(4) pos(300);
      *                            bib source
        SRC_FILE char(10) pos(304);
      *                            membre source
        SRC_LIB char(10) pos(314);
      *                            prog procedure is in
        SRC_MBR char(10) pos(324);
      *                            module procedure is in
        PROC_PGM char(10) pos(334);
        PROC_MOD char(10) pos(344);
       end-ds;
