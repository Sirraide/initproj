#ifndef HELLO_UTILS_HH
#define HELLO_UTILS_HH

#include <print>

using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;
using usz = size_t;
using uptr = uintptr_t;

using i8 = int8_t;
using i16 = int16_t;
using i32 = int32_t;
using i64 = int64_t;
using isz = ptrdiff_t;
using iptr = intptr_t;

#define STR_(X) #X
#define STR(X) STR_(X)

#define CAT_(X, Y) X##Y
#define CAT(X, Y) CAT_(X, Y)

template <typename ...Args>
[[noreturn]] void Die(std::format_string<Args...> fmt, Args&& ...args) {
    std::print(stderr, fmt, std::forward<Args>(args)...);
    std::println(stderr);
    std::exit(1);
}

#endif // HELLO_UTILS_HH
