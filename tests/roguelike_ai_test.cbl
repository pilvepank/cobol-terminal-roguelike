*>================================================================
*> PROGRAM:  roguelike_ai_test.cbl
*> PURPOSE:  Test Harness for Dijkstra Monster Pathfinding Scent Map
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-AI-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "copybooks/SCENT-GRID.cpy".
 01  WS-MX                  PIC 9(03) COMP-5 VALUE 13.
 01  WS-MY                  PIC 9(03) COMP-5 VALUE 14.
 01  WS-DIST                PIC 9(04) COMP-5 VALUE 0.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE DIJKSTRA AI SCENT TEST SUITE          "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 10 TO SCENT-TARGET-X
     MOVE 10 TO SCENT-TARGET-Y
     MOVE 13 TO WS-MX
     MOVE 14 TO WS-MY
     CALL "ROGUELIKE-DIJKSTRA" USING SCENT-MAP-BUFFER, WS-MX, WS-MY, WS-DIST
     *> Manhattan distance = |13-10| + |14-10| = 3 + 4 = 7
     IF WS-DIST = 7
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Manhattan Scent Distance Calculation [PASS]"
     ELSE
         DISPLAY "TEST 1: Manhattan Scent Distance Calculation [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "AI Tests Run:    " WS-TESTS-RUN
     DISPLAY "AI Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL DIJKSTRA AI TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME DIJKSTRA AI TESTS FAILED <<"
     END-IF
     STOP RUN.
