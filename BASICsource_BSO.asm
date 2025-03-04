	.nam C64 BASIC 2.2  (C)1982 CBM
	.subttl Copyright (C) 1982 Commodore Business Machines, Inc.

; Converted to VAX/VMS BSO format by Fred Bowen

;	.include   DISCLAIM
;	.include   DECLARE
;	.include   TOKENS1
;	.include   TOKENS2
;	.include   CODE1
;	.include   CODE2
;	.include   CODE3
;	.include   CODE4
;	.include   CODE5
;	.include   CODE6
;	.include   CODE7
;	.include   CODE8
;	.include   CODE9
;	.include   CODE10
;	.include   CODE11
;	.include   CODE12
;	.include   CODE13
;	.include   CODE14
;	.include   CODE15
;	.include   CODE16
;	.include   CODE17
;	.include   CODE18
;	.include   CODE19
;	.include   CODE20
;	.include   CODE21
;	.include   CODE22
;	.include   CODE23
;	.include   CODE24
;	.include   CODE25
;	.include   CODE26
;	.include   TRIG
;	.include   INIT
;
;	.end
	.page
	.subttl Copyright (C) 1982 Commodore Business Machines, Inc.

;****************************************
;*                                      *
;* BBBBB   AAAA   SSS  IIII  CCCC       *
;* BB  BB AA  AA SS  S  II  CC   C      *
;* BB  BB AA  AA  SS    II  CC          *
;* BBBBB  AAAAAA   SS   II  CC          *
;* BB  BB AA  AA    SS  II  CC          *
;* BB  BB AA  AA S  SS  II  CC   C      *
;* BBBBB  AA  AA  SSS  IIII  CCCC       *
;*                                      *
;****************************************
;
;****************************************
;*                                      *
;* pet basic version 2.2                *
;*      this version of pet basic is    *
;* designed to function with the kernal *
;* provided in the folowing machines:   *
;*      2001-4/8 (b/n)                  *
;*      4016/4032                       *
;*      8032                            *
;*      toy                             *
;*      vic-20/vic-40                   *
;*    * commodore 10/16/64              *
;*      max                             *
;* copyright (c) 1982 by                *
;* commodore business machines          *
;*                                      *
;****************************************
	.space   3
;*****listing date -1200 02 july  1982***
	.space   3
;****************************************
;* this software is furnished for use in*
;* the above listed machines only.      *
;*                                      *
;* copies thereof may not be provided   *
;* or made available for use on any     *
;* system.                              *
;*                                      *
;* the information in this document is  *
;* subject to change without notice.    *
;*                                      *
;* no responsibility is assumed for     *
;* reliability of this software.  rsr   *
;*                                      *
;****************************************


;.end
	.page
	.subttl DECLARE

addprc   = 1
romloc   = $a000	; vic-40 basic rom
linlen   = 40    	; vic screen size ?why?
buflen   = 89    	; vic buffer
bufpag   = 2
buf      = 512
stkend   = 507
clmwid   = 10    	; print window 10 chars
pi       = 255
numlev   = 23
strsiz   = 3

blank0   *=*+3          ; 6510 register area
adray1   *=*+2          ; convert float->integer
adray2   *=*+2          ; convert integer->float
integr
charac   *=*+1
endchr   *=*+1
trmpos   *=*+1
verck    *=*+1
count    *=*+1
dimflg   *=*+1
valtyp   *=*+1
intflg   *=*+1
garbfl
dores    *=*+1
subflg   *=*+1
inpflg   *=*+1
domask
tansgn   *=*+1
channl   *=*+1
poker
linnum   *=*+2
temppt   *=*+1
lastpt   *=*+2
tempst   *=*+9
index
index1   *=*+2
index2   *=*+2
resho    *=*+1
resmoh   *=*+1
addend
resmo    *=*+1
reslo    *=*+1
	*=*+1
txttab   *=*+2
vartab   *=*+2
arytab   *=*+2
strend   *=*+2
fretop   *=*+2
frespc   *=*+2
memsiz   *=*+2
curlin   *=*+2
oldlin   *=*+2
oldtxt   *=*+2
datlin   *=*+2
datptr   *=*+2
inpptr   *=*+2
varnam   *=*+2
fdecpt
varpnt   *=*+2
lstpnt
andmsk
forpnt   *=*+2
eormsk   =forpnt+1
vartxt
opptr    *=*+2
opmask   *=*+1
grbpnt
tempf3
defpnt   *=*+2
dscpnt   *=*+2
	*=*+1
four6    *=*+1
jmper    *=*+1
size     *=*+1
oldov    *=*+1
tempf1   *=*+1
arypnt
highds   *=*+2
hightr   *=*+2
tempf2
	*=*+1
deccnt
lowds    *=*+2
grbtop
dptflg
lowtr    *=*+1
expsgn   *=*+1
tenexp   =lowds+1
epsgn    =lowtr+1
dsctmp
fac
facexp   *=*+1
facho    *=*+1
facmoh   *=*+1
indice
facmo    *=*+1
faclo    *=*+1
facsgn   *=*+1
degree
sgnflg   *=*+1
bits     *=*+1
argexp   *=*+1
argho    *=*+1
argmoh   *=*+1
argmo    *=*+1
arglo    *=*+1
argsgn   *=*+1
strngi
arisgn   *=*+1
facov    *=*+1
bufptr
strng2
polypt
curtol
fbufpt   *=*+2
chrget   *=*+6
chrgot   *=*+1
txtptr   *=*+6
qnum     *=*+10
chrrts   *=*+1
rndx     *=*+5

	* = 255

lofbuf   *=*+1
fbuffr   *=*+1
strng1   =arisgn

	* = $0300	;basic   indirects

ierror   *=*+2          ; indirect error (output error in .x)
imain    *=*+2          ; indirect main (system direct loop)
icrnch   *=*+2          ; indirect crunch (tokenization routine)
iqplop   *=*+2          ; indirect list (char list)
igone    *=*+2          ; indirect gone (char dispatch)
ieval    *=*+2          ; indirect eval (symbol evaluation)

; temp storage until system integration
; sys 6502 regs

sareg    *=*+1          ; .a reg
sxreg    *=*+1          ; .x reg
syreg    *=*+1          ; .y reg
spreg    *=*+1          ; .p reg
usrpok   *=*+3          ; user function dispatch

	* = $0300+20	;system   indirects  follow

;.end
	.page
	.subttl TOKENS1

	* = romloc

	.word   init	; c000 hard reset
	.word   panic	; c000 soft reset
	.byte   'CBMBASIC'

stmdsp   .word end-1
	.word   for-1
	.word   next-1
	.word   data-1
	.word   inputn-1
	.word   input-1
	.word   dim-1
	.word   read-1
	.word   let-1
	.word   goto-1
	.word   run-1
	.word   if-1
	.word   restor-1
	.word   gosub-1
	.word   return-1
	.word   rem-1
	.word   stop-1
	.word   ongoto-1
	.word   fnwait-1
	.word   cload-1
	.word   csave-1
	.word   cverf-1
	.word   def-1
	.word   poke-1
	.word   printn-1
	.word   print-1
	.word   cont-1
	.word   list-1
	.word   clear-1
	.word   cmd-1
	.word   csys-1
	.word   copen-1
	.word   cclos-1
	.word   get-1
	.word   scrath-1
fundsp   .word sgn
	.word   int
	.word   abs
usrloc   .word usrpok
	.word   fre
	.word   pos
	.word   sqr
	.word   rnd
	.word   log
	.word   exp
	.word   cos
	.word   sin
	.word   tan
	.word   atn
	.word   peek
	.word   len
	.word   strd
	.word   val
	.word  asc
	.word   chrd
	.word   leftd
	.word   rightd
	.word   midd

optab    .byte  121
	.word   faddt-1
	.byte   121
	.word   fsubt-1
	.byte   123
	.word   fmultt-1
	.byte   123
	.word   fdivt-1
	.byte   127
	.word   fpwrt-1
	.byte   80
	.word   andop-1
	.byte   70
	.word   orop-1
negtab   .byte  125
	.word   negop-1
nottab   .byte  90
	.word   notop-1
ptdorl   .byte  100
	.word   dorel-1
q	= 128-1

RESLST   .BYTE  'EN',$C4
ENDTK    =@200
	.BYTE   'FO',$D2
FORTK    =@201
	.BYTE   'NEX',$D4
	.BYTE   'DAT',$C1
DATATK   =@203
	.BYTE   'INPUT',$A3
	.BYTE   'INPU',$D4
	.BYTE   'DI',$CD
	.BYTE   'REA',$C4
	.BYTE   'LE',$D4
	.BYTE   'GOT',$CF
GOTOTK   =@211
	.BYTE   'RU',$CE
	.BYTE   'I',$C6
	.BYTE   'RESTOR',$C5
	.BYTE   'GOSU',$C2
GOSUTK   =@215
	.BYTE   'RETUR',$CE
	.BYTE   'RE',$CD
REMTK    =@217
	.BYTE   'STO',$D0
	.BYTE   'O',$CE
	.BYTE   'WAI',$D4
	.BYTE   'LOA',$C4
	.BYTE   'SAV',$C5
	.BYTE   'VERIF',$D9
	.BYTE   'DE',$C6
	.BYTE   'POK',$C5
	.BYTE   'PRINT',$A3
	.BYTE   'PRIN',$D4
PRINTK   =@231
	.BYTE   'CON',$D4
	.BYTE   'LIS',$D4
	.BYTE   'CL',$D2
	.BYTE   'CM',$C4
	.BYTE   'SY',$D3
	.BYTE   'OPE',$CE
	.BYTE   'CLOS',$C5
	.BYTE   'GE',$D4
	.BYTE   'NE',$D7
SCRATK   =@242

;.end
	.page
	.subttl TOKENS2

	.BYTE   'TAB',$A8
TABTK    =@243
	.BYTE   'T',$CF
TOTK     =@244
	.BYTE   'F',$CE
FNTK     =@245
	.BYTE   'SPC',$A8
SPCTK    =@246
	.BYTE   'THE',$CE
THENTK   =@247
	.BYTE   'NO',$D4
NOTTK    =@250
	.BYTE   'STE',$D0
STEPTK   =@251
	.BYTE   $AB
PLUSTK   =@252
	.BYTE   $AD
MINUTK   =@253
	.BYTE   $AA
	.BYTE   $AF
	.BYTE   $DE
	.BYTE   'AN',$C4
	.BYTE   'O',$D2
	.BYTE   190
GREATK   =@261
	.BYTE   $BD
EQULTK   =@262
	.BYTE   188
LESSTK   =@263
	.BYTE   'SG',$CE
ONEFUN   =@264
	.BYTE   'IN',$D4
	.BYTE   'AB',$D3
	.BYTE   'US',$D2
	.BYTE   'FR',$C5
	.BYTE   'PO',$D3
	.BYTE   'SQ',$D2
	.BYTE   'RN',$C4
	.BYTE   'LO',$C7
	.BYTE   'EX',$D0
	.BYTE   'CO',$D3
	.BYTE   'SI',$CE
	.BYTE   'TA',$CE
	.BYTE   'AT',$CE
	.BYTE   'PEE',$CB
	.BYTE   'LE',$CE
	.BYTE   'STR',$A4
	.BYTE   'VA',$CC
	.BYTE   'AS',$C3
	.BYTE   'CHR',$A4
LASNUM   =@307
	.BYTE   'LEFT',$A4
	.BYTE   'RIGHT',$A4
	.BYTE   'MID',$A4
	.BYTE   'G',$CF
GOTK     =@313
	.BYTE   0

	.page
	.subttl MESSAGES

ERR01    .BYTE  'TOO MANY FILE',$D3
ERR02    .BYTE  'FILE OPE',$CE
ERR03    .BYTE  'FILE NOT OPE',$CE
ERR04    .BYTE  'FILE NOT FOUN',$C4
ERR05    .BYTE  'DEVICE NOT PRESEN',$D4
ERR06    .BYTE  'NOT INPUT FIL',$C5
ERR07    .BYTE  'NOT OUTPUT FIL',$C5
ERR08    .BYTE  'MISSING FILE NAM',$C5
ERR09    .BYTE  'ILLEGAL DEVICE NUMBE',$D2
ERR10    .BYTE  'NEXT WITHOUT FO',$D2
ERRNF    =10
ERR11    .BYTE  'SYNTA',$D8
ERRSN    =11
ERR12    .BYTE  'RETURN WITHOUT GOSU',$C2
ERRRG    =12
ERR13    .BYTE  'OUT OF DAT',$C1
ERROD    =13
ERR14    .BYTE  'ILLEGAL QUANTIT',$D9
ERRFC    =14
ERR15    .BYTE  'OVERFLO',$D7
ERROV    =15
ERR16    .BYTE  'OUT OF MEMOR',$D9
ERROM    =16
ERR17    .BYTE  'UNDEF',$27,'D STATEMEN',$D4
ERRUS    =17
ERR18    .BYTE  'BAD SUBSCRIP',$D4
ERRBS    =18
ERR19    .BYTE  'REDIM',$27,'D ARRA',$D9
ERRDD    =19
ERR20    .BYTE  'DIVISION BY ZER',$CF
ERRDVO   =20
ERR21    .BYTE  'ILLEGAL DIREC',$D4
ERRID    =21
ERR22    .BYTE  'TYPE MISMATC',$C8
ERRTM    =22
ERR23    .BYTE  'STRING TOO LON',$C7
ERRLS    =23
ERR24    .BYTE  'FILE DAT',$C1
ERRBD    =24
ERR25    .BYTE  'FORMULA TOO COMPLE',$D8
ERRST    =25
ERR26    .BYTE  'CAN',$27,'T CONTINU',$C5
ERRCN    =26
ERR27    .BYTE  'UNDEF',$27,'D FUNCTIO',$CE
ERRUF    =27
ERR28    .BYTE  'VERIF',$D9
ERVFY    =28
ERR29    .BYTE  'LOA',$C4
ERLOAD   =29

	.page
; table to translate error message #
; to address of string containing message

