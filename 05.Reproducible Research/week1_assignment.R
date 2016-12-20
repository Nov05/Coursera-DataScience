##############################################################
# Coursera: Reproducible Research
# Week 1: Concepts, Ideas, & Structure
# Assignment
##############################################################
# Instructions
##############################################################
# We are conducting research on the ways that people use data
# analysis and data science tools. Your participation in this 
# non-graded and completely optional peer assessment will be 
# part of that research. We will not collect any personally 
# identifiable information about you for the purposes of this 
# research and only aggregated totals of responses to questions 
# will be reported. The potential risks to you are small. 
# The potential benefits to the community of data scientists, 
# developers, and professors are very high – we will be able 
# to figure out which methods work and which methods do not. 
# These two plotting exercises are 100% optional and will 
# not have any influence whatsoever on your grade in the class. 
# Thanks for considering helping us learn about data science!
#     
# Jeff + Roger + Brian
##############################################################
# Review criteria
##############################################################
# Instructions:
#     
#     To practice the plotting techniques you have learned 
#     so far, you will be making a graphic that explores 
#     relationships between variables. This practice is useful 
#     since we will later cover creating reproducible graphics 
#     in this class. You will be looking at a subset of a 
#     United States medical expenditures dataset with information 
#     on costs for different medical conditions and in different 
#     areas of the country.
# 
# You should do the following:
#     
#     1. Make a plot that answers the question: what is the 
#     relationship between mean covered charges 
#     (Average.Covered.Charges) and mean total payments 
#     (Average.Total.Payments) in New York?
#     
#     2. Make a plot (possibly multi-panel) that answers the 
#     question: how does the relationship between mean covered 
#     charges (Average.Covered.Charges) and mean total payments 
#     (Average.Total.Payments) vary by medical condition 
#     (DRG.Definition) and the state in which care was received 
#     (Provider.State)?
#     
# Use only the base R graphics system (not ggplot2 or lattice) 
# to make your figure.
# 
# Please submit 
# (1) R code that creates your plots, 
# (2) a single pdf for plot 1 and 
# (3) a single pdf for plot 2. 
# You will be graded on whether you answered the questions 
# and a number of features describing the clarity of the plots 
# including axis labels, figure legends, figure captions, and 
# plots. For guidelines on how to create production quality 
# plots see Chapter 10 of the Elements of Data Analytic Style 
# (https://www.dropbox.com/s/rybd14gq60jzira/edas_chapter10.pdf?dl=0)
# 
# To make the plots use the data in the attached .csv file. 
# These data are a processed version of the data from the site: 
# https://data.cms.gov/Medicare/Inpatient-Prospective-Payment-System-IPPS-Provider/97k6-zzx3
# 
# payments.csv
# https://d18ky98rnyall9.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1482278400&Signature=JN2VCajQYJpBW1R4XDol7HtwUevC1q-EO3II7X-C928JjBbYg4N2pXQuTvzj~FdYUpdsmc2Su7dScNf~pv9Lac7N5CMP9fQRwbs2Vu4Cv4V3SNUmOiPWmGIjBNnHSCLDCVUMDX~-VpH2yUVYkL4btxjQPqNIsYyy~9A8beiq1lQ_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A
##############################################################

mypath <- "./data/week1_payments.csv"
mydf <- read.csv(mypath)
dim(mydf) ## [1] 6401   12
names(mydf)
#  [1] "DRG.Definition"                       "Provider.Id"                         
#  [3] "Provider.Name"                        "Provider.Street.Address"             
#  [5] "Provider.City"                        "Provider.State"                      
#  [7] "Provider.Zip.Code"                    "Hospital.Referral.Region.Description"
#  [9] "Total.Discharges"                     "Average.Covered.Charges"             
# [11] "Average.Total.Payments"               "Average.Medicare.Payments"  

##############################################################
#     1. Make a plot that answers the question: what is the 
#     relationship between mean covered charges 
#     (Average.Covered.Charges) and mean total payments 
#     (Average.Total.Payments) in New York?
##############################################################
summary(mydf$Provider.State)
#   CA   FL   IL   NY   PA   TX 
# 1514  972  743  933  808 1431 
mydf2 <- mydf[mydf$Provider.State == "NY", ]
dim(mydf2)
# [1] 933  12

