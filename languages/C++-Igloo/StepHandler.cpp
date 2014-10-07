#include "StepHandler.hpp"
#include <regex>
#include <sstream>

using namespace ::std;

void StepHandler::SetCurrentLine(string line)
{
   m_current_line = line;
}

void StepHandler::ClearParameters()
{
    m_parameters.clear();
}

string StepHandler::GetParameter(int index) const
{
    if(m_parameters.size() > index)
        return m_parameters[index];
    else
        return "Unknown Parameter Index!!!";
}

void StepHandler::ExtractParameters()
{
    ClearParameters();
    vector<string> tokens;
    istringstream copy(m_current_line);
    string token;
    while(getline(copy, token, '|'))
    {
        tokens.push_back(token);
    }

    for(size_t i = 1; i < tokens.size(); i+=2)
    {
        m_parameters.push_back(tokens[i]);
    }
}

