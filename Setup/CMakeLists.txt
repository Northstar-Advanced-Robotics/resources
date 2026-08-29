cmake_minimum_required(VERSION 3.24)
project(sentry-intro )

find_package(Boost REQUIRED COMPONENTS log)

add_executable(hello
  main.cpp
)

target_link_libraries(hello PUBLIC Boost::log)
target_compile_options(hello PUBLIC -std=c++23)


