*>================================================================
*> COPYBOOK: FOV-STATE.cpy
*> PURPOSE:  Field of View (FOV) Line of Sight Visibility Matrix
*> ================================================================
 01  FOV-MAP-STATE.
     05  FOV-ORIGIN-X            PIC 9(03) COMP-5 VALUE 10.
     05  FOV-ORIGIN-Y            PIC 9(03) COMP-5 VALUE 10.
     05  FOV-RADIUS              PIC 9(03) COMP-5 VALUE 6.
     05  FOV-VISIBLE-TILES-COUNT PIC 9(04) COMP-5 VALUE 0.
     05  FOV-VISIBLE-POINTS OCCURS 32 TIMES INDEXED BY FOV-IDX.
         10  FOV-PT-X            PIC 9(03) COMP-5 VALUE 0.
         10  FOV-PT-Y            PIC 9(03) COMP-5 VALUE 0.
         10  FOV-LIGHT-INTENSITY PIC 9(02) COMP-5 VALUE 0.
