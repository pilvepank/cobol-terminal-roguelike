*>================================================================
*> COPYBOOK: STATUS-EFFECTS.cpy
*> PURPOSE:  Player and Monster Buff/Debuff Status Effects Table
*> ================================================================
 01  STATUS-EFFECTS-STATE.
     05  FX-ACTIVE-COUNT         PIC 9(02) COMP-5 VALUE 0.
     05  FX-LIST OCCURS 8 TIMES INDEXED BY FX-IDX.
         10  FX-NAME             PIC X(08) VALUE SPACES.
         10  FX-DURATION-TURNS   PIC 9(03) COMP-5 VALUE 0.
         10  FX-DOT-DAMAGE-TICK  PIC 9(03) COMP-5 VALUE 0.
