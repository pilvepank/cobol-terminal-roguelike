*>================================================================*
*> ROGUE-ENTITIES.cpy - Player, Monsters and Inventory Records
*>================================================================*
 01  PLAYER-RECORD.
     05  P-ROW                   PIC 9(4) COMP-5 VALUE 5.
     05  P-COL                   PIC 9(4) COMP-5 VALUE 10.
     05  P-STATS.
         10  P-HP                PIC S9(4) COMP-5 VALUE 30.
         10  P-MAX-HP            PIC 9(4)  COMP-5 VALUE 30.
         10  P-BASE-ATK          PIC 9(4)  COMP-5 VALUE 5.
         10  P-BASE-DEF          PIC 9(4)  COMP-5 VALUE 2.
         10  P-XP                PIC 9(6)  COMP-5 VALUE 0.
         10  P-LEVEL             PIC 9(2)  COMP-5 VALUE 1.
         10  P-GOLD              PIC 9(6)  COMP-5 VALUE 0.
     05  P-INVENTORY.
         10  INV-ITEM OCCURS 4 TIMES.
             15  INV-ACTIVE      PIC X    VALUE "N".
                 88  INV-EMPTY   VALUE "N".
                 88  INV-USED    VALUE "Y".
             15  INV-NAME        PIC X(18) VALUE SPACES.
             15  INV-TYPE        PIC X    VALUE " ".
                 88  IS-WEAPON   VALUE "W".
                 88  IS-ARMOR    VALUE "A".
                 88  IS-POTION   VALUE "P".
             15  INV-BONUS       PIC 9(4) COMP-5 VALUE 0.
             15  INV-EQUIPPED    PIC X    VALUE "N".
                 88  IS-EQUIPPED VALUE "Y".

 01  MONSTER-TABLE.
     05  M-COUNT                 PIC 9(2) COMP-5 VALUE 0.
     05  MONSTER-ENTRY OCCURS 4 TIMES.
         10  M-ACTIVE            PIC X    VALUE "N".
             88  M-ALIVE         VALUE "Y".
             88  M-DEAD          VALUE "N".
         10  M-NAME              PIC X(16) VALUE SPACES.
         10  M-SYM               PIC X    VALUE "g".
         10  M-ROW               PIC 9(4) COMP-5 VALUE 0.
         10  M-COL               PIC 9(4) COMP-5 VALUE 0.
         10  M-HP                PIC S9(4) COMP-5 VALUE 0.
         10  M-MAX-HP            PIC 9(4) COMP-5 VALUE 0.
         10  M-ATK               PIC 9(4) COMP-5 VALUE 0.
         10  M-DEF               PIC 9(4) COMP-5 VALUE 0.
         10  M-STATE             PIC X    VALUE "P".
             88  STATE-PATROL    VALUE "P".
             88  STATE-AGGRO     VALUE "A".
             88  STATE-FLEE      VALUE "F".
         10  M-XP-VAL            PIC 9(4) COMP-5 VALUE 0.

 01  GAME-STATE-RECORD.
     05  TURN-NUMBER             PIC 9(5) COMP-5 VALUE 0.
     05  GAME-OVER               PIC X    VALUE "N".
         88  IS-GAME-OVER        VALUE "Y".
     05  VICTORY                 PIC X    VALUE "N".
         88  IS-VICTORY          VALUE "Y".
     05  MSG-LOG                 PIC X(64) VALUE "Welcome to the COBOL Dungeon!".
