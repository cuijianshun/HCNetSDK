
CROSS_COMPILE =
AS		= $(CROSS_COMPILE)as
LD		= $(CROSS_COMPILE)ld
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CC) -E
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm

STRIP		= $(CROSS_COMPILE)strip
OBJCOPY		= $(CROSS_COMPILE)objcopy
OBJDUMP		= $(CROSS_COMPILE)objdump

export AS LD CC CPP AR NM
export STRIP OBJCOPY OBJDUMP

CFLAGS := -Wall -O2 -g

LDFLAGS := -lpthread -lmosquitto -lm -lmysqlclient -lnopoll -L/lib64/mysql

export CFLAGS LDFLAGS

TOPDIR := $(shell pwd)
export TOPDIR

SRCDIR := $(TOPDIR)/src
export SRCDIR

BINDIR := $(TOPDIR)/bin
export BINDIR

#If new subdir is created, you should do as following:
# 1. Write a makefile in this subdir and add obj-y item for all .c files.
# 2. Add INCLUDE line in this Makefile as following.
# 3. Add obj-y line in this Makefile as following.

INCLUDE := -I$(SRCDIR)
INCLUDE += -I$(SRCDIR)/includes
INCLUDE += -I$(SRCDIR)/listen


export INCLUDE

TARGET := $(BINDIR)/listenning 


obj-y += src/

all :
	make -C ./ -f $(TOPDIR)/Makefile.build
	$(CC) $(LDFLAGS) -o $(TARGET) built-in.o


clean:
	rm -f $(shell find -name "*.o")
	rm -f $(shell find -name "*.d")
	rm -f $(shell find -name "*.log")
	rm -f $(TARGET)
.PHONY:all clean 
