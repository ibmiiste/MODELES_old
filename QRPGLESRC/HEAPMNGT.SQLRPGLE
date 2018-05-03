      * Two counters are kept:
      * 1. The current number of array elements
      * 2. The number of array elements that are allocated for the array
       dcl-ds arrInfo qualified;
        pArr pointer inz(*null);
        numElems int(10) inz(0);
        numAlloc int(10) inz(0);
       end-ds;
       dcl-s arr varchar(20) dim(32767) based(arrinfo.parr);
       dcl-s i int(10);
         // Allocate storage for a few array elements
         // (The number of elements that the array is considered to
         // actually have remains zero.)
         arrInfo.numAlloc = 2;
         arrInfo.pArr = %alloc(arrInfo.numAlloc * %size(arr));

         // Add two elements to the array
         if arrInfo.numAlloc < arrInfo.numElems + 2;
           // There is no room for the new elements.
           // Allocate a few more elements.
           arrInfo.numAlloc += 10;
           arrInfo.pArr = %realloc (arrInfo.pArr
                                  : arrInfo.numAlloc * %size(arr));
         endif;
         arrInfo.numElems += 1;
         arr(arrInfo.numElems) = 'XYZ Electronics';
         arrInfo.numElems += 1;
         arr(arrInfo.numElems) = 'ABC Tools';

         // Search the array
         i = %lookup ('XYZ Electronics' : arr : 1 : arrInfo.numElems);
         // i = 1

         // Sort the array
         sorta %subarr(arr : 1 : arrInfo.numElems);