errtab   .word err01
	.word   err02
	.word   err03
	.word   err04
	.word   err05
	.word   err06
	.word   err07
	.word   err08
	.word   err09
	.word   err10
	.word   err11
	.word   err12
	.word   err13
	.word   err14
	.word   err15
	.word   err16
	.word   err17
	.word   err18
	.word   err19
	.word   err20
	.word   err21
	.word   err22
	.word   err23
	.word   err24
	.word   err25
	.word   err26
	.word   err27
	.word   err28
	.word   err29
	.word   err30
	.space   5
OKMSG    .BYTE  $D,'OK',$D,$0
ERR      .BYTE  $20,' ERROR',0         ; ADD A SPACE FOR VIC-40 SCREEN
INTXT    .BYTE  ' IN ',0
REDDY    .BYTE  $D,$A,'READY.',$D,$A,0
ERBRK    =30
BRKTXT   .BYTE  $D,$A
ERR30    .BYTE  'BREAK',0,$A0   ; SHIFTED SPACE

	.page
forsiz   =@22

fndfor  tsx
        inx
        inx
        inx
        inx
ffloop  lda  257,x
        cmp  #fortk
        bne  ffrts
        lda  forpnt+1
        bne  cmpfor
        lda  258,x
        sta  forpnt
        lda  259,x
        sta  forpnt+1
cmpfor  cmp  259,x
        bne  addfrs
        lda  forpnt
        cmp  258,x
        beq  ffrts
addfrs  txa
        clc
        adc  #forsiz
        tax
        bne  ffloop
ffrts   rts

bltu    jsr  reason
        sta  strend
        sty  strend+1
bltuc   sec
        lda  hightr
        sbc  lowtr
        sta  index
        tay
        lda  hightr+1
        sbc  lowtr+1
        tax
        inx
        tya
        beq  decblt
        lda  hightr
        sec
        sbc  index
        sta  hightr
        bcs  blt1
        dec  hightr+1
        sec
blt1    lda  highds
        sbc  index
        sta  highds
        bcs  moren1
        dec  highds+1
        bcc  moren1
bltlp   lda  (hightr),y
        sta  (highds),y
moren1  dey
        bne  bltlp
        lda  (hightr),y
        sta  (highds),y
decblt  dec  hightr+1
        dec  highds+1
        dex
        bne  moren1
        rts

getstk  asl  a
        adc  #numlev+numlev+16
        bcs  omerr
        sta  index
        tsx
        cpx  index
        bcc  omerr
        rts

reason  cpy  fretop+1
        bcc  rearts
        bne  trymor
        cmp  fretop
        bcc  rearts
trymor  pha
        ldx  #8+addprc
        tya
reasav  pha
        lda  highds-1,x
        dex
        bpl  reasav
        jsr  garba2
        ldx  #248-addprc
reasto  pla
        sta  highds+8+addprc,x
        inx
        bmi  reasto
        pla
        tay
        pla
        cpy  fretop+1
        bcc  rearts
        bne  omerr
        cmp  fretop
        bcs  omerr
rearts  rts

;.end

	.page
	.subttl CODE1
omerr   ldx  #errom
error   jmp  (ierror)

nerrox  txa
        asl  a
        tax
        lda  errtab-2,x
        sta  index1
        lda  errtab-1,x
        sta  index1+1
        jsr  clschn
        lda  #0
        sta  channl
errcrd  jsr  crdo
        jsr  outqst
        ldy  #0
geterr  lda  (index1),y
        pha
        and  #127
        jsr  outdo
        iny
        pla
        bpl  geterr
        jsr  stkini
        lda  #<err
        ldy  #>err
errfin  jsr  strout
        ldy  curlin+1
        iny
        beq  readyx
        jsr  inprt
	.space   5
readyx  lda  #<reddy
        ldy  #>reddy
        jsr  strout
        lda  #$80       ; direct messages on
        jsr  setmsg     ; from kernal
	.space   5
main    jmp  (imain)

nmain   jsr  inlin
        stx  txtptr
        sty  txtptr+1
        jsr  chrget
        tax
        beq  main
        ldx  #255
        stx  curlin+1
        bcc  main1
        jsr  crunch
        jmp  gone

main1   jsr  linget
        jsr  crunch
        sty  count
        jsr  fndlin
        bcc  nodel
        ldy  #1
        lda  (lowtr),y
        sta  index1+1
        lda  vartab
        sta  index1
        lda  lowtr+1
        sta  index2+1
        lda  lowtr
        dey
        sbc  (lowtr),y
        clc
        adc  vartab
        sta  vartab
        sta  index2
        lda  vartab+1
        adc  #255
        sta  vartab+1
        sbc  lowtr+1
        tax
        sec
        lda  lowtr
        sbc  vartab
        tay
        bcs  qdect1
        inx
        dec  index2+1
qdect1  clc
        adc  index1
        bcc  mloop
        dec  index1+1
        clc
mloop   lda  (index1),y
        sta  (index2),y
        iny
        bne  mloop
        inc  index1+1
        inc  index2+1
        dex
        bne  mloop
nodel   jsr  runc
        jsr  lnkprg
        lda  buf
        beq  main
        clc
        lda  vartab
        sta  hightr
        adc  count
        sta  highds
        ldy  vartab+1
        sty  hightr+1
        bcc  nodelc
        iny
nodelc  sty  highds+1
        jsr  bltu
        lda  linnum
        ldy  linnum+1
        sta  buf-2
        sty  buf-1
        lda  strend
        ldy  strend+1
        sta  vartab
        sty  vartab+1
        ldy  count
        dey
stolop  lda  buf-4,y
        sta  (lowtr),y
        dey
        bpl  stolop
fini    jsr  runc
        jsr  lnkprg
        jmp  main

lnkprg  lda  txttab
        ldy  txttab+1
        sta  index
        sty  index+1
        clc
chead   ldy  #1
        lda  (index),y
        beq  lnkrts
        ldy  #4
czloop  iny
        lda  (index),y
        bne  czloop
        iny
        tya
        adc  index
        tax
        ldy  #0
        sta  (index),y
        lda  index+1
        adc  #0
        iny
        sta  (index),y
        stx  index
        sta  index+1
        bcc  chead

lnkrts  rts
	.space   5
;function to get a line one character at
;a time from the input channel and
;build it in the input buffer.
;
inlin   ldx  #0
;
inlinc  jsr  inchr
        cmp  #13        ; a carriage return?
        beq  finin1     ; yes...done build
;
        sta  buf,x      ; put it away
        inx
        cpx  #buflen    ; max character line?
        bcc  inlinc     ; no...o.k.
;
        ldx  #errls     ; string too long error
        jmp  error

finin1  jmp  fininl
;.end
	.page
	.subttl CODE2
bufofs   = @1000

crunch  jmp  (icrnch)

ncrnch  ldx  txtptr
        ldy  #4
        sty  dores
kloop   lda  bufofs,x
        bpl  cmpspc
        cmp  #pi
        beq  stuffh
        inx
        bne  kloop
cmpspc  cmp  #' '
        beq  stuffh
        sta  endchr
        cmp  #34
        beq  strng
        bit  dores
        bvs  stuffh
        cmp  #'?'
        bne  kloop1
        lda  #printk
        bne  stuffh
kloop1  cmp  #'0'
        bcc  mustcr
        cmp  #60
        bcc  stuffh
mustcr  sty  bufptr
        ldy  #0
        sty  count
        dey
        stx  txtptr
        dex
reser   iny
        inx
rescon  lda  bufofs,x
        sec
        sbc  reslst,y
        beq  reser
        cmp  #128
        bne  nthis
        ora  count
getbpt  ldy  bufptr
stuffh  inx
        iny
        sta  buf-5,y
        lda  buf-5,y
        beq  crdone
        sec
        sbc  #':'
        beq  colis
        cmp  #datatk-$3a
        bne  nodatt
colis   sta  dores
nodatt  sec
        sbc  #remtk-$3a
        bne  kloop
        sta  endchr
str1    lda  bufofs,x
        beq  stuffh
        cmp  endchr
        beq  stuffh
strng   iny
        sta  buf-5,y
        inx
        bne  str1
nthis   ldx  txtptr
        inc  count
nthis1  iny
        lda  reslst-1,y
        bpl  nthis1
        lda  reslst,y
        bne  rescon
        lda  bufofs,x
        bpl  getbpt
crdone  sta  buf-3,y
        dec  txtptr+1

zz1	= buf-1

        lda  #<zz1
        sta  txtptr
        rts

fndlin  lda  txttab
        ldx  txttab+1
fndlnc  ldy  #1
        sta  lowtr
        stx  lowtr+1
        lda  (lowtr),y
        beq  flinrt
        iny
        iny
        lda  linnum+1
        cmp  (lowtr),y
        bcc  flnrts
        beq  fndlo1
        dey
        bne  affrts
fndlo1  lda  linnum
        dey
        cmp  (lowtr),y
        bcc  flnrts
        beq  flnrts
affrts  dey
        lda  (lowtr),y
        tax
        dey
        lda  (lowtr),y
        bcs  fndlnc

flinrt  clc
flnrts  rts

scrath  bne  flnrts
scrtch  lda  #0
        tay
        sta  (txttab),y
        iny
        sta  (txttab),y
        lda  txttab
        clc
        adc  #2
        sta  vartab
        lda  txttab+1
        adc  #0
        sta  vartab+1

runc    jsr  stxtpt
        lda  #0

clear   bne  stkrts

clearc  jsr  ccall      ; moved for v2 orig for rs-232
cleart  lda  memsiz     ; entry for open & close memsiz changes
        ldy  memsiz+1
        sta  fretop
        sty  fretop+1
        lda  vartab
        ldy  vartab+1
        sta  arytab
        sty  arytab+1
        sta  strend
        sty  strend+1
fload   jsr  restor
stkini  ldx  #tempst
        stx  temppt
        pla
        tay
        pla
        ldx  #stkend-257
        txs
        pha
        tya
        pha
        lda  #0
        sta  oldtxt+1
        sta  subflg
stkrts  rts

stxtpt  clc
        lda  txttab
        adc  #255
        sta  txtptr
        lda  txttab+1
        adc  #255
        sta  txtptr+1
        rts

;.end
	.page
	.subttl CODE3
list    bcc  golst
        beq  golst
        cmp  #minutk
        bne  stkrts

golst   jsr  linget
        jsr  fndlin
        jsr  chrgot
        beq  lstend
        cmp  #minutk
        bne  flnrts
        jsr  chrget
        jsr  linget
        bne  flnrts
lstend  pla
        pla
        lda  linnum
        ora  linnum+1
        bne  list4
        lda  #255
        sta  linnum
        sta  linnum+1
list4   ldy  #1
        sty  dores
        lda  (lowtr),y
        beq  grody
        jsr  iscntc
        jsr  crdo
        iny
        lda  (lowtr),y
        tax
        iny
        lda  (lowtr),y
        cmp  linnum+1
        bne  tstdun
        cpx  linnum
        beq  typlin
tstdun  bcs  grody
typlin  sty  lstpnt
        jsr  linprt
        lda  #' '
prit4   ldy  lstpnt
        and  #127
ploop   jsr  outdo
        cmp  #34
        bne  ploop1
        lda  dores
        eor  #@377
        sta  dores
ploop1  iny
        beq  grody
        lda  (lowtr),y
        bne  qplop
        tay
        lda  (lowtr),y
        tax
        iny
        lda  (lowtr),y
        stx  lowtr
        sta  lowtr+1
        bne  list4
grody   jmp  ready

qplop   jmp  (iqplop)

nqplop  bpl  ploop
        cmp  #pi
        beq  ploop
        bit  dores
        bmi  ploop
        sec
        sbc  #127
        tax
        sty  lstpnt
        ldy  #255
resrch  dex
        beq  prit3
rescr1  iny
        lda  reslst,y
        bpl  rescr1
        bmi  resrch
prit3   iny
        lda  reslst,y
        bmi  prit4
        jsr  outdo
        bne  prit3
for     lda  #128
        sta  subflg
        jsr  let
        jsr  fndfor
        bne  notol
        txa
        adc  #forsiz-3
        tax
        txs
notol   pla
        pla
        lda  #8+addprc
        jsr  getstk
        jsr  datan
        clc
        tya
        adc  txtptr
        pha
        lda  txtptr+1
        adc  #0
        pha
        lda  curlin+1
        pha
        lda  curlin
        pha
        lda  #totk
        jsr  synchr
        jsr  chknum
        jsr  frmnum
        lda  facsgn
        ora  #127
        and  facho
        sta  facho
        lda  #<ldfone
        ldy  #>ldfone
        sta  index1
        sty  index1+1
        jmp  forpsh

ldfone  lda  #<fone
        ldy  #>fone
        jsr  movfm
        jsr  chrgot
        cmp  #steptk
        bne  oneon
        jsr  chrget
        jsr  frmnum
oneon   jsr  sign
        jsr  pushf
        lda  forpnt+1
        pha
        lda  forpnt
        pha
        lda  #fortk
        pha
;.end
	.page
	.subttl CODE4
newstt  jsr  iscntc
        lda  txtptr
        ldy  txtptr+1
        cpy  #bufpag
        nop
        beq  dircon
        sta  oldtxt
        sty  oldtxt+1
dircon  ldy  #0
        lda  (txtptr),y
        bne  morsts
        ldy  #2
        lda  (txtptr),y
        clc
        bne  dircn1
        jmp  endcon

dircn1  iny
        lda  (txtptr),y
        sta  curlin
        iny
        lda  (txtptr),y
        sta  curlin+1
        tya
        adc  txtptr
        sta  txtptr
        bcc  gone
        inc  txtptr+1
gone    jmp  (igone)

ngone   jsr  chrget
ngone1  jsr  gone3
        jmp  newstt

gone3   beq  iscrts
gone2   sbc  #endtk
        bcc  glet
        cmp  #scratk-endtk+1
        bcs  snerrx
        asl  a
        tay
        lda  stmdsp+1,y
        pha
        lda  stmdsp,y
        pha
        jmp  chrget

