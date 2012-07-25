### This program was used to generate the images of the molecular crowding in 3D ###

n<-c("x","y","z")

d1_25<-read.table(file="allr1_25.px")
names(d1_25)<-n
d1<-d1_25
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30);
readline(prompt="size window")
rgl.snapshot(file="d1_25.png")
rgl.close()
d1_25<-NULL

d2_25<-read.table(file="allr2_25.px")
names(d2_25)<-n
d1<-d2_25
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d2_25.png")
rgl.close()
d2_25<-NULL


d3_25<-read.table(file="allr3_25.px")
names(d3_25)<-n
d1<-d3_25
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d3_25.png")
rgl.close()
d3_25<-NULL

d4_25<-read.table(file="allr4_25.px")
names(d4_25)<-n
d1<-d4_25
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d4_25.png")
rgl.close()
d4_25<-NULL

d1_50<-read.table(file="allr1_50.px")
names(d1_50)<-n
d1<-d1_50
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d1_50.png")
rgl.close()
d1_50<-NULL

d2_50<-read.table(file="allr2_50.px")
names(d2_50)<-n
d1<-d2_50
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d2_50.png")
rgl.close()
d2_50<-NULL

d3_50<-read.table(file="allr3_50.px")
names(d3_50)<-n
d1<-d3_50
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d3_50.png")
rgl.close()
d3_50<-NULL

d4_50<-read.table(file="allr4_50.px")
names(d4_50)<-n
d1<-d4_50
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d4_50.png")
rgl.close()
d4_50<-NULL

d1_75<-read.table(file="allr1_75.px")
names(d1_75)<-n
d1<-d1_75
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d1_75.png")
rgl.close()
d1_75<-NULL

d2_75<-read.table(file="allr2_75.px")
names(d2_75)<-n
d1<-d2_75
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d2_75.png")
rgl.close()
d2_75<-NULL

d3_75<-read.table(file="allr3_75.px")
names(d3_75)<-n
d1<-d3_75
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d3_75.png")
rgl.close()
d3_75<-NULL

d4_75<-read.table(file="allr4_75.px")
names(d4_75)<-n
d1<-d4_75
d1<-d1[d1$x>5 & d1$x<15,]
rgl.open()
particles3d(d1$x,d1$y,d1$z,radius=2)
rgl.viewpoint(90,-30,30); 
readline(prompt="size window")
rgl.snapshot(file="d4_75.png")
rgl.close()
d4_75<-NULL

