#include <gtest/gtest.h>
#include <igloo/igloo_alt.h>
#include "Hiker.feature.hpp"

using namespace ::igloo;

int main(int argc, char* argv[])
{
   ::testing::GTEST_FLAG(throw_on_failure) = true;
   ::testing::InitGoogleTest(&argc, argv);
   int result = TestRunner::RunAllTests();
   return result;
}