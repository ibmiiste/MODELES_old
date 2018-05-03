      //-----------------------------------------------------------------*
      // Prototypes for subprocedures in this module                     *
      //-----------------------------------------------------------------*
      //-----------------------------------------------------------------*
      // Each element in the list contains a pointer to the              *
      // name and a pointer to the next element                          *
      //-----------------------------------------------------------------*
       dcl-ds elem based(elem$);
        name$ pointer;
        next$ pointer;
        name_len uns(5);
       end-ds;
       dcl-s nameVal char(40) based(name$);
       dcl-c elemSize %size(elem);
      //-----------------------------------------------------------------*
      // The first element in the list is in static storage.             *
      // The name field of this element is not set to a value.           *
      //-----------------------------------------------------------------*
       dcl-ds first;
        *n pointer inz(*null);
        *n pointer inz(*null);
        *n uns(5) inz(0);
       end-ds;
      //-----------------------------------------------------------------*
      // This is the pointer to the current element.                     *
      // When elem$ is set to the address of <first>, the list is        *
      // empty.                                                          *
      //-----------------------------------------------------------------*
       dcl-s elem$ pointer inz(%addr(first));
      //-----------------------------------------------------------------*
      // Put 5 elements in the list                                      *
      //-----------------------------------------------------------------*
     C                   DO        5
     C     'Name?'       DSPLY                   name             40
      /FREE
         AddName(name);
       ENDDO;

       //-----------------------------------------------------------------*
       // Display the list and then free it.                              *
       //-----------------------------------------------------------------*
       Display();
       Free();
       *INLR = '1';
       //-----------------------------------------------------------------*
       // S U B P R O C E D U R E S                                       *
       //-----------------------------------------------------------------*
       //-----------------------------------------------------------------*
       // AddName - add a name to the end of the list                     *
       //-----------------------------------------------------------------*
      /END-FREE
       dcl-proc AddName;
       dcl-pi AddName;
        name char(40);
       end-pi;
      //-----------------------------------------------------------------*
      // Allocate a new element for the array, pointed at by the         *
      // 'next' pointer of the current end of the list.                  *
      //                                                                 *
      // Before:                                                         *
      //                                                                 *
      //  .-------------.                                                *
      //  |             |                                                *
      //  | name     *--->abc                                            *
      //  | name_len 3  |                                                *
      //  | next     *-------|||                                         *
      //  |             |                                                *
      //  '-------------'                                                *
      //                                                                 *
      //-----------------------------------------------------------------*
     C                   ALLOC     elemSize      next$
      //-----------------------------------------------------------------*
      //                                                                 *
      // After: Note that the old element is still the current one       *
      //        because elem$ is still pointing to the old element       *
      //                                                                 *
      //  .-------------.               .--------------.                 *
      //  |             |       .------>|              |                 *
      //  | name     *--->abc   |       |              |                 *
      //  | name_len 3  |       |       |              |                 *
      //  | next     *----------'       |              |                 *
      //  |             |               |              |                 *
      //  '-------------'               '--------------'                 *
      //                                                                 *
      // Now set elem$ to point to the new element                       *
      //-----------------------------------------------------------------*
      /FREE
       elem$ = next$;
       //-----------------------------------------------------------------*
       //                                                                 *
       // After: Now the names name$, name_len and next$ refer            *
       //        to storage in the new element                            *
       //                                                                 *
       //  .-------------.               .--------------.                 *
       //  |             |       .------>|              |                 *
       //  |          *--->abc   |       | name      *  |                 *
       //  |          3  |       |       | name_len     |                 *
       //  |          *----------'       | next      *  |                 *
       //  |             |               |              |                 *
       //  '-------------'               '--------------'                 *
       //                                                                 *
       // Now set the values of the new element.                          *
       // The next pointer is set to *NULL to indicate that it is the     *
       // end of the list.                                                *
       //-----------------------------------------------------------------*
       next$ = *NULL;
       //-----------------------------------------------------------------*
       // Save the length of the name (not counting trailing blanks)
       //-----------------------------------------------------------------*
       name_len = %len(%trimr(name));
       //-----------------------------------------------------------------*
       // Storage is allocated for the name and then set to the value of
       // the name.
       //-----------------------------------------------------------------*
      /END-FREE
     C                   ALLOC     name_len      name$
      /FREE
       %SUBST(nameVal:1:name_len) = name;
       //-----------------------------------------------------------------*
       //                                                                 *
       // After:                                                          *
       //                                                                 *
       //  .-------------.               .--------------.                 *
       //  |             |       .------>|              |                 *
       //  |          *--->abc   |       | name      *--->newname         *
       //  |          3  |       |       | name_len  nn |                 *
       //  |          *----------'       | next      *--->|||             *
       //  |             |               |              |                 *
       //  '-------------'               '--------------'                 *
       //-----------------------------------------------------------------*
      /END-FREE
       end-proc;
      //-----------------------------------------------------------------*
      // Display - display the list                                      *
      //-----------------------------------------------------------------*
       dcl-proc Display;
       dcl-s saveElem$ pointer;
       dcl-s dspName char(40);
      //-----------------------------------------------------------------*
      // Save the current elem pointer so the list can be restored after *
      // being displayed and set the list pointer to the beginning of    *
      // the list.                                                       *
      //-----------------------------------------------------------------*
      /FREE
       saveElem$ = elem$;
       elem$ = %ADDR(first);
       //-----------------------------------------------------------------*
       // Loop through the elements of the list until the next pointer is *
       // *NULL                                                           *
       //-----------------------------------------------------------------*
       DOW next$ <> *NULL;
         elem$ = next$;
         dspName = %SUBST(nameVal:1:name_len);
         dsply 'Name: ' ' ' dspName;
       ENDDO;
       //-----------------------------------------------------------------*
       // Restore the list pointer to its former place
       //-----------------------------------------------------------------*
       elem$ = saveElem$;
      /END-FREE
       end-proc;
      //-----------------------------------------------------------------*
      // Free - release the storage used by the list                     *
      //-----------------------------------------------------------------*
       dcl-proc Free;
       dcl-s prv$ pointer;
      //-----------------------------------------------------------------*
      // Loop through the elements of the list until the next pointer is *
      // *NULL, starting from the first real element in the list         *
      //-----------------------------------------------------------------*
      /FREE
       elem$ = %ADDR(first);
       elem$ = next$;
       DOW elem$ <> *NULL;
         //-----------------------------------------------------------------*
         // Free the storage for name                                       *
         //-----------------------------------------------------------------*
         DEALLOC name$;
         //-----------------------------------------------------------------*
         // Save the pointer to current elem$
         //-----------------------------------------------------------------*
         prv$ = elem$;
         //-----------------------------------------------------------------*
         // Advance elem$ to the next element
         //-----------------------------------------------------------------*
         elem$ = next$;

         //-----------------------------------------------------------------*
         // Free the storage for the current element
         //-----------------------------------------------------------------*
         DEALLOC prv$;
       ENDDO;

       //-----------------------------------------------------------------*
       // Ready for a new list:
       //-----------------------------------------------------------------*
       elem$ = %ADDR(first);
      /END-FREE
       end-proc;
