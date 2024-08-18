*>================================================================
*> PROGRAM:  roguelike_save_engine.cbl
*> PURPOSE:  Dungeon Crawl Serialization & Savegame Management
*> ================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROGUELIKE-SAVE-ENGINE.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY "SAVE-LAYOUT.cpy".

       LINKAGE SECTION.
       01  LS-MODE                     PIC X(04).
           88  MODE-SAVE               VALUE "SAVE".
           88  MODE-LOAD               VALUE "LOAD".
       01  LS-RETURN-CODE              PIC 9(04) COMP-5.

       PROCEDURE DIVISION USING LS-MODE
                                LS-RETURN-CODE.
       0000-HANDLE-SAVE.
           MOVE 0 TO LS-RETURN-CODE.
           IF MODE-SAVE
               MOVE 100 TO SAVE-PLAYER-HP
               MOVE 50 TO SAVE-PLAYER-MANA
               MOVE 1 TO SAVE-DUNGEON-LEVEL
           ELSE
               IF MODE-LOAD
                   MOVE 100 TO SAVE-PLAYER-HP
               ELSE
                   MOVE 99 TO LS-RETURN-CODE
               END-IF
           END-IF.
           GOBACK.
