*>================================================================
*> PROGRAM:  roguelike_combat_stats.cbl
*> PURPOSE:  XP Awarding, Level-Up Calculations & Damage Mitigation
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-COMBAT-STATS.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "EXPERIENCE-TABLE.cpy".
 01  LS-XP-AWARDED          PIC 9(08) COMP-5.
 01  LS-LEVEL-UP-FLAG       PIC X(01).

 PROCEDURE DIVISION USING HERO-COMBAT-STATS, LS-XP-AWARDED, LS-LEVEL-UP-FLAG.
 0000-MAIN.
     MOVE 'N' TO LS-LEVEL-UP-FLAG
     ADD LS-XP-AWARDED TO HC-EXPERIENCE
     IF HC-EXPERIENCE >= HC-NEXT-LEVEL-XP
         ADD 1 TO HC-LEVEL
         ADD 5 TO HC-ATTACK-POWER
         ADD 3 TO HC-DEFENSE-RATING
         COMPUTE HC-NEXT-LEVEL-XP = HC-NEXT-LEVEL-XP * 2
         MOVE 'Y' TO LS-LEVEL-UP-FLAG
     END-IF
     GOBACK.