glet    jmp  let

morsts  cmp  #':'
        beq  gone
snerr1  jmp  snerr

snerrx  cmp  #gotk-endtk
        bne  snerr1
        jsr  chrget
        lda  #totk
        jsr  synchr
        jmp  goto

restor  sec
        lda  txttab
        sbc  #1
        ldy  txttab+1
        bcs  resfin
        dey
resfin  sta  datptr
        sty  datptr+1
iscrts  rts

iscntc  jsr  $ffe1
stop    bcs  stopc
end     clc
stopc   bne  contrt
        lda  txtptr
        ldy  txtptr+1
        ldx  curlin+1
        inx
        beq  diris
        sta  oldtxt
        sty  oldtxt+1
stpend  lda  curlin
        ldy  curlin+1
        sta  oldlin
        sty  oldlin+1
diris   pla
        pla
endcon  lda  #<brktxt
        ldy  #>brktxt
        bcc  gordy
        jmp  errfin

gordy   jmp  ready

cont    bne  contrt
        ldx  #errcn
        ldy  oldtxt+1
        bne  *+5
        jmp  error

        lda  oldtxt
        sta  txtptr
        sty  txtptr+1
        lda  oldlin
        ldy  oldlin+1
        sta  curlin
        sty  curlin+1
contrt  rts

run     php
        lda  #0         ; no kernal messages
        jsr  setmsg
        plp
        bne  *+5
        jmp  runc

        jsr  clearc
        jmp  runc2

gosub   lda  #3
        jsr  getstk
        lda  txtptr+1
        pha
        lda  txtptr
        pha
        lda  curlin+1
        pha
        lda  curlin
        pha
        lda  #gosutk
        pha
runc2   jsr  chrgot
        jsr  goto
        jmp  newstt

goto    jsr  linget
        jsr  remn
        sec
        lda  curlin
        sbc  linnum
        lda  curlin+1
        sbc  linnum+1
        bcs  luk4it
        tya
        sec
        adc  txtptr
        ldx  txtptr+1
        bcc  lukall
        inx
        bcs  lukall
luk4it  lda  txttab
        ldx  txttab+1
lukall  jsr  fndlnc
        bcc  userr
        lda  lowtr
        sbc  #1
;.end
	.page
	.subttl CODE5
        sta  txtptr
        lda  lowtr+1
        sbc  #0
        sta  txtptr+1
gorts   rts

return  bne  gorts
        lda  #255
        sta  forpnt+1
        jsr  fndfor
        txs
        cmp  #gosutk
        beq  retu1
        ldx  #errrg
	.byte   $2c
userr   ldx  #errus
        jmp  error

snerr2  jmp  snerr

retu1   pla
        pla
        sta  curlin
        pla
        sta  curlin+1
        pla
        sta  txtptr
        pla
        sta  txtptr+1
data    jsr  datan
addon   tya
        clc
        adc  txtptr
        sta  txtptr
        bcc  remrts
        inc  txtptr+1
remrts  rts

datan   ldx  #':'
	.byte   $2c
remn    ldx  #0
        stx  charac
        ldy  #0
        sty  endchr
exchqt  lda  endchr
        ldx  charac
        sta  charac
        stx  endchr
remer   lda  (txtptr),y
        beq  remrts
        cmp  endchr
        beq  remrts
        iny
        cmp  #34
        bne  remer
        beq  exchqt
if      jsr  frmevl
        jsr  chrgot
        cmp  #gototk
        beq  okgoto
        lda  #thentk
        jsr  synchr
okgoto  lda  facexp
        bne  docond
rem     jsr  remn
        beq  addon
docond  jsr  chrgot
        bcs  doco
        jmp  goto

doco    jmp  gone3

ongoto  jsr  getbyt
        pha
        cmp  #gosutk
        beq  onglop
snerr3  cmp  #gototk
        bne  snerr2
onglop  dec  faclo
        bne  onglp1
        pla
        jmp  gone2

onglp1  jsr  chrget
        jsr  linget
        cmp  #44
        beq  onglop
        pla
ongrts  rts

linget  ldx  #0
        stx  linnum
        stx  linnum+1
morlin  bcs  ongrts
        sbc  #$2f
        sta  charac
        lda  linnum+1
        sta  index
        cmp  #25
        bcs  snerr3
        lda  linnum
        asl  a
        rol  index
        asl  a
        rol  index
        adc  linnum
        sta  linnum
        lda  index
        adc  linnum+1
        sta  linnum+1
        asl  linnum
        rol  linnum+1
        lda  linnum
        adc  charac
        sta  linnum
        bcc  nxtlgc
        inc  linnum+1
nxtlgc  jsr  chrget
        jmp  morlin

let     jsr  ptrget
        sta  forpnt
        sty  forpnt+1
        lda  #$b2
        jsr  synchr
        lda  intflg
        pha
        lda  valtyp
        pha
        jsr  frmevl
        pla
        rol  a
        jsr  chkval
        bne  copstr
        pla
qintgr  bpl  copflt
        jsr  round
        jsr  ayint
        ldy  #0
        lda  facmo
        sta  (forpnt),y
        iny
        lda  faclo
        sta  (forpnt),y
        rts

copflt  jmp  movvf

copstr  pla
inpcom  ldy  forpnt+1
        cpy  #>zero
        bne  getspt
        jsr  frefac
        cmp  #6
        bne  fcerr2
        ldy  #0
        sty  facexp
        sty  facsgn
;.end
	.page
	.subttl CODE6
timelp  sty  fbufpt
        jsr  timnum
        jsr  mul10
        inc  fbufpt
        ldy  fbufpt
        jsr  timnum
        jsr  movaf
        tax
        beq  noml6
        inx
        txa
        jsr  finml6
noml6   ldy  fbufpt
        iny
        cpy  #6
        bne  timelp
        jsr  mul10
        jsr  qint
        ldx  facmo
        ldy  facmoh
        lda  faclo
        jmp  settim

timnum  lda  (index),y
        jsr  qnum
        bcc  gotnum
fcerr2  jmp  fcerr

gotnum  sbc  #$2f
        jmp  finlog

getspt  ldy  #2
        lda  (facmo),y
        cmp  fretop+1
        bcc  dntcpy
        bne  qvaria
        dey
        lda  (facmo),y
        cmp  fretop
        bcc  dntcpy
qvaria  ldy  faclo
        cpy  vartab+1
        bcc  dntcpy
        bne  copy
        lda  facmo
        cmp  vartab
        bcs  copy
dntcpy  lda  facmo
        ldy  facmo+1
        jmp  copyc

copy    ldy  #0
        lda  (facmo),y
        jsr  strini
        lda  dscpnt
        ldy  dscpnt+1
        sta  strng1
        sty  strng1+1
        jsr  movins
        lda  #<dsctmp
        ldy  #>dsctmp
copyc   sta  dscpnt
        sty  dscpnt+1
        jsr  fretms
        ldy  #0
        lda  (dscpnt),y
        sta  (forpnt),y
        iny
        lda  (dscpnt),y
        sta  (forpnt),y
        iny
        lda  (dscpnt),y
        sta  (forpnt),y
        rts

printn  jsr  cmd
        jmp  iodone

cmd     jsr  getbyt
        beq  saveit
        lda  #44
        jsr  synchr
saveit  php
        stx  channl
        jsr  coout
        plp
        jmp  print

strdon  jsr  strprt
newchr  jsr  chrgot
print   beq  crdo
printc  beq  prtrts
        cmp  #tabtk
        beq  taber
        cmp  #spctk
        clc
        beq  taber
        cmp  #44
        beq  comprt
        cmp  #59
        beq  notabr
        jsr  frmevl
        bit  valtyp
        bmi  strdon
        jsr  fout
        jsr  strlit
        jsr  strprt
        jsr  outspc
        bne  newchr
fininl  lda  #0
        sta  buf,x

zz5	= buf-1

        ldx  #<zz5
        ldy  #>zz5
        lda  channl
        bne  prtrts
crdo    lda  #13
        jsr  outdo
        bit  channl
        bpl  crfin
;
        lda  #10
        jsr  outdo
crfin   eor  #255
prtrts  rts

comprt  sec
        jsr  plot       ; get tab position in x
        tya

ncmpos   = @36

        sec
morco1  sbc  #clmwid
        bcs  morco1
        eor  #255
        adc  #1
        bne  aspac
taber   php
        sec
        jsr  plot       ; read tab position
        sty  trmpos
        jsr  gtbytc
        cmp  #41
        bne  snerr4
        plp
        bcc  xspac
        txa
        sbc  trmpos
        bcc  notabr
aspac   tax
xspac   inx
xspac2  dex
        bne  xspac1
notabr  jsr  chrget
        jmp  printc

;.end
	.page
	.subttl CODE7
xspac1  jsr  outspc
        bne  xspac2
strout  jsr  strlit
strprt  jsr  frefac
        tax
        ldy  #0
        inx
strpr2  dex
        beq  prtrts
        lda  (index),y
        jsr  outdo
        iny
        cmp  #13
        bne  strpr2
        jsr  crfin
        jmp  strpr2

outspc
        lda  channl
        beq  crtskp
        lda  #' '
	.byte   $2c
crtskp  lda  #29
	.byte   $2c
outqst  lda  #'?'
outdo   jsr  outch
outrts  and  #255
        rts

trmnok  lda  inpflg
        beq  trmno1
        bmi  getdtl
        ldy  #255
        bne  stcurl
getdtl  lda  datlin
        ldy  datlin+1
stcurl  sta  curlin
        sty  curlin+1
snerr4  jmp  snerr

trmno1  lda  channl
        beq  doagin
        ldx  #errbd
        jmp  error

doagin  lda  #<tryagn
        ldy  #>tryagn
        jsr  strout
        lda  oldtxt
        ldy  oldtxt+1
        sta  txtptr
        sty  txtptr+1
        rts

get     jsr  errdir
        cmp  #'#'
        bne  gettty
        jsr  chrget
        jsr  getbyt
        lda  #44
        jsr  synchr
        stx  channl
        jsr  coin

zz2	= buf+1
zz3	= buf+2

gettty  ldx  #<zz2
        ldy  #>zz3
        lda  #0
        sta  buf+1
        lda  #64
        jsr  inpco1
        ldx  channl
        bne  iorele
        rts

inputn  jsr  getbyt
        lda  #44
        jsr  synchr
        stx  channl
        jsr  coin
        jsr  notqti
iodone  lda  channl
iorele  jsr  clschn
        ldx  #0
        stx  channl
        rts

input   cmp  #34
        bne  notqti
        jsr  strtxt
        lda  #59
        jsr  synchr
        jsr  strprt
notqti  jsr  errdir
        lda  #44
        sta  buf-1
getagn  jsr  qinlin
        lda  channl
        beq  bufful
        jsr  readst
        and  #2
        beq  bufful
        jsr  iodone
        jmp  data

bufful  lda  buf
        bne  inpcon
        lda  channl
        bne  getagn
        jsr  datan
        jmp  addon

qinlin  lda  channl
        bne  ginlin
        jsr  outqst
        jsr  outspc
ginlin  jmp  inlin

read    ldx  datptr
        ldy  datptr+1
	.byte   $a9
        tya
	.byte   $2c
inpcon  lda  #0
inpco1  sta  inpflg
        stx  inpptr
        sty  inpptr+1
inloop  jsr  ptrget
        sta  forpnt
        sty  forpnt+1
        lda  txtptr
        ldy  txtptr+1
        sta  vartxt
        sty  vartxt+1
        ldx  inpptr
        ldy  inpptr+1
        stx  txtptr
        sty  txtptr+1
        jsr  chrgot
        bne  datbk1
        bit  inpflg
        bvc  qdata
        jsr  cgetl
        sta  buf
zz4=buf-1
        ldx  #<zz4
        ldy  #>zz4
        bne  datbk
qdata   bmi  datlop
        lda  channl
        bne  getnth
        jsr  outqst
getnth  jsr  qinlin
datbk   stx  txtptr
        sty  txtptr+1
;.end
	.page
	.subttl CODE8
datbk1  jsr  chrget
        bit  valtyp
        bpl  numins
        bit  inpflg
        bvc  setqut
        inx
        stx  txtptr
        lda  #0
        sta  charac
        beq  resetc
setqut  sta  charac
        cmp  #34
        beq  nowget
        lda  #':'
        sta  charac
        lda  #44
resetc  clc
nowget  sta  endchr
        lda  txtptr
        ldy  txtptr+1
        adc  #0
        bcc  nowge1
        iny
nowge1  jsr  strlt2
        jsr  st2txt
        jsr  inpcom
        jmp  strdn2

numins  jsr  fin
        lda  intflg
        jsr  qintgr
strdn2  jsr  chrgot
        beq  trmok
        cmp  #44
        beq  *+5
        jmp  trmnok

trmok   lda  txtptr
        ldy  txtptr+1
        sta  inpptr
        sty  inpptr+1
        lda  vartxt
        ldy  vartxt+1
        sta  txtptr
        sty  txtptr+1
        jsr  chrgot
        beq  varend
        jsr  chkcom
        jmp  inloop

datlop  jsr  datan
        iny
        tax
        bne  nowlin
        ldx  #errod
        iny
        lda  (txtptr),y
        beq  errgo5
        iny
        lda  (txtptr),y
        sta  datlin
        iny
        lda  (txtptr),y
        iny
        sta  datlin+1
nowlin  jsr  addon      ; txtptr+.y
        jsr  chrgot     ; span blanks
        tax     ; used later
        cpx  #datatk
        bne  datlop
        jmp  datbk1

varend  lda  inpptr
        ldy  inpptr+1
        ldx  inpflg
        bpl  vary0
        jmp  resfin

vary0   ldy  #0
        lda  (inpptr),y
        beq  inprts
        lda  channl
        bne  inprts
        lda  #<exignt
        ldy  #>exignt
        jmp  strout

inprts  rts

EXIGNT   .BYTE  '?EXTRA IGNORED'
	.BYTE   $D
	.BYTE   0
