// Montecarlo fractal kinetics simulator //
#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include "stdlib.h"
#include "molecule.h"

// Calculates the distance between two molecules 
short mol_disti(Molecule mol1, Molecule mol2){
	double dist = 0;
	dist = sqrt( pow((mol1.x-mol2.x),2)+pow((mol1.y-mol2.y),2)+pow((mol1.z-mol2.z),2));
	if(dist < mol1.r+mol2.r){
		return 1;
	}
	else {
		return 0;
	}
}

// Calculates the distance between two molecules 
double mol_distd(Molecule mol1, Molecule mol2){
	double dist = 0;
	dist = sqrt( pow((mol1.x-mol2.x),2)+pow((mol1.y-mol2.y),2)+pow((mol1.z-mol2.z),2));
	return dist;
}

void Molecule::show()
{
	using namespace std;
	//cout << "Molecule " << type << " Coordinates" << endl;
	//cout << "Position and Radius " << x << "," << y << "," << z << "," << r << endl;

}//close show()


void Molecule::rotate_v(double * x, double * y, double * z, double a,double b,double g,double x2,double y2,double z2)
{
	double xp = (cos(a)*cos(g)-sin(a)*cos(b)*sin(g))*(*x-x2) + (-sin(a)*cos(g)-cos(a)*cos(b)*sin(g))*(*y-y2) + (sin(b)*sin(g))*(*z-z2) + x2;
	double yp = (cos(a)*sin(g)+sin(a)*cos(b)*cos(g))*(*x-x2) + (-sin(a)*sin(g)+cos(a)*cos(b)*cos(g))*(*y-y2) + (-sin(b)*cos(g))*(*z-z2) + y2;
	double zp = (sin(a)*sin(b))*(*x-x2) + (cos(a)*sin(b))*(*y-y2) + cos(b)*(*z-z2) + z2;
	*x = xp;
	*y = yp;
	*z = zp;
}

void Molecule::rotate_v2(double * x, double * y, double * z, double a,double x2,double y2,double z2)
{
	using namespace std;
	
	//Translate points to the x2,y2,z2
	
	double xp = *x - x2;
	double yp = *y - y2;
	//Rotate by ang a
	*x = xp*cos(a)-yp*sin(a) + x2;
	*y = xp*sin(a)+yp*cos(a) + y2;
}
void Molecule::trans_v(double * x, double * y, double *z, double x2,double y2,double z2,double r2)
{
	// Creating the Unit vector in the direction of x2,y2,z2
	double d = sqrt(pow(x2,2)+pow(y2,2)+pow(z2,2));
	//translation in direction of x2,y2,z2 of distance r2
	*x = *x+(x2/d) * r2;
	*y = *y+(y2/d) * r2;
	*z = *z+(z2/d) * r2;
}

//Random Rotation Function. Rotates mol1 around mol2 such that the maximum distance moved is 1 unit. 
void Molecule::rotate(double a,double b,double g,double x2,double y2,double z2)
{
	double xp = (cos(a)*cos(g)-sin(a)*cos(b)*sin(g))*(x-x2) + (-sin(a)*cos(g)-cos(a)*cos(b)*sin(g))*(y-y2) + (sin(b)*sin(g))*(z-z2) + x2;
	double yp = (cos(a)*sin(g)+sin(a)*cos(b)*cos(g))*(x-x2) + (-sin(a)*sin(g)+cos(a)*cos(b)*cos(g))*(y-y2) + (-sin(b)*cos(g))*(z-z2) + y2;
	double zp = (sin(a)*sin(b))*(x-x2) + (cos(a)*sin(b))*(y-y2) + cos(b)*(z-z2) + z2;
	x = xp;
	y = yp;
	z = zp;
}


void Molecule::trans(double x2,double y2,double z2,double r2)
{
	// Creating the Unit vector in the direction of x2,y2,z2
	double d = sqrt(pow(x2,2)+pow(y2,2)+pow(z2,2));
	//translation in direction of x2,y2,z2 of distance r2
	x = x+(x2/d)*r2;
	y = y+(y2/d)*r2;
	z = z+(z2/d)*r2;
}

