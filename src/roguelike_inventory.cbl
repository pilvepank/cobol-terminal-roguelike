*>================================================================
*> PROGRAM:  roguelike_inventory.cbl
*> PURPOSE:  Dungeon Inventory & Equipment Management Subprogram
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-INVENTORY.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "ITEM-TABLE.cpy".
 01  LS-OP                  PIC X(01).
 01  LS-NAME                PIC X(16).
 01  LS-POWER               PIC 9(04) COMP-5.
 01  LS-STATUS              PIC X(02).

 PROCEDURE DIVISION USING INVENTORY-TABLE, LS-OP, LS-NAME, LS-POWER, LS-STATUS.
 0000-MAIN.
     IF LS-OP = 'A' *> Add item
         IF INV-ITEM-COUNT < INV-CAPACITY
             ADD 1 TO INV-ITEM-COUNT
             MOVE LS-NAME TO ITEM-NAME(INV-ITEM-COUNT)
             MOVE 'P' TO ITEM-TYPE(INV-ITEM-COUNT)
             MOVE LS-POWER TO ITEM-POWER(INV-ITEM-COUNT)
             MOVE '00' TO LS-STATUS
         ELSE
             MOVE 'FL' TO LS-STATUS *> Full
         END-IF
     ELSE
         MOVE '00' TO LS-STATUS
     END-IF
     GOBACK.
