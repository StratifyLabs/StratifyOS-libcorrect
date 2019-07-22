#ifndef CORRECT_API_H
#define CORRECT_API_H

#include <mcu/types.h>
#include "correct.h"

typedef struct {
	int (*create)(void ** context,
					  u16 primitive_polynomial,
					  u8 first_consecutive_root,
					  u8 generator_root_gap,
					  u32 num_roots);

	void (*destroy)(void ** context);

	int (*encode)(void * obj,
							const u8 * msg,
							size_t msg_length,
							u8 * encoded);

	int (*decode)(void * obj,
							const u8 * encoded,
							size_t encoded_length,
							u8 * msg,
							int with_erasures);

} correct_api_t;

extern const correct_api_t correct_api;


#if defined __link
#define CORRECT_API_REQUEST &correct_api
#else
enum {
	CORRECT_API_REQUEST = MCU_API_REQUEST_CODE('f','e','c','c')
};
#endif




#endif // CORRECT_API_H
