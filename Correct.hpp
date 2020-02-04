#ifndef CORRECT_HPP
#define CORRECT_HPP

#include <sapi/api/WorkObject.hpp>
#include <sapi/api/ApiObject.hpp>
#include <sapi/var/Data.hpp>

#include "correct_api.h"


namespace api {

typedef Api<correct_api_t, CORRECT_API_REQUEST> CorrectApi;


class CorrectWorkObject : public api::WorkObject {
public:
	static CorrectApi & api(){ return m_api; }

private:
	static CorrectApi m_api;

};

}


namespace correct {

class CodecAttributes {
public:

	CodecAttributes(){
		//use some reasonable defaults
		m_primitive_polynomial = correct_rs_primitive_polynomial_8_4_3_2_0;
		m_first_consecutive_root = 1;
		m_generator_root_gap = 1;
		m_num_roots = 32;
	}


	CodecAttributes & set_primitive_polynomial(u16 value){
		m_primitive_polynomial = value; return *this;
	}

	CodecAttributes & set_first_consecutive_root(u8 value){
		m_first_consecutive_root = value; return *this;
	}

	CodecAttributes & set_generator_root_gap(u8 value){
		m_generator_root_gap = value; return *this;
	}

	CodecAttributes & set_root_count(u32 value){
		m_num_roots = value; return *this;
	}

	u16 primitive_polynomial() const { return m_primitive_polynomial; }
	u16 first_consecutive_root() const { return m_first_consecutive_root; }
	u16 generator_root_gap() const { return m_generator_root_gap; }
	u16 root_count() const { return m_num_roots; }

private:
	u16 m_primitive_polynomial;
	u8 m_first_consecutive_root;
	u8 m_generator_root_gap;
	u32 m_num_roots;
};


class Codec : public api::CorrectWorkObject {

public:
	Codec(){
		m_context = 0;
	}

	u32 message_size() const {
		return 255 - m_parity_length;
	}

	u32 encoded_size() const {
		return 255;
	}

	int create(const CodecAttributes & attributes){
		m_parity_length = attributes.root_count();
		return api()->create(&m_context,
									attributes.primitive_polynomial(),
									attributes.first_consecutive_root(),
									attributes.generator_root_gap(),
									attributes.root_count());
	}

	int destroy(){
		api()->destroy(&m_context);
		return 0;
	}

	int encode(var::Data & encoded, const var::Data & message){
		//validate encoded.size() is large enough to hold the encoded message
		return api()->encode(m_context,
									message.to_u8(), message.size(),
									encoded.to_u8());
	}

	var::Data encode(const var::Data & message){
		var::Data result;
		//result needs enough room to hold the encoded message
		result.set_size(message.size() + m_parity_length);
		int encoded_length = encode(result, message);

		if( encoded_length < 0 ){
			return var::Data();
		}

		result.set_size(encoded_length);


		return result;
	}


	int decode(var::Data & message, const var::Data & encoded){
		//validate message.size() is large enough to hold the encoded message
		return api()->decode(m_context,
									encoded.to_u8(), encoded.size(),
									message.to_u8(),
									0);
	}


	var::Data decode(const var::Data & encoded){
		var::Data result;
		//result needs enough room to hold the encoded message
		result.set_size(encoded.size());
		int decoded_length = decode(result, encoded);

		if( decoded_length < 0 ){
			return var::Data();
		}

		result.set_size(decoded_length);


		return result;
	}

private:
	void * m_context;
	u16 m_parity_length;
};


}


#endif // CORRECT_HPP
