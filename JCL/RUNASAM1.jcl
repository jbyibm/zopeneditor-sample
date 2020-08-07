//WAZIASM1 JOB ,NOTIFY=&SYSUID,
// MSGCLASS=H,MSGLEVEL=(1,1),REGION=0M,COND=(4,LT)
//*
//****************************************************************
//* LICENSED MATERIALS - PROPERTY OF IBM
//* "RESTRICTED MATERIALS OF IBM"
//* (C) COPYRIGHT IBM CORPORATION 2020. ALL RIGHTS RESERVED
//* US GOVERNMENT USERS RESTRICTED RIGHTS - USE, DUPLICATION,
//* OR DISCLOSURE RESTRICTED BY GSA ADP SCHEDULE
//* CONTRACT WITH IBM CORPORATION
//*****************************************************************
//*
//* THE FOLLOWING SYMBOLICS NEED TO BE UPDATED WITH THE ASSEMBLER
//* LIBRARIES AND YOUR TSO USER ID.
//*
//*****************************************************************
//    SET MACLIB='SYS1.MACLIB          '  *Z/OS MACRO LIBRARY
//    SET SCEEMAC='CEE.SCEEMAC'           *ASSEMBLER MACRO LIBRARY
//    SET MODGEN='SYS1.MODGEN'            *ASM MODGEN LIBRARY
//    SET LINKLIB='CEE.SCEELKED'          *LINK LIBRARY
//    SET HLQ='TSOUSER'                   *TSO USER ID
//    SET SPACE1='SYSALLDA,SPACE=(CYL,(1,1))' *SPACE ALLOCATION
//*************************
//* CLEAN UP
//*************************
//DELETE   EXEC PGM=IEFBR14
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//DD1      DD DSN=&HLQ..SAMPLE.ASM.FILEOUT,
//            DISP=(MOD,DELETE,DELETE),
//            UNIT=SYSDA,SPACE=(CYL,(0))
//*************************
//* COMPILE ASAM2
//*************************
//ASM2     EXEC PGM=ASMA90,PARM='DECK,ALIGN,OBJ'
//SYSLIB   DD  DISP=SHR,DSN=&MACLIB
//         DD  DISP=SHR,DSN=&MODGEN
//         DD  DISP=SHR,DSN=&SCEEMAC
//         DD  DISP=SHR,DSN=&HLQ..SAMPLE.ASMCOPY
//SYSPUNCH DD  DISP=SHR,DSN=&HLQ..SAMPLE.ASMOBJ(ASAM2)
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  UNIT=&SPACE1
//SYSUT2   DD  UNIT=&SPACE1
//SYSUT3   DD  UNIT=&SPACE1
//SYSLIN   DD  DUMMY
//SYSIN    DD  DISP=SHR,DSN=&HLQ..SAMPLE.ASM(ASAM2)
//*************************
//* COMPILE ASAM1
//*************************
//ASM1     EXEC PGM=ASMA90,PARM='DECK,ALIGN,OBJ'
//SYSLIB   DD  DISP=SHR,DSN=&MACLIB
//         DD  DISP=SHR,DSN=&MODGEN
//         DD  DISP=SHR,DSN=&SCEEMAC
//         DD  DISP=SHR,DSN=&HLQ..SAMPLE.ASMCOPY
//SYSPUNCH DD  DISP=SHR,DSN=&HLQ..SAMPLE.ASMOBJ(ASAM1)
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  UNIT=&SPACE1
//SYSUT2   DD  UNIT=&SPACE1
//SYSUT3   DD  UNIT=&SPACE1
//SYSLIN   DD  DUMMY
//SYSIN    DD  DISP=SHR,DSN=&HLQ..SAMPLE.ASM(ASAM1)
//*************************
//* LINK ASAM1
//*************************
//LKED     EXEC PGM=IEWL,REGION=3000K
//SYSLMOD  DD  DSN=&HLQ..SAMPLE.ASMLOAD,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  UNIT=SYSALLDA,SPACE=(CYL,(3,3))
//SYSLIB   DD  DISP=SHR,DSN=&LINKLIB
//OBJ      DD  DISP=SHR,DSN=&HLQ..SAMPLE.ASMOBJ
//SYSLIN   DD *
     INCLUDE OBJ(ASAM2)
     INCLUDE OBJ(ASAM1)
     NAME ASAM1(R)
/*
//*************************
//* RUN ASAM1
//*************************
//EXECUTE  EXEC PGM=ASAM1,REGION=0K
//STEPLIB  DD  DSN=&HLQ..SAMPLE.ASMLOAD,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
//* INPUT FILE
//FILEIN   DD  DSN=&HLQ..SAMPLE.ASM.FILEIN,DISP=SHR
//* OUTPUT FILE
//FILEOUT  DD  DSN=&HLQ..SAMPLE.ASM.FILEOUT,
//     DISP=(NEW,CATLG),UNIT=SYSALLDA,SPACE=(TRK,(10,10),RLSE),
//     DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=0
//*
