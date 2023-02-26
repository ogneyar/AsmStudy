   00 XX               NEG    (soff,SP)          ; Negate (Logical 2's complement)            M(soff+SP) <= -M(soff+SP)
72 00 MS LS XX         BTJT   lmem, #0, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#0==1 СС.C<=M(lmem).#0
   01                  RRWA   X                  ; Rotate Word Right through A                A -> XH -> XL - > A
72 01 MS LS XX         BTJF   lmem, #0, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#0==0 СС.C<=M(lmem).#0
90 01                  RRWA   Y                  ; Rotate Word Right through A                A -> YH -> YL - > A
   02                  RLWA   X                  ; Rotate Word Left through A                 A <- XH <- XL <- A
72 02 MS LS XX         BTJT   lmem, #1, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#1==1 СС.C<=M(lmem).#1
90 02                  RLWA   Y                  ; Rotate Word Left through A                 A <- YH <- YL <- A
   03 XX               CPL    (soff,SP)          ; Logical 1's complement                     M(soff+SP) <= /M(soff+SP)
72 03 MS LS XX         BTJF   lmem, #1, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#1==0 СС.C<=M(lmem).#1
   04 XX               SRL    (soff,SP)          ; Shift Right Logical                        M(soff+SP).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 04 MS LS XX         BTJT   lmem, #2, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#2==1 СС.C<=M(lmem).#2
   05                                            ; illegal opcode       
72 05 MS LS XX         BTJF   lmem, #2, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#2==0 СС.C<=M(lmem).#2
   06 XX               RRC    (soff,SP)          ; Rotate Right Logical through Carry         M(soff+SP).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 06 MS LS XX         BTJT   lmem, #3, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#3==1 СС.C<=M(lmem).#3
   07 XX               SRA    (soff,SP)          ; Shift Right Arithmetic                     M(soff+SP).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 07 MS LS XX         BTJF   lmem, #3, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#3==0 СС.C<=M(lmem).#3
   08 XX               SLA    (soff,SP)          ; Shift Left Arithmetic                      M(soff+SP).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   08 XX               SLL    (soff,SP)          ; Shift Left Logical                         M(soff+SP).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 08 MS LS XX         BTJT   lmem, #4, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#4==1 СС.C<=M(lmem).#4
   09 MS LS            RLC    (soff,SP)          ; Rotate Left Logical through Carry          M(soff+SP).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
72 09 MS LS XX         BTJF   lmem, #4, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#4==0 СС.C<=M(lmem).#4
   0A XX               DEC    (soff,SP)          ; Decrement                                  M(soff+SP) <= M(soff+SP) - 1
72 0A MS LS XX         BTJT   lmem, #5, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#5==1 СС.C<=M(lmem).#5
   0B                                            ; illegal opcode       
72 0B MS LS XX         BTJF   lmem, #5, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#5==0 СС.C<=M(lmem).#5
   0C XX               INC    (soff,SP)          ; Increment                                  M(soff+SP) <= M(soff+SP) + 1
72 0C MS LS XX         BTJT   lmem, #6, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#6==1 СС.C<=M(lmem).#6
   0D XX               TNZ    (soff,SP)          ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test{ M(soff+SP }
72 0D MS LS XX         BTJF   lmem, #6, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#6==0 СС.C<=M(lmem).#6
   0E                                            ;               ???????       
72 0E MS LS XX         BTJT   lmem, #7, ssoff    ; BitTest and Jump if True                   PC<=PC+ssoff if M(lmem).#7==1 СС.C<=M(lmem).#7
90 0E XX               SWAP   (soff,SP)          ; Swap Nibbles                               M(soff+SP).low <-> M(soff+SP).high
   0F XX               CLR    (soff,SP)          ; Clear                                      M(soff+SP) <= 0
72 0F MS LS XX         BTJF   lmem, #7, ssoff    ; BitTest and Jump if False                  PC<=PC+ssoff if M(lmem).#7==0 СС.C<=M(lmem).#7
   10 XX               SUB    A, (soff,SP)       ; Subtraction                                A <= A - M(soff+SP)
72 10 MS LS            BSET   lmem, #0           ; Bit Set                                    M(lmem).#0 <= 1 
90 10 MS LS            BCPL   lmem, #0           ; Bit Complement                             M(lmem).#0 <= /M(lmem).#0
   11 XX               CP     A, (soff,SP)       ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(soff+SP) }
72 11 MS LS            BRES   lmem, #0           ; Bit Reset                                  M(lmem).#0 <= 0
90 11 MS LS            BCCM   lmem, #0           ; Copy Carry Bit                             M(lmem).#0 <= CC.C
   12 XX               SBC    A, (soff,SP)       ; Subtraction                                A <= A - M(soff+SP)
72 12 MS LS            BSET   lmem, #1           ; Bit Set                                    M(lmem).#1 <= 1  
90 12 MS LS            BCPL   lmem, #1           ; Bit Complement                             M(lmem).#1 <= /M(lmem).#1 
   13 XX               CPW    X, (soff,SP)       ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(soff+SP).w }
72 13 MS LS            BRES   lmem, #1           ; Bit Reset                                  M(lmem).#1 <= 0
90 13 MS LS            BCCM   lmem, #1           ; Copy Carry Bit                             M(lmem).#1 <= CC.C
   14 XX               AND    A, (soff,SP)       ; Logical AND                                A <= A AND M(soff+SP) 
72 14 MS LS            BSET   lmem, #2           ; Bit Set                                    M(lmem).#2 <= 1 
90 14 MS LS            BCPL   lmem, #2           ; Bit Complement                             M(lmem).#2 <= /M(lmem).#2 
   15 XX               BCP    A, (soff,SP)       ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(soff,SP) }
72 15 MS LS            BRES   lmem, #2           ; Bit Reset                                  M(lmem).#2 <= 0
90 15 MS LS            BCCM   lmem, #2           ; Copy Carry Bit                             M(lmem).#2 <= CC.C 
   16                                            ;               ???????       
72 16 MS LS            BSET   lmem, #3           ; Bit Set                                    M(lmem).#3 <= 1
90 16 MS LS            BCPL   lmem, #3           ; Bit Complement                             M(lmem).#3 <= /M(lmem).#3
   17 XX               LDW    (soff,SP), Y       ; Load Word                                  M(soff+SP) <= Y
72 17 MS LS            BRES   lmem, #3           ; Bit Reset                                  M(lmem).#3 <= 0
90 17 MS LS            BCCM   lmem, #3           ; Copy Carry Bit                             M(lmem).#3 <= CC.C
   18 XX               XOR    A, (soff,SP)       ; Logical Exclusive OR                       A <= A XOR M(soff+SP)
72 18 MS LS            BSET   lmem, #4           ; Bit Set                                    M(lmem).#4 <= 1 
90 18 MS LS            BCPL   lmem, #4           ; Bit Complement                             M(lmem).#4 <= /M(lmem).#4
   19 XX               ADC    A, (soff,SP)       ; Addition with Carry                        A <= A + M(soff+SP) + CC.C
72 19 MS LS            BRES   lmem, #4           ; Bit Reset                                  M(lmem).#4 <= 0
90 19 MS LS            BCCM   lmem, #4           ; Copy Carry Bit                             M(lmem).#4 <= CC.C
   1A XX               OR     A, (soff,SP)       ; Logical OR                                 A <= A OR M(soff+SP)
72 1A MS LS            BSET   lmem, #5           ; Bit Set                                    M(lmem).#5 <= 1 
90 1A MS LS            BCPL   lmem, #5           ; Bit Complement                             M(lmem).#5 <= /M(lmem).#5
   1B XX               ADD    A, (soff,SP)       ; Addition                                   A <= A + M(soff+SP)
72 1B MS LS            BRES   lmem, #5           ; Bit Reset                                  M(lmem).#5 <= 0
90 1B MS LS            BCCM   lmem, #5           ; Copy Carry Bit                             M(lmem).#5 <= CC.C 
   1C MS LS            ADDW   X, #word           ; Addition Word                              X <= X + #word
72 1C MS LS            BSET   lmem, #6           ; Bit Set                                    M(lmem).#6 <= 1
90 1C MS LS            BCPL   lmem, #6           ; Bit Complement                             M(lmem).#6 <= /M(lmem).#6
   1D MS LS            SUBW   X, #word           ; Subtraction Word                           X <= X - #word
72 1D MS LS            BRES   lmem, #6           ; Bit Reset                                  M(lmem).#6 <= 0
90 1D MS LS            BCCM   lmem, #6           ; Copy Carry Bit                             M(lmem).#6 <= CC.C
   1E XX               LDW    X, (soff,SP)       ; Load Word                                  X <= M(soff+SP)
72 1E MS LS            BSET   lmem, #7           ; Bit Set                                    M(lmem).#7 <= 1 
90 1E MS LS            BCPL   lmem, #7           ; Bit Complement                             M(lmem).#7 <= /M(lmem).#7
   1F                                            ;               ???????       
