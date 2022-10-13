#Reading an input cancer data file
data=read.csv("C:/Users/arkaj/OneDrive/Documents/gene2.csv",sep=",",header=T,row.names = 1)
dim(data) #check the dimension of the dataset
#Create a count per matrix of the whole dataset
cpm = data
for(i in 1:ncol(data)){
  cpm[,i]=(data[,i]/sum(data[,i]))*1000000
}
#Calculate the log value of cpm 
logcpm=log2(cpm+1)
logcpm
saveRDS(logcpm,file="logCPM.rds") #Save the log value in the form of RDS file
summary(logcpm)


#Calculate the z score
library(matrixStats) #Import MatrixStats for calculating z score
zscr = (logcpm - rowMeans(logcpm))/rowSds(as.matrix(logcpm))[row(logcpm)]
zscr


#Calculate variance using log 
variance = apply(logcpm, 1, var)
variance = sort(variance,decreasing = T)
top50 = variance[1:50]
map = zscr[names(top50),]

library(ComplexHeatmap) #Import ComplexHeatmap to plot the Heatmap of the z score values
Heatmap(map)
