!PATH=!PATH + ':' + expand_path('+~/Dropbox/hii/idl/')

print,'Hello jgkim'
device,true=24,retain=2,set_font='Helvetica Bold'
device,decomposed=0		; color
loadct,5
!p.background=255
!p.color=0
!p.charsize=1.5
!quiet=1

compile_opt idl2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define physical constants (in cgs units) as system variables
;; First written by Jeong-Gyu Kim, May 2012
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

cons = {c:29979245800.d,$
        h:6.626069d-27,$        ; Planck constant
        hbar:1.054571d-27,$     ; hbar
        k_b:1.3806503d-16,$     ; Boltzmann constant
        m_H:1.67353d-24,$       ; mass of hydrogen atom
        m_p:1.67262158d-24,$    ; mass of proton
        m_p_eV:938.27203d6,$    ; mass of proton in eV
        m_e: 9.10938188d-28,$   ; mass of electron
        m_e_eV: 0.5109989d6,$   ; mass of electron in eV
        e: 4.80320425d-10,$     ; elementary charge (esu)
        G: 6.67400d-8,$         ; gravitational constant
        sigma_SB:5.6704d-5,$    ; Stefan-Boltzmann constant
        a0: 5.29177d-10,$       ; hbar^2/m_e/e^2 = Bohr radius
        eV: 1.60218d-12,$       ; electron volt
        G_astro:4.302d-3,$      ; in units of pc, M_sun, (km/s)^2
        yr:31557600d,$     ; 1 year in second
        M_sun:1.98892d33,$      ; Solar mass
        L_sun:3.839d33,$        ; Solar luminosity
        R_sun:6.955d10,$        ; Solar radius
        pc:3.08568025d18,$      ; parsec in cm
        mbar:1.37d*1.67353d-24 }; mean mass per particle in the neutral ISM
defsysv, '!pc',cons, 1

;for HII region simulations
dunit=!pc.m_H*1.4d
tunit=!pc.yr*1d6
lunit=!pc.pc
vunit=lunit/tunit
punit=dunit*vunit^2
h2={dunit:dunit,tunit:tunit,lunit:lunit,vunit:vunit,punit:punit,$
     colors:[cgcolor('black'),cgcolor('red'),cgcolor('blue'),cgcolor('purple'),cgcolor('green'),cgcolor('magenta'),cgcolor('orange')]}
defsysv,'!h2',h2,1
delvar,cons,h2 ; delete variables

defsysv, '!dli_fig','~/Dropbox/H2/notes/ApJ_ReplyToReferee/'
defsysv, '!h2_dataidl','~/Dropbox/H2/dataidl/'
defsysv, '!h2_fig','~/Dropbox/hii/notes/ms0.1/'
defsysv, '!dir_hii','~/Dropbox/hii/'
defsysv, '!dir_ifront','/data/research/IFront/'


;for the usage of !RNG, refer to "~/docs/idl/TI/numerical_exercise/boxmuller.pro" and Coyote's IDL website
defsysv, '!RNG', Obj_New('RandomNumberGenerator')
