library(matrixStats)
library(ComplexHeatmap)

can=readRDS('logCPM.rds')

function2=function(can){ 
  for(i in 1:nrow(can)){
    z_score = (can - rowMeans(can))/rowSds(as.matrix(can))[row(can)]
  }
  
  z_score[is.na(z_score)]=0 
  zcs = as.matrix(z_score) 
  return(Heatmap(zcs[1:10])) 
} 
function2(can)

pdf('ZScore.pdf',width = 10,height = 10)

plot(1:5,pch=20)

dev.off()