TRYAGN   .BYTE  '?REDO FROM START'
	.BYTE   $D
	.BYTE   0
next    bne  getfor
        ldy  #0
        beq  stxfor
getfor  jsr  ptrget
stxfor  sta  forpnt
        sty  forpnt+1
        jsr  fndfor
        beq  havfor
        ldx  #errnf
errgo5  jmp  error      ; change

havfor  txs
        txa
        clc
        adc  #4
        pha
        adc  #5+addprc
        sta  index2
        pla
        ldy  #1
        jsr  movfm
        tsx
        lda  addprc+264,x
        sta  facsgn
        lda  forpnt
        ldy  forpnt+1
        jsr  fadd
        jsr  movvf
        ldy  #1
        jsr  fcompn
        tsx
        sec
        sbc  addprc+264,x
        beq  loopdn
        lda  269+addprc+addprc,x
        sta  curlin
        lda  270+addprc+addprc,x
        sta  curlin+1
        lda  272+addprc+addprc,x
        sta  txtptr
        lda  271+addprc+addprc,x
        sta  txtptr+1
newsgo  jmp  newstt

loopdn  txa
        adc  #15+addprc+addprc
        tax
        txs
        jsr  chrgot
        cmp  #44
        bne  newsgo
        jsr  chrget
        jsr  getfor
frmnum  jsr  frmevl
chknum  clc
	.byte   $24
chkstr  sec
chkval  bit  valtyp
;.end
	.page
	.subttl CODE9
        bmi  docstr
        bcs  chkerr
chkok   rts

docstr  bcs  chkok
chkerr  ldx  #errtm
errgo4  jmp  error

frmevl  ldx  txtptr
        bne  frmev1
        dec  txtptr+1
frmev1  dec  txtptr
        ldx  #0
	.byte   $24
lpoper  pha
        txa
        pha
        lda  #1
        jsr  getstk
        jsr  eval
        lda  #0
        sta  opmask
tstop   jsr  chrgot
loprel  sec
        sbc  #greatk
        bcc  endrel
        cmp  #lesstk-greatk+1
        bcs  endrel
        cmp  #1
        rol  a
        eor  #1
        eor  opmask
        cmp  opmask
        bcc  snerr5
        sta  opmask
        jsr  chrget
        jmp  loprel

endrel  ldx  opmask
        bne  finrel
        bcs  qop
        adc  #greatk-plustk
        bcc  qop
        adc  valtyp
        bne  *+5
        jmp  cat

        adc  #$ff
        sta  index1
        asl  a
        adc  index1
        tay
qprec   pla
        cmp  optab,y
        bcs  qchnum
        jsr  chknum
doprec  pha
negprc  jsr  dopre1
        pla
        ldy  opptr
        bpl  qprec1
        tax
        beq  qopgo
        bne  pulstk
finrel  lsr  valtyp
        txa
        rol  a
        ldx  txtptr
        bne  finre2
        dec  txtptr+1
finre2  dec  txtptr
        ldy  #ptdorl-optab
        sta  opmask
        bne  qprec
qprec1  cmp  optab,y
        bcs  pulstk
        bcc  doprec
dopre1  lda  optab+2,y
        pha
        lda  optab+1,y
        pha
        jsr  pushf1
        lda  opmask
        jmp  lpoper

snerr5  jmp  snerr

pushf1  lda  facsgn
        ldx  optab,y
pushf   tay
        pla
        sta  index1
        inc  index1
        pla
        sta  index1+1
        tya
        pha
forpsh  jsr  round
        lda  faclo
        pha
        lda  facmo
        pha
        lda  facmoh
        pha
        lda  facho
        pha
        lda  facexp
        pha
        jmp  (index1)

qop     ldy  #255
        pla
qopgo   beq  qoprts
qchnum  cmp  #100
        beq  unpstk
        jsr  chknum
unpstk  sty  opptr
pulstk  pla
        lsr  a
        sta  domask
        pla
        sta  argexp
        pla
        sta  argho
        pla
        sta  argmoh
        pla
        sta  argmo
        pla
        sta  arglo
        pla
        sta  argsgn
        eor  facsgn
        sta  arisgn
qoprts  lda  facexp
unprts  rts
	.space   5
eval    jmp  (ieval)

neval   lda  #0
        sta  valtyp
eval0   jsr  chrget
        bcs  eval2
eval1   jmp  fin

eval2   jsr  isletc
        bcc  *+5
        jmp  isvar

        cmp  #pi
        bne  qdot
        lda  #<pival
        ldy  #>pival
        jsr  movfm
        jmp  chrget

pival    .byte  @202
	.byte   @111
	.byte   @017
	.byte   @332
	.byte   @241

qdot    cmp  #'.'
        beq  eval1
        cmp  #minutk
        beq  domin
        cmp  #plustk
        beq  eval0
        cmp  #34
        bne  eval3
strtxt  lda  txtptr
        ldy  txtptr+1
        adc  #0
        bcc  strtx2
        iny
strtx2  jsr  strlit
        jmp  st2txt

eval3   cmp  #nottk
        bne  eval4
        ldy  #24
        bne  gonprc
notop   jsr  ayint
        lda  faclo
        eor  #255
        tay
        lda  facmo
        eor  #255
        jmp  givayf

eval4   cmp  #fntk
        bne  *+5
        jmp  fndoer

        cmp  #onefun
        bcc  parchk
        jmp  isfun

parchk  jsr  chkopn
        jsr  frmevl
chkcls  lda  #41
	.byte   $2c
chkopn  lda  #40
	.byte   $2c
chkcom  lda  #44
synchr  ldy  #0
        cmp  (txtptr),y
        bne  snerr
        jmp  chrget

snerr   ldx  #errsn
        jmp  error

domin   ldy  #21
gonprc  pla
        pla
        jmp  negprc

;.end
        .page
	.subttl CODE10
;test pointer to variable to see
;if constant is contained in basic.
;array variables have zeroes placed
;in ram. undefined simple variables
;have pointer t zero in basic.
;
tstrom  sec
        lda  facmo
        sbc  #<romloc
        lda  faclo
        sbc  #>romloc
        bcc  tstr10
;
        lda  #<initat
        sbc  facmo
        lda  #>initat
        sbc  faclo
;
tstr10  rts
	.space   5
isvar   jsr  ptrget
isvret  sta  facmo
        sty  facmo+1
        ldx  varnam
        ldy  varnam+1
        lda  valtyp
        beq  gooo
        lda  #0
        sta  facov
        jsr  tstrom     ; see if an array
        bcc  strrts     ; don't test st(i),ti(i)
        cpx  #'T'
        bne  strrts
        cpy  #$c9
        bne  strrts
        jsr  gettim
        sty  tenexp
        dey
        sty  fbufpt
        ldy  #6
        sty  deccnt
        ldy  #fdcend-foutbl
        jsr  foutim
        jmp  timstr

strrts  rts

gooo    bit  intflg
        bpl  gooooo
        ldy  #0
        lda  (facmo),y
        tax
        iny
        lda  (facmo),y
        tay
        txa
        jmp  givayf

gooooo  jsr  tstrom     ; see if array
        bcc  gomovf     ; don't test st(i),ti(i)
        cpx  #'T'
        bne  qstatv
        cpy  #'I'
        bne  gomovf
        jsr  gettim
        tya
        ldx  #160
        jmp  floatb

gettim  jsr  rdtim
        stx  facmo
        sty  facmoh
        sta  faclo
        ldy  #0
        sty  facho
        rts

qstatv  cpx  #'S'
        bne  gomovf
        cpy  #'T'
        bne  gomovf
        jsr  readst
        jmp  float

gomovf  lda  facmo
        ldy  facmo+1
        jmp  movfm

isfun   asl  a
        pha
        tax
        jsr  chrget
        cpx  #lasnum+lasnum-255
        bcc  oknorm
        jsr  chkopn
        jsr  frmevl
        jsr  chkcom
        jsr  chkstr
        pla
        tax
        lda  facmo+1
        pha
        lda  facmo
        pha
        txa
        pha
        jsr  getbyt
        pla
        tay
        txa
        pha
        jmp  fingo

oknorm  jsr  parchk
        pla
        tay
fingo   lda  fundsp-onefun-onefun+256,y
        sta  jmper+1
        lda  fundsp-onefun-onefun+257,y
        sta  jmper+2
        jsr  jmper
        jmp  chknum

orop    ldy  #255
	.byte   $2c
andop   ldy  #0
        sty  count
        jsr  ayint
        lda  facmo
        eor  count
        sta  integr
        lda  faclo
        eor  count
        sta  integr+1
        jsr  movfa
        jsr  ayint
        lda  faclo
        eor  count
        and  integr+1
        eor  count
        tay
        lda  facmo
        eor  count
        and  integr
        eor  count
        jmp  givayf

dorel   jsr  chkval
        bcs  strcmp
        lda  argsgn
        ora  #127
        and  argho
        sta  argho
        lda  #<argexp
        ldy  #>argexp
        jsr  fcomp
        tax
        jmp  qcomp

strcmp  lda  #0
        sta  valtyp
        dec  opmask
        jsr  frefac
        sta  dsctmp
        stx  dsctmp+1
        sty  dsctmp+2
        lda  argmo
        ldy  argmo+1
        jsr  fretmp
        stx  argmo
        sty  argmo+1
        tax
        sec
        sbc  dsctmp
        beq  stasgn
        lda  #1
        bcc  stasgn
        ldx  dsctmp
        lda  #$ff
stasgn  sta  facsgn
        ldy  #255
        inx
nxtcmp  iny
        dex
        bne  getcmp
        ldx  facsgn
qcomp   bmi  docmp
        clc
        bcc  docmp
getcmp  lda  (argmo),y
;.end
	.page
	.subttl CODE11
        cmp  (dsctmp+1),y
        beq  nxtcmp
        ldx  #$ff
        bcs  docmp
        ldx  #1
docmp   inx
        txa
        rol  a
        and  domask
        beq  goflot
        lda  #$ff
goflot  jmp  float

dim3    jsr  chkcom
dim     tax
        jsr  ptrgt1
        jsr  chrgot
        bne  dim3
        rts

ptrget  ldx  #0
        jsr  chrgot
ptrgt1  stx  dimflg
ptrgt2  sta  varnam
        jsr  chrgot
        jsr  isletc
        bcs  ptrgt3
interr  jmp  snerr

ptrgt3  ldx  #0
        stx  valtyp
        stx  intflg
        jsr  chrget
        bcc  issec
        jsr  isletc
        bcc  nosec
issec   tax
eatem   jsr  chrget
        bcc  eatem
        jsr  isletc
        bcs  eatem
nosec   cmp  #'$'
        bne  notstr
        lda  #$ff
        sta  valtyp
        bne  turnon
notstr  cmp  #'%'
        bne  strnam
        lda  subflg
        bne  interr
        lda  #128
        sta  intflg
        ora  varnam
        sta  varnam
turnon  txa
        ora  #128
        tax
        jsr  chrget
strnam  stx  varnam+1
        sec
        ora  subflg
        sbc  #40
        bne  *+5
        jmp  isary

        ldy  #0
        sty  subflg
        lda  vartab
        ldx  vartab+1
stxfnd  stx  lowtr+1
lopfnd  sta  lowtr
        cpx  arytab+1
        bne  lopfn
        cmp  arytab
        beq  notfns
lopfn   lda  varnam
        cmp  (lowtr),y
        bne  notit
        lda  varnam+1
        iny
        cmp  (lowtr),y
        beq  finptr
        dey
notit   clc
        lda  lowtr
        adc  #6+addprc
        bcc  lopfnd
        inx
        bne  stxfnd
isletc  cmp  #'A'
        bcc  islrts
        sbc  #$5b
        sec
        sbc  #@245
islrts  rts

notfns  pla
        pha
zz6=isvret-1
        cmp  #<zz6
        bne  notevl
ldzr    lda  #<zero
        ldy  #>zero
        rts

notevl  lda  varnam
        ldy  varnam+1
        cmp  #'T'
        bne  qstavr
        cpy  #@311
        beq  ldzr
        cpy  #@111
        bne  qstavr
gobadv  jmp  snerr

qstavr
        cmp  #'S'
        bne  varok
        cpy  #'T'
        beq  gobadv
varok   lda  arytab
        ldy  arytab+1
        sta  lowtr
        sty  lowtr+1
        lda  strend
        ldy  strend+1
        sta  hightr
        sty  hightr+1
        clc
        adc  #6+addprc
        bcc  noteve
        iny
noteve  sta  highds
        sty  highds+1
        jsr  bltu
        lda  highds
        ldy  highds+1
        iny
        sta  arytab
        sty  arytab+1
        ldy  #0
        lda  varnam
        sta  (lowtr),y
        iny
        lda  varnam+1
        sta  (lowtr),y
        lda  #0
        iny
        sta  (lowtr),y
        iny
        sta  (lowtr),y
        iny
        sta  (lowtr),y
        iny
        sta  (lowtr),y
        iny
        sta  (lowtr),y
finptr  lda  lowtr
        clc
        adc  #2
        ldy  lowtr+1
        bcc  finnow
        iny
finnow  sta  varpnt
        sty  varpnt+1
        rts

fmaptr  lda  count
        asl  a
        adc  #5
        adc  lowtr
        ldy  lowtr+1
        bcc  jsrgm
        iny
jsrgm   sta  arypnt
        sty  arypnt+1
        rts

;.end
	.page
	.subttl CODE12
n32768   .byte  144,128,0,0,0

flpint  jsr  ayint
        lda  facmo
        ldy  faclo
        rts

intidx  jsr  chrget
        jsr  frmevl
posint  jsr  chknum
        lda  facsgn
        bmi  nonono
ayint   lda  facexp
        cmp  #144
        bcc  qintgo
        lda  #<n32768
        ldy  #>n32768
        jsr  fcomp
nonono  bne  fcerr
qintgo  jmp  qint

isary   lda  dimflg
        ora  intflg
        pha
        lda  valtyp
        pha
        ldy  #0
