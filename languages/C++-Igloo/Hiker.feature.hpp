#include <gtest/gtest.h>
#include <igloo/igloo_alt.h>
#include "HikerSteps.hpp"

using namespace ::std;
using namespace ::igloo;

Feature("BlankFeature") Handler(HikerSteps)

   Scenario("Describe a blank feature") StepEcho;
   Given("A simple handler class") StepEcho;
   When("some  calls are made in the steps") StepEcho;
   Then("The calls are passed through to the StepHandler")
      StepPlay(CallIsHandled);

   Scenario("Demonstrate some parameter handling") StepEcho;
   Given("A simple hander class") StepEcho;
   When("a step is recieved with parameters in the step text") StepEcho;
   Then("parameter[result0] and parameter[result1] can be obtained")
      StepPlay(HandleTwoParameters);

End
