*>================================================================
*> COPYBOOK: EXPERIENCE-TABLE.cpy
*> PURPOSE:  RPG Level Progression and Combat Attributes
*> ================================================================
 01  HERO-COMBAT-STATS.
     05  HC-LEVEL                PIC 9(02) COMP-5 VALUE 1.
     05  HC-EXPERIENCE           PIC 9(08) COMP-5 VALUE 0.
     05  HC-NEXT-LEVEL-XP        PIC 9(08) COMP-5 VALUE 100.
     05  HC-ATTACK-POWER         PIC 9(04) COMP-5 VALUE 10.
     05  HC-DEFENSE-RATING       PIC 9(04) COMP-5 VALUE 5.
