#Import libraries
library("RCircos")
data("UCSC.HG38.Human.CytoBandIdeogram")
cyto.info = UCSC.HG38.Human.CytoBandIdeogram
RCircos.Set.Core.Components(cyto.info, 
                            chr.exclude=NULL, 
                            tracks.inside=10, 
                            tracks.outside=0)
RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()


cyto.info = UCSC.HG38.Human.CytoBandIdeogram
cyto.info$Name = NA
cyto.info$Stain = NA
RCircos.Set.Core.Components(cyto.info, 
                            chr.exclude=NULL, 
                            tracks.inside=10, 
                            tracks.outside=0)
chr_order = unique(cyto.info$Chromosome)

RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()

ideo = RCircos.Get.Plot.Ideogram()
ideo$BandColor = 'orange'
num = which(ideo$Chromosome == 'chrX')
ideo[num, 'BandColor'] = 'chartreuse'

num = which(ideo$Chromosome == 'chrY')
ideo[num, 'BandColor'] = 'salmon'


RCircos.Reset.Plot.Ideogram(ideo)
RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()


num = which(ideo$Chromosome == 'chr1')
ideo[num, 'ChrColor'] = 'goldenrod2'

RCircos.Reset.Plot.Ideogram(ideo)
RCircos.Set.Plot.Area()
RCircos.Chromosome.Ideogram.Plot()

library(biomaRt)
mat = read.csv("C:/Users/arkaj/OneDrive/Documents/get.csv")
rownames(mat) = make.names(mat[,1],unique = TRUE) #rownames set as unique values
mat2 = mat[,-1] #remove first column
m = useDataset('hsapiens_gene_ensembl',useMart('ensembl'))
coords = getBM(attributes=c('chromosome_name', 'start_position', 
                              'end_position', 'hgnc_symbol'),
                 filters = c('hgnc_symbol'),
                 values = list(rownames(mat)),
                 mart = m)

write.csv(coords, file = 'coords.csv') #Write to a csv file
coords$chromosome_name = paste0('chr', coords$chromosome_name)
coords$chromosome_name = factor(coords$chromosome_name, levels = chr_order)

num = which(is.na(coords$chromosome_name))
coords = coords[-num, ]

#Up features
up = which((mat2$Pvalue < 0.01) &
             (mat2$Log2FC <1))
upmat = mat2[up, ]

#Select common values 
num = which(coords$hgnc_symbol %in% rownames(upmat))
coords1 = coords[num, ]

#Plot the Circos plot
RCircos.Gene.Name.Plot(coords1, name.col=4, track.num = 2, side = "in",
                       is.sorted = F)


#Select the intersection
genes = intersect(rownames(mat2), coords$hgnc_symbol)

mat1 = mat2[genes, ] 
df = cbind.data.frame(rownames(mat1), mat1[, c(1,2,4)]) #Column bind mat1 columns
colnames(df)[1] = 'hgnc_symbol' #Change the column name 

data = merge(coords, df, by = 'hgnc_symbol') 
View(data)
data = data[,c(2,3,4,1,5,6,7)] #Rearrange the dataset
data = data[,c('chromosome_name', 'start_position',
               'end_position', 'hgnc_symbol',
               'meanTumor', 'meanControl', 'Log2FC')]

#Plot the Circos plot
RCircos.Heatmap.Plot(data, data.col = 7, track.num =  6, side = "in",
                     min.value = -0.3, max.value = 1.8, genomic.columns = 3,
                     is.sorted = F)
