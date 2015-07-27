#/*****************************************************************************\
#*                                                                             *
#*       Copyright (c) 2003, The Regents of the University of California       *
#*     See the file COPYRIGHT for a complete copyright notice and license.     *
#*                                                                             *
#*******************************************************************************
#*
#* CVS info:
#*   $RCSfile: Makefile,v $
#*   $Revision: 1.2 $
#*   $Date: 2013/04/16 16:43:51 $
#*   $Author: brettkettering $
#*
#* Purpose:
#*       Make mdtest executable.
#*
#*       make [mdtest]   -- mdtest
#*       make clean      -- remove executable
#*
#\*****************************************************************************/

CC.AIX = mpcc_r -bmaxdata:0x80000000
CC.Linux = mpicc -Wall
#
# For Cray systems
#CC.Linux = ${MPI_CC}
CC.Darwin = mpicc -Wall

# Requires GNU Make
OS=$(shell uname)

# Flags for compiling on 64-bit machines
LARGE_FILE = -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE=1 -D__USE_LARGEFILE64=1

CC = $(CC.$(OS))


# One needs someting like the following code snippet in one's cshrc file if one
# plans to use S3 with mdtest.
#
#
# If we're not going to use S3 with mdtest, we don't need to define this variable.
#
# setenv MDTEST_FLAGS ""
#
# If we're going to use S3 with mdtest, we need to define this variable so that the
# S3 libraries can be found.
#
# Also, on some systems libxml2 include files are in:
#
#    /usr/include/libxml2
#
# which is not a standard include location. So, we must add "-I/usr/include/libxml2"
# to MDTEST_FLAGS also.
#
# setenv MDTEST_FLAGS "-D_HAS_S3 -I/usr/include/libxml2 -I/path/to/aws4c/include -L/path/to/aws4c/lib -laws4c_extra -laws4c -lcurl -lxml2"


# One needs someting like the following code snippet in one's cshrc file is one
# plans to use PLFS with mdtest.
#
#
# If we're not going to use PLFS with mdtest, we don't need to define this variable.
#
# setenv MDTEST_FLAGS ""
#
# If we're going to use PLFS with mdtest, we need to define this variable based on
# whether we are loading a PLFS module or using the system default PLFS installation.
#
# if ( $?PLFS_CFLAGS ) then
#   setenv MDTEST_FLAGS "-D_HAS_PLFS ${PLFS_CFLAGS} ${PLFS_LDFLAGS}"
# else
#   setenv MDTEST_FLAGS "-D_HAS_PLFS -I${MPICH_DIR}/include -lplfs"
# endif


all: mdtest 

mdtest: mdtest.c
	$(CC) -D$(OS) $(LARGE_FILE) -g -o mdtest mdtest.c -lm $(MDTEST_FLAGS)

clean:
	rm -f mdtest mdtest.o
