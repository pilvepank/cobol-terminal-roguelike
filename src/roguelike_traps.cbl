*>================================================================
*> PROGRAM:  roguelike_traps.cbl
*> PURPOSE:  Dungeon Hidden Trap Detection & Hazard Activation Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-TRAPS.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-I                   PIC 9(04) COMP-5.

 LINKAGE SECTION.
 COPY "TRAP-TABLE.cpy".
 01  LS-STEP-X              PIC 9(03) COMP-5.
 01  LS-STEP-Y              PIC 9(03) COMP-5.
 01  LS-DAMAGE-DEALT        PIC 9(04) COMP-5.
 01  LS-TRIGGERED-FLAG      PIC X(01).

 PROCEDURE DIVISION USING TRAP-DIRECTORY-STATE, LS-STEP-X, LS-STEP-Y, LS-DAMAGE-DEALT, LS-TRIGGERED-FLAG.
 0000-MAIN.
     MOVE 0 TO LS-DAMAGE-DEALT
     MOVE 'N' TO LS-TRIGGERED-FLAG
     PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > TRAP-COUNT
         IF TRAP-POS-X(WS-I) = LS-STEP-X AND TRAP-POS-Y(WS-I) = LS-STEP-Y
             IF TRAP-IS-SPRUNG(WS-I) = 'N'
                 MOVE 'Y' TO TRAP-IS-SPRUNG(WS-I)
                 MOVE TRAP-DAMAGE-AMT(WS-I) TO LS-DAMAGE-DEALT
                 MOVE 'Y' TO LS-TRIGGERED-FLAG
             END-IF
         END-IF
     END-PERFORM
     GOBACK.
