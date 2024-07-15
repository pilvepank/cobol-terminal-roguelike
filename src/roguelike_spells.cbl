*>================================================================
*> PROGRAM:  roguelike_spells.cbl
*> PURPOSE:  Arcane Spellcasting, AOE Damage & Mana Pool Engine
*> ================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROGUELIKE-SPELLS.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY "SPELL-DATA.cpy".

       LINKAGE SECTION.
       01  LS-SPELL-REQ.
           05  LS-CAST-SPELL-ID        PIC 9(02) COMP-5.
           05  LS-CURRENT-MANA         PIC 9(04) COMP-5.
           05  LS-TARGET-X             PIC 9(03) COMP-5.
           05  LS-TARGET-Y             PIC 9(03) COMP-5.
       01  LS-CALC-DAMAGE              PIC 9(04) COMP-5.
       01  LS-MANA-REMAINING           PIC 9(04) COMP-5.
       01  LS-STATUS                   PIC 9(02) COMP-5.
           88  SPELL-CAST-SUCCESS      VALUE 0.
           88  SPELL-NOT-ENOUGH-MANA   VALUE 1.
           88  SPELL-UNKNOWN-ID        VALUE 2.

       PROCEDURE DIVISION USING LS-SPELL-REQ
                                LS-CALC-DAMAGE
                                LS-MANA-REMAINING
                                LS-STATUS.
       0000-CAST-SPELL.
           MOVE 0 TO LS-STATUS.
           MOVE LS-CURRENT-MANA TO LS-MANA-REMAINING.
           MOVE 0 TO LS-CALC-DAMAGE.

           EVALUATE LS-CAST-SPELL-ID
               WHEN 1 *> Fireball
                   IF LS-CURRENT-MANA < 15
                       SET SPELL-NOT-ENOUGH-MANA TO TRUE
                   ELSE
                       SUBTRACT 15 FROM LS-MANA-REMAINING
                       MOVE 45 TO LS-CALC-DAMAGE
                       SET SPELL-CAST-SUCCESS TO TRUE
                   END-IF
               WHEN 2 *> Heal
                   IF LS-CURRENT-MANA < 10
                       SET SPELL-NOT-ENOUGH-MANA TO TRUE
                   ELSE
                       SUBTRACT 10 FROM LS-MANA-REMAINING
                       MOVE 30 TO LS-CALC-DAMAGE
                       SET SPELL-CAST-SUCCESS TO TRUE
                   END-IF
               WHEN OTHER
                   SET SPELL-UNKNOWN-ID TO TRUE
           END-EVALUATE.
           GOBACK.
