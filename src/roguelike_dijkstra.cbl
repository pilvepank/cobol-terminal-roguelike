*>================================================================
*> PROGRAM:  roguelike_dijkstra.cbl
*> PURPOSE:  Dijkstra Scent Distance Calculator for Monster Pathfinding
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. ROGUELIKE-DIJKSTRA.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-DX                  PIC S9(03) COMP-5.
 01  WS-DY                  PIC S9(03) COMP-5.

 LINKAGE SECTION.
 COPY "SCENT-GRID.cpy".
 01  LS-MONSTER-X           PIC 9(03) COMP-5.
 01  LS-MONSTER-Y           PIC 9(03) COMP-5.
 01  LS-DISTANCE            PIC 9(04) COMP-5.

 PROCEDURE DIVISION USING SCENT-MAP-BUFFER, LS-MONSTER-X, LS-MONSTER-Y, LS-DISTANCE.
 0000-MAIN.
     COMPUTE WS-DX = LS-MONSTER-X - SCENT-TARGET-X
     IF WS-DX < 0 COMPUTE WS-DX = -1 * WS-DX END-IF
     COMPUTE WS-DY = LS-MONSTER-Y - SCENT-TARGET-Y
     IF WS-DY < 0 COMPUTE WS-DY = -1 * WS-DY END-IF
     COMPUTE LS-DISTANCE = WS-DX + WS-DY
     GOBACK.
