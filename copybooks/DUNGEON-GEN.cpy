*>================================================================
*> COPYBOOK: DUNGEON-GEN.cpy
*> PURPOSE:  Procedural BSP Dungeon Room Generation Structure
*> ================================================================
 01  DUNGEON-GEN-STATE.
     05  DGEN-ROOM-COUNT         PIC 9(03) COMP-5 VALUE 0.
     05  DGEN-MAP-WIDTH          PIC 9(03) COMP-5 VALUE 80.
     05  DGEN-MAP-HEIGHT         PIC 9(03) COMP-5 VALUE 24.
     05  DGEN-ROOMS OCCURS 8 TIMES INDEXED BY DGEN-R-IDX.
         10  DGEN-RX             PIC 9(03) COMP-5 VALUE 0.
         10  DGEN-RY             PIC 9(03) COMP-5 VALUE 0.
         10  DGEN-RW             PIC 9(03) COMP-5 VALUE 0.
         10  DGEN-RH             PIC 9(03) COMP-5 VALUE 0.
