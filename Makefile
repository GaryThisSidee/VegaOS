.POSIX:
all: stand/limine sbin/vega-kernel 

include config.mk

OBJECTS=sys/kern/kern_init.o
ASMOBJS=

sbin/vega-kernel: $(OBJECTS) $(ASMOBJS)
	mkdir -p sbin/
	$(LD) -nostdlib -zmax-page-size=0x1000 -static -Tconf/link.ld\
		$(OBJECTS) $(ASMOBJS) -o $@
	@ # Create needed directories
	mkdir -p iso_root/boot/
	# Build ISO
	cp conf/limine.cfg stand/limine/limine.sys stand/limine/limine-cd.bin \
		stand/limine/limine-cd-efi.bin iso_root/
		cp sbin/vega-kernel iso_root/boot/
	xorriso -as mkisofs -b limine-cd.bin -no-emul-boot -boot-load-size 4 \
		-boot-info-table --efi-boot limine-cd-efi.bin -efi-boot-part \
		--efi-boot-image --protective-msdos-label iso_root -o Vega.iso
	stand/limine/limine-deploy Vega.iso
	rm -rf iso_root

run:
	qemu-system-x86_64 $(QEMU_FLAGS) -cdrom Vega.iso

stand/limine:
	mkdir -p stand/
	git clone https://github.com/limine-bootloader/limine.git --branch=v4.0-binary --depth=1 stand/limine/
	make -C stand/limine

clean:
	@ rm -f $(OBJECTS) $(ASMOBJS) sbin/vega-kernel
