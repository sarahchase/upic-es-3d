#Makefile for 3D parallel PIC codes in new_pbeps32.source

# Makefile GNU compiler with OpenMPI and MacOS X

HDF_HOME = /usr/local
H5_ROOT = $(HDF_HOME)
HDF_INCPATH = $(HDF_HOME)/include
H5_FLINKFLAGS  = -L$(H5_ROOT)/lib -lhdf5_fortran -lhdf5 -lz -lm

# MacMPI

FC90 = mpicc
FC77 = mpif90
CC = mpicc

OPTS90 = -O3 -r8 -ffree-form
OPTS77 = -O3 -r8 
CCOPTS = -O3
MOPTS = 
MBOPTS = 
LOPTS =
LEGACY =

#MPOBJS = MacMPf77.o MacMP.o

#LIBS = $(CARBON) -lSystemStubs

# Makefile gfortran compiler with MacOS X

# MacMPI
MPIFC = mpif90
MPIFC77 = mpif90

FC90 = mpif90
FC77 = mpif90
CC = mpicc

OPTS90 = -O3 -fdefault-real-8 -ffree-form
OPTS77 = -O3 -fdefault-real-8
CCOPTS = -O -march=native -std=c99
#MOPTS = -fno-automatic
#MBOPTS = -fno-automatic
#LOPTS =
#LEGACY =


GESOBJS = pespush32mod.o psimul32mod.o

GESOBJS_IE = pespush32mod_ie.o psimul32mod_ie.o

MGESOBJS = mpespush32mod.o mpsimul32mod.o

ESOBJS = globals.o pinit32mod.o prbpush32mod.o ppush32mod.o \
pfft32mod.o pfield32mod.o pdiag32mod.o p32mod.o p0mod.o mp0mod.o \
pinit32lib.o prbpush32lib.o ppush32lib.o pfft32lib.o pfield32lib.o \
pdiag32lib.o p32lib.o p0lib.o

ESOBJS_IE = pinit32mod.o pinit32lib.o pfield32mod.o pinit32mod_ie.o sqnmod_ie.o par_track.o p32lib_ie.o prbpush32mod_ie.o \
prbpush32lib_ie.o ppush32mod_ie.o ppush32lib_ie.o pfft32mod.o \
string.o os_util_hdf5.o data_utils.o p_os_util_hdf5.o pdata_utils.o \
hdf5_write32_ie.o diag32_ie.o p32mod_ie.o os-sys-multi.o os-sys-multi-c.o p0mod.o p0lib.o mp0mod.o \
globals.o  pnpfield32mod.o 

ESOBJSJF = pinit32mod_jf.o \
ext_driver32_jf.o p32mod_jf.o pinit32lib_jf.o

MESOBJS = mprbpush32mod.o mppush32mod.o mpfft32mod.o mp32mod.o \
mprbpush32lib.o mppush32lib.o mpfft32lib.o mp32lib.o 

GEMOBJS = pempush32mod.o

MGEMOBJS = mpempush32mod.o

EMOBJS = pbpush32mod.o pbpush32lib.o

MEMOBJS = mpbpush32mod.o mpbpush32lib.o

DESOBJS = pdfield32mod.o pbfield32mod.o pcfield32mod.o pnpfield32mod.o \
pdfield32lib.o pbfield32lib.o pcfield32lib.o

NPOBJS = nullMP.o nullLOG.o

# Linkage rules

all : new_pbeps32.out new_d0_pbeps32.out new_pbbeps32.out new_d0_pbbeps32.out 

threaded: new_mpbeps32.out new_d0_mpbeps32.out new_mpbbeps32.out new_d0_mpbbeps32.out

new_pbeps32.out : new_pbeps32.o $(GESOBJS) $(ESOBJS) $(NPOBJS)
	$(MPIFC) $(OPTS90) $(LOPTS) -o new_pbeps32.out \
	new_pbeps32.o $(GESOBJS) $(ESOBJS) $(NPOBJS) $(LIBS)
 
