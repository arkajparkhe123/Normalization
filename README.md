Normalization:

data file = https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE202650
cancer type = "prostate cancer"
steps:
1. I have downloaded the file GSE202650_readcounts_all.csx.gz from above file link.
2. The file column contains readcounts per gene from 12 sample patients
3. I have read data in r studio
4. Then converted data in matrix also removed row namesfrom the data 
5. Then Counted cpm value
6. Also Counted z score
7. Then I have drawn a heat map of zscore value 

HeatMapVisualization:
 We have logCPM value which is obtained from the normalization function.
 
 Now we can proceed for ZScore calculation 
 
 And we calculated variance of  z score , get top 50 variance values based on it’s descending order and then use the new variance values to print a heatmap
 
 DEG(Differential Gene Expression):
 
 1. Before proceeding for gene expression we have to take a basic assumption we split log2CPM matrix into two classes  based on sample size and consider first 7 samples are tumor class and rest samples as control class.
 
 The objective of this hypothesis is to identify genes which are differential in tumor vs control samples.
 
 2. To identify  DEG, perform t.test using vec1 amd vec2
 
    A t-test is a statistical test that is used to compare the means of two groups. It is often used in hypothesis testing to determine whether a process or treatment has an effect on the population of interest, or whether two groups are different from one another.
    
  3.calculate log2FC: log2FC = mean(vec1) - mean(vec2)
  
  4.Volcano plot: Volcano plot shows upregulated and downregulated genes. red color is for upregulated and green color is for downregulated.
  
    The horizontal axis represents the fold change between control and tumor class and the vertical axis represents the P value of t test for the differences between       control and tumor.
  
  
  
Name: Arkaj Parkhe
Msc.bioinformatics(2nd year)
