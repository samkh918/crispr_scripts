library(datasets)
#data("crispr")
library(ggplot2)
library(readr)
library(reshape2)
library(RColorBrewer)

# Created by: Sam Khalouei
# Creating the Boxplot showing the files sizes in each batch for both Primary Filtered and after excluding variants observed in 3 or more samples

pdf("CrisprBatches_SecondaryFilters_ExclVarsIn3orMoreSamples_Boxplot.pdf")

crispr <- read.csv("boxplot_numvar_input_excludeVarsIn3orMoreSamples_perbatch.txt")
colnames(crispr) <-c("sample","NumVariants","Batch","Filter_Status")
crispr$Filter_Status <- ordered(crispr$Filter_Status, levels = c("PrimaryFiltered","ExcludeVars_in3orMore_samples"))
head(crispr)

p10 <- ggplot(crispr, aes(x = Batch, y = NumVariants, fill = Filter_Status)) +
        geom_boxplot(alpha=0.7) +
        scale_y_continuous(name = "Number of Variants",
                           breaks = seq(0, 40000, 5000),
                           limits=c(0, 40000)) +
        scale_x_discrete(name = "Batch") +
        ggtitle("Number of Variants in Filtered and Unfiltered VCF files") +
        theme_bw() + 
        theme(axis.text=element_text(size=14),
                axis.title=element_text(size=16,face="bold"))
        #theme(plot.title = element_text(size = 14, family = "Tahoma", face = "bold"),
        #      text = element_text(size = 12, family = "Tahoma"),
        #      axis.title = element_text(face="bold"),
        #      axis.text.x=element_text(size = 11)) +
        #scale_fill_brewer(palette = "Accent")
p10
