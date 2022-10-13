#To identify genes which are differential in tumor vs control samples

logcpm=readRDS("logCPM.rds")
head(logcpm)
dim(logcpm)
mat=matrix(NA,ncol=9,nrow = nrow(logcpm))
rownames(mat)=rownames(logcpm)
colnames(mat)=c('meanTumor','meanControl','pvalue','log2FC')

for(i in 1:nrow(logcpm)){
  vector1 = as.numeric(logcpm[i, 1:7])
  
  vector2 = as.numeric(logcpm[i, 8:12])
  
  res=t.test(vector1, vector2, paired = F, alternative = "two.sided")
  mat[i,1]=res$estimate[[1]]
  mat[i,2]=res$estimate[[2]]
  mat[i,3]=res$p.value
  mat[i,4]=mat[i,1]-mat[i,2]
  
}
head(mat)

head(mat)
mat=as.data.frame(mat)
num=which(is.nan(mat$pvlue))
mat[num,'pvlue']=1
head(mat)
library(EnhancedVolcano)
EnhancedVolcano(mat,lab = rownames(mat),x = 'log2FC' ,y ='pvlue')