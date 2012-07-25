// molecule.h -- molecule class and functions

#ifndef MOLECULE_H_
#define MOLECULE_H_
#include <deque>
class Molecule
{
private:
public:
double z;
double x;
double y;
double r;
short type;
int num_list;
int re_calc;
bool isMain;
bool isbound;
int bound;
std::deque<int> verley;
//int verley[50];
int id;
int col_detect(std::deque<Molecule *> mols,double,double,double);
int col_detect_b(std::deque<Molecule *> mols,double,double,double,double,double,double);
double inside(double n,double n_min,double n_max);
void move(std::deque<Molecule *> mols,int num_mols, double diss[5][5], double assoc[5][5],double,double,double,double,double,double);
void trans(double,double,double,double);
void trans_v(double * x, double * y, double * z, double x2,double y2,double z2,double d);
void show();
double mol_dist2(Molecule A);
void dist_verley(std::deque<Molecule *>mols,int num);
void rotate(double, double, double, double, double, double);
void rotate_v(double * x, double * y, double * z, double a, double b, double g, double x2, double y2 , double z2);
void rotate_v2(double * x, double * y, double * z, double a, double x2, double y2 , double z2);
void new_verley(std::deque<Molecule *>mols, int num_mols);
};


short mol_disti(Molecule mol1, Molecule mol2);
double mol_distd(Molecule mol1, Molecule mol2);



#endif



