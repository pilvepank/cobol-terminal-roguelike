*>================================================================
*> PROGRAM:  roguelike_spell_test.cbl
*> PURPOSE:  Unit Test Suite for Arcane Spellcasting Engine
*> ================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROGUELIKE-SPELL-TEST.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-SPELL-REQ.
           05  WS-ID                   PIC 9(02) COMP-5 VALUE 1.
           05  WS-MANA                 PIC 9(04) COMP-5 VALUE 50.
           05  WS-TX                   PIC 9(03) COMP-5 VALUE 10.
           05  WS-TY                   PIC 9(03) COMP-5 VALUE 15.
       01  WS-DAMAGE                   PIC 9(04) COMP-5 VALUE 0.
       01  WS-REM-MANA                 PIC 9(04) COMP-5 VALUE 0.
       01  WS-STATUS                   PIC 9(02) COMP-5 VALUE 0.

       01  WS-TESTS-RUN                PIC 9(04) COMP-5 VALUE 0.
       01  WS-TESTS-PASSED             PIC 9(04) COMP-5 VALUE 0.

       PROCEDURE DIVISION.
       0000-MAIN.
           DISPLAY "==================================================".
           DISPLAY "  ROGUELIKE SPELLCASTING INVARIANT TEST SUITE     ".
           DISPLAY "==================================================".

           ADD 1 TO WS-TESTS-RUN.
           MOVE 1 TO WS-ID.
           MOVE 50 TO WS-MANA.
           CALL "ROGUELIKE-SPELLS" USING WS-SPELL-REQ WS-DAMAGE WS-REM-MANA WS-STATUS.
           IF WS-STATUS = 0 AND WS-DAMAGE = 45 AND WS-REM-MANA = 35
               ADD 1 TO WS-TESTS-PASSED
               DISPLAY "TEST 1: Fireball Spell Cast & Mana Deduction [PASS]"
           END-IF.

           ADD 1 TO WS-TESTS-RUN.
           MOVE 1 TO WS-ID.
           MOVE 5 TO WS-MANA. *> Not enough mana
           CALL "ROGUELIKE-SPELLS" USING WS-SPELL-REQ WS-DAMAGE WS-REM-MANA WS-STATUS.
           IF WS-STATUS = 1
               ADD 1 TO WS-TESTS-PASSED
               DISPLAY "TEST 2: Insufficient Mana Rejection [PASS]"
           END-IF.

           DISPLAY "--------------------------------------------------".
           DISPLAY "TEST SUMMARY: " WS-TESTS-PASSED " / " WS-TESTS-RUN " PASSED.".
           DISPLAY "==================================================".
           IF WS-TESTS-PASSED = WS-TESTS-RUN
               DISPLAY ">> ALL SPELL ENGINE INVARIANTS PASS [100% OK] <<"
           END-IF.
           STOP RUN.