72 1F MS LS            BRES   lmem, #7           ; Bit Reset                                  M(lmem).#7 <= 0
90 1F MS LS            BCCM   lmem, #7           ; Copy Carry Bit                             M(lmem).#7 <= CC.C 
   20 XX               JRA    ssoff              ; Jump Relative Always                       PC <= PC + ssoff
   20 XX               JRT    ssoff              ; Relative jump if True                      PC <= PC + ssoff
   21 XX               JRF    ssoff              ; Relative jump if False                     always skip (PC <= PC + 2)
   22 XX               JRUGT  ssoff              ; Relative jump if Unsigned Greater Than     PC<=PC+ssoff if CC.C==0 AND CC.Z==0
   23 XX               JRULE  ssoff              ; Relative jump if Unsigned Lower or Equal   PC<=PC+ssoff if CC.C==1 AND CC.Z==1
   24 XX               JRNC   ssoff              ; Relative jump if Not Carry                 PC<=PC+ssoff if CC.C==0
   24 XX               JRUGE  ssoff              ; Relative jump if Unsigned Greater or Equal PC<=PC+ssoff if CC.C==0
   25 XX               JRC    ssoff              ; Relative jump if Carry                     PC<=PC+ssoff if CC.C==1
   25 XX               JRULT  ssoff              ; Relative jump if Unsigned Lower Than       PC<=PC+ssoff if CC.C==1
   26 XX               JRNE   ssoff              ; Relative jump if Not equal                 PC<=PC+ssoff if CC.Z==0
   27 XX               JREQ   ssoff              ; Relative jump if Equal                     PC<=PC+ssoff if CC.Z==1
   28 XX               JRNV   ssoff              ; Relative jump if Not overflow              PC<=PC+ssoff if CC.V==0
90 28 XX               JRNH   ssoff              ; Relative jump if Not Half-Carry            PC<=PC+ssoff if CC.H==0
   29 XX               JRV    ssoff              ; Relative jump if Overflow                  PC<=PC+ssoff if CC.V==1
90 29 XX               JRH    ssoff              ; Relative jump if Half-Carry                PC<=PC+ssoff if CC.H==1
   2A XX               JRPL   ssoff              ; Relative jump if Plus                      PC<=PC+ssoff if CC.N==0
   2B XX               JRMI   ssoff              ; Relative jump if Minus                     PC<=PC+ssoff if CC.N==1
   2C XX               JRSGT  ssoff              ; Relative jump if Signed Greater Than       PC<=PC+ssoff if {CC.Z OR {CC.N XOR CC.V}}==0
90 2C XX               JRNM   ssoff              ; Relative jump if Not Interrupt Mask        PC<=PC+ssoff if {CC.I0 AND CC.I1}==0
   2D XX               JRSLE  ssoff              ; Relative jump if Signed Lower or Equal     PC<=PC+ssoff if {CC.Z OR {CC.N XOR CC.V}}==1
90 2D XX               JRM    ssoff              ; Relative jump if Interrupt Mask            PC<=PC+ssoff if {CC.I0 AND CC.I1}==1
   2E XX               JRSGE  ssoff              ; Relative jump if Signed Greater or Equal   PC<=PC+ssoff if {CC.N  XOR CC.V} ==0
90 2E XX               JRIL   ssoff              ; Relative jump if Interrupt Line is Low     PC<=PC+ssoff if Port INT pin==0
   2F XX               JRSLT  ssoff              ; Relative jump if Signed Lower Than         PC<=PC+ssoff if {CC.N  XOR CC.V} ==1
