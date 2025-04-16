
!TASK 1: ZERO-PADDING ON B, OUTPUT BFFT
SUBROUTINE ZEROP2DB(LD, MD, B, IL, JM, BFFT)
IMPLICIT NONE
INTEGER LD, MD, IL, JM, L, M
DOUBLE PRECISION B(LD, MD)
DOUBLE COMPLEX BFFT(IL, JM)

BFFT=DCMPLX(0.D0, 0.D0)

DO L=1, LD
    DO M=1, MD
        BFFT(L,M)=DCMPLX(B(L,M), 0.D0)
    ENDDO
ENDDO

CALL DFFT2D(IL, JM, BFFT, IL, BFFT, IL)

RETURN
END

!*****************     CONVOLUTION PART   ****************************
!TASK 2A: WRAP-AROUND ORDER PADDING FOR CONVOLUTION ON C, OUTPUT CFFT
SUBROUTINE CNVWR2PC(ID, JD, LD, MD, C, CFFT)
IMPLICIT NONE
INTEGER ID, JD, LD, MD, IL, JM
INTEGER I, J, I0, J0
DOUBLE PRECISION C(-LD: ID-1, -MD: JD-1)
DOUBLE COMPLEX CFFT(ID+LD, JD+MD)

IL=ID+LD
JM=JD+MD

DO I=1, IL
    I0=I-1
    IF(I0.GE.ID) I0=I0-IL
    DO J=1, JM
        J0=J-1
        IF(J0.GE.JD) J0=J0-JM
        CFFT(I, J)=DCMPLX(C(I0, J0), 0.D0)
    ENDDO
ENDDO

CALL DFFT2D(IL, JM, CFFT, IL, CFFT, IL)

RETURN
END

!*****************     CORRELATION PART   ****************************
!TASK 2B:  WRAP-AROUND-PADDING FOR CORRELATION ON C, OUTPUT CFFT
SUBROUTINE CRLWR2PC(ID, JD, LD, MD, CI, CFFT)
IMPLICIT NONE
INTEGER ID, JD, LD, MD, IL, JM, JD2
INTEGER I, J, I0, J0
DOUBLE PRECISION CI(-LD: ID-1, JD+MD)
DOUBLE COMPLEX CFFT(ID+LD, JD+MD)

IL=ID+LD
JM=JD+MD

JD2=JD+2

DO I=1, IL
    I0=I-1
    IF(I0.GE.ID) I0=I0-IL
    DO J=1, JM
        J0=JD2-J
        IF(J0.LT.1) J0=J0+JM
        CFFT(I, J)=DCMPLX(CI(I0, J0), 0.D0)
    ENDDO
ENDDO

CALL DFFT2D(IL, JM, CFFT, IL, CFFT, IL)

RETURN
END

!*****************     CORRELATION PART   ****************************
!TASK 3A: WE INPUT CFFT AND BFFT TO CALCULATE A
SUBROUTINE CNVFT2CB(ID, JD, LD, MD, CFFT, BFFT, A)
IMPLICIT NONE

INTEGER ID, JD, LD, MD
INTEGER IL, JM, I, J

DOUBLE PRECISION A(ID,JD)
DOUBLE COMPLEX CFFT(ID+LD, JD+MD), BFFT(ID+LD, JD+MD)
DOUBLE COMPLEX, ALLOCATABLE :: AFFT(:, :)

IL=ID+LD
JM=JD+MD

ALLOCATE(AFFT(IL, JM))

DO I=1,IL
	DO J=1,JM
		AFFT(I,J)=CFFT(I,J)*BFFT(I,J)
	ENDDO
ENDDO

CALL DFFT2B(IL, JM, AFFT, IL, AFFT, IL) 

DO I=1,ID
	DO J=1,JD
		A(I,J)=DREAL(AFFT(I,J))/DFLOAT(IL*JM)
	ENDDO
ENDDO

DEALLOCATE(AFFT)

RETURN
    END

!*****************     CORRELATION PART   ****************************    
! TASK 3B: WE INPUT CFFT AND BFFT TO CALCULATE 
! (2) A(I,J)= C(I-L,J+M) * B(L,M)
SUBROUTINE CRLFT2CB(ID, JD, LD, MD, CFFT, BFFT, A)
IMPLICIT NONE

INTEGER ID, JD, LD, MD, JD1 
INTEGER IL, JM, I, J, L, M

DOUBLE PRECISION A(ID,JD)
DOUBLE COMPLEX CFFT(ID+LD, JD+MD), BFFT(ID+LD, JD+MD)
DOUBLE COMPLEX, ALLOCATABLE :: AFFT(:, :)

IL=ID+LD
JM=JD+MD

JD1=JD+1

ALLOCATE(AFFT(IL, JM))

DO I=1,IL
	DO J=1,JM
		AFFT(I,J)=CFFT(I,J)*BFFT(I,J)
	ENDDO
ENDDO

CALL DFFT2B(IL, JM, AFFT, IL, AFFT, IL) 

DO I=1,ID
	DO J=1,JD
		A(I,J)=DREAL(AFFT(I,JD1-J))/DFLOAT(IL)/DFLOAT(JM)
	ENDDO
ENDDO

DEALLOCATE(AFFT)

RETURN
END
