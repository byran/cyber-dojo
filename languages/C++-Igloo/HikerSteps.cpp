#include "HikerSteps.hpp"
#include <gtest/gtest.h>
#include <igloo/igloo_alt.h> 

void HikerSteps::CallIsHandled()
{
   ASSERT_TRUE(true);
}

void HikerSteps::HandleTwoParameters()
{
   ASSERT_EQ(GetParam(0), "result0");
   ASSERT_EQ(GetParam(1), "result1");
}

