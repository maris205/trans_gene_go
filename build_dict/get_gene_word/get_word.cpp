//filter the n-gram words according to frequency
#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <stdlib.h>
#include <string.h>
using namespace std;

//split string
vector<string> SplitString(const std::string &str, const char *separator)
{
    vector<string> result;
    string::size_type prev_pos=0;
    string::size_type pos=0;
    while ((pos = str.find(separator, prev_pos)) != string::npos)
    {
            if (prev_pos < pos)
            {
                    result.push_back(str.substr(prev_pos, pos-prev_pos));
            }
            prev_pos = pos + strlen(separator);
    }
    if (prev_pos < str.size())
    {
        result.push_back(str.substr(prev_pos));
    }
    return result;
}

//frequency threshold
const int Threshold[]={
	0,//1-gram
	0,//2
	0,//3
	1,//4
	1,//5
	1,//6
	1,//7
	1,//8
	1,//9
	1,//10
	1,//11
	1,//12
	1,//13
	1,//14
	1,//15
    1,//16
    1,//17
    1,//18
    1,//19
    1,//20
    1,//21
};

int main(int argc, char* argv[])
{
	if (2 != argc)
	{
		cout<<"please input file name"<<endl;
		exit(0);
	}

	string strInFileName=argv[1];
	string strOutFileName=strInFileName+".dict";

	string strLine="";
	string strSequence="";

	vector <string> vectText;
	int nWordLength=0;
	int nFreq=0;
	int nIdx=0;
	ofstream ofOutFile(strOutFileName.c_str());

	ifstream ifInFile(strInFileName.c_str());
	if (!ifInFile)
	{
		cout<<"file read error"<<endl;
		exit(0);
	}

	while(getline(ifInFile,strLine))
	{
		vectText=SplitString(strLine,"\t");//split by tab
		strSequence=vectText[0];
		nFreq=atoi(vectText[1].c_str());

		vectText.clear();
		vectText=SplitString(strSequence," ");//split sequence by space
		nWordLength=vectText.size();
		if ( nFreq > Threshold[nWordLength-1])
		{
			for (nIdx=0;nIdx<nWordLength;nIdx++)
			{
				ofOutFile<<vectText[nIdx];
			}
			ofOutFile<<endl;
		}
	}
	ifInFile.close();
	ofOutFile.close();
	return 0;
}