new_d0_pbeps32.out : new_d0_pbeps32.o $(GESOBJS) $(ESOBJS) $(DESOBJS) $(MPIOBJS) \
                     $(NPOBJS)
	$(MPIFC) $(OPTS90) $(LOPTS) -o new_d0_pbeps32.out \
	new_d0_pbeps32.o $(GESOBJS) $(ESOBJS) $(DESOBJS) $(MPIOBJS) $(NPOBJS) $(LIBS)

new_mpbeps32.out : new_mpbeps32.o $(MGESOBJS) $(ESOBJS) $(MESOBJS) $(MPIOBJS) $(NPOBJS) \
                   $(MPOBJS)
	$(MPIFC) $(OPTS90) $(LOPTS) -o new_mpbeps32.out \
    new_mpbeps32.o $(MGESOBJS) $(ESOBJS) $(MESOBJS) $(MPIOBJS) $(MPOBJS) $(NPOBJS) $(LIBS)

new_d0_mpbeps32.out : new_d0_mpbeps32.o $(MGESOBJS) $(ESOBJS) $(DESOBJS) $(MESOBJS) $(NPOBJS)\
                      $(MPIOBJS) $(MPOBJS)
	$(MPIFC) $(OPTS90) $(LOPTS) -o new_d0_mpbeps32.out \
	new_d0_mpbeps32.o $(MGESOBJS) $(ESOBJS) $(DESOBJS) $(MESOBJS) $(NPOBJS) $(MPIOBJS) \
	$(MPOBJS) $(LIBS)

new_pbbeps32.out : new_pbbeps32.o $(ESOBJS) $(GEMOBJS) $(EMOBJS) $(MPIOBJS) $(NPOBJS)
	$(MPIFC) $(OPTS90) $(OPTS90) $(LOPTS) -o new_pbbeps32.out \
	new_pbbeps32.o $(ESOBJS) $(GEMOBJS) $(EMOBJS) $(MPIOBJS) $(NPOBJS) $(LIBS)

new_d0_pbbeps32.out : new_d0_pbbeps32.o $(ESOBJS) $(GEMOBJS) $(EMOBJS) $(DESOBJS) \
                      $(MPIOBJS) $(NPOBJS)
	$(MPIFC) $(OPTS90) $(LOPTS) -o new_d0_pbbeps32.out \
	new_d0_pbbeps32.o $(ESOBJS) $(GEMOBJS) $(EMOBJS) $(DESOBJS) $(MPIOBJS) $(NPOBJS) \
    $(LIBS)

new_mpbbeps32.out : new_mpbbeps32.o $(ESOBJS) $(MESOBJS) $(MGEMOBJS) $(EMOBJS) $(NPOBJS) \
                    $(MEMOBJS) $(MPIOBJS) $(MPOBJS)
	$(MPIFC) $(OPTS90) $(LOPTS) -o new_mpbbeps32.out \
    new_mpbbeps32.o $(ESOBJS) $(MESOBJS) $(MGEMOBJS) $(EMOBJS) $(MEMOBJS) $(NPOBJS) $(MPIOBJS) \
    $(MPOBJS) $(LIBS)

new_d0_mpbbeps32.out : new_d0_mpbbeps32.o $(ESOBJS) $(MESOBJS) $(MGEMOBJS) $(EMOBJS) $(NPOBJS) \
                       $(MEMOBJS) $(DESOBJS) $(MPIOBJS) $(MPOBJS)
	$(MPIFC) $(OPTS90) $(LOPTS) -o new_d0_mpbbeps32.out \
    new_d0_mpbbeps32.o $(ESOBJS) $(MESOBJS) $(MGEMOBJS) $(EMOBJS) $(MEMOBJS) \
	$(DESOBJS) $(MPIOBJS) $(MPOBJS) $(NPOBJS) $(LIBS)

# Compilation rules

pinit32mod_ie.o : pinit32mod_ie.f
	$(FC90) $(OPTS90) -c -free pinit32mod_ie.f

pinit32mod_ie.o : pinit32mod_ie.f
	$(FC90) $(OPTS90) -c -free pinit32mod_ie.f

diag32_ie.o : diag32_ie.f pinit32mod.o pinit32mod_ie.o pinit32mod_jf.o hdf5_write32_ie.o p32mod_jf.o
	$(FC90) $(OPTS90) -c -free diag32_ie.f

