#include<iostream>
#include<vector>
#include<unordered_map>
#include<string>
#include<cstdlib>
#include<sstream>

int main(int argc, char *argv[])
{
    double x=0, y=0;

    std::string calculation="";
    std::cout<<"Enter calculation in the form of (# operation #)\n";
    getline(std::cin, calculation );

    std::stringstream ss(calculation);
    std::string temp;
    char whiteSpace = ' ';

    std::vector<std::string> strVec(0);

    while(getline(ss, temp, whiteSpace))
    {
        strVec.push_back(temp);
    }

    try{
    x=std::stoi(strVec[0]);
    y=std::stoi(strVec[2]);
    std::string op = strVec[1];

    
    if(op == "+")
    {
        printf("%.1lf + %.1lf = %.1lf\n", x, y, x+y);
    }
    else if(op == "-")
    {
        printf("%.1lf - %.1lf = %.1lf\n", x, y, x-y);
    }
    else if(op == "*")
    {
        printf("%.1lf * %.1lf = %.1lf\n", x, y, x*y);
    }
    else if(op == "/")
    {
        printf("%.1lf / %.1lf = %.1lf\n", x, y, x/y);
    }
    else 
    {
        std::cout<<"Entered incorrectly!\n";
    }
    }
    catch(...)
    {
        std::cout<<"Entered incorrectly.\n";
    }



    


  


    return 0;
    
}