int Molecule::col_detect_b(std::vector<Molecule *> mols,double x2,double y2,double z2,double xp2, double yp2, double zp2){
	using namespace std;
	////cout << "DECTING " << num_list << "POSSIBLE COLLISIONS"<< endl;
//This determines which molecule of mols was the first to collide with molecule A, when A moves from x,y,z to x1,y1,z1
	double a;
	double b;
	double c;
	double x3;
	double y3;
	double z3;
	double r3;
	double root1;
	double root1p;
	double root2p;
	int firstp = -1;
	double minp = -1;
	double root2;
	int  first = -1;
	double min = 1; // Minimum collision time
//If three molecules collide at exactly the same time, the one occuring first in the list is choosen for the final pair.	
		
	for(int i = 0; i < num_list; i++){
	if(mols[verley[i]]->id == bound){
	}else{		
	x3 = mols[verley[i]]->x;
	y3 = mols[verley[i]]->y;
	z3 = mols[verley[i]]->z;
	r3 = mols[verley[i]]->r;
		
		
	c = pow((x3-x),2)+pow((y3-y),2)+pow((z3-z),2)-pow((r3+r),2);
	b = -2*(x3-x)*(x2-x)-2*(y3-y)*(y2-y)-2*(z3-z)*(z2-z);
	a = pow((x2-x),2)+pow((y2-y),2)+pow((z2-z),2);
	if(pow(b,2) >= (4*a*c)){ 
	root1 = (-b + sqrt((pow(b,2) - 4*a*c)))/(2*a);
	root2 = (-b - sqrt((pow(b,2) - 4*a*c)))/(2*a);
	}
	else{
		root1 = -1;
		root2 = -1;
	}
//Save the id if 0 < root1 or root2 < min
////cout << verley[i] << ": Root 1, "<< root1 << endl;
////cout << verley[i] << ": Root 2, "<< root2 << endl;
if(root1 >= 0){
      if(root1 < min){
min = root1;
first = verley[i];
}}

if(root2 >= 0){
if(root2 < min){
min = root2;
first = verley[i];
}
}
	
	}
}

//Move bound complex and see if it collides with anything 

	firstp = -1;
	minp = 1; // Minimum collision time
//If three molecules collide at exactly the same time, the one occuring first in the list is choosen for the final pair.	
	for(int i = 0; i < mols[bound]->num_list; i++){
if(mols[mols[bound]->verley[i]]->id == id){
}else{
	x3 = mols[mols[bound]->verley[i]]->x;
	y3 = mols[mols[bound]->verley[i]]->y;
	z3 = mols[mols[bound]->verley[i]]->z;
	r3 = mols[mols[bound]->verley[i]]->r;
		
		
	c = pow((x3-mols[bound]->x),2)+pow((y3-mols[bound]->y),2)+pow((z3-mols[bound]->z),2)-pow((r3+mols[bound]->r),2);
	b = -2*(x3-mols[bound]->x)*(xp2-mols[bound]->x)-2*(y3-mols[bound]->y)*(yp2-mols[bound]->y)-2*(z3-mols[bound]->z)*(zp2-mols[bound]->z);
	a = pow((xp2-mols[bound]->x),2)+pow((yp2-mols[bound]->y),2)+pow((zp2-mols[bound]->z),2);
	if(pow(b,2) >= (4*a*c)){ 
	root1p = (-b + sqrt((pow(b,2) - 4*a*c)))/(2*a);
	root2p = (-b - sqrt((pow(b,2) - 4*a*c)))/(2*a);
	}
	else{
		root1p = -1;
		root2p = -1;
	}
//Save the id if 0 < root1 or root2 < min
////cout << verley[i] << ": Root 1, "<< root1 << endl;
////cout << verley[i] << ": Root 2, "<< root2 << endl;
if(root1p >= 0){
      if(root1p < minp){
minp = root1p;
firstp = mols[bound]->verley[i];
}}

if(root2p >= 0){
if(root2p < minp){
minp = root2p;
firstp = mols[bound]->verley[i];
}
}
	
	}
}

//If distance is exactly zero the next iteration might cause the radii to overlap
if((min-0.001) > 0){
	min = min-0.001;
}else{min = 0;}
if((minp-0.001) > 0){
minp = minp-0.001;
}else{
	minp = 0;
}
if(min < minp){
//Move the molecule so that it collides with the first molecule
x = min*(x2-x) + x;
y = min*(y2-y) + y;
z = min*(z2-z) + z;
mols[bound]->x =min*(xp2-mols[bound]->x) + mols[bound]->x;
mols[bound]->y =min*(yp2-mols[bound]->y) + mols[bound]->y;
mols[bound]->z =min*(zp2-mols[bound]->z) + mols[bound]->z;

return first;
}else{
x = minp*(x2-x) + x;
y = minp*(y2-y) + y;
z = minp*(z2-z) + z;
mols[bound]->x =minp*(xp2-mols[bound]->x) + mols[bound]->x;
mols[bound]->y =minp*(yp2-mols[bound]->y) + mols[bound]->y;
mols[bound]->z =minp*(zp2-mols[bound]->z) + mols[bound]->z;
return firstp;
}	

}

