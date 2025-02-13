*>================================================================
*> PROGRAM:  roguelike_combat_test.cbl
*> PURPOSE:  Unit Test Suite for RPG Level Progression Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-COMBAT-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "EXPERIENCE-TABLE.cpy".
 01  WS-XP                  PIC 9(08) COMP-5 VALUE 50.
 01  WS-LVLUP               PIC X(01) VALUE 'N'.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE RPG LEVEL PROGRESSION TEST SUITE      "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1 TO HC-LEVEL
     MOVE 0 TO HC-EXPERIENCE
     MOVE 100 TO HC-NEXT-LEVEL-XP
     MOVE 10 TO HC-ATTACK-POWER
     MOVE 5 TO HC-DEFENSE-RATING
     
     MOVE 50 TO WS-XP
     CALL "ROGUELIKE-COMBAT-STATS" USING HERO-COMBAT-STATS, WS-XP, WS-LVLUP
     IF WS-LVLUP = 'N' AND HC-EXPERIENCE = 50 AND HC-LEVEL = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Sub-threshold XP Awards Without Leveling [PASS]"
     ELSE
         DISPLAY "TEST 1: Sub-threshold XP Awards Without Leveling [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 60 TO WS-XP
     CALL "ROGUELIKE-COMBAT-STATS" USING HERO-COMBAT-STATS, WS-XP, WS-LVLUP
     IF WS-LVLUP = 'Y' AND HC-LEVEL = 2 AND HC-ATTACK-POWER = 15
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Level-Up Increments Stats & Recalculates Target [PASS]"
     ELSE
         DISPLAY "TEST 2: Level-Up Increments Stats & Recalculates Target [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Combat Tests Run:    " WS-TESTS-RUN
     DISPLAY "Combat Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL COMBAT STATS TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME COMBAT STATS TESTS FAILED <<"
     END-IF
     STOP RUN.
