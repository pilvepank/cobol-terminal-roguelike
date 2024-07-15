*>================================================================
*> COPYBOOK: SPELL-DATA.cpy
*> PURPOSE:  Magic Spell Books, Status Effects & AOE Formulas
*> ================================================================
       01  SPELL-REGISTRY.
           05  SPELL-ENTRY OCCURS 4 TIMES INDEXED BY SPL-IDX.
               10  SPELL-ID            PIC 9(02) COMP-5.
               10  SPELL-NAME          PIC X(16).
               10  SPELL-MANA-COST     PIC 9(03) COMP-5.
               10  SPELL-BASE-DAMAGE   PIC 9(04) COMP-5.
               10  SPELL-AOE-RADIUS    PIC 9(02) COMP-5.
               10  SPELL-EFFECT-TYPE   PIC X(01).
                   88  EFFECT-FIRE     VALUE 'F'.
                   88  EFFECT-HEAL     VALUE 'H'.
                   88  EFFECT-FREEZE   VALUE 'I'.
                   88  EFFECT-TELEPORT VALUE 'T'.