indlop  tya
        pha
        lda  varnam+1
        pha
        lda  varnam
        pha
        jsr  intidx
        pla
        sta  varnam
        pla
        sta  varnam+1
        pla
        tay
        tsx
        lda  258,x
        pha
        lda  257,x
        pha
        lda  indice
        sta  258,x
        lda  indice+1
        sta  257,x
        iny
        jsr  chrgot
        cmp  #44
        beq  indlop
        sty  count
        jsr  chkcls
        pla
        sta  valtyp
        pla
        sta  intflg
        and  #127
        sta  dimflg
        ldx  arytab
        lda  arytab+1
lopfda  stx  lowtr
        sta  lowtr+1
        cmp  strend+1
        bne  lopfdv
        cpx  strend
        beq  notfdd
lopfdv  ldy  #0
        lda  (lowtr),y
        iny
        cmp  varnam
        bne  nmary1
        lda  varnam+1
        cmp  (lowtr),y
        beq  gotary
nmary1  iny
        lda  (lowtr),y
        clc
        adc  lowtr
        tax
        iny
        lda  (lowtr),y
        adc  lowtr+1
        bcc  lopfda
bserr   ldx  #errbs
	.byte   $2c
fcerr   ldx  #errfc
errgo3  jmp  error

gotary  ldx  #errdd
        lda  dimflg
        bne  errgo3
        jsr  fmaptr
        lda  count
        ldy  #4
        cmp  (lowtr),y
        bne  bserr
        jmp  getdef

notfdd  jsr  fmaptr
        jsr  reason
        ldy  #0
        sty  curtol+1
        ldx  #5
        lda  varnam
        sta  (lowtr),y
        bpl  notflt
        dex
notflt  iny
        lda  varnam+1
        sta  (lowtr),y
        bpl  stomlt
        dex
        dex
stomlt  stx  curtol
        lda  count
        iny
        iny
        iny
        sta  (lowtr),y
loppta  ldx  #11
        lda  #0
        bit  dimflg
        bvc  notdim
        pla
        clc
        adc  #1
        tax
        pla
        adc  #0
notdim  iny
        sta  (lowtr),y
        iny
        txa
        sta  (lowtr),y
        jsr  umult
        stx  curtol
        sta  curtol+1
        ldy  index
        dec  count
        bne  loppta
        adc  arypnt+1
        bcs  omerr1
        sta  arypnt+1
        tay
        txa
        adc  arypnt
        bcc  grease
        iny
        beq  omerr1
grease  jsr  reason
        sta  strend
        sty  strend+1
        lda  #0
        inc  curtol+1
;.end
	.page
	.subttl CODE13
        ldy  curtol
        beq  deccur
zerita  dey
        sta  (arypnt),y
        bne  zerita
deccur  dec  arypnt+1
        dec  curtol+1
        bne  zerita
        inc  arypnt+1
        sec
        lda  strend
        sbc  lowtr
        ldy  #2
        sta  (lowtr),y
        lda  strend+1
        iny
        sbc  lowtr+1
        sta  (lowtr),y
        lda  dimflg
        bne  dimrts
        iny
getdef  lda  (lowtr),y
        sta  count
        lda  #0
        sta  curtol
inlpnm  sta  curtol+1
        iny
        pla
        tax
        sta  indice
        pla
        sta  indice+1
        cmp  (lowtr),y
        bcc  inlpn2
        bne  bserr7
        iny
        txa
        cmp  (lowtr),y
        bcc  inlpn1
bserr7  jmp  bserr

omerr1  jmp  omerr

inlpn2  iny
inlpn1  lda  curtol+1
        ora  curtol
        clc
        beq  addind
        jsr  umult
        txa
        adc  indice
        tax
        tya
        ldy  index1
addind  adc  indice+1
        stx  curtol
        dec  count
        bne  inlpnm
        sta  curtol+1
        ldx  #5
        lda  varnam
        bpl  notfl1
        dex
notfl1  lda  varnam+1
        bpl  stoml1
        dex
        dex
stoml1  stx  addend
        lda  #0
        jsr  umultd
        txa
        adc  arypnt
        sta  varpnt
        tya
        adc  arypnt+1
        sta  varpnt+1
        tay
        lda  varpnt
dimrts  rts

umult   sty  index
        lda  (lowtr),y
        sta  addend
        dey
        lda  (lowtr),y
umultd  sta  addend+1
        lda  #16
        sta  deccnt
        ldx  #0
        ldy  #0
umultc  txa
        asl  a
        tax
        tya
        rol  a
        tay
        bcs  omerr1
        asl  curtol
        rol  curtol+1
        bcc  umlcnt
        clc
        txa
        adc  addend
        tax
        tya
        adc  addend+1
        tay
        bcs  omerr1
umlcnt  dec  deccnt
        bne  umultc
umlrts  rts

fre     lda  valtyp
        beq  nofref
        jsr  frefac
nofref  jsr  garba2
        sec
        lda  fretop
        sbc  strend
        tay
        lda  fretop+1
        sbc  strend+1
givayf  ldx  #0
        stx  valtyp
        sta  facho
        sty  facho+1
        ldx  #144
        jmp  floats

pos     sec
        jsr  plot       ; get tab pos in .y
sngflt  lda  #0
        beq  givayf
errdir  ldx  curlin+1
        inx
        bne  dimrts
        ldx  #errid
	.byte   $2c
errguf  ldx  #erruf
        jmp  error

def     jsr  getfnm
        jsr  errdir
        jsr  chkopn
        lda  #128
        sta  subflg
        jsr  ptrget
        jsr  chknum
        jsr  chkcls
        lda  #$b2
        jsr  synchr
        pha
        lda  varpnt+1
        pha
        lda  varpnt
        pha
        lda  txtptr+1
;.end
	.page
	.subttl CODE14
        pha
        lda  txtptr
	pha
        jsr  data
        jmp  deffin

getfnm  lda  #fntk
        jsr  synchr
        ora  #128
        sta  subflg
        jsr  ptrgt2
        sta  defpnt
        sty  defpnt+1
        jmp  chknum

fndoer  jsr  getfnm
        lda  defpnt+1
        pha
        lda  defpnt
        pha
        jsr  parchk
        jsr  chknum
        pla
        sta  defpnt
        pla
        sta  defpnt+1
        ldy  #2
        lda  (defpnt),y
        sta  varpnt
        tax
        iny
        lda  (defpnt),y
        beq  errguf
        sta  varpnt+1
        iny
defstf  lda  (varpnt),y
        pha
        dey
        bpl  defstf
        ldy  varpnt+1
        jsr  movmf
        lda  txtptr+1
        pha
        lda  txtptr
        pha
        lda  (defpnt),y
        sta  txtptr
        iny
        lda  (defpnt),y
        sta  txtptr+1
        lda  varpnt+1
        pha
        lda  varpnt
        pha
        jsr  frmnum
        pla
        sta  defpnt
        pla
        sta  defpnt+1
        jsr  chrgot
        beq  *+5
        jmp  snerr

        pla
        sta  txtptr
        pla
        sta  txtptr+1
deffin  ldy  #0
        pla
        sta  (defpnt),y
        pla
        iny
        sta  (defpnt),y
        pla
        iny
        sta  (defpnt),y
        pla
        iny
        sta  (defpnt),y
        pla
        iny
        sta  (defpnt),y
        rts

strd    jsr  chknum
        ldy  #0
        jsr  foutc
        pla
        pla
timstr  lda  #<lofbuf
        ldy  #>lofbuf
        beq  strlit
strini  ldx  facmo
        ldy  facmo+1
        stx  dscpnt
        sty  dscpnt+1
strspa  jsr  getspa
        stx  dsctmp+1
        sty  dsctmp+2
        sta  dsctmp
        rts

strlit  ldx  #34
        stx  charac
        stx  endchr
strlt2  sta  strng1
        sty  strng1+1
        sta  dsctmp+1
        sty  dsctmp+2
        ldy  #255
strget  iny
        lda  (strng1),y
        beq  strfi1
        cmp  charac
        beq  strfin
        cmp  endchr
        bne  strget
strfin  cmp  #34
        beq  strfi2
strfi1  clc
strfi2  sty  dsctmp
        tya
        adc  strng1
        sta  strng2
        ldx  strng1+1
        bcc  strst2
        inx
strst2  stx  strng2+1
        lda  strng1+1
        beq  strcp
        cmp  #bufpag
        bne  putnew
strcp   tya
        jsr  strini
        ldx  strng1
        ldy  strng1+1
        jsr  movstr
putnew  ldx  temppt
        cpx  #tempst+strsiz+strsiz+strsiz
        bne  putnw1
        ldx  #errst
errgo2  jmp  error

putnw1  lda  dsctmp
        sta  0,x
        lda  dsctmp+1
        sta  1,x
        lda  dsctmp+2
        sta  2,x
        ldy  #0
        stx  facmo
        sty  facmo+1
        sty  facov
        dey
        sty  valtyp
        stx  lastpt
        inx
        inx
        inx
        stx  temppt
        rts

getspa  lsr  garbfl
tryag2  pha
        eor  #255
        sec
        adc  fretop
        ldy  fretop+1
        bcs  tryag3
        dey
tryag3  cpy  strend+1
        bcc  garbag
        bne  strfre
        cmp  strend
        bcc  garbag
strfre  sta  fretop
        sty  fretop+1
        sta  frespc
        sty  frespc+1
        tax
        pla
        rts

garbag  ldx  #errom
        lda  garbfl
        bmi  errgo2
        jsr  garba2
        lda  #128
        sta  garbfl
        pla
        bne  tryag2
garba2  ldx  memsiz
        lda  memsiz+1
fndvar  stx  fretop
        sta  fretop+1
        ldy  #0
        sty  grbpnt+1
        sty  grbpnt
        lda  strend
        ldx  strend+1
        sta  grbtop
        stx  grbtop+1
        lda  #<tempst
        ldx  #>tempst
        sta  index1
        stx  index1+1
tvar    cmp  temppt
        beq  svars
        jsr  dvar
        beq  tvar
svars   lda  #6+addprc
        sta  four6
        lda  vartab
        ldx  vartab+1
;.end
	.page
	.subttl CODE15
        sta  index1
        stx  index1+1
svar    cpx  arytab+1
        bne  svargo
        cmp  arytab
        beq  aryvar
svargo  jsr  dvars
        beq  svar
aryvar  sta  arypnt
        stx  arypnt+1
        lda  #strsiz
        sta  four6
aryva2  lda  arypnt
        ldx  arypnt+1
aryva3  cpx  strend+1
        bne  aryvgo
        cmp  strend
        bne  *+5
        jmp  grbpas

aryvgo  sta  index1
        stx  index1+1
        ldy  #1-addprc
        lda  (index1),y
        tax
        iny
        lda  (index1),y
        php
        iny
        lda  (index1),y
        adc  arypnt
        sta  arypnt
        iny
        lda  (index1),y
        adc  arypnt+1
        sta  arypnt+1
        plp
        bpl  aryva2
        txa
        bmi  aryva2
        iny
        lda  (index1),y
        ldy  #0
        asl  a
        adc  #5
        adc  index1
        sta  index1
        bcc  aryget
        inc  index1+1
aryget  ldx  index1+1
arystr  cpx  arypnt+1
        bne  gogo
        cmp  arypnt
        beq  aryva3
gogo    jsr  dvar
        beq  arystr
dvars   lda  (index1),y
        bmi  dvarts
        iny
        lda  (index1),y
        bpl  dvarts
        iny
dvar    lda  (index1),y
        beq  dvarts
        iny
        lda  (index1),y
        tax
        iny
        lda  (index1),y
        cmp  fretop+1
        bcc  dvar2
        bne  dvarts
        cpx  fretop
        bcs  dvarts
dvar2   cmp  grbtop+1
        bcc  dvarts
        bne  dvar3
        cpx  grbtop
        bcc  dvarts
dvar3   stx  grbtop
        sta  grbtop+1
        lda  index1
        ldx  index1+1
        sta  grbpnt
        stx  grbpnt+1
        lda  four6
        sta  size
dvarts  lda  four6
        clc
        adc  index1
        sta  index1
        bcc  grbrts
        inc  index1+1
grbrts  ldx  index1+1
        ldy  #0
        rts

grbpas  lda  grbpnt+1
        ora  grbpnt
        beq  grbrts
        lda  size
        and  #4
        lsr  a
        tay
        sta  size
        lda  (grbpnt),y
        adc  lowtr
        sta  hightr
        lda  lowtr+1
        adc  #0
        sta  hightr+1
        lda  fretop
        ldx  fretop+1
        sta  highds
        stx  highds+1
        jsr  bltuc
        ldy  size
        iny
        lda  highds
        sta  (grbpnt),y
        tax
        inc  highds+1
        lda  highds+1
        iny
        sta  (grbpnt),y
        jmp  fndvar

cat     lda  faclo
        pha
        lda  facmo
        pha
        jsr  eval
        jsr  chkstr
        pla
        sta  strng1
        pla
        sta  strng1+1
        ldy  #0
        lda  (strng1),y
        clc
        adc  (facmo),y
        bcc  sizeok
        ldx  #errls
        jmp  error

sizeok  jsr  strini
        jsr  movins
        lda  dscpnt
        ldy  dscpnt+1
        jsr  fretmp
        jsr  movdo
        lda  strng1
        ldy  strng1+1
        jsr  fretmp
        jsr  putnew
        jmp  tstop

movins  ldy  #0
        lda  (strng1),y
        pha
        iny
;.end
	.page
	.subttl CODE16
        lda  (strng1),y
        tax
        iny
        lda  (strng1),y
        tay
        pla
movstr  stx  index
        sty  index+1
movdo   tay
        beq  mvdone
        pha
movlp   dey
        lda  (index),y
        sta  (frespc),y
        tya
        bne  movlp
        pla
mvdone  clc
        adc  frespc
        sta  frespc
        bcc  mvstrt
        inc  frespc+1
mvstrt  rts

frestr  jsr  chkstr
frefac  lda  facmo
        ldy  facmo+1
