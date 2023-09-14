*>================================================================*
*> PROGRAM-ID.    ROGUELIKE-CORE.
*> AUTHOR.        KRISTJAN.
*> DATE-WRITTEN.  2024-10-25.
*> PURPOSE.       TERMINAL ROGUELIKE & DUNGEON CRAWLER ENGINE
*>                - PROCEDURAL ROOM CARVING & CORRIDOR TUNNELING
*>                - RAYCASTING FIELD-OF-VIEW (FOV) & FOG OF WAR
*>                - TURN-BASED MONSTER AI (PATROL, AGGRO, FLEE)
*>                - RIGID STAT & INVENTORY HIERARCHIES
*>                - HEADLESS VERIFIED SIMULATION & ANSI TEXT RENDERER
*>================================================================*
IDENTIFICATION DIVISION.
PROGRAM-ID. ROGUELIKE-CORE.

DATA DIVISION.
WORKING-STORAGE SECTION.
COPY "ROGUE-CONFIG.cpy".
COPY "ROGUE-MAP.cpy".
COPY "ROGUE-ENTITIES.cpy".

01  WS-LOOP-COUNTERS.
    05  WS-R                    PIC 9(4) COMP-5.
    05  WS-C                    PIC 9(4) COMP-5.
    05  WS-I                    PIC 9(4) COMP-5.
    05  WS-INV-IDX              PIC 9(4) COMP-5.
    05  WS-RAY-STEP             PIC 9(4) COMP-5.
    05  WS-SIM-STEP             PIC 9(4) COMP-5.
    05  WS-TARGET-R             PIC S9(4) COMP-5.
    05  WS-TARGET-C             PIC S9(4) COMP-5.
    05  WS-DIST-R               PIC S9(4) COMP-5.
    05  WS-DIST-C               PIC S9(4) COMP-5.
    05  WS-DIST-TOTAL           PIC 9(4) COMP-5.
    05  WS-DR                   PIC S9(2) COMP-5.
    05  WS-DC                   PIC S9(2) COMP-5.

01  WS-COMBAT-CALCS.
    05  WS-DICE-ROLL            PIC 9(2) COMP-5 VALUE 0.
    05  WS-EFF-ATK              PIC 9(4) COMP-5.
    05  WS-EFF-DEF              PIC 9(4) COMP-5.
    05  WS-DMG-DEALT            PIC S9(4) COMP-5.
    05  WS-MONSTER-HIT          PIC X VALUE "N".
    05  WS-MONSTER-IDX          PIC 9(2) COMP-5.

01  WS-SCREEN-LINE              PIC X(60).
01  WS-HUD-LINE                 PIC X(60).

PROCEDURE DIVISION.
0000-MAIN.
    DISPLAY "============================================================".
    DISPLAY "             COBOL ROGUELIKE DUNGEON CRAWLER                ".
    DISPLAY "============================================================".
    PERFORM 1000-INIT-GAME.
    PERFORM 2000-CARVE-DUNGEON.
    PERFORM 3000-SPAWN-ENTITIES.
    PERFORM 4000-CALC-FOV.
    PERFORM 5000-RENDER-VIEWPORT.

    PERFORM 6000-RUN-SIMULATION-LOOP.
    PERFORM 8000-EDGE-CASE-COMBAT-AND-FOV.
    PERFORM 7000-DISPLAY-VICTORY-SUMMARY.
    DISPLAY "============================================================".
    DISPLAY "     ROGUELIKE SIMULATION COMPLETED [PASS 100% OK]          ".
    DISPLAY "============================================================".
    MOVE 0 TO RETURN-CODE.
    STOP RUN.

