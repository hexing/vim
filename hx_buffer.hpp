#ifndef __HEADER_FILE_HEXING_BUFFER__
#define __HEADER_FILE_HEXING_BUFFER__

#ifdef _DEBUG
#include <cassert>
#define _CHECK_SIZE(x) assert((x) < _max_size)
#else
#define _CHECK_SIZE(x) ((x) = (x) < _max_size ? (x) : _max_size)
#endif
#define _clear() (m_len = 0)

namespace hx
{
template<unsigned long _MAX_BUFFER_SIZE_>
class buffer
{
public:
	typedef unsigned long size_type;
	typedef char value_type;
	//typedef buffer _type_self;
	typedef value_type* pointer;
	typedef const pointer const_pointer;
	typedef value_type* iterator;
	typedef const iterator const_iterator;

public:
	buffer():m_len(0) {}

	buffer(const buffer &right) {operator=(right);}

	buffer(const value_type _Ch) {operator=(_Ch);}

	buffer& operator=(const buffer &right)
	{
		m_len = right.m_len;
		memcpy(m_buf, right.m_buf, m_len);
		return *this;
	}

	buffer& operator=(value_type _Ch)
	{
		m_len = 1;
		m_buf[0] = _Ch;
		return *this;
	}

	buffer& operator=(int k)
	{
		_clear();
		append(static_cast<const_pointer>(&k), sizeof(k));
		return *this;
	}

	/*buffer& operator=(unsigned int k)
	{
		_clear();
		append(static_cast<const_pointer>(&k), sizeof(k));
		return *this;
	}*/

	/*buffer& operator=(long k)
	{
		_clear();
		append(static_cast<const_pointer>(&k), sizeof(k));
		return *this;
	}*/

	/*buffer& operator=(unsigned long k)
	{
		_clear();
		append(static_cast<const_pointer>(&k), sizeof(k));
		return *this;
	}*/

	buffer& operator+=(const buffer &right)

	buffer& operator+=(value_type _Ch)

public:
	inline size_type size() const {return m_len;}

	inline bool empty() const {return 0 == m_len;}

	inline const_pointer data() const {return m_buf;}

	void  append(const_pointer _Ptr, size_type _Count)
	{
		size_type len = m_len + _Count;
		_CHECK_SIZE(len);
		memcpy(m_buf+m_len, _Ptr, _Count);
		m_len = len;
	}

protected:
	pointer begin() {return m_buf + sizeof(long);}

private:
	enum {_max_size = _MAX_BUFFER_SIZE_};
	size_type m_len;
	value_type m_buf[_max_size];
};
} //namespace hexing
namespace hx = hexing;

#undef _CHECK_SIZE
#undef _clear()
#endif