int Molecule::col_detect(std::vector<Molecule *> mols,double x2,double y2,double z2){
	using namespace std;
	////cout << "DECTING " << num_list << "POSSIBLE COLLISIONS"<< endl;
//This determines which molecule of mols was the first to collide with molecule A, when A moves from x,y,z to x1,y1,z1
	double a;
	double b;
	double c;
	double x3;
	double y3;
	double z3;
	double r3;
	double root1;
	double root2;
	int  first = -1;
	double min = 1; // Minimum collision time
//If three molecules collide at exactly the same time, the one occuring first in the list is choosen for the final pair.	
	for(int i = 0; i < num_list; i++){
if(mols[verley[i]]->id == bound){
}else{
	x3 = mols[verley[i]]->x;
	y3 = mols[verley[i]]->y;
	z3 = mols[verley[i]]->z;
	r3 = mols[verley[i]]->r;
		
		
	c = pow((x3-x),2)+pow((y3-y),2)+pow((z3-z),2)-pow((r3+r),2);
	b = -2*(x3-x)*(x2-x)-2*(y3-y)*(y2-y)-2*(z3-z)*(z2-z);
	a = pow((x2-x),2)+pow((y2-y),2)+pow((z2-z),2);
	if(pow(b,2) >= (4*a*c)){ 
	root1 = (-b + sqrt((pow(b,2) - 4*a*c)))/(2*a);
	root2 = (-b - sqrt((pow(b,2) - 4*a*c)))/(2*a);
	}
	else{
		root1 = -1;
		root2 = -1;
	}
//Save the id if 0 < root1 or root2 < min
////cout << verley[i] << ": Root 1, "<< root1 << endl;
////cout << verley[i] << ": Root 2, "<< root2 << endl;
if(root1 >= 0){
      if(root1 < min){
min = root1;
first = verley[i];
}}

if(root2 >= 0){
if(root2 < min){
min = root2;
first = verley[i];
}
}
	
	}
}
min = min-0.0001;
//Move the molecule so that it collides with the first molecule
x = min*(x2-x) + x;
y = min*(y2-y) + y;
z = min*(z2-z) + z;

return first;
}


