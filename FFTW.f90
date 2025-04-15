	!Two demensional fft---complex to complex 
	subroutine DFFT2D (M2,N2,in,notuse1,out,notuse2)  
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    integer M2,N2,notuse1,notuse2
    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(M2,N2) :: in, out
    plan = fftw_plan_dft_2d(N2,M2,in,out, FFTW_FORWARD,FFTW_ESTIMATE)
    call fftw_execute_dft(plan, in, out)
    call fftw_destroy_plan(plan)
    end
    
	!Two dimensional inverse fft---complex to complex 
	subroutine DFFT2B (M2,N2,in,notuse1,out,notuse2)  
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    integer M2,N2,notuse1,notuse2
    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(M2,N2) :: in, out
    plan = fftw_plan_dft_2d(N2,M2,in,out, FFTW_BACKWARD,FFTW_ESTIMATE)
    call fftw_execute_dft(plan, in, out)
    call fftw_destroy_plan(plan)
    end
    
	!Three demensional fft---complex to complex 
	subroutine DFFT3F (M2,N2,L2,in,notuse1,notuse2,out,notuse3,notuse4)  
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    integer M2,N2,L2,notuse1,notuse2,notuse3,notuse4
    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(M2,N2,L2) :: in, out
    plan = fftw_plan_dft_3d(L2,N2,M2,in,out, FFTW_FORWARD,FFTW_ESTIMATE)
    call fftw_execute_dft(plan, in, out)
    call fftw_destroy_plan(plan)
    end
    
    !Three demensional fft---complex to complex 
	subroutine DFFT3B (M2,N2,L2,in,notuse1,notuse2,out,notuse3,notuse4)  
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    integer M2,N2,L2,notuse1,notuse2,notuse3,notuse4
    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(M2,N2,L2) :: in, out
    plan = fftw_plan_dft_3d(L2,N2,M2,in,out, FFTW_BACKWARD,FFTW_ESTIMATE)
    call fftw_execute_dft(plan, in, out)
    call fftw_destroy_plan(plan)
	end

	!One demensional fft---complex to complex	
	subroutine DFFT1F (M2,in,out)  
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    integer M2    
    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(M2) :: in, out
    plan = fftw_plan_dft_1d(M2,in,out, FFTW_FORWARD,FFTW_ESTIMATE)
    call fftw_execute_dft(plan, in, out)
    call fftw_destroy_plan(plan)
	end    

	!One dimensional inverse fft---complex to complex 	
    subroutine DFFT1B (M2,in,out)  
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    integer M2
    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(M2) :: in, out
    plan = fftw_plan_dft_1d(M2,in,out, FFTW_BACKWARD,FFTW_ESTIMATE)
    call fftw_execute_dft(plan, in, out)
    call fftw_destroy_plan(plan)
    end