*>================================================================
*> COPYBOOK: SAVE-LAYOUT.cpy
*> PURPOSE:  Dungeon Crawl Persistent Binary Savefile Layout
*> ================================================================
       01  SAVE-STATE-HEADER.
           05  SAVE-MAGIC              PIC X(04) VALUE "ROGS".
           05  SAVE-VERSION            PIC 9(02) COMP-5 VALUE 1.
           05  SAVE-TIMESTAMP          PIC 9(16) COMP-5.
           05  SAVE-DUNGEON-LEVEL      PIC 9(02) COMP-5.
           05  SAVE-PLAYER-HP          PIC 9(04) COMP-5.
           05  SAVE-PLAYER-MANA        PIC 9(04) COMP-5.
           05  SAVE-PLAYER-SCORE       PIC 9(08) COMP-5.
           05  SAVE-CHECKSUM           PIC 9(08) COMP-5.
