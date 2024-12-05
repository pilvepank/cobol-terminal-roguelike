*>================================================================
*> PROGRAM:  roguelike_trap_test.cbl
*> PURPOSE:  Unit Test Suite for Roguelike Hidden Trap Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-TRAP-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "TRAP-TABLE.cpy".
 01  WS-X                   PIC 9(03) COMP-5 VALUE 12.
 01  WS-Y                   PIC 9(03) COMP-5 VALUE 8.
 01  WS-DMG                 PIC 9(04) COMP-5 VALUE 0.
 01  WS-TRIG                PIC X(01) VALUE 'N'.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE DUNGEON TRAP & HAZARD TEST SUITE      "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1 TO TRAP-COUNT
     MOVE 12 TO TRAP-POS-X(1)
     MOVE 8 TO TRAP-POS-Y(1)
     MOVE 'S' TO TRAP-TYPE(1)
     MOVE 25 TO TRAP-DAMAGE-AMT(1)
     MOVE 'N' TO TRAP-IS-SPRUNG(1)
     
     CALL "ROGUELIKE-TRAPS" USING TRAP-DIRECTORY-STATE, WS-X, WS-Y, WS-DMG, WS-TRIG
     IF WS-TRIG = 'Y' AND WS-DMG = 25 AND TRAP-IS-SPRUNG(1) = 'Y'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Step On Hidden Spike Trap Triggers Damage [PASS]"
     ELSE
         DISPLAY "TEST 1: Step On Hidden Spike Trap Triggers Damage [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 0 TO WS-DMG
     MOVE 'N' TO WS-TRIG
     CALL "ROGUELIKE-TRAPS" USING TRAP-DIRECTORY-STATE, WS-X, WS-Y, WS-DMG, WS-TRIG
     IF WS-TRIG = 'N' AND WS-DMG = 0
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Sprung Trap Does Not Fire Twice [PASS]"
     ELSE
         DISPLAY "TEST 2: Sprung Trap Does Not Fire Twice [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Trap Tests Run:    " WS-TESTS-RUN
     DISPLAY "Trap Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL TRAP TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME TRAP TESTS FAILED <<"
     END-IF
     STOP RUN.
