//TESTING COL_DETECT
//mols[0]->col_detect(mols[],x,y,z), mols = list of molecules in the space
//This function moves the given molecule toward x,y,z. If the molecule collides
//with another molecule before reaching x,y,z the function moves the molecule until
//it just touches the other molecule and returns the id of the molecule that it
//the was in the collision.

#include <ctime>
#include <fstream>
#include <iostream>
#include "molecule.h"
#include <string>
#include <cmath>
#include <vector>
#include <istream>
#include <sstream>
#include <stdlib.h>

double d1 = 0;
void print_border(std::vector<Molecule *> mols, int num_mols){
using namespace std;
std::ofstream out("/home/m003206/projects/p1001/cpp/fks1.1/border.xyz",ios_base::app);
out << num_mols << endl;
out << "BOUNDARY ELEMENTS" << endl;
for(int j = 0; j < num_mols; j++){
if(mols[j]->type==2){
out << "c " << mols[j]->x << " " << mols[j]->y << " " << mols[j]->z << endl;
}
}


}
//parsing input file for molecular boundaries
double strtodouble(std::string what)
{
using namespace std;
	istringstream instr(what);
	double val;
	instr >> val;
	return val;
}
double strtoint(std::string what)
{
using namespace std;
	istringstream instr(what);
	int val;
	instr >> val;
	return val;
}

std::vector<Molecule *> readboundariesXYZR(const char* file,std::vector<Molecule *> mols,int* tot,int SIZE,int *live, bool move){
	//Tot is the number of boundary elements to use is a number between 1 and 100 that gives the percentage of boundary elements to place
	using namespace std;
	double x,y,z,r;
	string field;
	std::ifstream input;
	input.open(file);
	string line;
	int a,typ,l;
	a=6;
	*tot = 0;
	l=0;
while(getline(input, line)) 
{ 
//Read in file with each line being x \t y \t z \t r\n
	istringstream iss(line,istringstream::in);	
	getline(iss,field,'\t');
	x=strtodouble(field);
		getline(iss,field,'\t');
	y=strtodouble(field);
		getline(iss,field,'\t');
	z=strtodouble(field);
		getline(iss,field,'\t');
	r=strtodouble(field);
		getline(iss,field,'\t');
	typ=strtoint(field);
		//cout << x << "," << y << "," << z << endl;
//Initializing Molecules
mols.push_back(new Molecule());
mols[a]->id = a;
mols[a]->x = x;
mols[a]->y = y;
mols[a]->z = z;
mols[a]->type=typ;
mols[a]->r = r;
mols[a]->num_list = 0;
mols[a]->re_calc = 0;
mols[a]->col_type = -1;
if(typ==2){
mols[a]->isMain=move;
if(move){
mols[a]->isbound=false;
mols[a]->bound=a;
l++;
}
}else{
	l++;
mols[a]->isMain=true;
}
mols[a]->isbound=false;
mols[a]->bound=a;
for(int t = 0; t < 500; t++){
mols[a]->verley[t] = 0;
}
a++;
}
*tot = a;
*live=l;
double o1=3*100*pow(SIZE*1.00,3);
		double o2=(4*a*3.14);
		double o3 =o1/o2;
double o=pow(o3,.3);
cout << "radius:" << o3 <<":" <<  o << endl;
for(int t=0; t< a; t++){
	mols[t]->r_outer = o; 
	mols[t]->num_list = a; 
}
return mols;
}
std::vector<Molecule *> readboundariesXYZ(const char* file,std::vector<Molecule *> mols,int prob,double r){
	//Prob is a number between 1 and 100 that gives the percentage of boundary elements to place
	using namespace std;
	double x,y,z;
int a;
	string field;
	std::ifstream input;
	input.open(file);
	string line;
a=6;
while(getline(input, line) && a < (prob+6)) 
{
       cout << a << endl;	
//Read in file with each line being x \t y \t z \n
	istringstream iss(line,istringstream::in);	
	getline(iss,field,'\t');
	x=strtodouble(field);
		getline(iss,field,'\t');
	y=strtodouble(field);
		getline(iss,field,'\t');
	z=strtodouble(field);
//		cout << x << "," << y << "," << z << endl;
mols.push_back(new Molecule());
mols[a]->id = a;
mols[a]->x = x;
mols[a]->y = y;
mols[a]->z = z;
mols[a]->type=2;
mols[a]->r = r;
mols[a]->num_list = 0;
mols[a]->re_calc = 0;
mols[a]->col_type = -1;
mols[a]->isMain=true;
mols[a]->isbound=false;
mols[a]->bound=a;
for(int t = 0; t < 500; t++){
mols[a]->verley[t] = 0;
}
a++;
	}
return mols;
}



