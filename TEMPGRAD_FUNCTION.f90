FUNCTION SGRAD_I(StrN,Num,X,Z)
INTEGER StrN,Num
DOUBLE PRECISION SGRAD_I,X,Z
DOUBLE PRECISION U1,U3,Y2
DOUBLE PRECISION TG11,TG12,TG21,TG22

!20221129 I MODIFY
U1=DATAN(Z/X)
U3=DATAN(X/Z)
Y2=0.5D0*DLOG(X*X+Z*Z)

TG11=U1
TG12=Y2

TG21=Y2
TG22=U3

IF(StrN==1.AND.Num==1) GOTO 11
IF(StrN==1.AND.Num==2) GOTO 12

IF(StrN==2.AND.Num==1) GOTO 21
IF(StrN==2.AND.Num==2) GOTO 22


11  SGRAD_I = TG11
    RETURN
12  SGRAD_I = TG12
    RETURN
21  SGRAD_I = TG21
    RETURN
22  SGRAD_I = TG22
    RETURN

END