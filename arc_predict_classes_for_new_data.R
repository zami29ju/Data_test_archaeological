

library(Momocs)

## setting file name in the R directory
images_folder <- "test_data_arc_01//grain_images"
image_filenames <- list.files (images_folder, full.names = T)

## Importing data
data <- import_jpg(image_filenames, threshold = 0.9)

## Setting data into R prescribed format
data <- Out(data)
data$

## Checking data whether it imported properly
panel(data)
stack(data)
modernOut.l%>% coo_center() %>% coo_align() %>% coo_scale() %>%
  coo_slidedirection("down") %>% stack()
## Importing additional file for image description; It can be done in two ways
image_description_csv_file_path <- list.files('test_data_arc_01//CSV_file', full.names = T)
arc_rice <- read.csv(image_description_csv_file_path)


#Checking data table structure whether it uploads properly
str(arc_rice)
arc_rice

#adding csv. file to the  momocs main data file; data=main data file of jpeg; arc_rice=imported+
#csv. file
data$fac <- arc_rice
##Checking final data file
data

## Filtering all dorsal/lateral/shape (to efourier and then PCA and LDA)
modernOut.l <- data 

#Effourier transformation by Lateral/Dorsal/Polar
modernOut.l.fourier <- efourier(modernOut.l, nb.h =8,norm=FALSE, start = TRUE)

# To write the efourier coefficients in an output CSV file
modernOut.l.fourier$coe
write.csv(modernOut.l.fourier$coe,'Outputs\\coefs.csv')

# TESTING
train_PCA <- readRDS("Outputs//trained_L_PCA.rds")
train_LDA <- readRDS("Outputs//trained_L_LDA.rds")

# we redo PCA with saved train_PCA
test_PCA <- rePCA(train_PCA, modernOut.l.fourier)

# then we perform reLDA on test_PCA data using train_LDA
test_LDA <- reLDA(test_PCA, train_LDA)
test_LDA$class
test_LDA$x
test_LDA$posterior
write.csv(test_LDA$posterior, 'posterior.csv')
write.csv(test_LDA$class, 'Outputs\\output_classes.csv')
