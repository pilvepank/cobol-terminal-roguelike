*>================================================================
*> PROGRAM:  roguelike_status_fx.cbl
*> PURPOSE:  Status Effects Tick-Down & Damage Resolution Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-STATUS-FX.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-I                   PIC 9(02) COMP-5.

 LINKAGE SECTION.
 COPY "STATUS-EFFECTS.cpy".
 01  LS-TOTAL-DOT-DEALT     PIC 9(04) COMP-5.

 PROCEDURE DIVISION USING STATUS-EFFECTS-STATE, LS-TOTAL-DOT-DEALT.
 0000-MAIN.
     MOVE 0 TO LS-TOTAL-DOT-DEALT
     PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > FX-ACTIVE-COUNT
         IF FX-DURATION-TURNS(WS-I) > 0
             ADD FX-DOT-DAMAGE-TICK(WS-I) TO LS-TOTAL-DOT-DEALT
             SUBTRACT 1 FROM FX-DURATION-TURNS(WS-I)
         END-IF
     END-PERFORM
     GOBACK.
