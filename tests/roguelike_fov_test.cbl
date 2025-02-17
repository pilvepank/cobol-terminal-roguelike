*>================================================================
*> PROGRAM:  roguelike_fov_test.cbl
*> PURPOSE:  Unit Test Suite for Roguelike Field of View (FOV)
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-FOV-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "copybooks/FOV-STATE.cpy".
 01  WS-TX                  PIC 9(03) COMP-5 VALUE 12.
 01  WS-TY                  PIC 9(03) COMP-5 VALUE 11.
 01  WS-VIS                 PIC X(01) VALUE 'N'.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE FIELD OF VIEW (FOV) TEST SUITE        "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 10 TO FOV-ORIGIN-X
     MOVE 10 TO FOV-ORIGIN-Y
     MOVE 6 TO FOV-RADIUS
     MOVE 0 TO FOV-VISIBLE-TILES-COUNT
     
     MOVE 12 TO WS-TX
     MOVE 11 TO WS-TY
     CALL "ROGUELIKE-FOV" USING FOV-MAP-STATE, WS-TX, WS-TY, WS-VIS
     IF WS-VIS = 'Y' AND FOV-VISIBLE-TILES-COUNT = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Adjacent Tile In Sight Range [PASS]"
     ELSE
         DISPLAY "TEST 1: Adjacent Tile In Sight Range [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 20 TO WS-TX
     MOVE 25 TO WS-TY
     CALL "ROGUELIKE-FOV" USING FOV-MAP-STATE, WS-TX, WS-TY, WS-VIS
     IF WS-VIS = 'N'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Distant Tile Beyond Radius Hidden [PASS]"
     ELSE
         DISPLAY "TEST 2: Distant Tile Beyond Radius Hidden [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "FOV Tests Run:    " WS-TESTS-RUN
     DISPLAY "FOV Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL FOV TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME FOV TESTS FAILED <<"
     END-IF
     STOP RUN.
