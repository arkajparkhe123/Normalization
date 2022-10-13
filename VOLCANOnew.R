#To identify genes which are differential in tumor vs control samples

logcpm=readRDS("logCPM.rds") #Import the RDS logCPM file 
head(logcpm)
dim(logcpm)
mat=matrix(NA,ncol=9,nrow = nrow(logcpm)) #Create a matrix of the logcpm
rownames(mat)=rownames(logcpm)  #Set Gene id as the Rownames of empty matrix
colnames(mat)=c('meanTumor','meanControl','pvalue','log2FC') #Create 4 columns in the mat variable

#Add the Tumor and Control in the empty matrix
for(i in 1:nrow(logcpm)){
  vector1 = as.numeric(logcpm[i, 1:7])
  
  vector2 = as.numeric(logcpm[i, 8:12])
  
  res=t.test(vector1, vector2, paired = F, alternative = "two.sided")
  mat[i,1]=res$estimate[[1]] #meanTumor
  mat[i,2]=res$estimate[[2]] #meanControl
  mat[i,3]=res$p.value #add the pvalue into the matrix
  mat[i,4]=mat[i,1]-mat[i,2] # add the log2FC into the matrix
  
}
head(mat) 

head(mat)
mat=as.data.frame(mat) #convert the matrix to dataframe
num=which(is.nan(mat$pvlue)) 
mat[num,'pvlue']=1 #Convert nan to 1
head(mat)
library(EnhancedVolcano) #Plot the Volcano plot using EnhancedVolcano
EnhancedVolcano(mat,lab = rownames(mat),x = 'log2FC' ,y ='pvlue')
