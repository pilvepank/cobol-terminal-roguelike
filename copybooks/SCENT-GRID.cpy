*>================================================================
*> COPYBOOK: SCENT-GRID.cpy
*> PURPOSE:  Dijkstra Monster Pathfinding Scent Gradient Grid
*> ================================================================
 01  SCENT-MAP-BUFFER.
     05  SCENT-DECAY-RATE        PIC 9(02) COMP-5 VALUE 1.
     05  SCENT-MAX-DISTANCE      PIC 9(02) COMP-5 VALUE 15.
     05  SCENT-TARGET-X          PIC 9(03) COMP-5 VALUE 10.
     05  SCENT-TARGET-Y          PIC 9(03) COMP-5 VALUE 10.
