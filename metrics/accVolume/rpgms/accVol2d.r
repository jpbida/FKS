rpgms_path="~/projects/p1000/metrics/accVolume/rpgms/"
source(paste(rpgms_path,"pixels.r",sep=""))
source(paste(rpgms_path,"functions.r",sep=""))
dat_path="/Users/bida/projects/p1000/paper/data0706/CROWDING/"
dat_path2="/Users/bida/projects/p1000/metrics/accVolume/data/"

###########  Random Radius Data  ##################

datasets<-c("border1500","border3000","border4500")
#datasets<-c("border1500")
for(dataset in datasets){
print(dataset)
dat3<-read.table(file=paste(dat_path,dataset,sep=""),sep=",",header=T)
### Pixelize these spheres and store pixels in pdat.px ###
### Snap centers to grid ###
dat3$x<-floor(dat3$x/(0.976))
dat3$y<-floor(dat3$y/(0.976))
dat3$z<-floor(dat3$z/(0.976))
dat3$r<-floor(dat3$r/(0.976))
### Pixelize boundary spheres and store in bdat.px ###
arb_pixelize(dat3)
system("mv out.dat bdat.px")
### Concatenate pdat.px and bdat.px with all.px. Remove all duplicate rows leaving pixels that need to be checked ###
system("cat bdat.px all2d_1024 > out.dat")
system("sort out.dat -o tmp1.dat")
system("uniq -u tmp1.dat > out.dat")
system("rm tmp1.dat")
accVol("out.dat",2)
}
########### Uniform Radius Data ####################

datasets<-NULL
#datasets<-c("border16000","border32000","border48000")
for(dataset in datasets){
print(dataset)
dat3<-read.table(file=paste(dat_path,dataset,sep=""),sep=",",header=T)
### Pixelize these spheres and store pixels in pdat.px ###
### Snap centers to grid ###
dat3$x<-floor(dat3$x/(0.976))
dat3$y<-floor(dat3$y/(0.976))
dat3$z<-floor(dat3$z/(0.976))
dat3$r<-floor(dat3$r/(0.976))
### Pixelize boundary spheres and store in bdat.px ###
arb_pixelize(dat3)
system("mv out.dat bdat.px")
### Concatenate pdat.px and bdat.px with all.px. Remove all duplicate rows leaving pixels that need to be checked ###
system("cat bdat.px all2d_512 > out.dat")
system("sort out.dat -o tmp1.dat")
system("uniq -u tmp1.dat > out.dat")
system("rm tmp1.dat")
accVol("out.dat",2)
}