//Outputing debug file
void print_mols_fa(int t,std::vector<Molecule *> mols,const char* ofile){
	using namespace std;
	std::ofstream out(ofile,ios_base::app);
	for(int j = 0; j < mols.size(); j++){
		        out << t << "," << mols[j]->id << "," << mols[j]->x << "," << mols[j]->y << "," << mols[j]->z << "," << mols[j]->isMain << "," << mols[j]->isbound << "," << mols[j]->bound << "," << mols[j]->r << "," << mols[j]->num_list << "," <<  mols[j]->type;
for(int w = 0; w < 12; w++){
out << "," << mols[j]->verley[w];
}
			out << endl;
	}       
}      
void print_mols_fc(int t,std::vector<Molecule  *> mols,const char* file,int n_mol){
using namespace std;
std::ofstream out(file,ios_base::app);
int A = 0;
int B = 0;
int C = 0;
// All Types of collisions for simple binding reaction////////
int A_A = 0;
int A_B = 0;
int A_C = 0;
int A_E = 0;
int B_B = 0;
int B_C = 0;
int B_E = 0;
int C_C = 0;
int C_E = 0;
////////////////////////////////////////////////////////////
// Printing intial conditions
//Printing concentration data
//Printing Initial Collisions
for(int j = 0; j < n_mol; j++){
	
if(mols[j]->isMain){
	if(mols[j]->isbound){
	C++;
///////////// Counting Collisions ///////////////////////////
	//Determining what C collided with
	if(mols[j]->col_type==0){
		//Collided with A
		A_C++;
	}else{
		if(mols[j]->col_type==1){
			//collided with B
		B_C++;
		}else{
			if(mols[j]->col_type==2){
		C_E++;
				//Collided with boundary
			}else{
				if(mols[j]->col_type==3){
					// Collided with C
			C_C++;
				}
			}
		}
		
	}
///////////// Counting Collisions ///////////////////////////
	
	}else{
		if(mols[j]->type==0){
	A++;
///////////// Counting Collisions ///////////////////////////
	if(mols[j]->col_type==0){
		//Collided with A
		A_A++;
	}else{
		if(mols[j]->col_type==1){
			//collided with B
		A_B++;
		}else{
			if(mols[j]->col_type==2){
		A_E++;
				//Collided with boundary
			}else{
				if(mols[j]->col_type==3){
					// Collided with C
			A_C++;
				}
			}
		}
		
	}
///////////////////////////////////////////////////////////////
	
		}else{
			if(mols[j]->type ==1){
	B++;
///////////// Counting Collisions ///////////////////////////
	if(mols[j]->col_type==0){
		//Collided with A
		A_B++;
	}else{
		if(mols[j]->col_type==1){
			//collided with B
		B_B++;
		}else{
			if(mols[j]->col_type==2){
		B_E++;
				//Collided with boundary
			}else{
				if(mols[j]->col_type==3){
					// Collided with C
			B_C++;
				}
			}
		}
		
	}
///////////////////////////////////////////////////////////////
			}
		}
	}
	//Reset col_type 
	mols[j]->col_type=-1;
}
}
out << t << "," << A << "," << B << ", " << C << "," << A_A << "," << A_B << "," << A_C << "," << A_E << "," << B_B << "," << B_C << "," << B_E << "," << C_C << "," << C_E <<  endl;
}


