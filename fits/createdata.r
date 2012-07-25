library("scatterplot3d")
d2<-read.table(file="2DFITS.TXT",header=T)
d3<-read.table(file="3dfits.txt",header=T,sep=" ")
metrics<-read.table(file="all_data.dat",header=T)
names(d2)<-c("pct","a_b","radius","models","k1","k2","tau_eta","h_zeta","chi2","sci","det")
names(d3)<-c("radius","pct","models","k1","k2","tau_eta","h_zeta","chi2","sci","det")
d2$chi2<-as.numeric(d2$chi2)
d3$chi2<-as.numeric(d3$chi2)
d2$k1<-as.numeric(d2$k1)
d3$k1<-as.numeric(d3$k1)
d2$k2<-as.numeric(d2$k2)
d3$k2<-as.numeric(d3$k2)
all<-merge(d2,d3,by=intersect(names(d2),names(d3)),all=T)
all<-merge(all,metrics,by=intersect(names(all),names(metrics)),all=T)
all$dim[is.na(all$dim)]<-2
all$fdim[is.na(all$fdim)]<-2
all$models<-as.character(all$models)
all$a_b<-as.character(all$a_b)
all$accvol[is.na(all$accvol)]<-1
ma<-all$models=="MA/MA" & all$dim==2 & all$a_b=="1:01" 
sv<-all$models=="SV/MA" & all$dim==2 & all$a_b=="1:01" 
st<-all$models=="ST/MA" & all$dim==2 & all$a_b=="1:01" 
ms<-all$models=="ST/ST" & all$dim==2 & all$a_b=="1:01" 

svd2<-all[sv,]
mad2<-all[ma,]
std2<-all[st,]
msd2<-all[ms,]

ma<-all$models=="MA/MA" & all$dim==3
sv<-all$models=="SV/MA" & all$dim==3
st<-all$models=="ST/MA" & all$dim==3
ms<-all$models=="ST/ST" & all$dim==3

svd3<-all[sv,]
mad3<-all[ma,]
std3<-all[st,]
msd3<-all[ms,]

ma<-all$models=="MA/MA" 
sv<-all$models=="SV/MA" 
st<-all$models=="ST/MA" 
ms<-all$models=="ST/ST" 

sv<-all[sv,]
ma<-all[ma,]
st<-all[st,]
ms<-all[ms,]

### Plotting Trends in Model Parameters #####
expected<-(4/3*pi)/(100^3)
k1_3<-svd3$k1/expected
f_3<-svd3$fdim
expected<- pi/(1000^2)
k1_2<-svd2$k1/expected
f_2<-svd2$fdim

f<-c(f_2,f_3)
k1<-c(k1_2,k1_3)


fo<-order(f)
plot(f[fo],k1[fo],typ="b")

