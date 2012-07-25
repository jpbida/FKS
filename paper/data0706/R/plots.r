slope <- function(x){
out <- c(0,diff(x))
}

ks<-function(data){
E <- data[,8]/1000000
S <- data[,9]/1000000
C <- data[,10]/1000000
P <- data[,11]/1000000

dPdt <- slope(P)
dEdt <- slope(E)
dSdt <- slope(S)
dCdt <- slope(C)
k2 <- dPdt/C
k1 <- (dPdt-dEdt)/(E*S)
k1n <- (dSdt+k1*(E*S))/C

postscript(file="constants.ps")
par(mfrow=c(3,1))
plot(data[,1],k1n)
plot(data[,1],k1)
plot(data[,1],k2)
dev.off()
}

files<-c(
"lattice2d_0_r1_1.csv"
,"lattice2d_0_r1_10.csv"
,"lattice2d_20_r1_1.csv"
,"lattice2d_20_r1_10.csv"
,"lattice2d_40_r1_1.csv"
,"lattice2d_40_r1_10.csv"
,"lattice2d_60_r1_1.csv"
,"lattice2d_60_r1_10.csv"
,"offlattice2d_0_r1_10_b1.csv"
,"offlattice2d_0_r1_10_b2.csv"
,"offlattice2d_0_r1_1_b1.csv"
,"offlattice2d_0_r1_1_b2.csv"
,"offlattice2d_20_r1_10_b1.csv"
,"offlattice2d_20_r1_10_b2.csv"
,"offlattice2d_20_r1_1_b1.csv"
,"offlattice2d_20_r1_1_b2.csv"
,"offlattice2d_40_r1_10_b1.csv"
,"offlattice2d_40_r1_10_b2.csv"
,"offlattice2d_40_r1_1_b1.csv"
,"offlattice2d_40_r1_1_b2.csv"
,"offlattice2d_60_r1_10_b1.csv"
,"offlattice2d_60_r1_10_b2.csv"
,"offlattice2d_60_r1_1_b1.csv"
,"offlattice2d_60_r1_1_b2.csv"
)


for(f in files){
t<-strsplit(f,".csv")
print(t[[1]])[1]
t<-t[[1]]
dat<-read.table(file=f,sep=" ",header=F)
assign(t,dat)
}

#par(mfrow=c(3,2))

postscript(file="C_r1_1_lattice.ps",paper="letter")
plot(lattice2d_0_r1_1[,1],lattice2d_0_r1_1[,10],ylim=c(0,600),col=1,type="l")
points(lattice2d_0_r1_1[,1],lattice2d_20_r1_1[,10],col=2,type="l")
points(lattice2d_0_r1_1[,1],lattice2d_40_r1_1[,10],col=3,type="l")
points(lattice2d_0_r1_1[,1],lattice2d_60_r1_1[,10],col=4,type="l")

#points(lattice2d_0_r1_1[,1],(lattice2d_0_r1_1[,10]+sqrt(lattice2d_0_r1_1[,21])),col=1,type="l",lty=2)
#points(lattice2d_0_r1_1[,1],(lattice2d_0_r1_1[,10]-sqrt(lattice2d_0_r1_1[,21])),col=1,type="l",lty=2)
#points(lattice2d_0_r1_1[,1],(lattice2d_20_r1_1[,10]+sqrt(lattice2d_20_r1_1[,21])),col=2,type="l",lty=2)
#points(lattice2d_0_r1_1[,1],(lattice2d_20_r1_1[,10]-sqrt(lattice2d_20_r1_1[,21])),col=2,type="l",lty=2)
#points(lattice2d_0_r1_1[,1],(lattice2d_40_r1_1[,10]+sqrt(lattice2d_40_r1_1[,21])),col=3,type="l",lty=2)
#points(lattice2d_0_r1_1[,1],(lattice2d_40_r1_1[,10]-sqrt(lattice2d_40_r1_1[,21])),col=3,type="l",lty=2)
#points(lattice2d_0_r1_1[,1],(lattice2d_60_r1_1[,10]+sqrt(lattice2d_60_r1_1[,21])),col=4,type="l",lty=2)
#points(lattice2d_0_r1_1[,1],(lattice2d_60_r1_1[,10]-sqrt(lattice2d_60_r1_1[,21])),col=4,type="l",lty=2)
dev.off()


postscript(file="C_r1_10_lattice.ps",paper="letter")
plot(lattice2d_0_r1_10[,1],lattice2d_0_r1_10[,10],ylim=c(0,100),col=1,type="l")
points(lattice2d_0_r1_10[,1],lattice2d_20_r1_10[,10],col=2,type="l")
points(lattice2d_0_r1_10[,1],lattice2d_40_r1_10[,10],col=3,type="l")
points(lattice2d_0_r1_10[,1],lattice2d_60_r1_10[,10],col=4,type="l")

dev.off()


postscript(file="C_r1_1_offlatticeb1.ps",paper="letter")
plot(offlattice2d_0_r1_1_b1[,1],offlattice2d_0_r1_1_b1[,4],ylim=c(0,600),col=1,type="l")
points(offlattice2d_0_r1_1_b1[,1],offlattice2d_20_r1_1_b1[,4],col=2,type="l")
points(offlattice2d_0_r1_1_b1[,1],offlattice2d_40_r1_1_b1[,4],col=3,type="l")
points(offlattice2d_0_r1_1_b1[,1],offlattice2d_60_r1_1_b1[,4],col=4,type="l")

dev.off()


postscript(file="C_r1_10_offlatticeb1.ps",paper="letter")
plot(offlattice2d_0_r1_10_b1[,1],offlattice2d_0_r1_10_b1[,4],ylim=c(0,100),col=1,type="l")
points(offlattice2d_0_r1_10_b1[,1],offlattice2d_20_r1_10_b1[,4],col=2,type="l")
points(offlattice2d_0_r1_10_b1[,1],offlattice2d_40_r1_10_b1[,4],col=3,type="l")
points(offlattice2d_0_r1_10_b1[,1],offlattice2d_60_r1_10_b1[,4],col=4,type="l")

dev.off()

postscript(file="C_r1_10_offlatticeb2.ps",paper="letter")
plot(offlattice2d_0_r1_10_b2[,1],offlattice2d_0_r1_10_b2[,4],ylim=c(0,20),col=1,type="l")
points(offlattice2d_0_r1_10_b2[,1],offlattice2d_20_r1_10_b2[,4],col=2,type="l")
points(offlattice2d_0_r1_10_b2[,1],offlattice2d_40_r1_10_b2[,4],col=3,type="l")
points(offlattice2d_0_r1_10_b2[,1],offlattice2d_60_r1_10_b2[,4],col=4,type="l")

dev.off()

postscript(file="C_r1_1_offlatticeb2.ps",paper="letter")
plot(offlattice2d_0_r1_1_b2[,1],offlattice2d_0_r1_1_b2[,4],ylim=c(0,60),col=1,type="l")
points(offlattice2d_0_r1_1_b2[,1],offlattice2d_20_r1_1_b2[,4],col=2,type="l")
points(offlattice2d_0_r1_1_b2[,1],offlattice2d_40_r1_1_b2[,4],col=3,type="l")
points(offlattice2d_0_r1_1_b2[,1],offlattice2d_60_r1_1_b2[,4],col=4,type="l")

dev.off()