void Molecule::move(std::vector<Molecule  *> mols,int num_mols,double diss[5][5],double assoc[5][5],double x_max,double x_min,double y_max, double y_min, double z_max, double z_min)
{
	//This is the main part of the program. It determines how the particles move in the space created.
	using namespace std;

	//isMain = True if the particle is not bound or is the bound but is designated as the center of mass for the complex. I am only considering complexes of two molecules.
	if(isMain){
//if(id==3074 | id==1560){cout << "M:";}
		//cout << "isMain = TRUE" << endl;
re_calc = re_calc -1;
if(re_calc <= 0){
	new_verley(mols, num_mols);
}
				double r1 = rand();
				double r2 = rand();
				double r3 = rand();
				double xr = ((r1/RAND_MAX)-0.5)*2;//Random number between -1 and 1;
				double yr = ((r2/RAND_MAX)-0.5)*2;
				double zr = ((r3/RAND_MAX)-0.5)*2;
		//If it is bound then we need to determine if it disassociates or not
		if(isbound){
//if(id==3074 | id==1560){cout << "B:";}
			mols[bound]->re_calc = mols[bound]->re_calc - 1;
			if(mols[bound]->re_calc <= 0){
			mols[bound]->new_verley(mols,num_mols);
			}
			//cout << "ISBOUND = TRUE" << endl;
			double r_dis = rand();
			if((r_dis/RAND_MAX) < diss[mols[bound]->type][type]){
				//The molecules dissassociate and are moved separately in opposite directions. 
				////cout << "DISASSOCIATE = TRUE" << endl;
				// Creating the Unit vector in the direction of x2,y2,z2
//if(id==3074 | id==1560){cout << "D:";}				
double d = sqrt(pow((x-mols[bound]->x),2)+pow((y-mols[bound]->y),2)+pow((z-mols[bound]->z),2));
				//translation in direction of x2,y2,z2 of distance r2
				double x3a = x+((x-mols[bound]->x)/d)*0.5;
				double y3a = y+((y-mols[bound]->y)/d)*0.5;
				double z3a = z+((z-mols[bound]->z)/d)*0.5;
				double x3b = mols[bound]->x+((x-mols[bound]->x)/d)*-0.5;
				double y3b = mols[bound]->y+((y-mols[bound]->y)/d)*-0.5;
				double z3b = mols[bound]->z+((z-mols[bound]->z)/d)*-0.5;
				//1. Move One molecule 0.5 units in that direction and the other -0.5 
				//Making sure x,y, and z are within the boundaries of the simulation
				x3a = inside(x3a,x_min,x_max);
				y3a = inside(y3a,y_min,y_max);
				z3a = inside(z3a,z_min,z_max);
				////cout << "MOVE A: " << x3a << "," << y3a << "," << z3a << endl;
				x3b = inside(x3b,x_min,x_max);
				y3b = inside(y3b,y_min,y_max);
				z3b = inside(z3b,z_min,z_max);
				////cout << "MOVE B: " << x3b << "," << y3b << "," << z3b << endl;
				
				int b1 = mols[bound]->col_detect(mols,x3b,y3b,z3b);
				int b2 = col_detect(mols,x3a,y3a,z3a);

				//3. Check if dissassociated molecule collided This needs to be done before we change the bound molecule id of the main molecule.
				
				if(b1 >= 0){
	//if(id==3074 | id==1560){cout << "Dc:";}
					if(mols[b1]->isbound){
					mols[bound]->isbound=false;
					mols[bound]->bound = bound;
					mols[bound]->isMain=true;
				//can't associate with a bound molecule
					}else{
				//Test to see if this molecule will associate with molecule id_k;
				double r_ass = rand();
					if((r_ass/RAND_MAX) < assoc[mols[b1]->type][mols[bound]->type]){
		//if(id==3074 | id==1560){cout << "Da:";}		//cout << "ASSOC AFTER DISS" << b1 << " AND " << mols[bound]->id << endl;
					
				//bind molecules 
				mols[bound]->isMain=true;
			  	mols[bound]->isbound=true;
				mols[bound]->bound = b1;
				mols[b1]->isbound=true;
				mols[b1]->bound = mols[bound]->id;	
				mols[b1]->isMain=false;
				
}else{//if(id==3074 | id==1560){cout << "D1";}
				mols[bound]->isbound=false;
				mols[bound]->isMain=true;
				mols[bound]->bound = bound;
				}	
				}}else{
//if(id==3074 | id==1560){cout << "D2";}
				mols[bound]->isbound=false;
				mols[bound]->isMain=true;
				mols[bound]->bound = bound;
				}

				//4. Check if main molecule collided with anything
				if(b2 >= 0){
//if(id==3074 | id==1560){cout << "Mc";}
					if(mols[b2]->isbound){
					isbound=false;
					isMain = true;
					bound = id;
					//can't associate with a bound molecule
					}else{
				//Test to see if this molecule will associate with molecule id_k;
				double r_ass2 = rand();
					if((r_ass2/RAND_MAX) < assoc[mols[b2]->type][type]){
//if(id==3074 | id==1560){cout << "Ma:";}				
//bind molecules 
				isMain=true;
			  	isbound=true;
				bound = b2;
				mols[b2]->isbound=true;
				mols[b2]->bound = id;	
				mols[b2]->isMain=false;
				}else{
//if(id==3074 | id==1560){cout << "M1";}
				isMain=true;
				isbound=false;
				bound = id;
				}	
				}}else{
//if(id==3074 | id==1560){cout << "M2";}
				isMain=true;
				isbound=false;
				bound = id;
				}

				
			}//End if dissassociates  
			else{
//if(id==3074 | id==1560){cout << "Mb";}
//Moving the two molecules together
			       ////cout << "MOVED IN COMPLEX" << endl;	
				//1. Pick Random rotation & direction
				double ang = acos((1-2*pow((mols[bound]->r+r),2))/(-2*pow((mols[bound]->r + r),2)));
				double ra1 = rand();
				double ra2 = rand();
				double ra3 = rand();
				double ar = ((ra1/RAND_MAX)-0.5)*2*ang; //Random Number between -ang and ang
				double gr = ((ra2/RAND_MAX)-0.5)*2*ang; //Random Number between -ang and ang
				double yr = ((ra3/RAND_MAX)-0.5)*2*ang; //Random Number between -ang and ang

				double x1 = x;
				double y1 = y;
				double z1 = z;
				double x2 = mols[bound]->x;
				double y2 = mols[bound]->y;
				double z2 = mols[bound]->z;	

				
				//2. Move molecule and bound molecule 
				trans_v(&x1,&y1,&z1,xr,yr,zr,1);
				trans_v(&x2,&y2,&z2,xr,yr,zr,1);

				//3. Rotate bound molecule around main molecule
				rotate_v(&x2,&y2,&z2,ar,gr,yr,x1,y1,z1);
				//rotate_v2(&x2,&y2,&z2,ar,x1,y1,z1); // This is the 2D rotation function used for testing
				//4. Check to make sure x y and z are within the boundaries
				x1 = inside(x1,x_min,x_max);
				y1 = inside(y1,y_min,y_max);
				z1 = inside(z1,z_min,z_max);
				
				x2 = inside(x2,x_min,x_max);
				y2 = inside(y2,y_min,y_max);
				z2 = inside(z2,z_min,z_max);
				//4. Move the molecule until it collides with something or moves 1 unit.
				if(re_calc <= 0){
					new_verley(mols,num_mols);
				}
				if(mols[bound]->re_calc <= 0){
					new_verley(mols,num_mols);
				}
				col_detect_b(mols,x1,y1,z1,x2,y2,z2);


				}

			}
		else{ //If the molecule is not bound we simply move it until it collides 

//cout << "ISBOUND = FALSE" << endl;		
	double xr1 = x;
	double yr1 = y;
	double zr1 = z;
	trans_v(&xr1,&yr1,&zr1,xr,yr,zr,1);
	xr1 = inside(xr1,x_min,x_max);
	yr1 = inside(yr1,y_min,y_max);
	zr1 = inside(zr1,z_min,z_max);
//cout << "Random Direction: " << xr1 <<"," << yr1 << "," << zr1 <<  endl;
	if(re_calc <= 0){
new_verley(mols,num_mols);
	}
	
	int b3 = col_detect(mols,xr1,yr1,zr1);
	//cout << "COLLISION " << b3 << " and " << id << endl;
	if(b3 > -1){
		if(mols[b3]->isbound){
		//can't associate with a bound molecule
		}else{
//If the molecule collides with another check to see if it associates
double r_ass3 = rand();
//cout << "PROB ASSOC " << r_ass3/RAND_MAX << endl;
if(r_ass3/RAND_MAX < assoc[type][mols[b3]->type]){
//Bind the molecules
isbound = true;
isMain = true;
bound = b3;
mols[b3]->isMain=false;
mols[b3]->isbound=true;
mols[b3]->bound=id;
}}
	}	

			
		}





}//end isMain

}
double Molecule::inside(double x,double x_min,double x_max){

double out = x;	
if(x > x_max){
	out =  x_max;
}
	else{
		if(x < x_min){
		out =  x_min;
		}	
	}

return out;	
}

