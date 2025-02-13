*>================================================================
*> PROGRAM:  roguelike_status_test.cbl
*> PURPOSE:  Unit Test Suite for Roguelike Status FX
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-STATUS-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "STATUS-EFFECTS.cpy".
 01  WS-DOT                 PIC 9(04) COMP-5 VALUE 0.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE STATUS EFFECTS TEST SUITE             "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1 TO FX-ACTIVE-COUNT
     MOVE "POISON  " TO FX-NAME(1)
     MOVE 3 TO FX-DURATION-TURNS(1)
     MOVE 5 TO FX-DOT-DAMAGE-TICK(1)
     
     CALL "ROGUELIKE-STATUS-FX" USING STATUS-EFFECTS-STATE, WS-DOT
     IF WS-DOT = 5 AND FX-DURATION-TURNS(1) = 2
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Turn Tick Applies 5 DoT Damage [PASS]"
     ELSE
         DISPLAY "TEST 1: Turn Tick Applies 5 DoT Damage [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     CALL "ROGUELIKE-STATUS-FX" USING STATUS-EFFECTS-STATE, WS-DOT
     CALL "ROGUELIKE-STATUS-FX" USING STATUS-EFFECTS-STATE, WS-DOT
     CALL "ROGUELIKE-STATUS-FX" USING STATUS-EFFECTS-STATE, WS-DOT
     IF WS-DOT = 0 AND FX-DURATION-TURNS(1) = 0
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Expired Status Deals No Further Damage [PASS]"
     ELSE
         DISPLAY "TEST 2: Expired Status Deals No Further Damage [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Status FX Tests Run:    " WS-TESTS-RUN
     DISPLAY "Status FX Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL STATUS FX TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME STATUS FX TESTS FAILED <<"
     END-IF
     STOP RUN.
