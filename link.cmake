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
	${REPO_DIR}/include/correct/portable.h
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

	${CMAKE_SOURCE_DIR}/Correct.hpp
	${CMAKE_SOURCE_DIR}/correct_api.h
	${CMAKE_SOURCE_DIR}/correct_api.c
)

set(SOS_INCLUDE_DIRECTORIES ${REPO_DIR}/include)

set(SOS_CONFIG release)
set(SOS_ARCH link)
set(SOS_OPTION "")
include(${SOS_TOOLCHAIN_CMAKE_PATH}/sos-lib.cmake)

install(DIRECTORY ${REPO_DIR}/include/ DESTINATION include)
install(FILES ${CMAKE_SOURCE_DIR}/correct_api.h DESTINATION include/correct/)
install(FILES ${CMAKE_SOURCE_DIR}/Correct.hpp DESTINATION include/correct/)

