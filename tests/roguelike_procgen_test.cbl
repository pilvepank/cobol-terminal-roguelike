*>================================================================
*> PROGRAM:  roguelike_procgen_test.cbl
*> PURPOSE:  Unit Test Suite for Dungeon Procedural Generator
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-PROCGEN-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "DUNGEON-GEN.cpy".
 01  WS-RX                  PIC 9(03) COMP-5 VALUE 5.
 01  WS-RY                  PIC 9(03) COMP-5 VALUE 5.
 01  WS-RW                  PIC 9(03) COMP-5 VALUE 10.
 01  WS-RH                  PIC 9(03) COMP-5 VALUE 6.
 01  WS-STAT                PIC X(02) VALUE '  '.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE PROCEDURAL DUNGEON GENERATOR SUITE    "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 0 TO DGEN-ROOM-COUNT
     MOVE 80 TO DGEN-MAP-WIDTH
     MOVE 24 TO DGEN-MAP-HEIGHT
     
     MOVE 5 TO WS-RX
     MOVE 5 TO WS-RY
     MOVE 10 TO WS-RW
     MOVE 6 TO WS-RH
     CALL "ROGUELIKE-PROCGEN" USING DUNGEON-GEN-STATE, WS-RX, WS-RY, WS-RW, WS-RH, WS-STAT
     IF WS-STAT = '00' AND DGEN-ROOM-COUNT = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Valid Room Carved Within Bounds [PASS]"
     ELSE
         DISPLAY "TEST 1: Valid Room Carved Within Bounds [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 75 TO WS-RX
     MOVE 20 TO WS-RY
     MOVE 15 TO WS-RW
     MOVE 10 TO WS-RH
     CALL "ROGUELIKE-PROCGEN" USING DUNGEON-GEN-STATE, WS-RX, WS-RY, WS-RW, WS-RH, WS-STAT
     IF WS-STAT = 'OB'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Room Exceeding Map Dimensions Rejected [PASS]"
     ELSE
         DISPLAY "TEST 2: Room Exceeding Map Dimensions Rejected [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "ProcGen Tests Run:    " WS-TESTS-RUN
     DISPLAY "ProcGen Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL PROCGEN TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME PROCGEN TESTS FAILED <<"
     END-IF
     STOP RUN.
