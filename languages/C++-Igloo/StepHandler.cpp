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
    return m_parameters[index];
}

void StepHandler::ExtractParameters()
{
    ClearParameters();
    std::string copy = m_current_line;
    std::regex search("\\[.*?\\]");
    std::smatch match;

    while (std::regex_search(copy, match, search))
    {
        std::stringstream ss;
        for (auto x : match)
        {
            ss << x;
        }
        copy = match.suffix().str();
        std::string token = ss.str();
        token = token.substr(1, token.size() - 2);
        m_parameters.push_back(token);
    }
}