fretmp  sta  index
        sty  index+1
        jsr  fretms
        php
        ldy  #0
        lda  (index),y
        pha
        iny
        lda  (index),y
        tax
        iny
        lda  (index),y
        tay
        pla
        plp
        bne  fretrt
        cpy  fretop+1
        bne  fretrt
        cpx  fretop
        bne  fretrt
        pha
        clc
        adc  fretop
        sta  fretop
        bcc  frepla
        inc  fretop+1
frepla  pla
fretrt  stx  index
        sty  index+1
        rts

fretms  cpy  lastpt+1
        bne  frerts
        cmp  lastpt
        bne  frerts
        sta  temppt
        sbc  #strsiz
        sta  lastpt
        ldy  #0
frerts  rts

chrd    jsr  conint
        txa
        pha
        lda  #1
        jsr  strspa
        pla
        ldy  #0
        sta  (dsctmp+1),y
        pla
        pla
        jmp  putnew

leftd   jsr  pream
        cmp  (dscpnt),y
        tya
rleft   bcc  rleft1
        lda  (dscpnt),y
        tax
        tya
rleft1  pha
rleft2  txa
rleft3  pha
        jsr  strspa
        lda  dscpnt
        ldy  dscpnt+1
        jsr  fretmp
        pla
        tay
        pla
        clc
        adc  index
        sta  index
        bcc  pulmor
        inc  index+1
pulmor  tya
        jsr  movdo
        jmp  putnew

rightd  jsr  pream
        clc
        sbc  (dscpnt),y
        eor  #255
        jmp  rleft

midd    lda  #255
        sta  faclo
        jsr  chrgot
        cmp  #41
        beq  mid2
        jsr  chkcom
        jsr  getbyt
mid2    jsr  pream
        beq  gofuc
        dex
        txa
        pha
        clc
        ldx  #0
        sbc  (dscpnt),y
        bcs  rleft2
        eor  #255
        cmp  faclo
        bcc  rleft3
        lda  faclo
        bcs  rleft3
pream   jsr  chkcls
        pla
        tay
        pla
        sta  jmper+1
        pla
        pla
        pla
        tax
        pla
        sta  dscpnt
        pla
        sta  dscpnt+1
        lda  jmper+1
        pha
        tya
        pha
        ldy  #0
        txa
        rts

len     jsr  len1
        jmp  sngflt

len1    jsr  frestr
        ldx  #0
        stx  valtyp
        tay
        rts

asc	jsr  len1
        beq  gofuc
        ldy  #0
        lda  (index1),y
        tay
        jmp  sngflt

gofuc   jmp  fcerr

gtbytc  jsr  chrget

;.end
	.page
	.subttl CODE17
getbyt  jsr  frmnum
conint  jsr  posint
        ldx  facmo
        bne  gofuc
        ldx  faclo
        jmp  chrgot

val     jsr  len1
        bne  *+5
        jmp  zerofc

        ldx  txtptr
        ldy  txtptr+1
        stx  strng2
        sty  strng2+1
        ldx  index1
        stx  txtptr
        clc
        adc  index1
        sta  index2
        ldx  index1+1
        stx  txtptr+1
        bcc  val2
        inx
val2    stx  index2+1
        ldy  #0
        lda  (index2),y
        pha
        tya     ; a=0
        sta  (index2),y
        jsr  chrgot
        jsr  fin
        pla
        ldy  #0
        sta  (index2),y
st2txt  ldx  strng2
        ldy  strng2+1
        stx  txtptr
        sty  txtptr+1
valrts  rts

getnum  jsr  frmnum
        jsr  getadr
combyt  jsr  chkcom
        jmp  getbyt

getadr  lda  facsgn
        bmi  gofuc
        lda  facexp
        cmp  #145
        bcs  gofuc
        jsr  qint
        lda  facmo
        ldy  facmo+1
        sty  poker
        sta  poker+1
        rts

peek    lda  poker+1
        pha
        lda  poker
        pha
        jsr  getadr
        ldy  #0
getcon  lda  (poker),y
        tay
dosgfl  pla
        sta  poker
        pla
        sta  poker+1
        jmp  sngflt

poke    jsr  getnum
        txa
        ldy  #0
        sta  (poker),y
        rts

fnwait  jsr  getnum
        stx  andmsk
        ldx  #0
        jsr  chrgot
        beq  stordo
        jsr  combyt
stordo  stx  eormsk
        ldy  #0
waiter  lda  (poker),y
        eor  eormsk
        and  andmsk
        beq  waiter
zerrts  rts

faddh   lda  #<fhalf
        ldy  #>fhalf
        jmp  fadd

fsub    jsr  conupk
fsubt   lda  facsgn
        eor  #@377
        sta  facsgn
        eor  argsgn
        sta  arisgn
        lda  facexp
        jmp  faddt

fadd5   jsr  shiftr
        bcc  fadd4
fadd    jsr  conupk
faddt   bne  *+5
        jmp  movfa

        ldx  facov
        stx  oldov
        ldx  #argexp
        lda  argexp
faddc   tay
        beq  zerrts
        sec
        sbc  facexp
        beq  fadd4
        bcc  fadda
        sty  facexp
        ldy  argsgn
        sty  facsgn
        eor  #@377
        adc  #0
        ldy  #0
        sty  oldov
        ldx  #fac
        bne  fadd1
fadda   ldy  #0
        sty  facov
fadd1   cmp  #$f9
        bmi  fadd5
        tay
        lda  facov
        lsr  1,x
        jsr  rolshf
fadd4   bit  arisgn
        bpl  fadd2
        ldy  #facexp
        cpx  #argexp
        beq  subit
        ldy  #argexp
subit   sec
        eor  #@377
        adc  oldov
        sta  facov
        lda  3+addprc,y
        sbc  3+addprc,x
        sta  faclo
        lda  addprc+2,y
        sbc  2+addprc,x
        sta  facmo
        lda  2,y
        sbc  2,x
        sta  facmoh
        lda  1,y
        sbc  1,x
        sta  facho
fadflt  bcs  normal
        jsr  negfac
normal  ldy  #0
        tya
        clc
norm3   ldx  facho
        bne  norm1
        ldx  facho+1
        stx  facho
        ldx  facmoh+1
;.end
	.page
	.subttl CODE18
        stx  facmoh
        ldx  facmo+1
        stx  facmo
        ldx  facov
        stx  faclo
        sty  facov
        adc  #@10

addpr2   = addprc+addprc
addpr4   = addpr2+addpr2
addpr8   = addpr4+addpr4

        cmp  #@30+addpr8
        bne  norm3

zerofc  lda  #0
zerof1  sta  facexp
zeroml  sta  facsgn
        rts

fadd2   adc  oldov
        sta  facov
        lda  faclo
        adc  arglo
        sta  faclo
        lda  facmo
        adc  argmo
        sta  facmo
        lda  facmoh
        adc  argmoh
        sta  facmoh
        lda  facho
        adc  argho
        sta  facho
        jmp  squeez

norm2   adc  #1
        asl  facov
        rol  faclo
        rol  facmo
        rol  facmoh
        rol  facho
norm1   bpl  norm2
        sec
        sbc  facexp
        bcs  zerofc
        eor  #@377
        adc  #1
        sta  facexp
squeez  bcc  rndrts
rndshf  inc  facexp
        beq  overr
        ror  facho
        ror  facmoh
        ror  facmo
        ror  faclo
        ror  facov
rndrts  rts

negfac  lda  facsgn
        eor  #@377
        sta  facsgn
negfch  lda  facho
        eor  #@377
        sta  facho
        lda  facmoh
        eor  #@377
        sta  facmoh
        lda  facmo
        eor  #@377
        sta  facmo
        lda  faclo
        eor  #@377
        sta  faclo
        lda  facov
        eor  #@377
        sta  facov
        inc  facov
        bne  incfrt
incfac  inc  faclo
        bne  incfrt
        inc  facmo
        bne  incfrt
        inc  facmoh
        bne  incfrt
        inc  facho
incfrt  rts

overr   ldx  #errov
        jmp  error

mulshf  ldx  #resho-1
shftr2  ldy  3+addprc,x
        sty  facov
        ldy  3,x
        sty  4,x
        ldy  2,x
        sty  3,x
        ldy  1,x
        sty  2,x
        ldy  bits
        sty  1,x
shiftr  adc  #@10
        bmi  shftr2
        beq  shftr2
        sbc  #@10
        tay
        lda  facov
        bcs  shftrt
shftr3  asl  1,x
        bcc  shftr4
        inc  1,x
shftr4  ror  1,x
        ror  1,x
rolshf  ror  2,x
        ror  3,x
        ror  4,x
        ror  a
        iny
        bne  shftr3
shftrt  clc
        rts

fone     .byte  @201,0,0,0,0

logcn2   .byte  3,@177,@136,@126
	.byte   @313,@171,@200,@23
	.byte   @233,@13,@144,@200
	.byte   @166,@70,@223,@26
	.byte   @202,@70,@252,@73,@40

sqr05    .byte  @200,@65,4,@363,@64
sqr20    .byte  @201,@65,@4,@363,@64
neghlf   .byte  @200,@200,0,0,0
log2     .byte  @200,@61,@162,@27,@370

;.end
	.page
	.subttl CODE19
log     jsr  sign
        beq  logerr
        bpl  log1
logerr  jmp  fcerr

log1    lda  facexp
        sbc  #@177
        pha
        lda  #@200
        sta  facexp
        lda  #<sqr05
        ldy  #>sqr05
        jsr  fadd
        lda  #<sqr20
        ldy  #>sqr20
        jsr  fdiv
        lda  #<fone
        ldy  #>fone
        jsr  fsub
        lda  #<logcn2
        ldy  #>logcn2
        jsr  polyx
        lda  #<neghlf
        ldy  #>neghlf
        jsr  fadd
        pla
        jsr  finlog
        lda  #<log2
        ldy  #>log2
fmult   jsr  conupk
fmultt  bne  *+5
        jmp  multrt

        jsr  muldiv
        lda  #0
        sta  resho
        sta  resmoh
        sta  resmo
        sta  reslo
        lda  facov
        jsr  mltply
        lda  faclo
        jsr  mltply
        lda  facmo
        jsr  mltply
        lda  facmoh
        jsr  mltply
        lda  facho
        jsr  mltpl1
        jmp  movfr

mltply  bne  *+5
        jmp  mulshf

mltpl1  lsr  a
        ora  #@200
mltpl2  tay
        bcc  mltpl3
        clc
        lda  reslo
        adc  arglo
        sta  reslo
        lda  resmo
        adc  argmo
        sta  resmo
        lda  resmoh
        adc  argmoh
        sta  resmoh
        lda  resho
        adc  argho
        sta  resho
mltpl3  ror  resho
        ror  resmoh
        ror  resmo
        ror  reslo
        ror  facov
        tya
        lsr  a
        bne  mltpl2
multrt  rts

conupk  sta  index1
        sty  index1+1
        ldy  #3+addprc
        lda  (index1),y
        sta  arglo
        dey
        lda  (index),y
        sta  argmo
        dey
        lda  (index1),y
        sta  argmoh
        dey
        lda  (index1),y
        sta  argsgn
        eor  facsgn
        sta  arisgn
        lda  argsgn
        ora  #@200
        sta  argho
        dey
        lda  (index1),y
        sta  argexp
        lda  facexp
        rts

muldiv  lda  argexp
mldexp  beq  zeremv
        clc
        adc  facexp
        bcc  tryoff
        bmi  goover
        clc
	.byte   $2c
tryoff  bpl  zeremv
        adc  #@200
        sta  facexp
        bne  *+5
        jmp  zeroml

        lda  arisgn
        sta  facsgn
        rts

mldvex  lda  facsgn
        eor  #@377
        bmi  goover
zeremv  pla
        pla
        jmp  zerofc

goover  jmp  overr

mul10   jsr  movaf
        tax
        beq  mul10r
        clc
        adc  #2
        bcs  goover
finml6  ldx  #0
        stx  arisgn
        jsr  faddc
        inc  facexp
        beq  goover
mul10r  rts

tenc     .byte  @204,@40,0,0,0

div10   jsr  movaf
        lda  #<tenc
        ldy  #>tenc
        ldx  #0
fdivf   stx  arisgn
        jsr  movfm
        jmp  fdivt

fdiv    jsr  conupk
fdivt   beq  dv0err
        jsr  round
        lda  #0
        sec
        sbc  facexp
        sta  facexp
        jsr  muldiv
        inc  facexp
        beq  goover
        ldx  #253-addprc
        lda  #1
divide  ldy  argho
        cpy  facho
        bne  savquo
        ldy  argmoh
        cpy  facmoh
        bne  savquo
        ldy  argmo
        cpy  facmo
        bne  savquo
        ldy  arglo
        cpy  faclo
savquo  php
        rol  a
        bcc  qshft
        inx
        sta  reslo,x
        beq  ld100
        bpl  divnrm
        lda  #1
qshft   plp
        bcs  divsub
shfarg  asl  arglo
        rol  argmo
        rol  argmoh
        rol  argho
        bcs  savquo
        bmi  divide
        bpl  savquo
divsub  tay
        lda  arglo
        sbc  faclo
        sta  arglo
        lda  argmo
        sbc  facmo
        sta  argmo
        lda  argmoh
        sbc  facmoh
        sta  argmoh
        lda  argho
        sbc  facho
        sta  argho
        tya
        jmp  shfarg

ld100   lda  #@100
        bne  qshft

divnrm  asl  a
        asl  a
        asl  a
        asl  a
        asl  a
        asl  a
        sta  facov
        plp
        jmp  movfr

dv0err  ldx  #errdvo
        jmp  error

;.end
	.page
	.subttl CODE20
movfr   lda  resho
        sta  facho
        lda  resmoh
        sta  facmoh
        lda  resmo
        sta  facmo
        lda  reslo
        sta  faclo
        jmp  normal

