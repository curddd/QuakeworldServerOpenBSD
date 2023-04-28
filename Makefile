
ARCH=x86-64

MAINDIR!=pwd
SERVER_DIR=$(MAINDIR)/server
CLIENT_DIR=$(MAINDIR)/client


CFLAGS=-Wall -DSERVERONLY -Dstricmp=strcasecmp -I$(CLIENT_DIR) -I$(SERVER_DIR) -Dsun
LDFLAGS=--static -lm

DO_CC=$(CC) $(CFLAGS) $(LDFLAGS)

S_SRCS=$(SERVER_DIR)/pr_cmds.c $(SERVER_DIR)/pr_edict.c  $(SERVER_DIR)/pr_exec.c  $(SERVER_DIR)/sv_init.c $(SERVER_DIR)/sv_main.c  $(SERVER_DIR)/sv_nchan.c $(SERVER_DIR)/sv_ents.c $(SERVER_DIR)/sv_send.c  $(SERVER_DIR)/sv_move.c  $(SERVER_DIR)/sv_phys.c  $(SERVER_DIR)/sv_user.c  $(SERVER_DIR)/sv_ccmds.c  $(SERVER_DIR)/world.c  $(SERVER_DIR)/sys_obsd.c  $(SERVER_DIR)/model.c 

C_SRCS=$(CLIENT_DIR)/cmd.c  $(CLIENT_DIR)/common.c  $(CLIENT_DIR)/crc.c  $(CLIENT_DIR)/cvar.c $(CLIENT_DIR)/mathlib.c  $(CLIENT_DIR)/md4.c $(CLIENT_DIR)/zone.c $(CLIENT_DIR)/pmove.c  $(CLIENT_DIR)/pmovetst.c $(CLIENT_DIR)/net_chan.c  $(CLIENT_DIR)/net_udp.c

OBJS=${S_SRCS:.c=.o} ${C_SRCS:.c=.o}


TARGET=qwsv

.SUFFIXES: .c .o
.c.o:
	$(DO_CC) -o $@ -c $<

qwsv: ${OBJS}
	$(DO_CC) -o $@ $(OBJS)

clean:
	rm -f $(OBJS) $(TARGET)
