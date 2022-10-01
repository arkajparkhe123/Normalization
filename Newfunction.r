library(ComplexHeatmap)
library(matrixStats)
v = read.csx("C:/Users/arkaj/OneDrixe/Documents/GSE202650_readcounts_all.csx.gz",sep=",",header=T,row.names = 1)
v = v[,-1]
  
heat=function(x){
    d=x
    for (i in 1:ncol(x)) {
      d[,i] = (x[,i]/sum(x[,i]))*1000000
      print(head(d))
      d[,i]= log2(d[,i] +1)
      logfc=log2(d+1)
    }
    d1= d
    for (i in 1:ncol(d)){
      z_scr = (d - rowMeans(d))/rowSds(as.matrix(d))[row(d)]
      
    }
    z_scr[is.na(z_scr)]=0
    zcs = as.matrix(z_scr)
    return(Heatmap(zcs[1:10]))
    
  }

heat(x)

