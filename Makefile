program = uvc_scope_sds1104xe

OBJ     = cyfxuvcdscr.o cyfxtx.o cyfx_gcc_startup.o main.o
LIBS    = -l:cyu3lpp.a -l:cyfxapi.a -l:cyu3threadx.a -lc -lgcc
OPT     = -O2

CC      = ../arm-2013.11/bin/arm-none-eabi-gcc
LD      = ../arm-2013.11/bin/arm-none-eabi-ld
OBJCOPY = ../arm-2013.11/bin/arm-none-eabi-objcopy

DEFS    =
CFLAGS  = ${DEFS} -fshort-wchar -mcpu=arm926ej-s -marm -mthumb-interwork -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wall -I../sdk_1_3_4/firmware/u3p_firmware/inc -D__CYU3P_TX__ ${OPT}

build: ${program}.img

clean:
	rm -f *.o ${program} ${program}.img

${program}: ${OBJ}
	${CC} -Wl,--no-wchar-size-warning -L../sdk_1_3_4/firmware/u3p_firmware/lib/fx3_release -T fx3.ld -nostartfiles -Xlinker --gc-sections ${CFLAGS} ${OBJ} ${LIBS} -o ${program} ${OPT}

${program}.img: ${program}
	../sdk_1_3_4/util/elf2img/elf2img -i ${program} -o ${program}.img -v

#Will try to find a flashing utility later
#run: ${program}.img
#	../tools/fx3prog/fx3prog ${program}.img

