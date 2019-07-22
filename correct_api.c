#include "correct_api.h"
#include "correct.h"

static int correct_api_create(void ** context,
										u16 primitive_polynomial,
										u8 first_consecutive_root,
										u8 generator_root_gap,
										u32 num_roots);

static void correct_api_destroy(void ** context);

static int correct_api_encode(void * obj,
										const u8 * msg,
										size_t msg_length,
										u8 * encoded);

static int correct_api_decode(void * obj,
										const u8 * encoded,
										size_t encoded_length,
										u8 * msg,
										int with_erasures);


const correct_api_t correct_api = {
	.create = correct_api_create,
	.destroy = correct_api_destroy,
	.encode = correct_api_encode,
	.decode = correct_api_decode
};

int correct_api_create(void ** context,
							  u16 primitive_polynomial,
							  u8 first_consecutive_root,
							  u8 generator_root_gap,
							  u32 num_roots){

	void * obj = correct_reed_solomon_create(primitive_polynomial,
														  first_consecutive_root,
														  generator_root_gap,
														  num_roots);

	if( obj != 0 ){
		*context = obj;
		return 0;
	}

	return -1;
}

void correct_api_destroy(void ** context){
	void * obj = *context;
	if( obj != 0 ){
		correct_reed_solomon_destroy(obj);
		*context = 0;
	}
}

int correct_api_encode(void * obj,
										const u8 * msg,
										size_t msg_length,
										u8 * encoded){
	return correct_reed_solomon_encode(obj, msg, msg_length, encoded);
}

int correct_api_decode(void * obj,
										const u8 * encoded,
										size_t encoded_length,
										u8 * msg,
							  int with_erasures){
	if( with_erasures){
		//return correct_reed_solomon_decode_with_erasures(obj, encoded, encoded_length, msg);
	}

	return correct_reed_solomon_decode(obj, encoded, encoded_length, msg);
}

