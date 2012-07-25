// molecule.h -- molecule class and functions

#ifndef MOLECULE_H_
#define MOLECULE_H_
#include <vector>

class Molecule
{
private:
public:
double z;
double x;
double y;
double r;
double r_outer;
short type;
char seq;
int num_list;
int re_calc;
bool isMain;
bool isbound;
int col_type;//Last type of molecule it collided with
int bound;
int verley[500];
int id;
int col_detect(std::vector<Molecule *> mols,double,double,double);
int col_detect_b(std::vector<Molecule *> mols,double,double,double,double,double,double);
double inside(double n,double n_min,double n_max);
void move(std::vector<Molecule *> mols,int num_mols, double diss[5][5], double assoc[5][5],double,double,double,double,double,double);
void translate(double,double,double);
void trans(double,double,double,double);
void trans_v(double * x, double * y, double * z, double x2,double y2,double z2,double d);
void show();
double mol_dist2(Molecule * A);
void dist_verley(std::vector<Molecule *>mols,int num);
void rotate3d(double * x, double * y, double * z, double a, double b, double g, double x2, double y2 , double z2);
void rotate(double a, double b, double g, double x2, double y2 , double z2);
void rotate3d_col_detect(std::vector<Molecule *> mols,double ang1, double ang2, double ang3, double x2, double y2, double z2);
void new_verley(std::vector<Molecule *>mols, int num_mols);
void rotateX(double);
void rotateY(double);
void rotateZ(double);

};

short mol_disti(Molecule mol1, Molecule mol2);
double mol_distd(Molecule mol1, Molecule mol2);



#endif