postscript(file="3dbar1.ps",paper="letter")
scatterplot3d(std3$fdim,std3$accvol,std3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="ST")
dev.off()
postscript(file="3dbar2.ps",paper="letter")
scatterplot3d(svd3$fdim,svd3$accvol,svd3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="SV")
dev.off()
postscript(file="3dbar3.ps",paper="letter")
scatterplot3d(mad3$fdim,mad3$accvol,mad3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MA")
dev.off()
postscript(file="3dbar4.ps",paper="letter")
scatterplot3d(msd3$fdim,msd3$accvol,msd3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MST")
dev.off()
postscript(file="3bar_metrics.ps",paper="letter")
par(mfrow=c(2,2))
scatterplot3d(std3$fdim,std3$accvol,std3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="ST")
scatterplot3d(svd3$fdim,svd3$accvol,svd3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="SV")
scatterplot3d(mad3$fdim,mad3$accvol,mad3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MA")
scatterplot3d(msd3$fdim,msd3$accvol,msd3$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MST")
dev.off()

postscript(file="3dbar_k2_radius.ps",paper="letter")
par(mfrow=c(2,2))
scatterplot3d(std3$radius,std3$pct_vol,std3$k2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(svd3$radius,svd3$pct_vol,svd3$k2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(mad3$radius,mad3$pct_vol,mad3$k2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(msd3$radius,msd3$pct_vol,msd3$k2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
dev.off()

postscript(file="3dbar_k1_radius.ps",paper="letter")
par(mfrow=c(2,2))
scatterplot3d(std3$radius,std3$pct_vol,std3$k1,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(svd3$radius,svd3$pct_vol,svd3$k1,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(mad3$radius,mad3$pct_vol,mad3$k1,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(msd3$radius,msd3$pct_vol,msd3$k1,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
dev.off()

postscript(file="3dbar_radius.ps",paper="letter")
par(mfrow=c(2,2))
scatterplot3d(std3$radius,std3$pct_vol,std3$chi2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(svd3$radius,svd3$pct_vol,svd3$chi2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(mad3$radius,mad3$pct_vol,mad3$chi2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
scatterplot3d(msd3$radius,msd3$pct_vol,msd3$chi2,typ="h",lwd=1,pch=5,xlab="radius",ylab="% crowding",zlab="ChiSq")
dev.off()
postscript(file="2dbar1.ps",paper="letter")
scatterplot3d(std2$fdim,std2$accvol,std2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="ST",angle=60,lab.z=3)
dev.off()
postscript(file="2dbar2.ps",paper="letter")
scatterplot3d(svd2$fdim,svd2$accvol,svd2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="SV",angle=60)
dev.off()
postscript(file="2dbar3.ps",paper="letter")
scatterplot3d(mad2$fdim,mad2$accvol,mad2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MA",angle=60)
dev.off()
postscript(file="2dbar4.ps",paper="letter")
scatterplot3d(msd2$fdim,msd2$accvol,msd2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MST",angle=60)
dev.off()

postscript(file="2bar_metrics.ps",paper="letter")
par(mfrow=c(2,2))
scatterplot3d(std2$fdim,std2$accvol,std2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="ST",lab.z=2)
scatterplot3d(svd2$fdim,svd2$accvol,svd2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="SV",lab.z=2)
scatterplot3d(mad2$fdim,mad2$accvol,mad2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MA",lab.z=2)
scatterplot3d(msd2$fdim,msd2$accvol,msd2$chi2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MST",lab.z=2)
dev.off()

postscript(file="3bar_k1.ps",paper="letter")
par(mfrow=c(2,2))
clr<-tim.colors()[round(5.8*(6+log(std3$chi2)))]
scatterplot3d(std3$fdim,std3$accvol,log(std3$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k1)",main="ST",lab.z=2,color=clr)
clr<-tim.colors()[round(5.8*(6+log(svd3$chi2)))]
scatterplot3d(svd3$fdim,svd3$accvol,log(svd3$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k1)",main="SV",lab.z=2,color=clr)
clr<-tim.colors()[round(5.8*(6+log(mad3$chi2)))]
scatterplot3d(mad3$fdim,mad3$accvol,log(mad3$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k1)",main="MA",lab.z=2,color=clr)
clr<-tim.colors()[round(5.8*(6+log(msd3$chi2)))]
scatterplot3d(msd3$fdim,msd3$accvol,log(msd3$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k1)",main="MST",lab.z=2,color=clr)
dev.off()

postscript(file="3bar_k2.ps",paper="letter")
par(mfrow=c(2,2))
clr<-tim.colors()[round(5.8*(6+log(std3$chi2)))]
scatterplot3d(std3$fdim,std3$accvol,log(std3$h_zeta),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k2)",main="ST",lab.z=2,color=clr)
clr<-tim.colors()[round(5.8*(6+log(svd3$chi2)))]
scatterplot3d(svd3$fdim,svd3$accvol,log(svd3$k2),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k2)",main="SV",lab.z=2,color=clr)
clr<-tim.colors()[round(5.8*(6+log(mad3$chi2)))]
scatterplot3d(mad3$fdim,mad3$accvol,log(mad3$k2),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k2)",main="MA",lab.z=2,color=clr)
clr<-tim.colors()[round(5.8*(6+log(msd3$chi2)))]
scatterplot3d(msd3$fdim,msd3$accvol,log(msd3$k2),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="log(k2)",main="MST",lab.z=2,color=clr)
dev.off()

postscript(file="2bar_k1.ps",paper="letter")
par(mfrow=c(2,2))
scatterplot3d(std2$fdim,std2$accvol,log(std2$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="ST",lab.z=2)
scatterplot3d(svd2$fdim,svd2$accvol,log(svd2$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="SV",lab.z=2)
scatterplot3d(mad2$fdim,mad2$accvol,log(mad2$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MA",lab.z=2)
scatterplot3d(msd2$fdim,msd2$accvol,log(msd2$k1),typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MST",lab.z=2)
dev.off()

postscript(file="2bar_k2.ps",paper="letter")
par(mfrow=c(2,2))
scatterplot3d(std2$fdim,std2$accvol,std2$k2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="ST",lab.z=2)
scatterplot3d(svd2$fdim,svd2$accvol,svd2$k2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="SV",lab.z=2)
scatterplot3d(mad2$fdim,mad2$accvol,mad2$k2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MA",lab.z=2)
scatterplot3d(msd2$fdim,msd2$accvol,msd2$k2,typ="h",lwd=3,pch=5,xlab="fractal dimension",ylab="accessible volume",zlab="Chi^2",main="MST",lab.z=2)
dev.off()
