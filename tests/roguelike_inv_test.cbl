*>================================================================
*> PROGRAM:  roguelike_inv_test.cbl
*> PURPOSE:  Test Harness for Roguelike Inventory System
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-INV-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "copybooks/ITEM-TABLE.cpy".
 01  WS-OP                  PIC X(01) VALUE 'A'.
 01  WS-NAME                PIC X(16) VALUE "HEALTH POTION   ".
 01  WS-POWER               PIC 9(04) COMP-5 VALUE 50.
 01  WS-STATUS              PIC X(02) VALUE '  '.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  ROGUELIKE INVENTORY TEST SUITE                  "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     CALL "ROGUELIKE-INVENTORY" USING INVENTORY-TABLE, WS-OP, WS-NAME, WS-POWER, WS-STATUS
     IF WS-STATUS = '00' AND INV-ITEM-COUNT = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Add Inventory Potion [PASS]"
     ELSE
         DISPLAY "TEST 1: Add Inventory Potion [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "Inventory Tests Run:    " WS-TESTS-RUN
     DISPLAY "Inventory Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL INVENTORY TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME INVENTORY TESTS FAILED <<"
     END-IF
     STOP RUN.