void print_mols_f(int t,std::vector<Molecule  *> mols,const char* file,int n_mol){
using namespace std;
std::ofstream out(file,ios_base::app);
int A = 0;
int B = 0;
int C = 0;
// Printing intial conditions
//Printing concentration data

for(int j = 0; j < n_mol; j++){
if(mols[j]->isMain){
	if(mols[j]->isbound){
	C++;
	}else{
		if(mols[j]->type==0){
	A++;
		}else{
			if(mols[j]->type ==1){
	B++;
			}
		}
	}
}
}
out << t << "," << A << "," << B << ", " << C << endl;
}
const char * file = "sim.param";
int main(int argc, char **argv)
{
  using namespace std;
 	int index;
char * pend;
int c;
int live_mols;
//Command Line Arguments //
  	char *ovalue = NULL;
  	char *Ovalue = NULL;
	char *tvalue = NULL;
	char *Tvalue = NULL;
	char *svalue = NULL;
	char *fvalue = NULL;
	char *rvalue = NULL;
	char *Evalue = NULL;	
	char *Ervalue = NULL;	
	char *Svalue = NULL;
	char *Srvalue = NULL;	
	char *Cvalue = NULL;
	char *Bvalue = NULL;
	char *Brvalue = NULL;	
	char *ivalue = NULL;	

  opterr = 0;

  while ((c = getopt (argc, argv, "o:t:s:f:r:E:e:S:a:C:B:b:T:i:O:")) != -1)

    switch (c)
      {
      case 'i':             // input file for reading initial positions
	      ivalue=optarg;
	break;
	case 'o':          // output file name
	ovalue = optarg;
	break;
	case 't':         // Total Time simulated 
	tvalue = optarg;
	break;
      case 's':
        svalue = optarg; // Size of space
        break;
      case 'f':
        fvalue = optarg; // Forward Probability
        break;
      case 'r':
       rvalue = optarg; // Reverse Probability
        break;
      case 'E':
       Evalue = optarg; // Amount of Enzyme Present
        break;
      case 'e':
       Ervalue = optarg; // radius of Enzyme
        break;
      case 'S':
       Svalue = optarg; // amount of substrate
        break;
      case 'a':
       Srvalue = optarg; // radius of substrate
        break;
      case 'C':
       Cvalue = optarg; // Doesn't work yet, set to zero
        break;
      case 'b':
       Brvalue = optarg; // radius of boundary
        break;
      case 'T':
       Tvalue = optarg; // Type of boundary
        break;
      case 'B':
       Bvalue = optarg; // amount of boundary
        break;
      case 'O':
	Ovalue = optarg; //Output type 1 = summary, 2 = coordinate, 3= summary + initial boundary
	break;
      case '?':
        if (isprint (optopt))
          fprintf (stderr, "Unknown option `-%c'.\n", optopt);
        else
          fprintf (stderr,
                   "Unknown option character `\\x%x'.\n",
                   optopt);
        return 1;
      default:
        abort ();
      }

int        SIZE           ; SIZE = int(strtod(svalue,&pend));
int 	   A         	  ; A= int(strtod(Evalue,&pend));
int 	   B      	  ; B= int(strtod(Svalue,&pend));
int 	   C        	  ; C= int(strtod(Cvalue,&pend));
double 	   Ar         	  ; Ar= double(strtod(Ervalue,&pend));
double 	   Br      	  ; Br= double(strtod(Srvalue,&pend));
double 	   Bnr        	  ; Bnr= double(strtod(Brvalue,&pend));
int 	   BOUNDARY       ; BOUNDARY= int(strtod(Bvalue,&pend));
double 	   R_STAT         ; R_STAT= (strtod(rvalue,&pend));
double 	   F_STAT         ; F_STAT= (strtod(fvalue,&pend));
int        TIME           ; TIME= int(strtod(tvalue,&pend));  
int        TYPE           ; TYPE= int(strtod(Tvalue,&pend));  
const char*    OUT_FILE   ; OUT_FILE = ovalue;
int        outType        ; outType = int(strtod(Ovalue,&pend));
const char*    IN_FILE   ; IN_FILE = ivalue;

//cout << "::::PARAMETERS::::" << endl;
//cout << "SIZE " << SIZE << endl;
//cout << "A " << A << endl;
//cout << "B " << B << endl;
//cout << "C " << C << endl;
//cout << "BOUNDARY " << BOUNDARY << endl;
//cout << "R_STAT " << R_STAT << endl;
//cout << "F_STAT " << F_STAT << endl;
//cout << "TIME " << TIME << endl;			  
//cout << "OFILE " << OUT_FILE << endl;			  
//The first 6 molecules are large spheres that help define the space

int num_mols = 6 + B + A + 2 * C + BOUNDARY;
cout << num_mols << endl;
srand(time(0));
//srand(0);
//Setting up space 
double x_min = -100;
double x_max = SIZE+100;
double y_max = SIZE+100;
double y_min = -100;
double z_min = -100;
double z_max = SIZE+100;
double assoc[5][5];
double dissoc[5][5];

assoc[0][0] = 0;
assoc[0][1] = F_STAT;
assoc[1][0] = F_STAT;
assoc[1][1] = 0;
assoc[2][0] = 0;
assoc[2][1] = 0;
assoc[2][2] = 0;
dissoc[0][0] = 1;
dissoc[0][1] = R_STAT;
dissoc[1][0] = R_STAT;
dissoc[1][1] = 1;
//cout << "R_STAT " << dissoc[1][0] << endl; 
vector<Molecule *> mols;
mols.reserve(2000000);
//cout << num_mols << " Molecules Loaded "  << endl;
//Randomly positioning molecules on the space

	double xr = rand();
        double yr = rand();
	double zr = rand();
bool go = true;

//Because the particles rotate into each other when I use a maximum x and maximum y value for the size of the space, I have decided to approximate the boundaries by 4 very large spherical particles.

mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols[0]->type=2;
mols[1]->type=2;
mols[2]->type=2;
mols[3]->type=2;
mols[4]->type=2;
mols[5]->type=2;

mols[0]->x=-100000;
mols[1]->x=SIZE/2;
mols[2]->x=SIZE+100000;
mols[3]->x=SIZE/2;
mols[4]->x=SIZE/2;
mols[5]->x=SIZE/2;

mols[0]->y=SIZE/2;
mols[1]->y=-100000;
mols[2]->y=SIZE/2;
mols[3]->y=SIZE+100000;
mols[4]->y=SIZE/2;
mols[5]->y=SIZE/2;

mols[0]->z=SIZE/2;
mols[1]->z=SIZE/2;
mols[2]->z=SIZE/2;
mols[3]->z=SIZE/2;
mols[4]->z=SIZE+100000;
mols[5]->z=-100000;

mols[0]->r=100000;
mols[1]->r=100000;
mols[2]->r=100000;
mols[3]->r=100000;
mols[4]->r=100000;
mols[5]->r=100000;


mols[0]->isMain=false;
mols[1]->isMain=false;
mols[2]->isMain=false;
mols[3]->isMain=false;
mols[4]->isMain=false;
mols[5]->isMain=false;


mols[0]->id=0;
mols[1]->id=1;
mols[2]->id=2;
mols[3]->id=3;
mols[4]->id=4;
mols[5]->id=5;

mols[0]->isbound=false;
mols[1]->isbound=false;
mols[2]->isbound=false;
mols[3]->isbound=false;
mols[4]->isbound=false;
mols[5]->isbound=false;


mols[0]->bound=0;
mols[1]->bound=1;
mols[2]->bound=2;
mols[3]->bound=3;
mols[4]->bound=4;
mols[5]->bound=5;

//////////////////// This is where I was going to add the boundary loading methods ///////////////////////
cout << "Placing Boundary: " << TYPE << endl;
if(TYPE == 0){
//Load in boundary file and place boundaries
mols=readboundariesXYZ(IN_FILE,mols,BOUNDARY,Bnr);
cout << num_mols << endl;
}else{
if(TYPE == 1){
mols=readboundariesXYZR(IN_FILE,mols,&num_mols,SIZE,&live_mols,false);
cout << num_mols << endl;
}
else{

if(TYPE == 2){
// Moving Boundary Elements
	mols=readboundariesXYZR(IN_FILE,mols,&num_mols,SIZE,&live_mols,true);
cout << num_mols << endl;
}
}
}
//////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

int t;
int zout, xout,yout;
cout << "Initializing Verley List:" <<num_mols<< endl; 
int w = 0;
//Initialize verley lists
for(int t=0; t < num_mols; t++){
//cout << t << ":"  << mols[t]->type << endl;
if(mols[t]->type != 2){
mols[t]->new_verley(mols,num_mols);
}
}
if(outType==3){
print_mols_fa(-1,mols,"boundary.dat");
}else{
if(outType==2){
print_mols_fa(-1,mols,OUT_FILE);
}
}
cout << "Simulating:" <<live_mols<< endl; 
for(int j = 0; j < TIME; j++){
	cout << "time: " << j << endl;
//	cout << ".";
for(int k = 0; k < live_mols; k++){

w = rand();
w = w % live_mols;
w=w+6;
mols[w]->move(mols,num_mols, dissoc, assoc,x_max,x_min,y_max,y_min,z_max,z_min);
//mols[w]->translate(1,1,1);
zout=mols[w]->z;
yout=mols[w]->y;
xout=mols[w]->x;
cout<<w<<":"<< xout<<":"<<yout<<":"<<zout<<endl;
}
if(outType==1){
print_mols_fc(j,mols,OUT_FILE,num_mols);
}else{
if(outType==2){
print_mols_fa(j,mols,OUT_FILE);
}else{
if(outType==3){
print_mols_fc(j,mols,OUT_FILE,num_mols);
}
}
}
}
cout << endl;

}//end main
