

#Add sources to the project
set(REPO_DIR ${CMAKE_SOURCE_DIR}/libcorrect)
set(REPO_REED_SOLOMON_DIR ${REPO_DIR}/src/reed-solomon)
set(REPO_CONVOLUTIONAL_DIR ${REPO_DIR}/src/convolutional)

set(SOS_SOURCELIST
	${REPO_REED_SOLOMON_DIR}/decode.c
	${REPO_REED_SOLOMON_DIR}/encode.c
	${REPO_REED_SOLOMON_DIR}/polynomial.c
	${REPO_REED_SOLOMON_DIR}/reed-solomon.c
	${REPO_CONVOLUTIONAL_DIR}/bit.c
	${REPO_CONVOLUTIONAL_DIR}/convolutional.c
	${REPO_CONVOLUTIONAL_DIR}/decode.c
	${REPO_CONVOLUTIONAL_DIR}/encode.c
	${REPO_CONVOLUTIONAL_DIR}/error_buffer.c
	${REPO_CONVOLUTIONAL_DIR}/history_buffer.c
	${REPO_CONVOLUTIONAL_DIR}/lookup.c
	${REPO_CONVOLUTIONAL_DIR}/metric.c
	#${REPO_CONVOLUTIONAL_DIR}/sse/decode.c
	#${REPO_CONVOLUTIONAL_DIR}/sse/encode.c
	#${REPO_CONVOLUTIONAL_DIR}/sse/lookup.c
	#${REPO_CONVOLUTIONAL_DIR}/sse/convolutional.c
	${REPO_DIR}/src/fec_shim.c
	${REPO_DIR}/include/correct.h
	${REPO_DIR}/include/correct/reed-solomon.h
	${REPO_DIR}/include/correct/reed-solomon/reed-solomon.h
	${REPO_DIR}/include/correct/reed-solomon/encode.h
	${REPO_DIR}/include/correct/reed-solomon/decode.h
	${REPO_DIR}/include/correct/reed-solomon/field.h
	${REPO_DIR}/include/correct/reed-solomon/polynomial.h
	${REPO_DIR}/include/correct/convolutional.h
	${REPO_DIR}/include/correct/util/error-sim-fec.h
	${REPO_DIR}/include/correct/util/error-sim-shim.h
	${REPO_DIR}/include/correct/util/error-sim-sse.h
	${REPO_DIR}/include/correct/util/error-sim.h
)


# Linking with the kernel
set(SOS_CONFIG release)
set(SOS_INCLUDE_DIRECTORIES ${REPO_DIR}/include ${TOOLCHAIN_INC_DIR}/mcu/arch/cmsis)
set(SOS_OPTION kernel)
include(${SOS_TOOLCHAIN_CMAKE_PATH}/sos-lib-std.cmake)

set(SOS_CONFIG debug)
include(${SOS_TOOLCHAIN_CMAKE_PATH}/sos-lib-std.cmake)

# Link within an app
set(SOS_OPTION "")
set(SOS_CONFIG release)
set(SOS_BUILD_FLAGS -mlong-calls)
#include(${SOS_TOOLCHAIN_CMAKE_PATH}/sos-lib-std.cmake)

install(DIRECTORY ${REPO_DIR}/include/ DESTINATION include)