void Molecule::new_verley(std::vector<Molecule *> mols,int num_mols){

	using namespace std;

	//We know molecules only move 1 unit distance per time step. We can then calculate a list of neighboring particles and update that list every N time steps.
	double r_outer = 22;
//	 //cout << "Number of Molecules " << num_mols << endl; 
	 re_calc = 8; //resets the number of moves before the verley list needs to be recalculated
//	 //cout << "Reset re_calc" << endl;
	for(int j = 0; j < 500; j++){
		verley[j] = 0;
	}
//	 //cout << "Reset Verley" << endl;
	int w=0;
	num_list = 0;
	for(int i = 0; i < num_mols; i++){
		double t = (sqrt(pow((x-mols[i]->x),2) +pow((y-mols[i]->y),2) +pow((z-mols[i]->z),2) ) - r - mols[i]->r); 

		if(t < r_outer){
			if(id == i){
			//cout << "Can't be in your own verley list!" << endl;
			}else{
				if(i == bound){
			//cout << "Can't have bound molecule on your list" << endl;
			}else{
				
//		 	//cout << num_list << ": " << i << ":" << w << ": " << mols[i]->x << "," << mols[i]->y << "," << mols[i]->z  << " : " << t << endl;
			verley[w++] = i;
			num_list++;
			}
			}
		}
		}
	}




double Molecule::mol_dist2(Molecule A){
	double dist=0;
	dist = (sqrt(pow((x-A.x),2) +
				pow((y-A.y),2) +
				pow((z-A.z),2) ) - r - A.r);
	return dist;
}

/*
void Molecule::dist_verley(Molecule mols[],int num){
	using namespace std;
	////cout << "NUM " << num << endl;
	int id_temp;
	for(int j = 0; j < num; j++){
		id_temp = verley[j];
	//	//cout << "ID-" << j << ": " << verley[j] << endl;
	//	//cout << "NUM_LIST " << num_list << endl;
		dists[j] = (sqrt(pow((x-mols[id_temp]->x),2) +pow((y-mols[id_temp]->y),2) +pow((z-mols[id_temp]->z),2) ) - r - mols[id_temp]->r);
////cout << "DIST: " << dists[j] << endl;
	}
}

*/











