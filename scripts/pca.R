library(reticulate)
library(matrixStats)
library(ggplot2)
library(ggrepel)
library(ggthemes)


inputFile  <- commandArgs(trailingOnly=TRUE)[1]
outputFile <- commandArgs(trailingOnly=TRUE)[2] 

np <- import("numpy")
#npz1 <- np$load("bigwig_summary.npz")
npz1 <- np$load(inputFile)



m <- npz1$f[['matrix']]

threshold         <- quantile(apply(m,1,sum),0.95)
m.above.threshold <- m[apply(m,1,sum) > threshold,]


antibodies <- c("H3K27me3","H3K27me3","H3K4me3",
                "H3K4me2-me3","H3K9ac","Pol2 S2P",
                "H3K27me3","H3K4me3","H3K9ac","H3K9ac",
                "Pol2 S2P","Ctcf","Ctcf","H3K9me3","H3K9me3")
                
antibodies_codes <- c("ab6002",
                      "ab6147",
                      "ab1012",
                      "ab6000",
                      "ab12179",
                      "ab5408",
                      "ab192985",
                      "ab213224",
                      "ab32129",
                      "ab177177",
                      "ab193467",
                      "ab188408",
                      "ab128873",
                      "ab176916",
                      "ab8898")

##################################
m.zscore <- t(scale(t(m.above.threshold)))

i = 100 # Select top 100 most enriched bins for each sample
m.top.ls <- lapply(1:dim(m.zscore)[2],function(x) {
  x.top <- head(order(m.zscore[,x],decreasing=TRUE),i)
  return(m.zscore[x.top,])
})
m.pca                   <- do.call('rbind',m.top.ls)

n = 200 # Randomly sample 200 bins of the 100*nsamples bins selected
pca.out                   <- prcomp(m.pca[sample(1:dim(m.pca)[1],n),])
###################################

pca.plot          <- as.data.frame(pca.out$rotation[,1:2])
pca.plot$antibody <- antibodies
pca.plot$code     <- antibodies_codes






p <- ggplot(data = as.data.frame(pca.plot),aes(x=PC1,y=PC2)) + 
      geom_point(aes(col = antibody)) + 
      geom_label_repel(aes(label = code),force=10,max.overlaps=100) 
      
ggsave(outputFile,p)



