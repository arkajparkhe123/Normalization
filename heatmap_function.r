#Import the required libraries
library(matrixStats) 
library(ComplexHeatmap)

#Create a function named Heat that will calculate the z score
Heat=function(var){ 
  for(i in 1:nrow(var)){
    z_score = (var - rowMeans(var))/rowSds(as.matrix(var))[row(var)]
  }
  
  z_score[is.na(z_score)]=0  #na values to 0
  zcs = as.matrix(z_score)  #convert to matrix
  return(Heatmap(zcs[1:10]))  #return the Heatmap of the matrix zcs 
} 


can=readRDS('logCPM.rds')

Heat(can) #Input can variable in the Heat function and it will return the Heatmap of the dataset

pdf('ZScore.pdf',width = 10,height = 10) #Save the Heatmap in the form of pdf

plot(1:5,pch=20)

dev.off()