pdf("week1_assignment_plot1.pdf", width = 8, height = 8)
plot(mydf2$Average.Covered.Charges, mydf2$Average.Total.Payments, 
     pch = 1, cex = 0.5,
     main = "Plot 1 Relationship between Mean Covered Charges 
             and Mean Total Payments in New York",
     xlab = "Mean Covered Charges",
     ylab = "Mean Total Payments")
abline(lm(data = mydf2,
          formula = Average.Total.Payments~Average.Covered.Charges),
       col = "green")
dev.off()

##############################################################
#     2. Make a plot (possibly multi-panel) that answers the 
#     question: how does the relationship between mean covered 
#     charges (Average.Covered.Charges) and mean total payments 
#     (Average.Total.Payments) vary by medical condition 
#     (DRG.Definition) and the state in which care was received 
#     (Provider.State)?
##############################################################
summary(mydf$DRG.Definition)
# 194 - SIMPLE PNEUMONIA & PLEURISY W CC 
# 1075 
# 292 - HEART FAILURE & SHOCK W CC 
# 1077 
# 392 - ESOPHAGITIS, GASTROENT & MISC DIGEST DISORDERS W/O MCC 
# 1069 
# 641 - MISC DISORDERS OF NUTRITION,METABOLISM,FLUIDS/ELECTROLYTES W/O MCC 
# 1040 
# 690 - KIDNEY & URINARY TRACT INFECTIONS W/O MCC 
# 1087 
# 871 - SEPTICEMIA OR SEVERE SEPSIS W/O MV 96+ HOURS W MCC 
# 1053 

summary(mydf$Provider.State)
#   CA   FL   IL   NY   PA   TX 
# 1514  972  743  933  808 1431 

##############################################################
# Method 1
par(mfrow = c(1, 2))
plot(mydf$Average.Covered.Charges,
     mydf$Average.Total.Payments,
     # pch = 1, cex = 0.1,
     pch = ".",
     col = c("black", "red", "yellow", "blue", "green", "orange")[mydf$DRG.Definition],
     main = "Plot 2.1 By DRG.Definition",
     xlab = "Average.Covered.Charges",
     ylab = "Average.Total.Payments")
legend("topleft", legend = levels(mydf$DRG.Definition),
       cex = 0.6,
       col = c("black", "red", "yellow", "blue", "green", "orange"),
       pch = 16)

par(new)
plot(mydf$Average.Covered.Charges,
     mydf$Average.Total.Payments,
     # pch = 1, cex = 0.1,
     pch = ".",
     col = c("black", "red", "yellow", "blue", "green", "orange")[mydf$Provider.State],
     main = "Plot 2.2 By Provider.State",
     xlab = "Average.Covered.Charges",
     ylab = "Average.Total.Payments")
legend("topleft", legend = levels(mydf$Provider.State),
       cex = 1,
       col = c("black", "red", "yellow", "blue", "green", "orange"),
       pch = 16)

##############################################################
# Method 2
state.levels <- levels(mydf$Provider.State)
drg.levels <- levels(mydf$DRG.Definition)
drg.num <- length(drg.levels)
cols <- rainbow(length(drg.levels))

pdf("week1_assignment_plot2.pdf", width = 14, height = 14)
layout(matrix(c(1,2,3,4,5,6,7,7,7), 3, 3, byrow = TRUE))
for (i in state.levels) {
    par(new)
    mydf3 <- mydf[mydf$Provider.State == i, ]
    plot(mydf3$Average.Covered.Charges,
         mydf3$Average.Total.Payments,
         pch = 19, cex = 0.5,
         col = cols,
         main = i,
         xlab = "Mean Covered Charges",
         ylab = "Mean Total Payments")
    for (j in 1:drg.num) {
        abline(lm(data = mydf3[mydf3$DRG.Definition == drg.levels[j], ],
                  formula = Average.Total.Payments~Average.Covered.Charges),
               col = cols[j])
    }
}
plot.new()
title("Plot 2: Relationship between Mean Covered Charges and Mean Total Payments Vary 
      by Medical Condition and the State")
legend("center", ncol = 2,
       legend = levels(mydf$DRG.Definition),
       fill = cols,
       title = "Medical Conditions")
dev.off()
