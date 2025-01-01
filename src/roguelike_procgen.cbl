*>================================================================
*> PROGRAM:  roguelike_procgen.cbl
*> PURPOSE:  Procedural Room Partitioning & Corridor Carving
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-PROCGEN.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "DUNGEON-GEN.cpy".
 01  LS-NEW-X               PIC 9(03) COMP-5.
 01  LS-NEW-Y               PIC 9(03) COMP-5.
 01  LS-NEW-W               PIC 9(03) COMP-5.
 01  LS-NEW-H               PIC 9(03) COMP-5.
 01  LS-STATUS              PIC X(02).
     88  DGEN-OK            VALUE '00'.
     88  DGEN-OUT-OF-BOUNDS VALUE 'OB'.

 PROCEDURE DIVISION USING DUNGEON-GEN-STATE, LS-NEW-X, LS-NEW-Y, LS-NEW-W, LS-NEW-H, LS-STATUS.
 0000-MAIN.
     IF (LS-NEW-X + LS-NEW-W) < DGEN-MAP-WIDTH AND (LS-NEW-Y + LS-NEW-H) < DGEN-MAP-HEIGHT
         IF DGEN-ROOM-COUNT < 8
             ADD 1 TO DGEN-ROOM-COUNT
             MOVE LS-NEW-X TO DGEN-RX(DGEN-ROOM-COUNT)
             MOVE LS-NEW-Y TO DGEN-RY(DGEN-ROOM-COUNT)
             MOVE LS-NEW-W TO DGEN-RW(DGEN-ROOM-COUNT)
             MOVE LS-NEW-H TO DGEN-RH(DGEN-ROOM-COUNT)
             MOVE '00' TO LS-STATUS
         END-IF
     ELSE
         MOVE 'OB' TO LS-STATUS
     END-IF
     GOBACK.
