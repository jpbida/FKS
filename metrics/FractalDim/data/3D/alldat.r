data<-NULL
i<-1
for(conc in c(25,50,75)){
	for(rad in c(1,2,3,4)){
load(paste("F1output_test",conc,"_",rad,".dat",sep=""))
t<-glm(log(frac_data$lines[2:5])~log(1/frac_data$r[2:5]))
data$r[i]<-rad
data$c[i]<-conc
data$fdim[i]<-t$coef[2]
	i<-i+1
	}
}