sqnmod_ie.o : sqnmod_ie.f
	$(FC90) $(OPTS90) -c -free sqnmod_ie.f


hdf5_write32_ie.o : hdf5_write32_ie.f string.o os_util_hdf5.o \
			data_utils.o p_os_util_hdf5.o pdata_utils.o pinit32mod_jf.o
	$(FC90) $(OPTS90) -c -free hdf5_write32_ie.f

string.o : string.f
	$(FC90) $(OPTS90) -c -free string.f

os_util_hdf5.o : os_util_hdf5.f
	$(FC90) $(OPTS90) $(HDF_INCPATH) -c -free os_util_hdf5.f

os-sys-multi-c.o : os-sys-multi-c.c
	$(CC) $(CCOPTS) -c os-sys-multi-c.c

os-sys-multi.o : os-sys-multi.f90
	$(FC90) $(OPTS90) $(HDF_INCPATH) -c -free os-sys-multi.f90

data_utils.o : data_utils.f os_util_hdf5.o string.o
	$(FC90) $(OPTS90) -c -free data_utils.f

p_os_util_hdf5.o : p_os_util_hdf5.f os_util_hdf5.o
	$(FC90) $(OPTS90) $(HDF_INCPATH) -c -free p_os_util_hdf5.f

pdata_utils.o : pdata_utils.f p_os_util_hdf5.o string.o
	$(FC90) $(OPTS90) -c -free pdata_utils.f

#pdb_write32_ie.o : pdb_write32_ie.f
#       $(FC90) $(OPTS90) -c -free pdb_write32_ie.f

par_track.o : par_track.f
	$(FC90) $(OPTS90) -c -free par_track.f

p32lib_ie.o : p32lib_ie.f
	$(FC77) $(OPTS77) -c -free p32lib_ie.f

par_track_ie.o : par_track_ie.f
	$(FC90) $(OPTS90) -c -free par_track_ie.f

pdb_write32_ie.o : pdb_write32_ie.f
	$(FC90) $(OPTS90) -c -free pdb_write32_ie.f

pinit32mod_jf.o : pinit32mod_jf.f
	$(FC90) $(OPTS90) -c -free pinit32mod_jf.f

prbpush32mod_jf.o : prbpush32mod_jf.f
	$(FC90) $(OPTS90) -c -free prbpush32mod_jf.f

prbpush32mod_ie.o : prbpush32mod_ie.f
	$(FC90) $(OPTS90) -c -free prbpush32mod_ie.f

ppush32mod_ie.o : ppush32mod_ie.f
	$(FC90) $(OPTS90) -c -free ppush32mod_ie.f

ppush32lib_ie.o : ppush32lib_ie.f
	$(FC77) $(OPTS77) -c -free ppush32lib_ie.f

pdb_write32_ie.o : pdb_write32_ie.f
	$(FC90) $(OPTS90) -c -free pdb_write32_ie.f

pespush32mod_ie.o : pespush32mod_ie.f
	$(FC90) $(OPTS90) -c -free pespush32mod_ie.f

prbpush32lib_ie.o : prbpush32lib_ie.f
	$(FC77) $(OPTS77) -c -free prbpush32lib_ie.f

psimul32mod_ie.o : psimul32mod_ie.f
	$(FC90) $(OPTS90) -free -c psimul32mod_ie.f

p32mod_ie.o : p32mod_ie.f
	$(FC90) $(OPTS90) -c -free p32mod_ie.f

ext_driver32_jf.o : ext_driver32_jf.f
	$(FC90) $(OPTS90) -c -free ext_driver32_jf.f

p32mod_jf.o : p32mod_jf.f
	$(FC90) $(OPTS90) -c -free p32mod_jf.f

pinit32lib_jf.o : pinit32lib_jf.f
	$(FC77) $(OPTS77) -c -free pinit32lib_jf.f

LnxMP.o : LnxMP.c
	$(CC) $(CCOPTS) -c LnxMP.c

LPProcessors.o : LPProcessors.c
	$(CC) $(CCOPTS) -c LPProcessors.c