90 2F XX               JRIH   ssoff              ; Relative jump if Interrupt Line is High    PC<=PC+ssoff f Port INT pin==1
   30 XX               NEG    smem               ; Negate (Logical 2's complement)            M(smem) <= -M(smem)
72 30 XX               NEG    [lptr.w]           ; Negate (Logical 2's complement)            M(M(lptr).w) <= -M(M(lptr).w)
92 30 XX               NEG    [sptr.w]           ; Negate (Logical 2's complement)            M(M(sptr).w) <= -M(M(sptr).w)
   31 MS LS            EXG    A, lmem            ; Exchange                                   A <-> M(lmem)
   32 MS LS            POP    lmem               ; Pop from stack                             SP++  M(lmem) <= M(SP)
   33 XX               CPL    smem               ; Logical 1's complement                     M(smem) <= /M(smem)
72 33 MS LS            CPL    [lptr.w]           ; Logical 1's complement                     M(M(lptr).w) <= /M(M(lptr).w)
92 33 XX               CPL    [sptr.w]           ; Logical 1's complement                     M(M(sptr).w) <= /M(M(sptr).w)
   34 XX               SRL    smem               ; Shift Right Logical                        M(smem).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 34 MS LS            SRL    [lptr.w]           ; Shift Right Logical                        M(M(lptr).w).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
92 34 XX               SRL    [sptr.w]           ; Shift Right Logical                        M(M(sptr).w).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   35 XX MS LS         MOV    lmem, #byte        ; Move                                       M(lmem) <= #byte
   36 XX               RRC    smem               ; Rotate Right Logical through Carry         M(smem).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 36 MS LS            RRC    [lptr.w]           ; Rotate Right Logical through Carry         M(M(lptr).w).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
92 36 XX               RRC    [sptr.w]           ; Rotate Right Logical through Carry         M(M(sptr).w).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   37 XX               SRA    smem               ; Shift Right Arithmetic                     M(smem).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 37 MS LS            SRA    [lptr.w]           ; Shift Right Arithmetic                     M(M(lptr).w).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
92 37 XX               SRA    [sptr.w]           ; Shift Right Arithmetic                     M(M(sptr).w).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   38 XX               SLA    smem               ; Shift Left Arithmetic                      M(smem).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   38 XX               SLL    smem               ; Shift Left Logical                         M(smem).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 38 MS LS            SLA    [lptr.w]           ; Shift Left Arithmetic                      M(M(lptr).w).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 38 MS LS            SLL    [lptr.w]           ; Shift Left Logical                         M(M(lptr).w).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
92 38 XX               SLA    [sptr.w]           ; Shift Left Arithmetic                      M(M(sptr).w).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
92 38 XX               SLL    [sptr.w]           ; Shift Left Logical                         M(M(sptr).w).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   39 XX               RLC    smem               ; Rotate Left Logical through Carry          M(smem).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
72 39 MS LS            RLC    [lptr.w]           ; Rotate Left Logical through Carry          M(M(lptr).w).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
92 39 XX               RLC    [sptr.w]           ; Rotate Left Logical through Carry          M(M(sptr).w).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
   3A XX               DEC    smem               ; Decrement                                  M(smem)      <= M(smem)      - 1
72 3A XX               DEC    [lptr.w]           ; Decrement                                  M(M(lptr).w) <= M(M(lptr).w) - 1
92 3A XX               DEC    [sptr.w]           ; Decrement                                  M(M(sptr).w) <= M(M(sptr).w) - 1
   3B MS LS            PUSH   lmem               ; Push onto the Stack                        M(SP--) <= M(lmem)  postincrement
   3C XX               INC    smem               ; Increment                                  M(smem)      <= M(smem)      + 1
72 3C MS LS            INC    [lptr.w]           ; Increment                                  M(M(lptr).w) <= M(M(lptr).w) + 1
92 3C XX               INC    [sptr.w]           ; Increment                                  M(M(sptr).w) <= M(M(sptr).w) + 1
   3D XX               TNZ    smem               ; Test for Negative or Zero                  {N, Z} <= Test{ M(smem) }
72 3D MS LS            TNZ    [lptr.w]           ; Test for Negative or Zero                  {N, Z} <= Test{ M(M(lptr).w) }
92 3D XX               TNZ    [sptr.w]           ; Test for Negative or Zero                  {N, Z} <= Test{ M(M(sptr).w) }
   3E XX               SWAP   smem               ; Swap Nibbles                               M(smem).low      <-> M(smem).high     
72 3E XX               SWAP   [lptr.w]           ; Swap Nibbles                               M(M(lptr).w).low <-> M(M(lptr).w).high
92 3E XX               SWAP   [sptr.w]           ; Swap Nibbles                               M(M(sptr).w).low <-> M(M(sptr).w).high
   3F XX               CLR    smem               ; Clear                                      M(smem)      <= 0
72 3F MS LS            CLR    [lptr.w]           ; Clear                                      M(M(lptr).w) <= 0
92 3F XX               CLR    [sptr.w]           ; Clear                                      M(M(sptr).w) <= 0
   40                  NEG    A                  ; Negate (Logical 2's complement)            A         <= -A
72 40 MS LS            NEG    (loff,X)           ; Negate (Logical 2's complement)            M(loff+X) <= -M(loff+X)
90 40 MS LS            NEG    (loff,Y)           ; Negate (Logical 2's complement)            M(loff+Y) <= -M(loff+Y)
   41                  EXG    A, XL              ; Exchange                                   A <-> XL
   42                  MUL    X, A               ; Multiply(unsigned)                         X <= XL * A
90 42                  MUL    Y, A               ; Multiply(unsigned)                         Y <= YL * A
   43                  CPL    A                  ; Logical 1's complement                     A         <= /A
72 43 MS LS            CPL    (loff,X)           ; Logical 1's complement                     M(loff+X) <= /M(loff+X)
90 43 MS LS            CPL    (loff,Y)           ; Logical 1's complement                     M(loff+Y) <= /M(loff+Y)
   44                  SRL    A                  ; Shift Right Logical                        A.{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 44 MS LS            SRL    (loff,X)           ; Shift Right Logical                        M(loff+X).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 44 MS LS            SRL    (loff,Y)           ; Shift Right Logical                        M(loff+Y).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   45 XX2 XX1          MOV    smem1, smem2       ; Move                                       M(smem1) <= M(smem2)
   46                  RRC    A                  ; Rotate Right Logical through Carry         A.{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 46 MS LS            RRC    (loff,X)           ; Rotate Right Logical through Carry         M(loff+X).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 46 MS LS            RRC    (loff,Y)           ; Rotate Right Logical through Carry         M(loff+Y).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   47                  SRA    A                  ; Shift Right Arithmetic                     A.{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 47 MS LS            SRA    (loff,X)           ; Shift Right Arithmetic                     M(loff+X).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 47 MS LS            SRA    (loff,Y)           ; Shift Right Arithmetic                     M(loff+Y).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   48                  SLA    A                  ; Shift Left Arithmetic                      A.{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   48                  SLL    A                  ; Shift Left Logical                         A.{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 48 MS LS            SLA    (loff,X)           ; Shift Left Arithmetic                      M(loff+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 48 MS LS            SLL    (loff,X)           ; Shift Left Logical                         M(loff+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
90 48 MS LS            SLA    (loff,Y)           ; Shift Left Arithmetic                      M(loff+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
90 48 MS LS            SLL    (loff,Y)           ; Shift Left Logical                         M(loff+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   49                  RLC    A                  ; Rotate Left Logical through Carry          A.{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
72 49 MS LS            RLC    (loff,X)           ; Rotate Left Logical through Carry          M(loff+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
90 49 MS LS            RLC    (loff,Y)           ; Rotate Left Logical through Carry          M(loff+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
   4A                  DEC    A                  ; Decrement                                  A         <= A - 1
72 4A MS LS            DEC    (loff,X)           ; Decrement                                  M(loff+X) <= M(loff+X) - 1
90 4A MS LS            DEC    (loff,Y)           ; Decrement                                  M(loff+Y) <= M(loff+Y) - 1
   4B XX               PUSH   #byte              ; Push onto the Stack                        M(SP) <= #byte SP <= SP - 1
   4C                  INC    A                  ; Increment                                  A         <= A + 1
72 4C MS LS            INC    (loff,X)           ; Increment                                  M(loff+X) <= M(loff+X) + 1
90 4C MS LS            INC    (loff,Y)           ; Increment                                  M(loff+Y) <= M(loff+Y) + 1
   4D                  TNZ    A                  ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test{ A }
72 4D MS LS            TNZ    (loff,X)           ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test{ M(loff+X) }
90 4D MS LS            TNZ    (loff,Y)           ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test{ M(loff+Y) }
   4E                  SWAP   A                  ; Swap Nibbles                               A.low         <-> A.high        
72 4E MS LS            SWAP   (loff,X)           ; Swap Nibbles                               M(loff+X).low <-> M(loff+X).high
90 4E MS LS            SWAP   (loff,Y)           ; Swap Nibbles                               M(loff+Y).low <-> M(loff+Y).high
   4F                  CLR    A                  ; Clear                                      A         <= 0
72 4F MS LS            CLR    (loff,X)           ; Clear                                      M(loff+X) <= 0
90 4F MS LS            CLR    (loff,Y)           ; Clear                                      M(loff+Y) <= 0
   50                  NEGW   X                  ; Negate Word (Logical 2s Complement)        X <= -X
72 50 MS LS            NEG    lmem               ; Negate (Logical 2's complement)            M(lmem) <= -M(lmem)
90 50                  NEGW   Y                  ; Negate Word (Logical 2s Complement)        Y <= -Y
   51                  EXGW   X, Y               ; Exchange Word                              X <-> Y
   52 XX               SUB    SP, #byte          ; Subtraction                                SP <= SP - #byte
   53                  CPLW   X                  ; Logical 1's complement                     X <= /X
72 53 MS LS            CPL    lmem               ; Logical 1's complement                     M(lmem) <= /M(lmem)
90 53                  CPLW   Y                  ; Logical 1's complement                     Y <= /Y
   54                  SRLW   X                  ; Shift Right Logical Word                   X.{0->#15->#14->#13->...->#2->#1->#0->CC.C}
72 54 MS LS            SRL    lmem               ; Shift Right Logical                        M(lmem).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 54                  SRLW   Y                  ; Shift Right Logical Word                   Y.{0->#15->#14->#13->...->#2->#1->#0->CC.C}
   55 MS2 LS2 MS1 LS1  MOV    lmem1, lmem2       ; Move                                       M(lmem1) <= M(lmem2)
   56                  RRCW   X                  ; Rotate Word Right Logical through Carry    X.{CC.C->#15->#14->#13->...->#2->#1->#0->CC.C}
72 56 MS LS            RRC    lmem               ; Rotate Right Logical through Carry         M(lmem).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 56                  RRCW   Y                  ; Rotate Word Right Logical through Carry    Y.{CC.C->#15->#14->#13->...->#2->#1->#0->CC.C}
   57                  SRAW   X                  ; Shift Right Arithmetic Word                X.{#15->#14->#13->...->#2->#1->#0->CC.C}
72 57 MS LS            SRA    lmem               ; Shift Right Arithmetic                     M(lmem).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 57                  SRAW   Y                  ; Shift Right Arithmetic Word                Y.{#15->#14->#13->...->#2->#1->#0->CC.C}
   58                  SLAW   X                  ; Shift Left Arithmetic Word                 X.{CC.C<-#15<-#14<-#13<-...<-#2<-#1<-#0<-0}
   58                  SLLW   X                  ; Shift Left Logical Word                    X.{CC.C<-#15<-#14<-#13<-...<-#2<-#1<-#0<-0}
72 58 MS LS            SLA    lmem               ; Shift Left Arithmetic                      M(lmem).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 58 MS LS            SLL    lmem               ; Shift Left Logical                         M(lmem).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
90 58                  SLAW   Y                  ; Shift Left Arithmetic Word                 Y.{CC.C<-#15<-#14<-#13<-...<-#2<-#1<-#0<-0}
90 58                  SLLW   Y                  ; Shift Left Logical Word                    Y.{CC.C<-#15<-#14<-#13<-...<-#2<-#1<-#0<-0}
   59                  RLCW   X                  ; Rotate Word Left Logical through Carry     X.{CC.C<-#15<-#14<-#13<-...<-#2<-#1<-#0<-CC.C}
72 59 MS LS            RLC    lmem               ; Rotate Left Logical through Carry          M(lmem).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
90 59                  RLCW   Y                  ; Rotate Word Left Logical through Carry     Y.{CC.C<-#15<-#14<-#13<-...<-#2<-#1<-#0<-CC.C}
   5A                  DECW   X                  ; Decrement                                  X <= X - 1
72 5A MS LS            DEC    lmem               ; Decrement                                  M(lmem) <= M(lmem) - 1
90 5A                  DECW   Y                  ; Decrement                                  Y <= Y - 1
   5B XX               ADDW   SP, #byte          ; Addition                                   SP <= SP + #byte
   5C                  INCW   X                  ; Increment                                  X <= X + 1
72 5C MS LS            INC    lmem               ; Increment                                  M(lmem) <= M(lmem) + 1
90 5C                  INCW   Y                  ; Increment                                  Y <= Y + 1
   5D                  TNZW   X                  ; Test Word for Negative or Zero             {CC.N, CC.Z} <= Test{ X }
72 5D MS LS            TNZ    lmem               ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test{ M(lmem) }
90 5D                  TNZW   Y                  ; Test Word for Negative or Zero             {CC.N, CC.Z} <= Test{ Y }
   5E                  SWAPW  X                  ; Swap Bytes of Word                         XH <-> XL 
72 5E MS LS            SWAP   lmem               ; Swap Nibbles                               M(lmem).low <-> (lmem).high
90 5E                  SWAPW  Y                  ; Swap Bytes of Word                         YH <-> YL 
   5F                  CLRW   X                  ; Clear                                      X       <= 0
72 5F MS LS            CLR    lmem               ; Clear                                      M(lmem) <= 0
90 5F                  CLRW   Y                  ; Clear                                      Y       <= 0
   60 XX               NEG    (soff,X)           ; Negate (Logical 2's complement)            M(soff+X)      <= -M(soff+X)
72 60 MS LS            NEG    ([lptr.w],X)       ; Negate (Logical 2's complement)            M(M(lptr).w+X) <= -M(M(lptr).w+X)
90 60 XX               NEG    (soff,Y)           ; Negate (Logical 2's complement)            M(soff+Y)      <= -M(soff+Y)
91 60 XX               NEG    ([sptr.w],Y)       ; Negate (Logical 2's complement)            M(M(sptr).w+Y) <= -M(M(sptr).w+Y)
92 60 XX               NEG    ([sptr.w],X)       ; Negate (Logical 2's complement)            M(M(sptr).w+X) <= -M(M(sptr).w+X)
   61                  EXG    A, YL              ; Exchange                                   A <-> YL
   62                  DIV    X, A               ; Divide (unsigned)                          X <= X % A, remainder in A
90 62                  DIV    Y, A               ; Divide (unsigned)                          Y <= Y % A, remainder in A
   63 XX               CPL    (soff,X)           ; Logical 1's complement                     M(soff+X)      <= /M(soff+X)
72 63 MS LS            CPL    ([lptr.w],X)       ; Logical 1's complement                     M(M(lptr).w+X) <= /M(M(lptr).w+X)
90 63 XX               CPL    (soff,Y)           ; Logical 1's complement                     M(soff+Y)      <= /M(soff+Y)
91 63 XX               CPL    ([sptr.w],Y)       ; Logical 1's complement                     M(M(sptr).w+Y) <= /M(M(sptr).w+Y)
92 63 XX               CPL    ([sptr.w],X)       ; Logical 1's complement                     M(M(sptr).w+X) <= /M(M(sptr).w+X)
   64 XX               SRL    (soff,X)           ; Shift Right Logical                        M(soff+X).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 64 MS LS            SRL    ([lptr.w],X)       ; Shift Right Logical                        M(M(lptr).w+X).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 64 XX               SRL    (soff,Y)           ; Shift Right Logical                        M(soff+Y).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
91 64 XX               SRL    ([sptr.w],Y)       ; Shift Right Logical                        M(M(sptr).w+Y).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
92 64 XX               SRL    ([sptr.w],X)       ; Shift Right Logical                        M(M(sptr).w+X).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   65                  DIV    X, Y               ; Divide word (unsigned)                     X <= X % Y, remainder in Y
   66 XX               RRC    (soff,X)           ; Rotate Right Logical through Carry         M(soff+X).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 66 MS LS            RRC    ([lptr.w],X)       ; Rotate Right Logical through Carry         M(M(lptr).w+X).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 66 XX               RRC    (soff,Y)           ; Rotate Right Logical through Carry         M(soff+Y).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
91 66 XX               RRC    ([sptr.w],Y)       ; Rotate Right Logical through Carry         M(M(sptr).w+Y).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
92 66 XX               RRC    ([sptr.w],X)       ; Rotate Right Logical through Carry         M(M(sptr).w+X).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   67 XX               SRA    (soff,X)           ; Shift Right Arithmetic                     M(soff+X).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
72 67 XX               SRA    ([lptr.w],X)       ; Shift Right Arithmetic                     M(M(lptr).w+X).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 67 XX               SRA    (soff,Y)           ; Shift Right Arithmetic                     M(soff+Y).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
91 67 XX               SRA    ([sptr.w],Y)       ; Shift Right Arithmetic                     M(M(sptr).w+Y).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
92 67 XX               SRA    ([sptr.w],X)       ; Shift Right Arithmetic                     M(M(sptr).w+X).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   68 XX               SLA    (soff,X)           ; Shift Left Arithmetic                      M(soff+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   68 XX               SLL    (soff,X)           ; Shift Left Logical                         M(soff+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 68 XX               SLA    ([lptr.w],X)       ; Shift Left Arithmetic                      M(M(lptr).w+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
72 68 XX               SLL    ([lptr.w],X)       ; Shift Left Logical                         M(M(lptr).w+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
90 68 XX               SLA    (soff,Y)           ; Shift Left Arithmetic                      M(soff+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
90 68 XX               SLL    (soff,Y)           ; Shift Left Logical                         M(soff+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
91 68 XX               SLA    ([sptr.w],Y)       ; Shift Left Arithmetic                      M(M(sptr).w+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
91 68 XX               SLL    ([sptr.w],Y)       ; Shift Left Logical                         M(M(sptr).w+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
92 68 XX               SLA    ([sptr.w],X)       ; Shift Left Arithmetic                      M(M(sptr).w+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
92 68 XX               SLL    ([sptr.w],X)       ; Shift Left Logical                         M(M(sptr).w+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   69 XX               RLC    (soff,X)           ; Rotate Left Logical through Carry          M(soff+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
72 69 MS LS            RLC    ([lptr.w],X)       ; Rotate Left Logical through Carry          M(M(lptr).w+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
90 69 XX               RLC    (soff,Y)           ; Rotate Left Logical through Carry          M(soff+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
91 69 XX               RLC    ([sptr.w],Y)       ; Rotate Left Logical through Carry          M(M(sptr).w+Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
92 69 XX               RLC    ([sptr.w],X)       ; Rotate Left Logical through Carry          M(M(sptr).w+X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
   6A XX               DEC    (soff,X)           ; Decrement                                  M(soff+X)      <= M(soff+X) - 1
72 6A MS LS            DEC    ([lptr.w],X)       ; Decrement                                  M(M(lptr).w+X) <= M(M(lptr).w+X) - 1
90 6A XX               DEC    (soff,Y)           ; Decrement                                  M(soff+Y)      <= M(soff+Y) - 1
91 6A XX               DEC    ([sptr.w],Y)       ; Decrement                                  M(M(sptr).w+Y) <= M(M(sptr).w+Y) - 1
92 6A XX               DEC    ([sptr.w],X)       ; Decrement                                  M(M(sptr).w+X) <= M(M(sptr).w+X) - 1
   6B XX               LD     (soff,SP), A       ; Load                                       A <= M(soff+SP)
   6C XX               INC    (soff,X)           ; Increment                                  M(soff+X)      <= M(soff+X) + 1
72 6C MS LS            INC    ([lptr.w],X)       ; Increment                                  M(M(lptr).w+X) <= M(M(lptr).w+X) + 1
90 6C XX               INC    (soff,Y)           ; Increment                                  M(soff+Y)      <= M(soff+Y) + 1
91 6C XX               INC    ([sptr.w],Y)       ; Increment                                  M(M(sptr).w+Y) <= M(M(sptr).w+Y) + 1
92 6C XX               INC    ([sptr.w],X)       ; Increment                                  M(M(sptr).w+X) <= M(M(sptr).w+X) + 1
   6D XX               TNZ    (soff,X)           ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test {M(soff+X)} 
72 6D MS LS            TNZ    ([lptr.w],X)       ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test {M(M(lptr).w+X)}
90 6D XX               TNZ    (soff,Y)           ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test {M(soff+Y)}
91 6D XX               TNZ    ([sptr.w],Y)       ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test {M(M(sptr).w+Y)}
92 6D XX               TNZ    ([sptr.w],X)       ; Test for Negative or Zero                  {CC.N, CC.Z} <= Test {M(M(sptr).w+X)}
   6E XX               SWAP   (soff,X)           ; Swap Nibbles                               M(soff+X).low      <=> M(soff+X).high     
72 6E MS LS            SWAP   ([lptr.w],X)       ; Swap Nibbles                               M(M(lptr).w+X).low <=> M(M(lptr).w+X).high
90 6E XX               SWAP   (soff,Y)           ; Swap Nibbles                               M(soff+Y).low      <=> M(soff+Y).high     
91 6E XX               SWAP   ([sptr.w],Y)       ; Swap Nibbles                               M(M(sptr).w+Y).low <=> M(M(sptr).w+Y).high
92 6E XX               SWAP   ([sptr.w],X)       ; Swap Nibbles                               M(M(sptr).w+X).low <=> M(M(sptr).w+X).high
   6F XX               CLR    (soff,X)           ; Clear                                      M(soff+X)      <= 0
72 6F MS LS            CLR    ([lptr.w],X)       ; Clear                                      M(M(lptr).w+X) <= 0
90 6F XX               CLR    (soff,Y)           ; Clear                                      M(soff+Y)      <= 0
91 6F XX               CLR    ([sptr.w],Y)       ; Clear                                      M(M(sptr).w+Y) <= 0
92 6F XX               CLR    ([sptr.w],X)       ; Clear                                      M(M(sptr).w+X) <= 0
   70                  NEG    (X)                ; Negate (Logical 2's complement)            M(X) <= -M(X)
90 70                  NEG    (Y)                ; Negate (Logical 2's complement)            M(Y) <= -M(Y)
   71                                            ; illegal opcode       
   72                 ; prefix PWSP      
   73                  CPL    (X)                ; Logical 1's complement                     M(X) <= /M(X)
90 73                  CPL    (Y)                ; Logical 1's complement                     M(Y) <= /M(Y)
   74                  SRL    (X)                ; Shift Right Logical                        M(X).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 74                  SRL    (Y)                ; Shift Right Logical                        M(Y).{0->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   75                                            ; illegal opcode       
   76                  RRC    (X)                ; Rotate Right Logical through Carry         M(X).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 76                  RRC    (Y)                ; Rotate Right Logical through Carry         M(Y).{CC.C->#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   77                  SRA    (X)                ; Shift Right Arithmetic                     M(X).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
90 77                  SRA    (Y)                ; Shift Right Arithmetic                     M(Y).{#7->#6->#5->#4->#3->#2->#1->#0->CC.C}
   78                  SLA    (X)                ; Shift Left Arithmetic                      M(X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   78                  SLL    (X)                ; Shift Left Logical                         M(X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
90 78                  SLA    (Y)                ; Shift Left Arithmetic                      M(Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
90 78                  SLL    (Y)                ; Shift Left Logical                         M(Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-0}
   79                  RLC    (X)                ; Rotate Left Logical through Carry          M(X).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
90 79                  RLC    (Y)                ; Rotate Left Logical through Carry          M(Y).{CC.C<-#7<-#6<-#5<-#4<-#3<-#2<-#1<-#0<-CC.C}
   7A                  DEC    (X)                ; Decrement                                  M(X) <= M(X) - 1
90 7A                  DEC    (Y)                ; Decrement                                  M(Y) <= M(Y) - 1
   7B XX               LD     A, (soff,SP)       ; Load                                       A <= M(soff+SP)
   7C                  INC    (X)                ; Increment                                  M(X) <= M(X) - 1
90 7C                  INC    (Y)                ; Increment                                  M(Y) <= M(Y) - 1
   7D                  TNZ    (X)                ; Test for Negative or Zero                  {CC.N, CC.Z}<= Test{M(X)}
90 7D                  TNZ    (Y)                ; Test for Negative or Zero                  {CC.N, CC.Z}<= Test{M(Y)}
   7E                  SWAP   (X)                ; Swap Nibbles                               M(X).low <-> M(X).high
90 7E                  SWAP   (Y)                ; Swap Nibbles                               M(Y).low <-> M(Y).high
   7F                  CLR    (X)                ; Clear                                      M(X) <= 0
90 7F                  CLR    (Y)                ; Clear                                      M(Y) <= 0
   80                  IRET                      ; Interrupt Return                           CC<=M(++SP) A<=M(++SP) XH<=M(++SP)
                                                 ;                                            XL<=M(++SP) YH<=M(++SP) YL<=M(++SP) 
                                                 ;                                            PCE<=M(++SP) PCH<=M(++SP) PCL<=M(++SP) 
   81                  RET                       ; Return from subroutine                     PCH <= M(++SP)   PCL <= M(++SP)
   82 ExtB MS LS       INT    emem               ; Interrupt                                  PC <= emem
   83                  TRAP                      ; Software Interrupt
   84                  POP    A                  ; Pop from stack                             A  <= M(++SP)  preincremrnt
   85                  POPW   X                  ; Pop Word from stack                        XH <= M(++SP)  XL <= M(++SP)
90 85                  POPW   Y                  ; Pop Word from stack                        YH <= M(++SP)  YL <= M(++SP)
   86                  POP    CC                 ; Pop from stack                             CC <= M(++SP)  preincremrnt
   87                  RETF                      ; Far Return from subroutine                 PCE<=M(++SP) PCH<=M(++SP) PCL<=M(++SP)
   88                  PUSH   A                  ; Push into the Stack                        M(SP--) <= A   postdecremrnt
   89                  PUSHW  X                  ; Push Word onto the Stack                   M(SP--) <= XL  M(SP--) <= XH
90 89                  PUSHW  Y                  ; Push Word onto the Stack                   M(SP--) <= YL  M(SP--) <= YH
   8A                  PUSH   CC                 ; Push into the Stack                        M(SP--) <= CC  postdecremrnt
   8B                  BREAK                     ; Software break
   8C                  CCF                       ; Complement Carry Flag                      CC.C <= /CC.C
   8D ExtB MS LS       CALLF  emem               ; Call Far Subroutine                        M(SP--)<=PCL M(SP--)<-PCH M(SP--)<-PCE PC<=emem
92 8D MS LS            CALLF  [lptr.e]           ; Call Far Subroutine                        M(SP--)<=PCL M(SP--)<-PCH M(SP--)<-PCE PC<=M(lptr).e
   8E                  HALT                      ; Halt Oscillator (CPU + Peripherals)
   8F                  WFI                       ; Wait For Interrupt (CPU stopped, low power mode)
72 8F                  WFE                       ; Wait For Event (CPU stopped, low power mode)
   90                  ; prefix PDY              Replases an X based instruction by a Y one.
   91                  ; prefix PIY              indirect X by a Y one
   92                  ; prefix PIX              direct to indirect addressing mode  .
   93                  LDW    X, Y               ; Load Word                                  X  <= Y
90 93                  LDW    Y, X               ; Load Word                                  Y  <= X
   94                  LDW    SP, X              ; Load Word                                  SP <= X
90 94                  LDW    SP, Y              ; Load Word                                  SP <= Y
   95                  LD     XH, A              ; Load                                       XH <= A
90 95                  LD     YH, A              ; Load                                       YH <= A
   96                  LDW    X, SP              ; Load Word                                  X  <= SP
90 96                  LDW    Y, SP              ; Load Word                                  Y  <= SP
   97                  LD     XL, A              ; Load                                       XL <= A
90 97                  LD     YL, A              ; Load                                       YL <= A
   98                  RCF                       ; Reset Carry Flag                           CC.C <= 0
   99                  SCF                       ; Set Carry Flag                             CC.C <= 1
   9A                  RIM                       ; Reset Interrupt Mask / Enable Interrupt    CC.I1 <= 1 CC.I0 <= 0
   9B                  SIM                       ; Set Interrupt Mask / Disable Interrupt     CC.I1 <= 1 CC.I0 <= 1
   9C                  RVF                       ; Reset Overflow Flag                        CC.V <= 0
   9D                  NOP                       ; No operation
   9E                  LD     A, XH              ; Load                                       A <= XH
90 9E                  LD     A, YH              ; Load                                       A <= YH
   9F                  LD     A, XL              ; Load                                       A <= XL
90 9F                  LD     A, YL              ; Load                                       A <= YL
   A0 XX               SUB    A, #byte           ; Subtraction                                A <= A  -  #byte
   A1 XX               CP     A, #byte           ; Compare                                    {CC.N, CC.Z, CC.C}<= Test{A - #byte}
   A2 XX               SBC    A, #byte           ; Subtraction with Carry/Borrow              A <= A  -  #byte - CC.C
72 A2 MS LS            SUBW   Y, #word           ; Subtraction Word                           Y <= Y - #word
   A3 MS LS            CPW    X, #word           ; Compare Word                               {CC.N, CC.Z, CC.C}<= Test{X - #word}
90 A3 MS LS            CPW    Y, #word           ; Compare Word                               {CC.N, CC.Z, CC.C}<= Test{Y - #word}
   A4 XX               AND    A, #byte           ; Logical AND                                A <= A AND #byte
   A5 XX               BCP    A, #byte           ; Logical Bit Compare                        {CC.N, CC.Z}<= Test{A AND #byte}
   A6 XX               LD     A, #byte           ; Load                                       A              <= #byte
   A7 ExtB MS LS       LDF    (eoff,X), A        ; Load Far                                   M(eoff+X)      <= A
90 A7 ExtB MS LS       LDF    (eoff,Y), A        ; Load Far                                   M(eoff+Y)      <= A
91 A7 MS LS            LDF    ([lptr.e],Y), A    ; Load Far                                   M(M(lptr).e+Y) <= A
92 A7 MS LS            LDF    ([lptr.e],X), A    ; Load Far                                   M(M(lptr).e+X) <= A
   A8 XX               XOR    A, #byte           ; Logical Exclusive OR                       A <= A XOR #byte
   A9 XX               ADC    A, #byte           ; Addition with Carry                        A <= A  +  #byte + CC.C
72 A9 MS LS            ADDW   Y, #word           ; Addition Word                              Y <= Y  +  #word
   AA XX               OR     A, #byte           ; Logical OR                                 A <= A  OR #byte
   AB XX               ADD    A, #byte           ; Addition                                   A <= A  +  #byte
   AC ExtB MS LS       JPF    emem               ; Jump Far                                   PC <- emem
92 AC MS LS            JPF    [lptr.e]           ; Jump Far                                   PC <- M(lptr).e
   AD XX               CALLR  ssoff              ; CALL Subroutine Relative                   M(SP--)<=PCL M(SP--)<-PCH PC<=PC+ssoff
   AE MS LS            LDW    X, #word           ; Load Word                                  X <= #word
90 AE MS LS            LDW    Y, #word           ; Load Word                                  Y <= #word
   AF ExtB MS LS       LDF    A, (eoff,X)        ; Load                                       A <= M(eoff,X)
90 AF ExtB MS LS       LDF    A, (eoff,Y)        ; Load                                       A <= M(eoff,Y)
91 AF MS LS            LDF    A, ([lptr.e],Y)    ; Load                                       A <= M(M(lptr).e+Y)
92 AF MS LS            LDF    A, ([lptr.e],X)    ; Load                                       A <= M(M(lptr).e+M)
   B0 XX               SUB    A, smem            ; Subtraction                                A <= A  -  M(smem)
72 B0 MS LS            SUBW   X, lmem.w          ; Subtraction Word                           X <= X  -  M(lmem).w
   B1 XX               CP     A, smem            ; Compare                                    {CC.N, CC.Z, CC.C}<= Test{ A - M(smem) }
   B2 XX               SBC    A, smem            ; Subtraction with Carry/Borrow              A <= A  -  M(smem) - CC.C
72 B2 MS LS            SUBW   Y, lmem.w          ; Subtraction word                           Y <= Y  -  M(lmem).w
   B3 XX               CPW    X, smem.w          ; Compare Word                               {CC.N, CC.Z, CC.C}<= Test{ X - M(smem).w }
90 B3 XX               CPW    Y, smem.w          ; Compare Word                               {CC.N, CC.Z, CC.C}<= Test{ Y - M(smem).w }
   B4 XX               AND    A, smem            ; Logical AND                                A <= A  AND  M(smem) 
   B5 XX               BCP    A, smem            ; Logical Bit Compare                        {CC.N, CC.Z}<= Test{A AND M(smem)}
   B6 XX               LD     A, smem            ; Load                                       A       <= M(smem)
   B7 XX               LD     smem, A            ; Load                                       M(smem) <= A      
   B8 XX               XOR    A, smem            ; Logical Exclusive OR                       A <= A XOR M(smem)
   B9 XX               ADC    A, smem            ; Addition with Carry                        A <= A  +  M(smem) + CC.C
72 B9 MS LS            ADDW   Y, lmem.w          ; Addition  Word                             Y <= Y  +  M(lmem).w
   BA XX               OR     A, smem            ; Logical OR                                 A <= A  OR M(smem)
   BB XX               ADD    A, smem            ; Addition                                   A <= A  +  M(smem)
72 BB MS LS            ADDW   X, lmem.w          ; Addition Word                              X <= X  +  M(lmem).w
   BC ExtB MS LS       LDF    A, emem            ; Load Far                                   A <= M(emem)
92 BC MS LS            LDF    A, [lptr.e]        ; Load Far                                   A <= M(M(lptr).e)
   BD ExtB MS LS       LDF    emem, A            ; Load Far                                   M(emem)      <= A
92 BD MS LS            LDF    [lptr.e], A        ; Load Far                                   M(M(lptr).e) <= A
   BE XX               LDW    X, smem.w          ; Load                                       X         <= M(smem).w
90 BE XX               LDW    Y, smem.w          ; Load                                       Y         <= M(smem).w
   BF XX               LDW    smem.w, X          ; Load                                       M(smem).w <= X
90 BF XX               LDW    smem.w, Y          ; Load                                       M(smem).w <= Y
   C0 MS LS            SUB    A, lmem            ; Subtraction                                A <= A  -  M(Lmem)
72 C0 XX               SUB    A, [lptr.w]        ; Subtraction                                A <= A  -  M(M(lptr).w)
92 C0 XX               SUB    A, [sptr.w]        ; Subtraction                                A <= A  -  M(M(sptr).w)
   C1 MS LS            CP     A, lmem            ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(lmem) }
72 C1 MS LS            CP     A, [lptr.w]        ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(M(lptr).w) }
92 C1 XX               CP     A, [sptr.w]        ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(M(sptr).w) }
   C2 MS LS            SBC    A, lmem            ; Subtraction with Carry/Borrow              A <= A  -  M(lmem)      - CC.C
72 C2 MS LS            SBC    A, [lptr.w]        ; Subtraction with Carry/Borrow              A <= A  -  M(M(lptr).w) - CC.C
92 C2 XX               SBC    A, [sptr.w]        ; Subtraction with Carry/Borrow              A <= A  -  M(M(sptr).w) - CC.C
   C3 MS LS            CPW    X, lmem.w          ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(lmem).w }
72 C3 MS LS            CPW    X, [lptr.w]        ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(M(lptr).w).w }
90 C3 MS LS            CPW    Y, lmem.w          ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ Y - M(lmem).w }
91 C3 XX               CPW    Y, [lptr.w]        ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ Y - M(M(lptr).w).w }
92 C3 XX               CPW    X, [sptr.w]        ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(M(sptr).w).w }
   C4 MS LS            AND    A, lmem            ; Logical AND                                A <= A  AND  M(lmem) 
72 C4 MS LS            AND    A, [lptr.w]        ; Logical AND                                A <= A  AND  M(M(lptr).w) 
92 C4 XX               AND    A, [sptr.w]        ; Logical AND                                A <= A  AND  M(M(sptr).w) 
   C5 MS LS            BCP    A, lmem            ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(lmem) }
72 C5 MS LS            BCP    A, [lptr.w]        ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(M(lptr).w) }
92 C5 XX               BCP    A, [sptr.w]        ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(M(sptr).w) }
   C6 MS LS            LD     A, lmem            ; Load                                       A            <= M(lmem)
72 C6 MS LS            LD     A, [lptr.w]        ; Load                                       A            <= M(M(lptr).w)
92 C6 XX               LD     A, [sptr.w]        ; Load                                       A            <= M(M(sptr).w)
   C7 MS LS            LD     lmem, A            ; Load                                       M(lmem)      <= A
72 C7 MS LS            LD     [lptr.w], A        ; Load                                       M(M(lptr).w) <= A
92 C7 XX               LD     [sptr.w], A        ; Load                                       M(M(sptr).w) <= A
   C8 MS LS            XOR    A, lmem            ; Logical Exclusive OR                       A <= A XOR M(lmem)
72 C8 MS LS            XOR    A, [lptr.w]        ; Logical Exclusive OR                       A <= A XOR M(M(lptr).w)
92 C8 XX               XOR    A, [sptr.w]        ; Logical Exclusive OR                       A <= A XOR M(M(sptr).w)
   C9 MS LS            ADC    A, lmem            ; Addition with Carry                        A <= A  +  M(lmem) + CC.C
72 C9 MS LS            ADC    A, [lptr.w]        ; Addition with Carry                        A <= A  +  M(M(lptr).w) + CC.C
92 C9 XX               ADC    A, [sptr.w]        ; Addition with Carry                        A <= A  +  M(M(sptr).w) + CC.C
   CA MS LS            OR     A, lmem            ; Logical OR                                 A <= A  OR M(lmem)
72 CA MS LS            OR     A, [lptr.w]        ; Logical OR                                 A <= A  OR M(M(lptr).w)
92 CA XX               OR     A, [sptr.w]        ; Logical OR                                 A <= A  OR M(M(sptr).w)
   CB MS LS            ADD    A, lmem            ; Addition                                   A <= A  +  M(lmem)
72 CB MS LS            ADD    A, [lptr.w]        ; Addition                                   A <= A  +  M(M(lptr).w)
92 CB XX               ADD    A, [sptr.w]        ; Addition                                   A <= A  +  M(M(sptr).w)
   CC MS LS            JP     lmem               ; Jump (Absolute)                            PC <= lmem
72 CC MS LS            JP     [lptr.w]           ; Jump (Absolute)                            PC <= M(lptr).w
92 CC XX               JP     [sptr.w]           ; Jump (Absolute)                            PC <= M(sptr).w
   CD MS LS            CALL   lmem               ; Call Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=lmem
72 CD MS LS            CALL   [lptr.w]           ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(lptr).w
92 CD XX               CALL   [sptr.w]           ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(sptr).w
   CE MS LS            LDW    X, lmem.w          ; Load Word                                  X              <= M(lmem).w
72 CE MS LS            LDW    X, [lptr.w]        ; Load Word                                  X              <= M(M(lptr).w).w
90 CE MS LS            LDW    Y, lmem.w          ; Load Word                                  Y              <= M(lmem).w
91 CE XX               LDW    Y, [sptr.w]        ; Load Word                                  Y              <= M(M(sptr).w).w
92 CE XX               LDW    X, [sptr.w]        ; Load Word                                  X              <= M(M(sptr).w).w
   CF MS LS            LDW    lmem.w, X          ; Load Word                                  M(lmem).w      <= X
72 CF MS LS            LDW    [lptr.w], X        ; Load Word                                  M(M(lptr).w)   <= X
90 CF MS LS            LDW    lmem.w, Y          ; Load Word                                  M(lmem).w      <= Y
91 CF XX               LDW    [sptr.w].w, Y      ; Load Word                                  M(M(sptr).w).w <= Y
92 CF XX               LDW    [sptr.w].w, X      ; Load Word                                  M(M(lptr).w).w <= X
   D0 MS LS            SUB    A, (loff,X)        ; Subtraction                                A <= A  -  M(loff+X)
72 D0 MS LS            SUB    A, ([lptr.w],X)    ; Subtraction                                A <= A  -  M(M(lptr).w+X)
90 D0 MS LS            SUB    A, (loff,Y)        ; Subtraction                                A <= A  -  M(loff+Y)
91 D0 XX               SUB    A, ([sptr.w],Y)    ; Subtraction                                A <= A  -  M(M(sptr).w+Y)
92 D0 XX               SUB    A, ([sptr.w],X)    ; Subtraction                                A <= A  -  M(M(sptr).w+X)
   D1 MS LS            CP     A, (loff,X)        ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(loff+X) }
72 D1 MS LS            CP     A, ([lptr.w],X)    ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(M(lptr).w+X) }
90 D1 MS LS            CP     A, (loff,Y)        ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(loff+Y) }
91 D1 XX               CP     A, ([sptr.w],Y)    ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(M(sptr).w+Y) }
92 D1 XX               CP     A, ([sptr.w],X)    ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{ A - M(M(sptr).w+X) }
   D2 MS LS            SBC    A, (loff,X)        ; Subtraction with Carry/Borrow              A <= A  -  M(loff+X)
72 D2 MS LS            SBC    A, ([lptr.w],X)    ; Subtraction with Carry/Borrow              A <= A  -  M(M(lptr).w+X) with Carry/Borrow from A
90 D2 MS LS            SBC    A, (loff,Y)        ; Subtraction with Carry/Borrow              A <= A  -  M(loff+Y)
91 D2 XX               SBC    A, ([sptr.w],Y)    ; Subtraction with Carry/Borrow              A <= A  -  M(M(srptr).w+Y)
92 D2 XX               SBC    A, ([sptr.w],X)    ; Subtraction with Carry/Borrow              A <= A  -  M(M(srptr).w+X)
   D3 MS LS            CPW    Y, (loff,X).w      ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ Y - M(loff+X).w }
72 D3 MS LS            CPW    X, ([lptr.w],X).w  ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(M(lptr).w+X).w }
90 D3 MS LS            CPW    X, (loff,Y).w      ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(loff+Y).w }
91 D3 XX               CPW    X, ([sptr.w],Y).w  ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(M(sptr).w+Y).w }
92 D3 XX               CPW    X, ([sptr.w],X).w  ; Compare Word                               {CC.N, CC.Z, CC.C} <= Test{ X - M(M(sptr).w+X).w }
   D4 MS LS            AND    A, (loff,X)        ; Logical AND                                A <= A AND M(loff+X) 
72 D4 MS LS            AND    A, ([lptr.w],X)    ; Logical AND                                A <= A AND M(M(lptr).w+X) 
90 D4 MS LS            AND    A, (loff,Y)        ; Logical AND                                A <= A AND M(loff+Y) 
91 D4 XX               AND    A, ([sptr.w],Y)    ; Logical AND                                A <= A AND M(M(sptr).w+Y) 
92 D4 XX               AND    A, ([sptr.w],X)    ; Logical AND                                A <= A AND M(M(sptr).w+X) 
   D5 MS LS            BCP    A, (loff,X)        ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(loff+Y) }
72 D5 MS LS            BCP    A, ([lptr.w],X)    ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(M(lptr).w+X) }
90 D5 MS LS            BCP    A, (loff,Y)        ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(loff+Y) }
91 D5 XX               BCP    A, ([sptr.w],Y)    ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(M(sptr).w+Y) }
92 D5 XX               BCP    A, ([sptr.w],X)    ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{ A AND M(M(sptr).w+X) }
   D6 MS LS            LD     A, (loff,X)        ; Load                                       A              <= M(loff+X)
72 D6 MS LS            LD     A, ([lptr.w],X)    ; Load                                       A              <= M(M(lptr).w+X)
90 D6 MS LS            LD     A, (loff,Y)        ; Load                                       A              <= M(loff+Y)
91 D6 XX               LD     A, ([sptr.w],Y)    ; Load                                       A              <= M(M(sptr).w+Y)
92 D6 XX               LD     A, ([sptr.w],X)    ; Load                                       A              <= M(M(sptr).w+X)
   D7 MS LS            LD     (loff,X), A        ; Load                                       M(loff+X)      <= A
72 D7 MS LS            LD     ([lptr.w],X), A    ; Load                                       M(M(lptr).w+X) <= A
90 D7 MS LS            LD     (loff,Y), A        ; Load                                       M(loff+Y)      <= A
91 D7 XX               LD     ([sptr.w],Y), A    ; Load                                       M(M(sptr).w+Y) <= A
92 D7 XX               LD     ([sptr.w],X), A    ; Load                                       M(M(sptr).w+X) <= A
   D8 MS LS            XOR    A, (loff,X)        ; Logical Exclusive OR                       A <= A XOR M(loff+X)
72 D8 MS LS            XOR    A, ([lptr.w],X)    ; Logical Exclusive OR                       A <= A XOR M(M(lptr).w+X)
90 D8 MS LS            XOR    A, (loff,Y)        ; Logical Exclusive OR                       A <= A XOR M(loff+Y) 
91 D8 XX               XOR    A, ([sptr.w],Y)    ; Logical Exclusive OR                       A <= A XOR M(M(sptr).w+Y)
92 D8 XX               XOR    A, ([sptr.w],X)    ; Logical Exclusive OR                       A <= A XOR M(M(sptr).w+X)
   D9 MS LS            ADC    A, (loff,X)        ; Addition with Carry                        A <= A  +  M(loff+X)      + CC.C
72 D9 MS LS            ADC    A, ([lptr.w],X)    ; Addition with Carry                        A <= A  +  M(M(lptr).w+X) + CC.C
90 D9 MS LS            ADC    A, (loff,Y)        ; Addition with Carry                        A <= A  +  M(loff+Y)      + CC.C
91 D9 XX               ADC    A, ([sptr.w],Y)    ; Addition with Carry                        A <= A  +  M(M(sptr).w+Y) + CC.C
92 D9 XX               ADC    A, ([sptr.w],X)    ; Addition with Carry                        A <= A  +  M(M(sptr).w+X) + CC.C
   DA MS LS            OR     A, (loff,X)        ; Logical OR                                 A <= A  OR M(loff+X)
72 DA MS LS            OR     A, ([lptr.w],X)    ; Logical OR                                 A <= A  OR M(M(lptr).w+X) 
90 DA MS LS            OR     A, (loff,Y)        ; Logical OR                                 A <= A  OR M(loff+Y)
91 DA XX               OR     A, ([sptr.w],Y)    ; Logical OR                                 A <= A  OR M(M(sptr).w+Y) 
92 DA XX               OR     A, ([sptr.w],X)    ; Logical OR                                 A <= A  OR M(M(sptr).w+X)
   DB MS LS            ADD    A, (loff,X)        ; Addition                                   A <= A  +  M(loff+X)
72 DB MS LS            ADD    A, ([lptr.w],X)    ; Addition                                   A <= A  +  M(M(lptr).w+X)
90 DB MS LS            ADD    A, (loff,Y)        ; Addition                                   A <= A  +  M(loff+Y)
91 DB XX               ADD    A, ([sptr.w],Y)    ; Addition                                   A <= A  +  M(M(sptr).w+Y)
92 DB XX               ADD    A, ([sptr.w],X)    ; Addition                                   A <= A  +  M(M(sptr).w+X)
   DC MS LS            JP     (loff,X)           ; Jump (Absolute)                            PC <= M(loff+X).w
72 DC MS LS            JP     ([lptr.w],X)       ; Jump (Absolute)                            PC <= M(M(lptr).w+X).
90 DC MS LS            JP     (loff,Y)           ; Jump (Absolute)                            PC <= M(loff+Y).w
91 DC XX               JP     ([sptr.w],Y)       ; Jump (Absolute)                            PC <= M(M(sptr).w+Y).w
92 DC XX               JP     ([sptr.w],X)       ; Jump (Absolute)                            PC <= M(M(sptr).w+X).w
   DD MS LS            CALL   (loff,X)           ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(loff+X).w
72 DD MS LS            CALL   ([lptr.w],X)       ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(M(lptr).w+X).w
90 DD MS LS            CALL   (loff,Y)           ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(loff+Y).w
91 DD XX               CALL   ([sptr.w],Y)       ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(M(sptr).w+Y).w
92 DD XX               CALL   ([sptr.w],X)       ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(M(sptr).w+X).w
   DE MS LS            LDW    X, (loff,X).w      ; Load Word                                  X                <= M(loff+X).w
72 DE MS LS            LDW    X, ([lptr.w],X).w  ; Load Word                                  X                <= M(M(lptr).w+X).w
90 DE MS LS            LDW    Y, (loff,Y).w      ; Load Word                                  Y                <= M(loff+Y).w
91 DE XX               LDW    Y, ([sptr.w],Y).w  ; Load Word                                  Y                <= M(M(sptr).w+Y).w
92 DE XX               LDW    X, ([sptr.w],X).w  ; Load Word                                  X                <= M(M(sptr).w+X).w
   DF MS LS            LDW    (loff,X).w,  Y     ; Load Word                                  M(loff+X).w      <= Y
72 DF MS LS            LDW    ([lptr.w],X).w, Y  ; Load Word                                  M(M(lptr).w+X).w <= Y
90 DF MS LS            LDW    (loff,Y).w, X      ; Load Word                                  M(loff+Y).w      <= X
91 DF XX               LDW    ([sptr.w],Y).w, X  ; Load Word                                  M(M(sptr).w+Y).w <= X
92 DF MS LS            LDW    ([sptr.w],X).w, Y  ; Load Word                                  M(M(sptr).w+X).w <= Y
   E0 XX               SUB    A, (soff,X)        ; Subtraction                                A <= A - M(soff+X)
90 E0 XX               SUB    A, (soff,Y)        ; Subtraction                                A <= A - M(soff+Y)
   E1 XX               CP     A, (soff,X)        ; Compare                                    {CC.N, CC.Z, CC.C} = Test{A - M(soff+X)}
90 E1 XX               CP     A, (soff,Y)        ; Compare                                    {CC.N, CC.Z, CC.C} = Test{A - M(soff+Y)}
   E2 XX               SBC    A, (soff,X)        ; Subtraction                                A <= A - M(soff+X) - CC.C
72 F2 XX               SUBW   Y, (soff.w,SP).w   ; Subtraction                                Y <= Y - M(soff.w+SP).w
90 E2 XX               SBC    A, (soff,Y)        ; Subtraction                                A <= A - M(soff+Y) - CC.C
   E3 XX               CPW    Y, (soff,X).w      ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{Y - M(soff+X).w}
90 E3 XX               CPW    X, (soff,Y).w      ; Compare                                    {CC.N, CC.Z, CC.C} <= Test{X - M(soff+Y).w}
   E4 XX               AND    A, (soff,X)        ; Logical AND                                A <= A AND M(soff+X)
90 E4 XX               AND    A, (soff,Y)        ; Logical AND                                A <= A AND M(soff+Y)
   E5 XX               BCP    A, (soff,X)        ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{A AND M(soff+X)}
90 E5 XX               BCP    A, (soff,Y)        ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{A AND M(soff+Y)}
   E6 XX               LD     A, (soff,X)        ; Load                                       A <= M(soff+X)
90 E6 XX               LD     A, (soff,Y)        ; Load                                       A <= M(soff+Y)
   E7 XX               LD     (soff,X), A        ; Load                                       M(soff+X) <= A
90 E7 XX               LD     (soff,Y), A        ; Load                                       M(soff+Y) <= A
   E8 XX               XOR    (soff,X)           ; Logical Exclusive OR                       A <= A XOR M(soff+X)
90 E8 XX               XOR    (soff,Y)           ; Logical Exclusive OR                       A <= A XOR M(soff+Y)
   E9 XX               ADC    A, (soff,X)        ; Addition with Carry                        A <= A  +  M(soff+X) + CC.C
90 E9 XX               ADC    A, (soff,Y)        ; Addition with Carry                        A <= A  +  M(soff+Y) + CC.C
   EA XX               OR     A, (soff,X)        ; Logical OR                                 A <= A  OR M(soff+X)
90 FA XX               OR     A, (soff,Y)        ; Logical OR                                 A <= A  OR M(soff+Y)
   EB XX               ADD    A, (soff,X)        ; Addition                                   A <= A  +  M(soff+X)
90 EB XX               ADD    A, (soff,Y)        ; Addition                                   A <= A  +  M(soff+Y)
   EC XX               JP     (soff,X)           ; Jump (Absolute)                            PC <= M(soff+X).w
90 EC XX               JP     (soff,Y)           ; Jump (Absolute)                            PC <= M(soff+Y).w
   ED XX               CALL   (soff,X)           ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(soff+X).w
90 ED XX               CALL   (soff,Y)           ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(soff+Y).w
   EE XX               LDW    X, (soff,X).w      ; Load                                       Word X <= M(soff+X).w
90 EE XX               LDW    Y, (soff,Y).w      ; Load                                       Word Y <= M(soff+Y).w
   EF XX               LDW    (soff,X), Y        ; Load                                       Word M(soff+X).w <= Y
90 EF XX               LDW    (soff,Y), X        ; Load                                       Word M(soff+Y).w <= X
   F0                  SUB    A, (X)             ; Subtraction                                A <= A - M(X)
72 F0 XX               SUBW   X, (soff,SP)       ; Subtraction Word                           X <= X - M(soff+SP).w
90 F0                  SUB    A, (Y)             ; Subtraction                                A <= A - M(Y)
   F1                  CP     A, (X)             ; Compare                                    {CC.N, CC.Z, CC.C} = Test{A - M(X)}
90 F1                  CP     A, (Y)             ; Compare                                    {CC.N, CC.Z, CC.C} = Test{A - M(Y)}
   F2                  SBC    A, (X)             ; Subtraction                                A <= A - M(X) - CC.C
90 F2                  SBC    A, (Y)             ; Subtraction                                A <= A - M(Y) - CC.C
   F3                  CPW    Y, (X)             ; Compare                                    {CC.N, CC.Z, CC.C} = Test{Y - M(X)}      word ?
90 F3                  CPW    X, (Y)             ; Compare                                    {CC.N, CC.Z, CC.C} = Test{Y - M(X)}      word ?
   F4                  AND    A, (X)             ; Logical AND                                A <= A AND M(X)
90 F4                  AND    A, (Y)             ; Logical AND                                A <= A AND M(Y)
   F5                  BCP    A, (X)             ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{A AND M(X)
90 F5                  BCP    A, (Y)             ; Logical Bit Compare                        {CC.N, CC.Z} <= Test{A AND M(Y)
   F6                  LD     A, (X)             ; Load                                       A <= M(X)
90 F6                  LD     A, (Y)             ; Load                                       A <= M(Y)
   F7                  LD     (X), A             ; Load                                       M(X) <= A
90 F7                  LD     (Y), A             ; Load                                       M(Y) <= A
   F8                  XOR    A, (X)             ; Logical Exclusive OR                       A <= A XOR M(X)
90 F8                  XOR    A, (Y)             ; Logical Exclusive OR                       A <= A XOR M(Y)
   F9                  ADC    A, (X)             ; Addition with Carry                        A <= A  +  M(X) + CC.C
72 F9 XX               ADDW   Y, (soff,SP)       ; Addition Word                              Y <= Y  +  M(soff+SP)
90 F9                  ADC    A, (Y)             ; Addition with Carry                        A <= A  +  M(Y) + CC.C
   FA                  OR     A, (X)             ; Logical OR                                 A <= A  OR M(X)
90 FA                  OR     A, (Y)             ; Logical OR                                 A <= A  OR M(Y)
   FB                  ADD    A, (X)             ; Addition                                   A <= A  +  M(X)
72 FB XX               ADDW   X, (soff,SP)       ; Addition Word                              X <= X  +  M(soff+SP)
90 FB                  ADD    A, (Y)             ; Addition                                   A <= A  +  M(Y)
   FC                  JP     (X)                ; Jump (Absolute)                            PC <= M(X).w
90 FC                  JP     (Y)                ; Jump (Absolute)                            PC <= M(Y).w
   FD                  CALL   (X)                ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(X).w
90 FD                  CALL   (Y)                ; CALL Subroutine (Absolute)                 M(SP--)<=PCL M(SP--)<-PCH PC<=M(Y).w
   FE                  LDW    X, (X)             ; Load Word                                  X <= M(X).w
90 FE                  LDW    Y, (Y)             ; Load Word                                  Y <= M(Y).w
   FF                  LDW    (X), Y             ; Load Word                                  M(Y).w <= Y
90 FF                  LDW    (Y), X             ; Load Word                                  M(Y).w <= X
