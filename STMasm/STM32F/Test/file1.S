
      THUMB
       
stackStartAddress  EQU 0x20000100
 
      AREA mySection1, DATA, READONLY
       
      DCD stackStartAddress
      DCD myResetHandler
       
      AREA mySection2, CODE, READONLY
      ENTRY
      
      
myResetHandler   
      IMPORT myApplication
       
      B myApplication
      
      END