nullLOG.o : nullLOG.f
	$(FC77) $(OPTS77) -c nullLOG.f

nullMP.o : nullMP.f
	$(FC77) $(OPTS77) -c nullMP.f


p0lib.o : p0lib.f
	$(MPIFC77) $(OPTS77) $(LEGACY) -c p0lib.f

mp32lib.o : mp32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c mp32lib.f

p32lib.o : p32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c p32lib.f

pinit32lib.o : pinit32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c pinit32lib.f

mppush32lib.o : mppush32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c mppush32lib.f

ppush32lib.o : ppush32lib.f
	$(FC77) $(OPTS77) -c ppush32lib.f

mpbpush32lib.o : mpbpush32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c mpbpush32lib.f

pbpush32lib.o : pbpush32lib.f
	$(FC77) $(OPTS77) -c pbpush32lib.f

mprbpush32lib.o : mprbpush32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c mprbpush32lib.f

prbpush32lib.o : prbpush32lib.f
	$(FC77) $(OPTS77) -c prbpush32lib.f

mpfft32lib.o : mpfft32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c mpfft32lib.f

pfft32lib.o : pfft32lib.f
	$(FC77) $(OPTS77) $(LEGACY) -c pfft32lib.f

pfield32lib.o : pfield32lib.f
	$(FC77) $(OPTS77) -c pfield32lib.f

pdfield32lib.o : pdfield32lib.f
	$(FC77) $(OPTS77) -c pdfield32lib.f

pbfield32lib.o : pbfield32lib.f
	$(FC77) $(OPTS77) -c pbfield32lib.f

pcfield32lib.o : pcfield32lib.f
	$(FC77) $(OPTS77) -c pcfield32lib.f

pdiag32lib.o : pdiag32lib.f
	$(FC77) $(OPTS77) -c pdiag32lib.f

globals.o : globals.f
	$(FC90) $(OPTS90) -c globals.f

pinit32mod.o : pinit32mod.f globals.o
	$(FC90) $(OPTS90) -c pinit32mod.f

mppush32mod.o : mppush32mod.f ppush32mod.o mp0mod.o
	$(FC90) $(OPTS90) -c mppush32mod.f

ppush32mod.o : ppush32mod.f p0mod.o
	$(FC90) $(OPTS90) -c ppush32mod.f

mpbpush32mod.o : mpbpush32mod.f pbpush32mod.o mp0mod.o
	$(FC90) $(OPTS90) -c mpbpush32mod.f

pbpush32mod.o : pbpush32mod.f p0mod.o
	$(FC90) $(OPTS90) -c pbpush32mod.f

mprbpush32mod.o : mprbpush32mod.f prbpush32mod.o mp0mod.o
	$(FC90) $(OPTS90) -c mprbpush32mod.f

prbpush32mod.o : prbpush32mod.f p0mod.o
	$(FC90) $(OPTS90) -c prbpush32mod.f

mpfft32mod.o : mpfft32mod.f pfft32mod.o mp0mod.o
	$(FC90) $(OPTS90) -c mpfft32mod.f

pfft32mod.o : pfft32mod.f p0mod.o
	$(FC90) $(OPTS90) -c pfft32mod.f

pfield32mod.o : pfield32mod.f globals.o
	$(FC90) $(OPTS90) -c pfield32mod.f

pdfield32mod.o : pdfield32mod.f globals.o
	$(FC90) $(OPTS90) -c pdfield32mod.f

pbfield32mod.o : pbfield32mod.f globals.o
	$(FC90) $(OPTS90) -c pbfield32mod.f

pcfield32mod.o : pcfield32mod.f globals.o
	$(FC90) $(OPTS90) -c pcfield32mod.f

pnpfield32mod.o : pnpfield32mod.f pfield32mod.o pdfield32mod.o pbfield32mod.o \
                 pcfield32mod.o
	$(FC90) $(OPTS90) -c pnpfield32mod.f

pdiag32mod.o : pdiag32mod.f pinit32mod.o
	$(FC90) $(OPTS90) -c pdiag32mod.f

p0mod.o : p0mod.f globals.o
	$(FC90) $(OPTS90) -c p0mod.f

