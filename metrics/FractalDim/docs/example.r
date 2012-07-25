source("functions.r")
#### This will output the data as an R object to the file F1output_2dslot ####
data<-fdim("./test2d_slot.dat","2dslot",0.976,1000)

#### The data is also returned by the function ####
#### The dataset contains the columns ###
# n, r,total_pixels #
# n = number of pixels covering the fractal object
# r = size of the pixel side
plot(log(data$n),log(1/data$r))

