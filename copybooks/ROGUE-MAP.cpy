*>================================================================*
*> ROGUE-MAP.cpy - Dungeon Grid and Procedural Room Definitions
*>================================================================*
 01  DUNGEON-DATA.
     05  DUNGEON-GRID.
         10  GRID-ROW OCCURS 20 TIMES.
             15  GRID-COL OCCURS 60 TIMES PIC X VALUE "#".
     05  FOV-GRID.
         10  FOV-ROW OCCURS 20 TIMES.
             15  FOV-COL OCCURS 60 TIMES PIC X VALUE "U".
                 88  FOV-UNSEEN      VALUE "U".
                 88  FOV-SEEN        VALUE "S".
                 88  FOV-VISIBLE     VALUE "V".

 01  ROOM-TABLE.
     05  ROOM-COUNT              PIC 9(2) COMP-5 VALUE 0.
     05  ROOM-ENTRY OCCURS 5 TIMES.
         10  RM-R1               PIC 9(4) COMP-5.
         10  RM-C1               PIC 9(4) COMP-5.
         10  RM-R2               PIC 9(4) COMP-5.
         10  RM-C2               PIC 9(4) COMP-5.
         10  RM-CENTER-R         PIC 9(4) COMP-5.
         10  RM-CENTER-C         PIC 9(4) COMP-5.
