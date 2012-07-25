loaddat <- function(t,filename,ext){
data.out <- NULL
var.out <- NULL
for(i in 0:t){
if(i ==0){
data.out <- read.table(file=paste(filename,(i%%10000-i%%1000)/1000,(i%%1000-i%%100)/100,(i%%100-i%%10)/10,(i%%10),ext,sep=''),sep=',')
plot(data.out[,1],data.out[,4],ylim=c(0,50),type="l")
var.out <- data.out*0
print(i)
}else{
print(i)
n <- i+2
data <- read.table(file=paste(filename,(i%%10000-i%%1000)/1000,(i%%1000-i%%100)/100,(i%%100-i%%10)/10,(i%%10),ext,sep=''),sep=',')
points(data[,1],data[,4],type="l")
if(i==1){
var.out <- ((data.out+data)/2-data.out)^2
}

print(paste('data',(i%%10000-i%%1000)/1000,(i%%1000-i%%100)/100,(i%%100-i%%10)/10,(i%%10),'.csv',sep=''))

data.out <- (i+1)*data.out/(i+2)+data/(i+2)

var <- ((n*data.out+data)/(n+1)-data)^2
var.out <- var.out+var

}
}
var.out <- var.out/(t+1)
data.out <- cbind(data.out,var.out[,2:4])
names(data.out) <- c('time','A','B','C','sd_a','sd_b','sd_c')
points(data.out[,1],(sqrt(data.out[,7])+data.out[,4]),lty=3,col=2,type='l')
points(data.out[,1],(-sqrt(data.out[,7])+data.out[,4]),lty=3,col=2,type='l')
data.out
}

#dat1 <- loaddat(9,'../sim1/dat1_','')
#dat2 <- loaddat(9,'../sim1/dat2_','')
#dat3 <- loaddat(9,'../sim1/dat3_','')
#dat4 <- loaddat(9,'../sim1/dat4_','')
#dat5 <- loaddat(9,'../sim1/dat5_','')
#dat6 <- loaddat(9,'../sim1/dat6_','')




