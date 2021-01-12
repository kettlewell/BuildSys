// OS / System
#include <iostream>
#include <vector>

// Boost
#include <boost/any.hpp>

// Lapack
// #include <Accelerate/Accelerate.h>

extern "C" void dgetrf_(int* dim1, int* dim2, double* a, int* lda, int* ipiv, int* info);
extern "C" void dgetrs_(char *TRANS, int *N, int *NRHS, double *A, int *LDA, int *IPIV, double *B, int *LDB, int *INFO );


// RapidJSON
#include "rapidjson/document.h"
#include "rapidjson/writer.h"
#include "rapidjson/stringbuffer.h"

using namespace std;
using namespace rapidjson;

int main(int argc, char *argv[]){
    cout << "Hello there, World!" << endl;
    std::cout << "Hello Main2!" << std::endl;

    // Boost
    boost::any foo = 42;
    foo.clear();

    // Lapack
    char trans = 'N';
    int dim = 2;    
    int nrhs = 1;
    int LDA = dim;
    int LDB = dim;
    int info;

    vector<double> a, b;

    a.push_back(1);
    a.push_back(1);
    a.push_back(1);
    a.push_back(-1);

    b.push_back(2);
    b.push_back(0);

    int ipiv[3];

    dgetrf_(&dim, &dim, &*a.begin(), &LDA, ipiv, &info);
    dgetrs_(&trans, &dim, &nrhs, & *a.begin(), &LDA, ipiv, & *b.begin(), &LDB, &info);


    std::cout << "solution is:";    
    std::cout << "[" << b[0] << ", " << b[1] << ", " << "]" << std::endl;
    std::cout << "Info = " << info << std::endl; 

    // RapidJson
     // 1. Parse a JSON string into DOM.
    const char* json = "{\"project\":\"rapidjson\",\"stars\":10}";
    Document d;
    d.Parse(json);

    // 2. Modify it by DOM.
    Value& s = d["stars"];
    s.SetInt(s.GetInt() + 1);

    // 3. Stringify the DOM
    StringBuffer buffer;
    Writer<StringBuffer> writer(buffer);
    d.Accept(writer);
    // Output {"project":"rapidjson","stars":11}
    std::cout << buffer.GetString() << std::endl;


    // Static Analysis
    // this should throw a compile time warning as well
    // as get caught by the cppcheck static analysis ( with make analysis )
    char tmp[10];
    tmp[11] = 's';
    return 0;
}