mp32mod.o : mp32mod.f p32mod.o mp0mod.o
	$(FC90) $(OPTS90) -c mp32mod.f

p32mod.o : p32mod.f p0mod.o
	$(FC90) $(OPTS90) $(LEGACY) -c p32mod.f

mpespush32mod.o : mpespush32mod.f mprbpush32mod.o mppush32mod.o mpfft32mod.o \
                  mp32mod.o
	$(FC90) $(OPTS90) -c mpespush32mod.f

pespush32mod.o : pespush32mod.f prbpush32mod.o ppush32mod.o pfft32mod.o p32mod.o
	$(FC90) $(OPTS90) -c pespush32mod.f

mpempush32mod.o : mpempush32mod.f mprbpush32mod.o mpbpush32mod.o mppush32mod.o \
                  mpfft32mod.o mp32mod.o
	$(FC90) $(OPTS90) -c mpempush32mod.f

pempush32mod.o : pempush32mod.f prbpush32mod.o pbpush32mod.o ppush32mod.o \
                 pfft32mod.o p32mod.o
	$(FC90) $(OPTS90) -c pempush32mod.f

psimul32mod.o : psimul32mod.f pdiag32mod.o pespush32mod.o pfield32mod.o
	$(FC77) $(OPTS77) -c psimul32mod.f

mpsimul32mod.o : psimul32mod.f pdiag32mod.o mpespush32mod.o pfield32mod.o
	$(FC90) $(OPTS90) -o mpsimul32mod.o -c psimul32mod.f

mp0mod.o : mp0mod.f
	$(FC90) $(OPTS90) -c mp0mod.f

new_pbeps32.o : new_pbeps32.f psimul32mod.o pfield32mod.o pdiag32mod.o \
                mp0mod.o
	$(FC90) $(OPTS90) $(MOPTS) -c new_pbeps32.f

new_pbeps32_ie.o : new_pbeps32_ie.f psimul32mod.o pfield32mod.o pdiag32mod.o mp0mod.o pinit32mod_ie.o
	$(FC90) $(OPTS90) $(MOPTS) -c new_pbeps32_ie.f

new_mpbeps32.o : new_pbeps32.f mpsimul32mod.o pfield32mod.o pdiag32mod.o \
                 mp0mod.o
	$(FC90) $(OPTS90) $(MOPTS) -o new_mpbeps32.o -c new_pbeps32.f

new_pbbeps32.o : new_pbbeps32.f pempush32mod.o pfield32mod.o pdiag32mod.o mp0mod.o
	$(FC90) $(OPTS90) $(MOPTS) -c new_pbbeps32.f

new_mpbbeps32.o : new_pbbeps32.f mpempush32mod.o pfield32mod.o pdiag32mod.o \
                  pdiag32mod.o mp0mod.o
	$(FC90) $(OPTS90) $(MOPTS) -o new_mpbbeps32.o -c new_pbbeps32.f

new_d0_pbeps32.o : new_d0_pbeps32.f pespush32mod.o pnpfield32mod.o pdiag32mod.o \
                   mp0mod.o
	$(FC90) $(OPTS90) $(MOPTS) -c new_d0_pbeps32.f

new_d0_mpbeps32.o : new_d0_pbeps32.f mpespush32mod.o pnpfield32mod.o pdiag32mod.o \
                    mp0mod.o
	$(FC90) $(OPTS90) $(MOPTS) -o new_d0_mpbeps32.o -c new_d0_pbeps32.f

new_d0_pbbeps32.o : new_d0_pbbeps32.f pempush32mod.o pnpfield32mod.o pdiag32mod.o \
                    mp0mod.o
	$(FC90) $(OPTS90) $(MBOPTS) -c new_d0_pbbeps32.f

new_d0_mpbbeps32.o : new_d0_pbbeps32.f mpempush32mod.o pnpfield32mod.o pdiag32mod.o \
                     mp0mod.o
	$(FC90) $(OPTS90) $(MBOPTS) -o new_d0_mpbbeps32.o -c new_d0_pbbeps32.f


clean :
	rm -f *.o *.mod

clobber: clean
	rm -f *.out
