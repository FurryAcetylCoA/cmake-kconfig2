BUILD_DIR = ./build



all:
	@mkdir -p $(BUILD_DIR)
	@cd ${BUILD_DIR} && \
	if [ -f .config ]; then \
		make; \
	else \
		cmake .. && make menuconfig && make;\
	fi

clean:
	@cd ${BUILD_DIR} && make clean

menuconfig:
	@cd ${BUILD_DIR} && make menuconfig


.PHONY: all clean menuconfig
