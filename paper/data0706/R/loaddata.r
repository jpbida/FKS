loaddat <- function(t,ifile){
data.out <- NULL
var.out <- NULL
#r<-c(0:87,89:95,97:t)
r<-c(0:t)
for(i in r){
if(i ==0){
data.out <- read.table(file=paste(ifile,"_",i,"",sep=""),sep=',',header=F)
var.out <- data.out*0
print(i)
}else{
print(i)
n <- i+2
data <- read.table(file=paste(ifile,"_",i,"",sep=""),sep=',')
if(i==1){
var.out <- ((data.out+data)/2-data.out)^2
}
data.out <- (i+1)*data.out/(i+2)+data/(i+2)
var <- ((n*data.out+data)/(n+1)-data)^2
var.out <- var.out+var
}
}
var.out <- var.out/(t+1)
data.out <- cbind(data.out,var.out)
names(data.out)<-c('time','a','b','c','sd_time','sd_a','sd_b','sd_c')
#names(data.out) <- c('time','es_col','c_dis_es.s','c_dis_es.f','es_assoc','c_dis_ep.s','c_dis_ep.f','e','s','c','p','sd_time','sd_es_col','sd_c_dis_es.s','sd_c_dis_es.f','sd_es_assoc','sd_c_dis_ep.s','sd_c_dis_ep.f','sd_e','sd_s','sd_c','sd_p')
data.out
}

dat<-loaddat(99,"../2D_LATTICE/R1_1/sim0")
write.table(dat,file="lattice2d_0_r1_1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_LATTICE/R1_1/sim20")
write.table(dat,file="lattice2d_20_r1_1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_LATTICE/R1_1/sim40")
write.table(dat,file="lattice2d_40_r1_1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_LATTICE/R1_1/sim60")
write.table(dat,file="lattice2d_60_r1_1.csv",row.names=F,col.names=F)

dat<-loaddat(99,"../2D_LATTICE/R1_10/sim10_0")
write.table(dat,file="lattice2d_0_r1_10.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_LATTICE/R1_10/sim10_20")
write.table(dat,file="lattice2d_20_r1_10.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_LATTICE/R1_10/sim10_40")
write.table(dat,file="lattice2d_40_r1_10.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_LATTICE/R1_10/sim10_60")
write.table(dat,file="lattice2d_60_r1_10.csv",row.names=F,col.names=F)

dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B2/cppA1_sim0")
write.table(dat,file="offlattice2d_0_r1_1_b2.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B2/cppA1_sim20")
write.table(dat,file="offlattice2d_20_r1_1_b2.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B2/cppA1_sim40")
write.table(dat,file="offlattice2d_40_r1_1_b2.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B2/cppA1_sim60")
write.table(dat,file="offlattice2d_60_r1_1_b2.csv",row.names=F,col.names=F)

dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B2/cppA10_sim0")
write.table(dat,file="offlattice2d_0_r1_10_b2.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B2/cppA10_sim20")
write.table(dat,file="offlattice2d_20_r1_10_b2.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B2/cppA10_sim40")
write.table(dat,file="offlattice2d_40_r1_10_b2.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B2/cppA10_sim60")
write.table(dat,file="offlattice2d_60_r1_10_b2.csv",row.names=F,col.names=F)

dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B1/cpp10_sim0")
write.table(dat,file="offlattice2d_0_r1_10_b1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B1/cpp10_sim20")
write.table(dat,file="offlattice2d_20_r1_10_b1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B1/cpp10_sim40")
write.table(dat,file="offlattice2d_40_r1_10_b1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_10_B1/cpp10_sim60")
write.table(dat,file="offlattice2d_60_r1_10_b1.csv",row.names=F,col.names=F)

dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B1/cpp1_sim0")
write.table(dat,file="offlattice2d_0_r1_1_b1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B1/cpp1_sim20")
write.table(dat,file="offlattice2d_20_r1_1_b1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B1/cpp1_sim40")
write.table(dat,file="offlattice2d_40_r1_1_b1.csv",row.names=F,col.names=F)
dat<-loaddat(99,"../2D_OFF_LATTICE/R1_1_B1/cpp1_sim60")
write.table(dat,file="offlattice2d_60_r1_1_b1.csv",row.names=F,col.names=F)

