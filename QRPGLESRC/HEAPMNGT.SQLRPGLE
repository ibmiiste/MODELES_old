000100180502      * Two counters are kept:
000200180502      * 1. The current number of array elements
000300180502      * 2. The number of array elements that are allocated for the array
000400180502       dcl-ds arrInfo qualified;
000500180502        pArr pointer inz(*null);
000600180502        numElems int(10) inz(0);
000700180502        numAlloc int(10) inz(0);
000800180502       end-ds;
000900180502       dcl-s arr varchar(20) dim(32767) based(arrinfo.parr);
001000180502       dcl-s i int(10);
001100180502         // Allocate storage for a few array elements
001200180502         // (The number of elements that the array is considered to
001300180502         // actually have remains zero.)
001400180502         arrInfo.numAlloc = 2;
001500180502         arrInfo.pArr = %alloc(arrInfo.numAlloc * %size(arr));
001600180502
001700180502         // Add two elements to the array
001800180502         if arrInfo.numAlloc < arrInfo.numElems + 2;
001900180502           // There is no room for the new elements.
002000180502           // Allocate a few more elements.
002100180502           arrInfo.numAlloc += 10;
002200180502           arrInfo.pArr = %realloc (arrInfo.pArr
002300180502                                  : arrInfo.numAlloc * %size(arr));
002400180502         endif;
002500180502         arrInfo.numElems += 1;
002600180502         arr(arrInfo.numElems) = 'XYZ Electronics';
002700180502         arrInfo.numElems += 1;
002800180502         arr(arrInfo.numElems) = 'ABC Tools';
002900180502
003000180502         // Search the array
003100180502         i = %lookup ('XYZ Electronics' : arr : 1 : arrInfo.numElems);
003200180502         // i = 1
003300180502
003400180502         // Sort the array
003500180502         sorta %subarr(arr : 1 : arrInfo.numElems);