movfm   sta  index1
        sty  index1+1
        ldy  #3+addprc
        lda  (index1),y
        sta  faclo
        dey
        lda  (index1),y
        sta  facmo
        dey
        lda  (index1),y
        sta  facmoh
        dey
        lda  (index1),y
        sta  facsgn
        ora  #@200
        sta  facho
        dey
        lda  (index1),y
        sta  facexp
        sty  facov
        rts

mov2f   ldx  #tempf2
	.byte   $2c
mov1f   ldx  #tempf1
        ldy  #0
        beq  movmf
movvf   ldx  forpnt
        ldy  forpnt+1
movmf   jsr  round
        stx  index1
        sty  index1+1
        ldy  #3+addprc
        lda  faclo
        sta  (index),y
        dey
        lda  facmo
        sta  (index),y
        dey
        lda  facmoh
        sta  (index),y
        dey
        lda  facsgn
        ora  #@177
        and  facho
        sta  (index),y
        dey
        lda  facexp
        sta  (index),y
        sty  facov
        rts

movfa   lda  argsgn
movfa1  sta  facsgn
        ldx  #4+addprc
movfal  lda  argexp-1,x
        sta  facexp-1,x
        dex
        bne  movfal
        stx  facov
        rts

movaf   jsr  round
movef   ldx  #5+addprc
movafl  lda  facexp-1,x
        sta  argexp-1,x
        dex
        bne  movafl
        stx  facov
movrts  rts

round   lda  facexp
        beq  movrts
        asl  facov
        bcc  movrts
incrnd  jsr  incfac
        bne  movrts
        jmp  rndshf

sign    lda  facexp
        beq  signrt
fcsign  lda  facsgn
fcomps  rol  a
        lda  #$ff
        bcs  signrt
        lda  #1
signrt  rts

sgn     jsr  sign

float   sta  facho
        lda  #0
        sta  facho+1
        ldx  #@210
floats  lda  facho
        eor  #@377
        rol  a
floatc  lda  #0
        sta  faclo
        sta  facmo
floatb  stx  facexp
        sta  facov
        sta  facsgn
        jmp  fadflt

abs     lsr  facsgn
        rts

fcomp   sta  index2
fcompn  sty  index2+1
        ldy  #0
        lda  (index2),y
        iny
        tax
        beq  sign
        lda  (index2),y
        eor  facsgn
        bmi  fcsign
        cpx  facexp
        bne  fcompc
        lda  (index2),y
        ora  #@200
        cmp  facho
        bne  fcompc
        iny
        lda  (index2),y
        cmp  facmoh
        bne  fcompc
        iny
        lda  (index2),y
        cmp  facmo
        bne  fcompc
        iny
        lda  #@177
        cmp  facov
        lda  (index2),y
        sbc  faclo
        beq  qintrt
fcompc  lda  facsgn
        bcc  fcompd
        eor  #@377
fcompd  jmp  fcomps

;.end
	.page
	.subttl CODE21
qint    lda  facexp
        beq  clrfac
        sec
        sbc  #addpr8+@230
        bit  facsgn
        bpl  qishft
        tax
        lda  #@377
        sta  bits
        jsr  negfch
        txa
qishft  ldx  #fac
        cmp  #$f9
        bpl  qint1
        jsr  shiftr
        sty  bits
qintrt  rts

qint1   tay
        lda  facsgn
        and  #@200
        lsr  facho
        ora  facho
        sta  facho
        jsr  rolshf
        sty  bits
        rts

int     lda  facexp
        cmp  #addpr8+@230
        bcs  intrts
        jsr  qint
        sty  facov
        lda  facsgn
        sty  facsgn
        eor  #@200
        rol  a
        lda  #@230+8
        sta  facexp
        lda  faclo
        sta  integr
        jmp  fadflt

clrfac  sta  facho
        sta  facmoh
        sta  facmo
        sta  faclo
        tay
intrts  rts

fin     ldy  #@0
        ldx  #@11+addprc
finzlp  sty  deccnt,x
        dex
        bpl  finzlp
        bcc  findgq
        cmp  #'-'
        bne  qplus
        stx  sgnflg
        beq  finc
qplus   cmp  #'+'
        bne  fin1
finc    jsr  chrget
findgq  bcc  findig
fin1    cmp  #'.'
        beq  findp
        cmp  #'E'
        bne  fine
        jsr  chrget
        bcc  fnedg1
        cmp  #minutk
        beq  finec1
        cmp  #'-'
        beq  finec1
        cmp  #plustk
        beq  finec
        cmp  #'+'
        beq  finec
        bne  finec2
finec1  ror  expsgn
finec   jsr  chrget
fnedg1  bcc  finedg
finec2  bit  expsgn
        bpl  fine
        lda  #0
        sec
        sbc  tenexp
        jmp  fine1

findp   ror  dptflg
        bit  dptflg
        bvc  finc
fine    lda  tenexp
fine1   sec
        sbc  deccnt
        sta  tenexp
        beq  finqng
        bpl  finmul
findiv  jsr  div10
        inc  tenexp
        bne  findiv
        beq  finqng
finmul  jsr  mul10
        dec  tenexp
        bne  finmul
finqng  lda  sgnflg
        bmi  negxqs
        rts

negxqs  jmp  negop

findig  pha
        bit  dptflg
        bpl  findg1
        inc  deccnt
findg1  jsr  mul10
        pla
        sec
        sbc  #'0'
        jsr  finlog
        jmp  finc

finlog  pha
        jsr  movaf
        pla
        jsr  float
        lda  argsgn
        eor  facsgn
        sta  arisgn
        ldx  facexp
        jmp  faddt

finedg  lda  tenexp
        cmp  #@12
        bcc  mlex10
        lda  #@144
        bit  expsgn
        bmi  mlexmi
        jmp  overr

mlex10  asl  a
        asl  a
        clc
        adc  tenexp
        asl  a
        clc
        ldy  #0
        adc  (txtptr),y
        sec
        sbc  #'0'
mlexmi  sta  tenexp
        jmp  finec

;.end
	.page
	.subttl CODE22
n0999    .byte  @233,@76,@274,@37,@375
n9999    .byte  @236,@156,@153,@47,@375
nmil     .byte  @236,@156,@153,@50,0

inprt   lda  #<intxt
        ldy  #>intxt
        jsr  strou2
        lda  curlin+1
        ldx  curlin
linprt  sta  facho
        stx  facho+1
        ldx  #@220
        sec
        jsr  floatc
        jsr  foutc
strou2  jmp  strout

fout    ldy  #1
foutc   lda  #' '
        bit  facsgn
        bpl  fout1
        lda  #'-'
fout1   sta  fbuffr-1,y
        sta  facsgn
        sty  fbufpt
        iny
        lda  #'0'
        ldx  facexp
        bne  *+5
        jmp  fout19

        lda  #0
        cpx  #@200
        beq  fout37
        bcs  fout7
fout37  lda  #<nmil
        ldy  #>nmil
        jsr  fmult
        lda  #250-addpr2-addprc
fout7   sta  deccnt
fout4   lda  #<n9999
        ldy  #>n9999
        jsr  fcomp
        beq  bigges
        bpl  fout9
fout3   lda  #<n0999
        ldy  #>n0999
        jsr  fcomp
        beq  fout38
        bpl  fout5
fout38  jsr  mul10
        dec  deccnt
        bne  fout3
fout9   jsr  div10
        inc  deccnt
        bne  fout4
fout5   jsr  faddh
bigges  jsr  qint
        ldx  #1
        lda  deccnt
        clc
        adc  #addpr2+addprc+7
        bmi  foutpi
        cmp  #addpr2+addprc+@10
        bcs  fout6
        adc  #$ff
        tax
        lda  #2
foutpi  sec
fout6   sbc  #2
        sta  tenexp
        stx  deccnt
        txa
        beq  fout39
        bpl  fout8
fout39  ldy  fbufpt
        lda  #'.'
        iny
        sta  fbuffr-1,y
        txa
        beq  fout16
        lda  #'0'
        iny
        sta  fbuffr-1,y
fout16  sty  fbufpt
fout8   ldy  #0
foutim  ldx  #@200
fout2   lda  faclo
        clc
        adc  foutbl+2+addprc,y
        sta  faclo
        lda  facmo
        adc  foutbl+1+addprc,y
        sta  facmo
        lda  facmoh
        adc  foutbl+1,y
        sta  facmoh
        lda  facho
        adc  foutbl,y
        sta  facho
        inx
        bcs  fout41
        bpl  fout2
        bmi  fout40
fout41  bmi  fout2
fout40  txa
        bcc  foutyp
        eor  #@377
        adc  #@12
foutyp  adc  #@57
        iny
        iny
        iny
        iny
        sty  fdecpt
        ldy  fbufpt
        iny
        tax
        and  #@177
        sta  fbuffr-1,y
        dec  deccnt
        bne  stxbuf
        lda  #'.'
        iny
        sta  fbuffr-1,y
stxbuf  sty  fbufpt
        ldy  fdecpt
        txa
        eor  #@377
        and  #@200
        tax
        cpy  #fdcend-foutbl
        beq  fouldy
        cpy  #timend-foutbl
        bne  fout2
fouldy  ldy  fbufpt
fout11  lda  fbuffr-1,y
        dey
        cmp  #'0'
        beq  fout11
        cmp  #'.'
        beq  fout12
        iny
fout12  lda  #'+'
        ldx  tenexp
        beq  fout17
        bpl  fout14
        lda  #0
        sec
        sbc  tenexp
        tax
;.end
	.page
	.subttl CODE23
        lda  #'-'
fout14  sta  fbuffr+1,y
        lda  #'E'
        sta  fbuffr,y
        txa
        ldx  #@57
        sec
fout15  inx
        sbc  #@12
        bcs  fout15
        adc  #@72
        sta  fbuffr+3,y
        txa
        sta  fbuffr+2,y
        lda  #0
        sta  fbuffr+4,y
        beq  fout20
fout19  sta  fbuffr-1,y
fout17  lda  #0
        sta  fbuffr,y
fout20  lda  #<fbuffr
        ldy  #>fbuffr
        rts

fhalf    .byte  @200,0
zero     .byte  0,0,0
foutbl   .byte  @372,@12,@37,0,0
	.byte   @230,@226,@200,@377
	.byte   @360,@275,@300,0
	.byte   1,@206,@240,@377
	.byte   @377,@330,@360,0,0
	.byte   3,@350,@377,@377
	.byte   @377,@234,0,0,0,@12
	.byte   @377,@377,@377,@377
fdcend   .byte  @377,@337,@12,@200
	.byte   0,3,@113,@300,@377
	.byte   @377,@163,@140,0,0
	.byte   @16,@20,@377,@377
	.byte   @375,@250,0,0,0,@74
timend
;
cksma0   .byte  $00     ; $a000 8k room check sum adj

patchs   *=*+30         ;  patch area
;
sqr     jsr  movaf
        lda  #<fhalf
        ldy  #>fhalf
        jsr  movfm
fpwrt   beq  exp
        lda  argexp
        bne  fpwrt1
        jmp  zerof1

fpwrt1  ldx  #<tempf3
        ldy  #>tempf3
        jsr  movmf
        lda  argsgn
        bpl  fpwr1
        jsr  int
        lda  #<tempf3
        ldy  #>tempf3
        jsr  fcomp
        bne  fpwr1
        tya
        ldy  integr
fpwr1   jsr  movfa1
        tya
        pha
        jsr  log
        lda  #<tempf3
        ldy  #>tempf3
        jsr  fmult
        jsr  exp
        pla
        lsr  a
        bcc  negrts
negop   lda  facexp
        beq  negrts
        lda  facsgn
        eor  #@377
        sta  facsgn
negrts  rts

;.end
	.page
	.subttl CODE24
logeb2   .byte  @201,@70,@252,@73,@51

expcon   .byte  7,@161,@64,@130,@76
	.byte   @126,@164,@26,@176
	.byte   @263,@33,@167,@57
	.byte   @356,@343,@205,@172
	.byte   @35,@204,@34,@52
	.byte   @174,@143,@131,@130
	.byte   @12,@176,@165,@375
	.byte   @347,@306,@200,@61
	.byte   @162,@30,@20,@201
	.byte   0,0,0,0
;
; start of kernal rom
;
exp     lda  #<logeb2
        ldy  #>logeb2
        jsr  fmult
        lda  facov
        adc  #@120
        bcc  stoldx
        jsr  incrnd
stoldx  jmp  stold      ; cross boundries

;.end
	.page
	.subttl CODE25

	* = $e000	;start   of  vic-40  kernal  rom
	.space   2
; continuation of exponent routine
;
stold   sta  oldov
        jsr  movef
        lda  facexp
        cmp  #@210
        bcc  exp1
gomldv  jsr  mldvex
exp1    jsr  int
        lda  integr
        clc
        adc  #@201
        beq  gomldv
        sec
        sbc  #1
        pha
        ldx  #4+addprc
swaplp  lda  argexp,x
        ldy  facexp,x
        sta  facexp,x
        sty  argexp,x
        dex
        bpl  swaplp
        lda  oldov
        sta  facov
        jsr  fsubt
        jsr  negop
        lda  #<expcon
        ldy  #>expcon
        jsr  poly
        lda  #0
        sta  arisgn
        pla
        jsr  mldexp
        rts

polyx   sta  polypt
        sty  polypt+1
        jsr  mov1f
        lda  #tempf1
        jsr  fmult
        jsr  poly1
        lda  #<tempf1
        ldy  #>tempf1
        jmp  fmult

poly    sta  polypt
        sty  polypt+1
poly1   jsr  mov2f
        lda  (polypt),y
        sta  degree
        ldy  polypt
        iny
        tya
        bne  poly3
        inc  polypt+1
poly3   sta  polypt
        ldy  polypt+1
poly2   jsr  fmult
        lda  polypt
        ldy  polypt+1
        clc
        adc  #4+addprc
        bcc  poly4
        iny
poly4   sta  polypt
        sty  polypt+1
        jsr  fadd
        lda  #<tempf2
        ldy  #>tempf2
        dec  degree
        bne  poly2
        rts

