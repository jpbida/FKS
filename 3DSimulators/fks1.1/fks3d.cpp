//TESTING COL_DETECT
//mols[0]->col_detect(mols[],x,y,z), mols = list of molecules in the space
//This function moves the given molecule toward x,y,z. If the molecule collides
//with another molecule before reaching x,y,z the function moves the molecule until
//it just touches the other molecule and returns the id of the molecule that it
//the was in the collision.

#include "stdlib.h"
#include <ctime>
#include <fstream>
#include <iostream>
#include "molecule.h"
#include <string>
#include <cmath>
#include <vector>
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



//Parsing input file for simulation parameters
void print_mols_fa(int t,std::vector<Molecule *> mols){
	using namespace std;
	std::ofstream out("debug.csv",ios_base::app);
	for(int j = 0; j < 4000; j++){
		        out << t << "," << mols[j]->id << "," << mols[j]->x << "," << mols[j]->y << "," << mols[j]->z << "," << mols[j]->isMain << "," << mols[j]->isbound << "," << mols[j]->bound << "," << mols[j]->re_calc << "," << mols[j]->num_list << "," <<  mols[j]->type;
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

int num_mols = B + A + 2 * C + BOUNDARY;
//cout << num_mols << endl;
srand(time(0));

//Setting up space 
double x_min = 0;
double x_max = SIZE;
double y_max = SIZE;
double y_min = 0;
double z_min = 0;
double z_max = SIZE;
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
double pt1x = rand();
double pt1y = rand();
double pt1z = rand();

double pt2x = rand();
double pt2y = rand();
double pt2z = rand();

double u_x,actin_dist,d_temp; 
double u_y ;
double u_z ;


bool go = true;

//Adding Actin Boundary Particles 
int a = 0;
while(a < BOUNDARY){
//Molecule * A = new Molecule();
mols.push_back(new Molecule());
//Picking Random End Points for the actin filament
//make sure all points are inside of the simulation boundary
pt1x = rand();pt1x = pt1x/RAND_MAX * SIZE;pt1x=mols[a]->inside(pt1x,x_min,x_max);
pt1y = rand();pt1y = pt1y/RAND_MAX * SIZE;pt1y=mols[a]->inside(pt1y,y_min,y_max);
pt1z = rand();pt1z = pt1z/RAND_MAX * SIZE;pt1z=mols[a]->inside(pt1z,z_min,z_max);

pt2x = rand();pt2x = pt2x/RAND_MAX * SIZE;pt2x=mols[a]->inside(pt2x,x_min,x_max);
pt2y = rand();pt2y = pt2y/RAND_MAX * SIZE;pt2y=mols[a]->inside(pt2y,y_min,y_max);
pt2z = rand();pt2z = pt2z/RAND_MAX * SIZE;pt2z=mols[a]->inside(pt2z,z_min,z_max);


//calculate distance between two points
actin_dist = sqrt(pow((pt2x-pt1x),2)+pow((pt2y-pt1y),2)+pow((pt2z-pt1z),2));

u_x = (pt2x-pt1x)/actin_dist;
u_y = (pt2y-pt1y)/actin_dist;
u_z = (pt2z-pt1z)/actin_dist;
d_temp = 0;
//cout << d_temp << ":" << actin_dist << endl;
while(d_temp < actin_dist){
if(d_temp > 0){
	mols.push_back(new Molecule());}
mols[a]->x = d_temp*u_x + pt1x;
mols[a]->type=2;
mols[a]->isMain=false;
mols[a]->isbound=false;
mols[a]->bound=a;
mols[a]->r = 5;
mols[a]->y = d_temp*u_y + pt1y;
mols[a]->z = d_temp*u_z + pt1z;
d_temp = d_temp + 10;
d_temp=d_temp+10;
a++;
if(a >= BOUNDARY){
d_temp = actin_dist;
}
}

}

for(int i = BOUNDARY; i < num_mols; i++){
//cout << "First_Mol:" <<  i << endl;
mols.push_back(new Molecule());	
	mols[i]->r = 1;
go = true;
	while(go){
		xr = rand();
		yr = rand();
		zr = rand();
	xr = xr/RAND_MAX * SIZE;
	yr = yr/RAND_MAX * SIZE;
	zr = zr/RAND_MAX * SIZE;
	
	zr = mols[i]->inside(zr,z_min,z_max);
	yr = mols[i]->inside(yr,y_min,y_max);
	xr = mols[i]->inside(xr,x_min,x_max);
	
	mols[i]->x = xr;
	mols[i]->y = yr;
	mols[i]->z = zr;
go = false;
for(int w = 0; w < i; w++){
if(mols[i]->mol_dist2(*mols[w]) < 0){
go = true;
}
}
}
mols[i]->num_list=0;
mols[i]->re_calc=0;
mols[i]->id = i;
mols[i]->isMain=true;
mols[i]->isbound=false;
mols[i]->bound = i;
for(int t = 0; t < 100; t++){
mols[i]->verley[t] = 0;
}
mols[i]->num_list = 0;
	if(i < A + BOUNDARY){
	mols[i]->type = 0;
	}else{
	if(i < (A + B + BOUNDARY)){
		mols[i]->type=1;
}else{
if(i < (A + B + 2*C + BOUNDARY)){
//cout << "Incorrect: " << i << endl;
mols[i]->type = 2;//This doesn't work
}
}
	}	

}

// Print Pymol Image of Boundary 
int t;
//print_border(mols,num_mols);
//cout << "Start Sim? " << endl;
//cin >> t;

//Beginning Plot data
//cout << "SIMULATING:" << endl; 
int w = 0;
for(int j = 0; j < TIME; j++){
	//////cout << "time: " << j << endl;
for(int k = 0; k < num_mols; k++){
//1560 & 3074 must be followed

//Pick a random molecule to move
w = rand();
w = w % num_mols;
//if(w == 1560){
////cout << "Moving 1560" << endl;
////cout << "isBound " << mols[w]->isbound << " isMain " << mols[w]->isMain << " bound " << mols[w]->bound << endl; 

//}else{
//if(w == 3074){
////cout << "Moving 3074" << endl;
////cout << "isBound " << mols[w]->isbound << " isMain " << mols[w]->isMain << " bound " << mols[w]->bound << endl; 
//}
//}
mols[w]->move(mols,num_mols, dissoc, assoc,x_max,x_min,y_max,y_min,z_max,z_min);
}
//print_mols_fa(j,mols);
print_mols_f(j,mols,OUT_FILE,num_mols);
}
//cout << endl;




}//end main
