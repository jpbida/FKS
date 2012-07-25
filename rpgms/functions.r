dignum<-function(n,d){
#### Generates a d digit number from the integer n ####
## example: dignum(1,4) =  0001 ####
if(d>1){
out<-""
for(j in d:1){
out<-paste(out,((n%%10^j-n%%10^(j-1))/10^(j-1)),sep="")
}
}else{
out<-as.character(n)
}
out
}

dat_var <- function(path,n1,n2,digits,max_lines=-1){
### This function takes in a file path,maximum number of files,and the number of digits after the file name and produces one file containing the average of all the files with the variance ####
#ex: path="/data/bida/kinetics/c1/c1_2_25_", n1=0,n2=99,digits=4
# this takes the files with names "/data/bida/kinetics/c1/c1_2_25_0000 to 0099 and averages them 
# the files should not have any column names #
data.out <- NULL
var.out <- NULL
k<-0
for(i in n1:n2){
if(i ==n1){
ext<-dignum(i,digits)
file=paste(path,ext,sep="")
print(file)
if(max_lines== -1){
data.out <- read.table(file=file,sep=",")
}
else{
data.out <- read.table(file=file,sep=",",nrows=max_lines)
}
var.out <- data.out*0
### Setting up the column names ####
col_names1<-paste("col_",c(1:dim(data.out)[2]),sep="")
col_names2<-paste("var_",c(1:dim(data.out)[2]),sep="")
col_names<-c(col_names1,col_names2)
print(i)
}else{
print(i)
n <- k+2
ext<-dignum(i,digits)
file=paste(path,ext,sep="")
if(max_lines== -1){
data <- read.table(file=file,sep=",")
}else{
data <- read.table(file=file,sep=",",nrows=max_lines)
}
if(i==(n1+1)){
var.out <- ((data.out+data)/2-data.out)^2
}
print(file)
data.out <- (k+1)*data.out/(k+2)+data/(k+2)
var <- ((n*data.out+data)/(n+1)-data)^2
var.out <- var.out+var
}
k<-k+1
}
var.out <- var.out/((n2-n1)+1)
data.out <- cbind(data.out,var.out)
names(data.out)<-col_names
data.out
}


