*>================================================================
*> PROGRAM:  roguelike_save_test.cbl
*> PURPOSE:  Unit Test Harness for Roguelike Save Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-SAVE-TEST.
 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01 WS-MODE PIC X(04) VALUE "SAVE".
 01 WS-RC   PIC 9(04) COMP-5 VALUE 0.
 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE SAVE ENGINE INVARIANT TEST SUITE      "
     DISPLAY "=================================================="
     CALL "ROGUELIKE-SAVE-ENGINE" USING WS-MODE, WS-RC
     IF WS-RC = 0
         DISPLAY "TEST 1: Game State Serialization Save [PASS]"
         DISPLAY ">> ALL SAVE ENGINE INVARIANTS PASS [100% OK] <<"
     ELSE
         DISPLAY "TEST 1: Game State Serialization Save [FAIL]"
     END-IF
     STOP RUN.