rmulc    .byte  @230,@65,@104,@172,0
raddc    .byte  @150,@50,@261,@106,0

rnd     jsr  sign
        bmi  rnd1
        bne  qsetnr
        jsr  rdbas
        stx  index1
        sty  index1+1
        ldy  #4
        lda  (index1),y
        sta  facho
        iny
        lda  (index1),y
        sta  facmo
        ldy  #8
        lda  (index1),y
        sta  facmoh
        iny
        lda  (index1),y
        sta  faclo
        jmp  strnex

qsetnr  lda  #<rndx
        ldy  #>rndx
        jsr  movfm
        lda  #<rmulc
        ldy  #>rmulc
        jsr  fmult
        lda  #<raddc
        ldy  #>raddc
        jsr  fadd
rnd1    ldx  faclo
        lda  facho
        sta  faclo
        stx  facho
        ldx  facmoh
        lda  facmo
        sta  facmoh
        stx  facmo
strnex  lda  #0
        sta  facsgn
        lda  facexp
        sta  facov
        lda  #@200
        sta  facexp
        jsr  normal
        ldx  #<rndx
        ldy  #>rndx
gmovmf  jmp  movmf

;.end
	.page
	.subttl CODE26
;most references to kernal are defined here
;
erexit  cmp  #$f0       ; check for special case
        bne  erexix
; top of memory has changed
        sty  memsiz+1
        stx  memsiz
        jmp  cleart     ; act as if he typed clear

erexix  tax     ; set termination flags
        bne  erexiy
        ldx  #erbrk     ; break error
erexiy  jmp  error      ; normal error
	.space   5
clschn   =$ffcc
	.space   5
outch   jsr  $ffd2
        bcs  erexit
        rts
	.space   5
inchr   jsr  $ffcf
        bcs  erexit
        rts
	.space   5
ccall    =$ffe7
	.space   5
settim   =$ffdb
rdtim    =$ffde
	.space   5
coout   jsr  ppach      ;  go out to save .a for print# patch
        bcs  erexit
        rts
	.space   5
coin    jsr  $ffc6
        bcs  erexit
        rts
	.space   5
readst   =$ffb7
	.space   5
cgetl   jsr  $ffe4
        bcs  erexit
        rts
	.space   5
rdbas    =$fff3
	.space   5
setmsg   =$ff90
	.space   5
plot     =$fff0
	.space   5
csys    jsr  frmnum     ; eval formula
        jsr  getadr     ; convert to int. addr
        lda  #>csysrz   ; push return address
        pha
        lda  #<csysrz
        pha
        lda  spreg      ; status reg
        pha
        lda  sareg      ; load 6502 regs
        ldx  sxreg
        ldy  syreg
        plp     ; load 6502 status reg
        jmp  (linnum)   ; go do it

csysrz   = *-1   ; return to here

        php     ; save status reg
        sta  sareg      ; save 6502 regs
        stx  sxreg
        sty  syreg
        pla     ; get status reg
        sta  spreg
        rts     ; return to system
	.space   5
csave   jsr  plsv       ; parse parms
        ldx  vartab     ; end save addr
        ldy  vartab+1
        lda  #<txttab   ; indirect with start address
        jsr  $ffd8      ; save it
        bcs  erexit
        rts
	.space   5
cverf   lda  #1         ; verify flag
	.byte   $2c    ; skip two bytes
	.space   5
cload   lda  #0         ; load flag
        sta  verck
        jsr  plsv       ; parse parameters
;
cld10           ;  jsr $ffe1     ;check run/stop
; cmp #$ff ;done yet?
; bne cld10 ;still bouncing
        lda  verck
        ldx  txttab     ; .x and .y have alt...
        ldy  txttab+1   ; ...load address
        jsr  $ffd5      ; load it
        bcs  jerxit     ; problems
;
        lda  verck
        beq  cld50      ; was load
;
;finish verify
;
        ldx  #ervfy     ; assume error
        jsr  $ffb7      ; read status
        and  #$10       ; check error
        bne  cld55      ; replaces beq *+5/jmp error
;
;print verify 'ok' if direct
;
        lda  txtptr
        cmp  #bufpag
        beq  cld20
        lda  #<okmsg
        ldy  #>okmsg
        jmp  strout
;
cld20   rts
	.space   5
;
;finish load
;
cld50   jsr  $ffb7      ; read status
        and  #$ff-$40   ; clear e.o.i.
        beq  cld60      ; was o.k.
        ldx  #erload
cld55   jmp  error
;
cld60   lda  txtptr+1
        cmp  #bufpag    ; direct?
        bne  cld70      ; no...
;
        stx  vartab
        sty  vartab+1   ; end load address
        lda  #<reddy
        ldy  #>reddy
        jsr  strout
        jmp  fini
;
;program load
;
cld70   jsr  stxtpt
        jsr  lnkprg
        jmp  fload
	.space   5
copen   jsr  paoc       ; parse statement
        jsr  $ffc0      ; open it
        bcs  jerxit     ; bad stuff or memsiz change
        rts     ; a.o.k.
	.space   5
cclos   jsr  paoc       ; parse statement
        lda  andmsk     ; get la
        jsr  $ffc3      ; close it
        bcc  cld20      ; it's okay...no memsize change
;
jerxit  jmp  erexit
	.space   5
;
;parse load and save commands
;
plsv
;default file name
;
        lda  #0         ; length=0
        jsr  $ffbd
;
;default device #
;
        ldx  #1         ; device #1
        ldy  #0         ; command 0
        jsr  $ffba
;
        jsr  paoc20     ; by-pass junk
        jsr  paoc15     ; get/set file name
        jsr  paoc20     ; by-pass junk
        jsr  plsv7      ; get ',fa'
        ldy  #0         ; command 0
        stx  andmsk
        jsr  $ffba
        jsr  paoc20     ; by-pass junk
        jsr  plsv7      ; get ',sa'
        txa     ; new command
        tay
        ldx  andmsk     ; device #
        jmp  $ffba
	.space   5
;look for comma followed by byte
plsv7   jsr  paoc30
        jmp  getbyt
	.space   5
;skip return if next char is end
;
paoc20  jsr  chrgot
        bne  paocx
        pla
        pla
paocx   rts
	.space   5
;check for comma and good stuff
;
paoc30  jsr  chkcom     ; check comma
paoc32  jsr  chrgot     ; get current
        bne  paocx      ; is o.k.
paoc40  jmp snerr       ;bad...end of line
	.space   5
;parse open/close
;
paoc    lda  #0
        jsr  $ffbd      ; default file name
;
        jsr  paoc32     ; must got something
        jsr  getbyt     ; get la
        stx  andmsk
        txa
        ldx  #1         ; default device
        ldy  #0         ; default command
        jsr  $ffba      ; store it
        jsr  paoc20     ; skip junk
        jsr  plsv7
        stx  eormsk
        ldy  #0         ; default command
        lda  andmsk     ; get la
        cpx  #3
        bcc  paoc5
        dey     ; default ieee to $ff
paoc5   jsr  $ffba      ; store them
        jsr  paoc20     ; skip junk
        jsr  plsv7      ; get sa
        txa
        tay
        ldx  eormsk
        lda  andmsk
        jsr  $ffba      ; set up real eveything
paoc7   jsr  paoc20
        jsr  paoc30
paoc15  jsr  frmevl
        jsr  frestr     ; length in .a
        ldx  index1
        ldy  index1+1
        jmp  $ffbd

;.end
; rsr 8/10/80 - change sys command
; rsr 8/26/80 - add open&close memsiz detect
; rsr 10/7/80 - change load (remove run wait)
; rsr 4/10/82 - inline fix program load
; rsr 7/02/82 - fix print# problem

	.page
	.subttl TRIG
cos     lda  #<pi2
        ldy  #>pi2
        jsr  fadd
sin     jsr  movaf
        lda  #<twopi
        ldy  #>twopi
        ldx  argsgn
        jsr  fdivf
        jsr  movaf
        jsr  int
        lda  #0
        sta  arisgn
        jsr  fsubt
        lda  #<fr4
        ldy  #>fr4
        jsr  fsub
        lda  facsgn
        pha
        bpl  sin1
        jsr  faddh
        lda  facsgn
        bmi  sin2
        lda  tansgn
        eor  #$ff
        sta  tansgn
sin1    jsr  negop
sin2    lda  #<fr4
        ldy  #>fr4
        jsr  fadd
        pla
        bpl  sin3
        jsr  negop
sin3    lda  #<sincon
        ldy  #>sincon
        jmp  polyx

tan     jsr  mov1f
        lda  #0
        sta  tansgn
        jsr  sin
        ldx  #<tempf3
        ldy  #>tempf3
        jsr  gmovmf
        lda  #<tempf1
        ldy  #>tempf1
        jsr  movfm
        lda  #0
        sta  facsgn
        lda  tansgn
        jsr  cosc
        lda  #<tempf3
        ldy  #>tempf3
        jmp  fdiv

cosc    pha
        jmp  sin1

pi2      .byte  @201,@111,@17,@332,@242
twopi    .byte  @203,@111,@17,@332,@242
fr4      .byte  @177,0,0,0,0
sincon   .byte  5,@204,@346,@32,@55
	.byte   @33,@206,@50,@7,@373
	.byte   @370,@207,@231,@150,@211
	.byte   1,@207,@43,@65,@337,@341
	.byte   @206,@245,@135,@347,@50,@203
	.byte   @111,@17,@332,@242

atn     lda  facsgn
        pha
        bpl  atn1
        jsr  negop
atn1    lda  facexp
        pha
        cmp  #@201
        bcc  atn2
        lda  #<fone
        ldy  #>fone
        jsr  fdiv
atn2    lda  #<atncon
        ldy  #>atncon
        jsr  polyx
        pla
        cmp  #@201
        bcc  atn3
        lda  #<pi2
        ldy  #>pi2
        jsr  fsub
atn3    pla
        bpl  atn4
        jmp  negop

atn4    rts

atncon   .byte  @13,@166,@263,@203
	.byte   @275,@323,@171,@36,@364
	.byte   @246,@365,@173,@203,@374
	.byte   @260,@20
	.byte   @174,@14,@37,@147,@312
	.byte   @174,@336,@123,@313,@301
	.byte   @175,@24,@144,@160,@114
	.byte   @175,@267,@352,@121,@172
	.byte   @175,@143,@60,@210,@176
	.byte   @176,@222,@104,@231,@72
	.byte   @176,@114,@314,@221,@307
	.byte   @177,@252,@252,@252,@23
	.byte   @201,0,0,0,0

;.end
	.page
	.subttl INIT
panic   jsr  clschn     ; warm start basic...
        lda  #0         ; clear channels
        sta  channl
        jsr  stkini     ; restore stack
        cli     ; enable irq's
	.space   2
ready   ldx  #$80
        jmp  (ierror)

nerror  txa     ; get  high bit
        bmi  nready
        jmp  nerrox

nready  jmp  readyx
	.space   2
init    jsr  initv      ; go init vectors
        jsr  initcz     ; go init charget & z-page
        jsr  initms     ; go print initilization messages
        ldx  #stkend-256        ; set up end of stack
        txs
        bne  ready      ; jmp...ready
	.space   4
initat  inc  chrget+7
        bne  chdgot
        inc  chrget+8
chdgot  lda  60000
        cmp  #':'
        bcs  chdrts
        cmp  #' '
        beq  initat
        sec
        sbc  #'0'
        sec
        sbc  #$d0
chdrts  rts

	.byte   128,79,199,82,88
	.space   6
initcz  lda  #76
        sta  jmper
        sta  usrpok
        lda  #<fcerr
        ldy  #>fcerr
        sta  usrpok+1
        sty  usrpok+2
        lda  #<givayf
        ldy  #>givayf
        sta  adray2
        sty  adray2+1
        lda  #<flpint
        ldy  #>flpint
        sta  adray1
        sty  adray1+1
        ldx  #initcz-initat-1
movchg  lda  initat,x
        sta  chrget,x
        dex
        bpl  movchg
        lda  #strsiz
        sta  four6
        lda  #0
        sta  bits
        sta  channl
        sta  lastpt+1
        ldx  #1
        stx  buf-3
        stx  buf-4
        ldx  #tempst
        stx  temppt
        sec     ; read bottom of memory
        jsr  $ff9c
        stx  txttab     ; now txtab has it
        sty  txttab+1
        sec
        jsr  $ff99      ; read top of memory
usedef  stx  memsiz
        sty  memsiz+1
        stx  fretop
        sty  fretop+1
        ldy  #0
        tya
        sta  (txttab),y
        inc  txttab
        bne  init20
        inc  txttab+1
init20  rts
	.space   6
initms  lda  txttab
        ldy  txttab+1
        jsr  reason
        lda  #<fremes
        ldy  #>fremes
        jsr  strout
        lda  memsiz
        sec
        sbc  txttab
        tax
        lda  memsiz+1
        sbc  txttab+1
        jsr  linprt
        lda  #<words
        ldy  #>words
        jsr  strout
        jmp  scrtch
	.space   4
bvtrs    .wor  nerror,nmain,ncrnch,nqplop,ngone,neval
;
initv   ldx  #initv-bvtrs-1     ; init vectors
initv1  lda  bvtrs,x
        sta  ierror,x
        dex
        bpl  initv1
        rts

chke0    .byte  $00
	.space   4
WORDS    .BYTE  ' BASIC BYTES FREE',13,0
FREMES   .BYTE  147,13,'    **** COMMODORE 64 BASIC V2 ****'

	.BYTE   13,13,' 64K RAM SYSTEM  ',0
	.BYTE   $81

; ppach - print# patch to coout (save .a)
;
ppach   pha
        jsr  $ffc9
        tax     ; save error code
        pla
        bcc  ppach0     ; no error....
        txa     ; error code
ppach0  rts

;.end
;rsr 8/10/80 update panic :rem could use in error routine
;rsr 2/08/82 modify for vic-40 release
;rsr 4/15/82 add advertising sign-on
;rsr 7/02/82 add print# patch


	.end