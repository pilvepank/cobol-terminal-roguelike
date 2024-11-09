*>================================================================
*> COPYBOOK: ITEM-TABLE.cpy
*> PURPOSE:  Roguelike Inventory & Equipment Layout
*> ================================================================
 01  INVENTORY-TABLE.
     05  INV-ITEM-COUNT          PIC 9(02) COMP-5 VALUE 0.
     05  INV-CAPACITY            PIC 9(02) COMP-5 VALUE 10.
     05  INV-ITEM OCCURS 10 TIMES INDEXED BY ITEM-IDX.
         10  ITEM-NAME           PIC X(16).
         10  ITEM-TYPE           PIC X(01).
             88  ITEM-WEAPON     VALUE 'W'.
             88  ITEM-POTION     VALUE 'P'.
             88  ITEM-SCROLL     VALUE 'S'.
         10  ITEM-POWER          PIC 9(04) COMP-5.
