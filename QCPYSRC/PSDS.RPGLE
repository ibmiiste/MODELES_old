      /if defined(PSDS_H)
        /eof
      /endif

      /define PSDS_H

      *
     DPsds            SDS
      *                            Nom de la procdure
     D PROCEDURE         *PROC
      *                            code status
     D ERROR             *STATUS
      *                            code status prcdent
     D PRV_STATUS             16     20S 0
      *                            numro line selon source
     D LINE_NUM               21     28
      *                            nom routine
     D ROUTINE           *ROUTINE
      *                            nombre de paramtres reus
     D PARMS             *PARMS
      *                            type d'exception
     D EXCP_TYPE              40     42
      *                            numro d'exception
     D EXCP_NUM               43     46
      *                            bib du programme
     D PGM_LIB                81     90
      *                            donnes d'exception
     D EXCP_DATA              91    170
      *                            ID excpption
     D EXCP_ID               171    174
      *                            date (*DATE fmt)
     D DATE_JOUR             191    198
      *                            anne (*YEAR fmt)
     D YEAR                  199    200S 0
      *                            dernier fichier utilis
     D LAST_FILE             201    208
      *                            infomation erreur fichier
     D FILE_INFO             209    243
      *                            nom du travail
     D JOB_NAME              244    253
      *                            nom utilisateur
     D USER                  254    263
      *                            numro du travail
     D JOB_NUM               264    269S 0
      *                            date du travail  (UDATE fmt)
     D JOB_DATE              270    275S 0
      *                            date lance travail  (UDATE fmt)
     D RUN_DATE              276    281S 0
      *                            heure lance travail (UDATE fmt)
     D RUN_TIME              282    287S 0
      *                            date de cration
     D CRT_DATE              288    293
      *                            heure de cration
     D CRT_TIME              294    299
      *                            niveau de compilation
     D CPL_LEVEL             300    303
      *                            fichier source
     D SRC_FILE              304    313
      *                            bib source
     D SRC_LIB               314    323
      *                            membre source
     D SRC_MBR               324    333
      *                            prog procedure is in
     D PROC_PGM              334    343
      *                            module procedure is in
     D PROC_MOD              344    353
