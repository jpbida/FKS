data<-NULL
i<-1
for(conc in c(16000,32000,48000,1500,3000,4500)){
load(paste("F1output_allborder",conc,".px",sep=""))
t<-glm(log(frac_data$lines[2:5])~log(1/frac_data$r[2:5]))
data$c[i]<-conc
data$fdim[i]<-t$coef[2]
	i<-i+1
	}
data<-as.data.frame(data)
