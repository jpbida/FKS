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
#include "stdlib.h"
#include <string>
#include <cmath>
#include <vector>
double d1 = 0;


void print_border2(std::vector<Molecule *> mols, int num_mols){
using namespace std;
std::ofstream out("border.xyz",ios_base::app);
out << "x,y,z,r" << endl;
for(int j = 0; j < num_mols; j++){
if(mols[j]->type==2){
out << mols[j]->x << "," << mols[j]->y << "," << mols[j]->z << "," << mols[j] -> r << endl;
}
}


}

void print_border(std::vector<Molecule *> mols, int num_mols){
using namespace std;
std::ofstream out("border.xyz",ios_base::app);
out << num_mols << endl;
out << "BOUNDARY ELEMENTS" << endl;
for(int j = 0; j < num_mols; j++){
if(mols[j]->type==2){
out << "c " << mols[j]->x << " " << mols[j]->y << " " << mols[j]->z << endl;
}
}


}



//Parsing input file for simulation parameters
////////////////////////////////////////////////////////////////////
void print_mols_fa(int t,std::vector<Molecule *> mols){
	using namespace std;
	std::ofstream out("debug.csv",ios_base::app);
	for(int j = 0; j < mols.size(); j++){
		        out << t << "," << mols[j]->id << "," << mols[j]->x << "," << mols[j]->y << "," << mols[j]->z << "," << mols[j]->isMain << "," << mols[j]->isbound << "," << mols[j]->bound << "," << mols[j]->r << "," << mols[j]->num_list << "," <<  mols[j]->type;
for(int w = 0; w < 12; w++){
out << "," << mols[j]->verley[w];
}
			out << endl;
	}       
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
//Command Line Arguments //
  	char *ovalue = NULL;
	char *tvalue = NULL;
	char *svalue = NULL;
	char *fvalue = NULL;
	char *rvalue = NULL;
	char *Evalue = NULL;	
	char *Svalue = NULL;
	char *Cvalue = NULL;
	char *Bvalue = NULL;

  opterr = 0;

  while ((c = getopt (argc, argv, "o:t:s:f:r:E:S:C:B:")) != -1)

    switch (c)
      {
	case 'o':
	ovalue = optarg;
	break;
	case 't':
	tvalue = optarg;
	break;
      case 's':
        svalue = optarg;
        break;
      case 'f':
        fvalue = optarg; // Input file
        break;
      case 'r':
       rvalue = optarg; // output file
        break;
      case 'E':
       Evalue = optarg; // output file
        break;
      case 'S':
       Svalue = optarg; // output file
        break;
      case 'C':
       Cvalue = optarg; // output file
        break;
      case 'B':
       Bvalue = optarg; // output file
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
int 	   BOUNDARY       ; BOUNDARY= int(strtod(Bvalue,&pend));
double 	   R_STAT         ; R_STAT= (strtod(rvalue,&pend));
double 	   F_STAT         ; F_STAT= (strtod(fvalue,&pend));
int        TIME           ; TIME= int(strtod(tvalue,&pend));  
const char*    OUT_FILE   ; OUT_FILE = ovalue;

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

//Intializing the all molecules in the simulation
////////////////////////////////////////////////////////////////////
int num_mols = 4 + B + A + 2 * C + BOUNDARY;
//cout << num_mols << endl;
//Uncomment the srand(time(0)); line when not debugging
srand(0);
//srand(time(0));
//Setting up space 
double x_min = -100000;
double x_max = SIZE+100000;
double y_max = SIZE+100000;
double y_min = -100000;
double z_min = -0.0001;
double z_max = 0.0001;
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
	double zr = 0;
bool go = true;

//Because the particles rotate into each other when I use a maximum x and maximum y value for the size of the space, I have decided to approximate the boundaries by 4 very large spherical particles.

mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols.push_back(new Molecule());
mols[0]->type=2;
mols[1]->type=2;
mols[2]->type=2;
mols[3]->type=2;

mols[0]->x=-100000;
mols[1]->x=SIZE/2;
mols[2]->x=SIZE+100000;
mols[3]->x=SIZE/2;

mols[0]->y=SIZE/2;
mols[1]->y=-100000;
mols[2]->y=SIZE/2;
mols[3]->y=SIZE+100000;

mols[0]->z=0;
mols[1]->z=0;
mols[2]->z=0;
mols[3]->z=0;

mols[0]->r=100000;
mols[1]->r=100000;
mols[2]->r=100000;
mols[3]->r=100000;


mols[0]->isMain=false;
mols[1]->isMain=false;
mols[2]->isMain=false;
mols[3]->isMain=false;


mols[0]->id=0;
mols[1]->id=1;
mols[2]->id=2;
mols[3]->id=3;

mols[0]->isbound=false;
mols[1]->isbound=false;
mols[2]->isbound=false;
mols[3]->isbound=false;


mols[0]->bound=0;
mols[1]->bound=1;
mols[2]->bound=2;
mols[3]->bound=3;
int w;
int a = 4;
//Initializing and placing boundary elements//
while(a < BOUNDARY+4){
mols.push_back(new Molecule());
mols[a]->type=2;
mols[a]->num_list = 0;
mols[a]->re_calc = 0;
//If is.main is set to false the molecules will not be moved during the simulation
mols[a]->isMain=false;
mols[a]->isbound=false;
mols[a]->bound=a;
//Initializing verley list
//for(int t = 0; t < 500; t++){
//mols[a]->verley[t] = 0;
//}
mols[a]->id = a;

//Randomly Positioned Spheres Overlapping and Stationary
		xr = rand();
		yr = rand();
		zr = rand();
	xr = xr/RAND_MAX * SIZE;
	yr = yr/RAND_MAX * SIZE;
	yr = mols[a]->inside(yr,y_min,y_max);
	xr = mols[a]->inside(xr,x_min,x_max);
	mols[a]->x = xr;
	mols[a]->y = yr;
	mols[a]->z = 0;

//Pick random radius between 0.5 - 15
zr = zr/RAND_MAX * 15 + 5;

mols[a]->r = 1;
a++;
}

//Initializing All other elements
while(a < num_mols){
cout << "m: " << a << endl;
//Molecule * A = new Molecule();
mols.push_back(new Molecule());
//Picking Random End Points for the actin filament
//make sure all points are inside of the simulation boundary
if(a < (BOUNDARY + A + 4)){
	mols[a]->type=0;
	mols[a]->r = 1;
mols[a]->isMain=true;
mols[a]->isbound=false;
mols[a]->bound=a;
}else{
	if(a < (4+A + B + BOUNDARY)){
		mols[a]->type=1;
		mols[a]->r = 1;
mols[a]->isMain=true;
mols[a]->isbound=false;
mols[a]->bound=a;
	}
}
mols[a]->num_list = 0;
mols[a]->re_calc = 0;

go = true;

//Initializing x,y,z
	while(go){
		xr = rand();
		yr = rand();
		zr = 0;
	xr = xr/RAND_MAX * SIZE;
	yr = yr/RAND_MAX * SIZE;
	
	yr = mols[a]->inside(yr,y_min,y_max);
	xr = mols[a]->inside(xr,x_min,x_max);
	
	mols[a]->x = xr;
	mols[a]->y = yr;
	mols[a]->z = 0;
go = false;
for(int w = 0; w < a; w++){
	d1=0;
	d1=mols[a]->mol_dist2(mols[w]);
if(d1 <= 0.1){
go = true;
}
}
}
//Initializing verley list
for(int t = 0; t < 500; t++){
mols[a]->verley[t] = 0;
}
mols[a]->id = a;
a++;
}


// Print Pymol Image of Boundary 
//print_border2(mols,num_mols);
//cin >> t;
//Beginning Plot data
//cout << "SIMULATING:" << endl; 
//Making list of molecules to move 

for(int top234=(BOUNDARY + 4); top234 < num_mols; top234++){
mols[top234]->new_verley(mols,num_mols);
}

//Prints out time boundary elements to Debug.csv
print_mols_fa(-1,mols);
////////////////////////////////////////////////////////////////////


//Run the simulation
////////////////////////////////////////////////////////////////////
for(int j = 0; j < TIME; j++){
	cout << "time: " << j << endl;
for(int k = 0; k < (A+B); k++){

//Pick a random molecule
w = rand();
w = w % (A + B);
//Excludes boundary elements from the list
w = w + 4 + BOUNDARY;
//Moves the molecule based on a set of rules defined by the user
mols[w]->move(mols,num_mols, dissoc, assoc,x_max,x_min,y_max,y_min,z_max,z_min);
}
//prints the time step to the output file
print_mols_fa(j,mols);
print_mols_f(j,mols,OUT_FILE,num_mols);
}
}//end main
