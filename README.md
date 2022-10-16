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
 
 1. Before proceeding for gene expression we have to take a basic assumption 
Name: Arkaj Parkhe
Msc.bioinformatics(2nd year)
