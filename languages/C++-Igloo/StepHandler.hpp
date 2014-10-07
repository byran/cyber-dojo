#ifndef STEPHANDLER_HPP
#define STEPHANDLER_HPP

#include <vector>
#include <string>

class StepHandler
{
public:
    void ExtractParameters();
    void SetCurrentLine(std::string line);
protected:
    void ClearParameters();
    std::string GetParameter(size_t index) const;
protected:
    std::vector<std::string> m_parameters;
    std::string m_current_line;
};

#endif