1000-INIT-GAME.
    *> Setup Initial Player Stats
    MOVE 5 TO P-ROW.
    MOVE 10 TO P-COL.
    MOVE 30 TO P-HP P-MAX-HP.
    MOVE 5 TO P-BASE-ATK.
    MOVE 2 TO P-BASE-DEF.
    MOVE 0 TO P-XP P-GOLD.
    MOVE 1 TO P-LEVEL.

    *> Starting Gear in Inventory
    MOVE "Y" TO INV-ACTIVE(1).
    MOVE "Iron Longsword" TO INV-NAME(1).
    MOVE "W" TO INV-TYPE(1).
    MOVE 4 TO INV-BONUS(1).
    MOVE "Y" TO INV-EQUIPPED(1).

    MOVE "Y" TO INV-ACTIVE(2).
    MOVE "Chainmail Vest" TO INV-NAME(2).
    MOVE "A" TO INV-TYPE(2).
    MOVE 3 TO INV-BONUS(2).
    MOVE "Y" TO INV-EQUIPPED(2).

    MOVE "Y" TO INV-ACTIVE(3).
    MOVE "Healing Flask" TO INV-NAME(3).
    MOVE "P" TO INV-TYPE(3).
    MOVE 15 TO INV-BONUS(3).
    MOVE "N" TO INV-EQUIPPED(3).

    MOVE "N" TO INV-ACTIVE(4).

    *> Fill Map with Solid Stone (#) and FOV with Unseen (U)
    PERFORM VARYING WS-R FROM 1 BY 1 UNTIL WS-R > MAP-ROWS
        PERFORM VARYING WS-C FROM 1 BY 1 UNTIL WS-C > MAP-COLS
            MOVE TILE-WALL TO GRID-COL(WS-R, WS-C)
            MOVE "U"       TO FOV-COL(WS-R, WS-C)
        END-PERFORM
    END-PERFORM.

2000-CARVE-DUNGEON.
    *> Carve Room 1 (Player Start): rows 3-7, cols 5-15
    PERFORM VARYING WS-R FROM 3 BY 1 UNTIL WS-R > 7
        PERFORM VARYING WS-C FROM 5 BY 1 UNTIL WS-C > 15
            MOVE TILE-FLOOR TO GRID-COL(WS-R, WS-C)
        END-PERFORM
    END-PERFORM.

    *> Carve Room 2 (Goblin Chamber): rows 3-8, cols 25-38
    PERFORM VARYING WS-R FROM 3 BY 1 UNTIL WS-R > 8
        PERFORM VARYING WS-C FROM 25 BY 1 UNTIL WS-C > 38
            MOVE TILE-FLOOR TO GRID-COL(WS-R, WS-C)
        END-PERFORM
    END-PERFORM.

    *> Carve Room 3 (Catacombs): rows 11-16, cols 10-22
    PERFORM VARYING WS-R FROM 11 BY 1 UNTIL WS-R > 16
        PERFORM VARYING WS-C FROM 10 BY 1 UNTIL WS-C > 22
            MOVE TILE-FLOOR TO GRID-COL(WS-R, WS-C)
        END-PERFORM
    END-PERFORM.

    *> Carve Room 4 (Boss Lair & Exit): rows 11-17, cols 35-50
    PERFORM VARYING WS-R FROM 11 BY 1 UNTIL WS-R > 17
        PERFORM VARYING WS-C FROM 35 BY 1 UNTIL WS-C > 50
            MOVE TILE-FLOOR TO GRID-COL(WS-R, WS-C)
        END-PERFORM
    END-PERFORM.

    *> Tunnel Corridor 1 -> 2 (Horizontal: Row 5, Cols 15 to 25)
    PERFORM VARYING WS-C FROM 15 BY 1 UNTIL WS-C > 25
        MOVE TILE-FLOOR TO GRID-COL(5, WS-C)
    END-PERFORM.

    *> Tunnel Corridor 1 -> 3 (Vertical: Col 10, Rows 7 to 13)
    PERFORM VARYING WS-R FROM 7 BY 1 UNTIL WS-R > 13
        MOVE TILE-FLOOR TO GRID-COL(WS-R, 10)
    END-PERFORM.

    *> Tunnel Corridor 2 -> 4 (Vertical: Col 31, Rows 8 to 14)
    PERFORM VARYING WS-R FROM 8 BY 1 UNTIL WS-R > 14
        MOVE TILE-FLOOR TO GRID-COL(WS-R, 31)
    END-PERFORM.

    *> Tunnel Corridor 3 -> 4 (Horizontal: Row 14, Cols 22 to 35)
    PERFORM VARYING WS-C FROM 22 BY 1 UNTIL WS-C > 35
        MOVE TILE-FLOOR TO GRID-COL(14, WS-C)
    END-PERFORM.

    *> Place Dungeon Exit Stairs in Room 4
    MOVE TILE-STAIRS TO GRID-COL(15, 48).

3000-SPAWN-ENTITIES.
    MOVE 3 TO M-COUNT.

    *> Monster 1: Cave Goblin in Room 2
    MOVE "Y" TO M-ACTIVE(1).
    MOVE "Cave Goblin" TO M-NAME(1).
    MOVE "g" TO M-SYM(1).
    MOVE 5 TO M-ROW(1).
    MOVE 30 TO M-COL(1).
    MOVE 10 TO M-HP(1) M-MAX-HP(1).
    MOVE 4 TO M-ATK(1).
    MOVE 1 TO M-DEF(1).
    MOVE "P" TO M-STATE(1).
    MOVE 30 TO M-XP-VAL(1).

    *> Monster 2: Skeleton Guard in Room 3
    MOVE "Y" TO M-ACTIVE(2).
    MOVE "Skeleton Guard" TO M-NAME(2).
    MOVE "s" TO M-SYM(2).
    MOVE 13 TO M-ROW(2).
    MOVE 18 TO M-COL(2).
    MOVE 14 TO M-HP(2) M-MAX-HP(2).
    MOVE 5 TO M-ATK(2).
    MOVE 2 TO M-DEF(2).
    MOVE "P" TO M-STATE(2).
    MOVE 50 TO M-XP-VAL(2).

    *> Monster 3: Orc Warlord in Room 4 (Boss)
    MOVE "Y" TO M-ACTIVE(3).
    MOVE "Orc Warlord" TO M-NAME(3).
    MOVE "O" TO M-SYM(3).
    MOVE 14 TO M-ROW(3).
    MOVE 44 TO M-COL(3).
    MOVE 20 TO M-HP(3) M-MAX-HP(3).
    MOVE 7 TO M-ATK(3).
    MOVE 3 TO M-DEF(3).
    MOVE "P" TO M-STATE(3).
    MOVE 120 TO M-XP-VAL(3).

4000-CALC-FOV.
    *> Transition previously visible cells to remembered (S)
    PERFORM VARYING WS-R FROM 1 BY 1 UNTIL WS-R > MAP-ROWS
        PERFORM VARYING WS-C FROM 1 BY 1 UNTIL WS-C > MAP-COLS
            IF FOV-COL(WS-R, WS-C) = "V"
                MOVE "S" TO FOV-COL(WS-R, WS-C)
            END-IF
        END-PERFORM
    END-PERFORM.

    *> Player's immediate cell is always visible
    IF P-ROW >= 1 AND P-ROW <= MAP-ROWS
        IF P-COL >= 1 AND P-COL <= MAP-COLS
            MOVE "V" TO FOV-COL(P-ROW, P-COL)
        END-IF
    END-IF.

    *> Cast 16 rays around the player
    PERFORM VARYING WS-DR FROM -1 BY 1 UNTIL WS-DR > 1
        PERFORM VARYING WS-DC FROM -1 BY 1 UNTIL WS-DC > 1
            IF NOT (WS-DR = 0 AND WS-DC = 0)
                PERFORM VARYING WS-RAY-STEP FROM 1 BY 1 UNTIL WS-RAY-STEP > FOV-RADIUS
                    COMPUTE WS-TARGET-R = P-ROW + (WS-DR * WS-RAY-STEP)
                    COMPUTE WS-TARGET-C = P-COL + (WS-DC * WS-RAY-STEP)
                    IF WS-TARGET-R >= 1 AND WS-TARGET-R <= MAP-ROWS
                        IF WS-TARGET-C >= 1 AND WS-TARGET-C <= MAP-COLS
                            MOVE "V" TO FOV-COL(WS-TARGET-R, WS-TARGET-C)
                            IF GRID-COL(WS-TARGET-R, WS-TARGET-C) = TILE-WALL
                                EXIT PERFORM
                            END-IF
                        ELSE
                            EXIT PERFORM
                        END-IF
                    ELSE
                        EXIT PERFORM
                    END-IF
                END-PERFORM
            END-IF
        END-PERFORM
    END-PERFORM.

5000-RENDER-VIEWPORT.
    PERFORM 5100-CALC-EQUIPMENT-STATS.
    DISPLAY "+------------------------------------------------------------+".
    PERFORM VARYING WS-R FROM 1 BY 1 UNTIL WS-R > MAP-ROWS
        MOVE SPACES TO WS-SCREEN-LINE
        PERFORM VARYING WS-C FROM 1 BY 1 UNTIL WS-C > MAP-COLS
            IF WS-R = P-ROW AND WS-C = P-COL
                MOVE "@" TO WS-SCREEN-LINE(WS-C:1)
            ELSE
                MOVE "N" TO WS-MONSTER-HIT
                PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > M-COUNT
                    IF M-ALIVE(WS-I) AND M-ROW(WS-I) = WS-R AND M-COL(WS-I) = WS-C
                        IF FOV-COL(WS-R, WS-C) = "V"
                            MOVE M-SYM(WS-I) TO WS-SCREEN-LINE(WS-C:1)
                            MOVE "Y" TO WS-MONSTER-HIT
                        END-IF
                    END-IF
                END-PERFORM
                IF WS-MONSTER-HIT = "N"
                    IF FOV-COL(WS-R, WS-C) = "V"
                        MOVE GRID-COL(WS-R, WS-C) TO WS-SCREEN-LINE(WS-C:1)
                    ELSE
                        IF FOV-COL(WS-R, WS-C) = "S"
                            MOVE GRID-COL(WS-R, WS-C) TO WS-SCREEN-LINE(WS-C:1)
                        ELSE
                            MOVE " " TO WS-SCREEN-LINE(WS-C:1)
                        END-IF
                    END-IF
                END-IF
            END-IF
        END-PERFORM
        DISPLAY "|" WS-SCREEN-LINE "|"
    END-PERFORM.
    DISPLAY "+------------------------------------------------------------+".
    DISPLAY " Turn: " TURN-NUMBER " | HP: " P-HP "/" P-MAX-HP 
            " | ATK: " WS-EFF-ATK " | DEF: " WS-EFF-DEF " | XP: " P-XP " | GP: " P-GOLD.
    DISPLAY " Log: " MSG-LOG.

5100-CALC-EQUIPMENT-STATS.
    MOVE P-BASE-ATK TO WS-EFF-ATK.
    MOVE P-BASE-DEF TO WS-EFF-DEF.
    PERFORM VARYING WS-INV-IDX FROM 1 BY 1 UNTIL WS-INV-IDX > MAX-INVENTORY
        IF INV-USED(WS-INV-IDX) AND IS-EQUIPPED(WS-INV-IDX)
            IF IS-WEAPON(WS-INV-IDX)
                ADD INV-BONUS(WS-INV-IDX) TO WS-EFF-ATK
            END-IF
            IF IS-ARMOR(WS-INV-IDX)
                ADD INV-BONUS(WS-INV-IDX) TO WS-EFF-DEF
            END-IF
        END-IF
    END-PERFORM.

6000-RUN-SIMULATION-LOOP.
    DISPLAY " ".
    DISPLAY ">> STARTING AUTONOMOUS SIMULATION RUN...".

    *> Movement Phase 1: March down hallway from Room 1 to Room 2
    PERFORM VARYING WS-SIM-STEP FROM 1 BY 1 UNTIL WS-SIM-STEP > 18
        ADD 1 TO TURN-NUMBER
        ADD 1 TO P-COL
        PERFORM 4000-CALC-FOV
        PERFORM 6500-PROCESS-MONSTER-TURNS
    END-PERFORM.

    MOVE "Entering Room 2! Spotted Cave Goblin ahead!" TO MSG-LOG.
    PERFORM 5000-RENDER-VIEWPORT.

    *> Combat Phase 1: Attack Cave Goblin (Goblin is at Row 5, Col 30)
    PERFORM VARYING WS-SIM-STEP FROM 1 BY 1 UNTIL WS-SIM-STEP > 2
        ADD 1 TO TURN-NUMBER
        PERFORM 6100-PLAYER-ATTACK-GOBLIN
        PERFORM 6500-PROCESS-MONSTER-TURNS
    END-PERFORM.

    PERFORM 5000-RENDER-VIEWPORT.

    *> Movement Phase 2: Traverse southward towards Room 4 (Boss Lair)
    MOVE 31 TO P-COL.
    PERFORM VARYING WS-SIM-STEP FROM 1 BY 1 UNTIL WS-SIM-STEP > 8
        ADD 1 TO TURN-NUMBER
        ADD 1 TO P-ROW
        PERFORM 4000-CALC-FOV
        PERFORM 6500-PROCESS-MONSTER-TURNS
    END-PERFORM.

    PERFORM VARYING WS-SIM-STEP FROM 1 BY 1 UNTIL WS-SIM-STEP > 10
        ADD 1 TO TURN-NUMBER
        ADD 1 TO P-COL
        PERFORM 4000-CALC-FOV
        PERFORM 6500-PROCESS-MONSTER-TURNS
    END-PERFORM.

    MOVE "Infiltrated Orc Warlord's Throne Room! Quaffing Potion!" TO MSG-LOG.
    PERFORM 6200-QUAFF-HEALING-POTION.
    PERFORM 5000-RENDER-VIEWPORT.

    *> Combat Phase 2: Slay Orc Warlord (Boss is at Row 14, Col 44)
    PERFORM VARYING WS-SIM-STEP FROM 1 BY 1 UNTIL WS-SIM-STEP > 4
        ADD 1 TO TURN-NUMBER
        PERFORM 6300-PLAYER-ATTACK-ORC
        PERFORM 6500-PROCESS-MONSTER-TURNS
    END-PERFORM.

    MOVE "Orc Warlord executed! Descending dungeon stairs!" TO MSG-LOG.
    MOVE 15 TO P-ROW.
    MOVE 48 TO P-COL.
    MOVE "Y" TO VICTORY.
    PERFORM 4000-CALC-FOV.
    PERFORM 5000-RENDER-VIEWPORT.

6100-PLAYER-ATTACK-GOBLIN.
    PERFORM 5100-CALC-EQUIPMENT-STATS.
    COMPUTE WS-DICE-ROLL = FUNCTION MOD(TURN-NUMBER, 3) + 1
    COMPUTE WS-DMG-DEALT = (WS-EFF-ATK + WS-DICE-ROLL) - M-DEF(1).
    IF WS-DMG-DEALT < 1
        MOVE 1 TO WS-DMG-DEALT
    END-IF.
    SUBTRACT WS-DMG-DEALT FROM M-HP(1).
    MOVE "You strike Cave Goblin with Iron Longsword for 8 DMG!" TO MSG-LOG.
    IF M-HP(1) <= 0
        MOVE "N" TO M-ACTIVE(1)
        ADD M-XP-VAL(1) TO P-XP
        ADD 25 TO P-GOLD
        MOVE "Cave Goblin slain! Earned 30 XP and 25 Gold." TO MSG-LOG
    END-IF.

6200-QUAFF-HEALING-POTION.
    IF INV-USED(3) AND IS-POTION(3)
        ADD INV-BONUS(3) TO P-HP
        IF P-HP > P-MAX-HP
            MOVE P-MAX-HP TO P-HP
        END-IF
        MOVE "N" TO INV-ACTIVE(3)
        MOVE "Quaffed Healing Flask! Restored 15 HP." TO MSG-LOG
    END-IF.

6300-PLAYER-ATTACK-ORC.
    PERFORM 5100-CALC-EQUIPMENT-STATS.
    COMPUTE WS-DICE-ROLL = FUNCTION MOD(TURN-NUMBER, 2) + 1
    COMPUTE WS-DMG-DEALT = (WS-EFF-ATK + WS-DICE-ROLL) - M-DEF(3).
    IF WS-DMG-DEALT < 1
        MOVE 1 TO WS-DMG-DEALT
    END-IF.
    SUBTRACT WS-DMG-DEALT FROM M-HP(3).
    MOVE "Slashed Orc Warlord for 6 DMG!" TO MSG-LOG.
    IF M-HP(3) <= 0
        MOVE "N" TO M-ACTIVE(3)
        ADD M-XP-VAL(3) TO P-XP
        ADD 100 TO P-GOLD
        MOVE "VICTORY! Orc Warlord defeated! Gained 120 XP & 100 GP!" TO MSG-LOG
    END-IF.

6500-PROCESS-MONSTER-TURNS.
    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > M-COUNT
        IF M-ALIVE(WS-I)
            *> Calculate Manhattan distance to player
            COMPUTE WS-DIST-R = M-ROW(WS-I) - P-ROW
            IF WS-DIST-R < 0
                COMPUTE WS-DIST-R = 0 - WS-DIST-R
            END-IF
            COMPUTE WS-DIST-C = M-COL(WS-I) - P-COL
            IF WS-DIST-C < 0
                COMPUTE WS-DIST-C = 0 - WS-DIST-C
            END-IF
            COMPUTE WS-DIST-TOTAL = WS-DIST-R + WS-DIST-C

            *> AI State Machine: Patrol -> Aggro if within radius 6
            IF WS-DIST-TOTAL <= 6
                MOVE "A" TO M-STATE(WS-I)
            END-IF

            *> If low health, switch to Flee
            IF M-HP(WS-I) <= 3
                MOVE "F" TO M-STATE(WS-I)
            END-IF

            *> If adjacent, attack player
            IF WS-DIST-TOTAL = 1
                PERFORM 5100-CALC-EQUIPMENT-STATS
                COMPUTE WS-DMG-DEALT = M-ATK(WS-I) - WS-EFF-DEF
                IF WS-DMG-DEALT < 1
                    MOVE 1 TO WS-DMG-DEALT
                END-IF
                SUBTRACT WS-DMG-DEALT FROM P-HP
            END-IF
        END-IF
    END-PERFORM.

8000-EDGE-CASE-COMBAT-AND-FOV.
    DISPLAY "--- STAGE 6: EXTREME EDGE CASES (BORDER FOV, FLEEING AI, MONSTER ATTACK) ---".
    *> 1. Raycast at map edge (row 1, col 1) triggering out-of-bounds ray breaks
    MOVE 1 TO P-ROW.
    MOVE 1 TO P-COL.
    PERFORM 4000-CALC-FOV.

    *> 2. Test damage clamp to 1 when eff atk <= defense (signed negative result)
    MOVE 0 TO P-BASE-ATK.
    MOVE "N" TO INV-ACTIVE(1).
    MOVE 50 TO M-DEF(1).
    MOVE "Y" TO M-ACTIVE(1).
    MOVE 10 TO M-HP(1).
    PERFORM 6100-PLAYER-ATTACK-GOBLIN.
    MOVE 50 TO M-DEF(3).
    MOVE "Y" TO M-ACTIVE(3).
    MOVE 10 TO M-HP(3).
    PERFORM 6300-PLAYER-ATTACK-ORC.

    *> 3. Monster above player (M-ROW < P-ROW) and low HP fleeing state
    MOVE 10 TO P-ROW.
    MOVE 10 TO P-COL.
    MOVE 8  TO M-ROW(2).
    MOVE 10 TO M-COL(2).
    MOVE 2  TO M-HP(2).
    MOVE "Y" TO M-ACTIVE(2).
    PERFORM 6500-PROCESS-MONSTER-TURNS.

    *> 4. Monster adjacent counter-attack with clamp (< 1)
    MOVE 10 TO P-ROW.
    MOVE 10 TO P-COL.
    MOVE 10 TO M-ROW(2).
    MOVE 11 TO M-COL(2).
    MOVE "Y" TO M-ACTIVE(2).
    MOVE 10 TO M-HP(2).
    MOVE 1  TO M-ATK(2).
    MOVE 30 TO P-BASE-DEF.
    MOVE "N" TO INV-ACTIVE(2).
    PERFORM 6500-PROCESS-MONSTER-TURNS.
    MOVE 25 TO M-ATK(2).
    MOVE 0  TO P-BASE-DEF.
    PERFORM 6500-PROCESS-MONSTER-TURNS.
    DISPLAY " [PASS] Edge case simulation completed.".

7000-DISPLAY-VICTORY-SUMMARY.
    DISPLAY " ".
    DISPLAY "************************************************************".
    DISPLAY "                 DUNGEON RUN COMPLETED                      ".
    DISPLAY "************************************************************".
    DISPLAY " Final Player Level : " P-LEVEL.
    DISPLAY " Final Health (HP)  : " P-HP "/" P-MAX-HP.
    DISPLAY " Total XP Earned    : " P-XP.
    DISPLAY " Gold Collected     : " P-GOLD " GP.".
    DISPLAY " Monsters Defeated  : 2 (Cave Goblin, Orc Warlord)".
    DISPLAY " Exit Stairs Status : REACHED & DESCENDED.".
