*>================================================================
*> COPYBOOK: TRAP-TABLE.cpy
*> PURPOSE:  Dungeon Floor Hidden Traps and Hazard Descriptors
*> ================================================================
 01  TRAP-DIRECTORY-STATE.
     05  TRAP-COUNT              PIC 9(04) COMP-5 VALUE 0.
     05  TRAP-ENTRIES OCCURS 16 TIMES INDEXED BY TRAP-IDX.
         10  TRAP-POS-X          PIC 9(03) COMP-5 VALUE 0.
         10  TRAP-POS-Y          PIC 9(03) COMP-5 VALUE 0.
         10  TRAP-TYPE           PIC X(01) VALUE 'S'.
             88  TRAP-IS-SPIKE   VALUE 'S'.
             88  TRAP-IS-POISON  VALUE 'P'.
             88  TRAP-IS-TELEPORT VALUE 'T'.
         10  TRAP-DAMAGE-AMT     PIC 9(04) COMP-5 VALUE 15.
         10  TRAP-IS-SPRUNG      PIC X(01) VALUE 'N'.
