#for programming assignment

#download file
FILEPATH= "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
temp = tempfile()
download.file(FILEPATH,temp)
unzip(temp)
unlink(temp)

#
#
#set pollutantmean
#
#
pollutantmean = function(directory, pollutant, id = 1:332) {
  #set root path
  path = paste0(getwd(),"/", directory)
  
  #set helper function for file name
  padzero = function (i) {
    if (i<10) {i = paste0("/00",i)}
    else if (i<100) {i = paste0("/0",i)}
    else {i = paste0("/",i)}
    return (i)
  }
  
  #set variable to store selected file data
  dat = c()
  
  #read selected file data
  for (file in id) {
    file = padzero(file)
    df = read.csv(paste0(path,file,".csv"))
    df = df[,pollutant]
    dat = c(dat,df)
  }
  
  #get mean
  return(mean(dat,na.rm=1))
}

#
#
#set complete
#
#
complete = function(directory, id = 1:332) {
  #set root path
  path = paste0(getwd(),"/", directory)
  
  #set helper function for file name
  padzero = function (i) {
    if (i<10) {i = paste0("/00",i)}
    else if (i<100) {i = paste0("/0",i)}
    else {i = paste0("/",i)}
    return (i)
  }
  
  #set variable to store selected file data
  dat = data.frame()
  
  #read selected file data
  for (file in id) {
    file2 = padzero(file)
    df = read.csv(paste0(path,file2,".csv"))
    df = data.frame (id = file,
                     nobs = sum(complete.cases(df))
                     )
    dat = rbind(dat,df)
  }
  
  return(dat)
}

#
#
# corr
#
#
corr = function(directory, threshold = 0) {
  #set root path
  path = paste0(getwd(),"/", directory)
  
  #set helper function for file name
  padzero = function (i) {
    if (i<10) {i = paste0("/00",i)}
    else if (i<100) {i = paste0("/0",i)}
    else {i = paste0("/",i)}
    return (i)
  }
  
  #set variable to store selected file data
  dat = c()
  
  #read selected file data
  for (file in 1:332) {
    file2 = padzero(file)
    df = read.csv(paste0(path,file2,".csv"))
    
    if(sum(complete.cases(df))<threshold){
      df = c()
    } else {
      df = df[complete.cases(df),2:3]
      df = cor(df$nitrate,df$sulfate)
      }
    
    dat = c(dat,df)
  }
  
  return(dat)
}

#for programming quiz
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310)); print(cc$nobs)
cc <- complete("specdata", 54); print(cc$nobs)
RNGversion("3.5.1");set.seed(42);cc <- complete("specdata", 332:1);use <- sample(332, 10);print(cc[use, "nobs"])
cr <- sort(corr("specdata"));RNGversion("3.5.1");set.seed(868);out <- round(cr[sample(length(cr), 5)], 4);print(out)
cr <- corr("specdata", 129);cr <- sort(cr);n <- length(cr);RNGversion("3.5.1");set.seed(197);out <- c(n, round(cr[sample(n, 5)], 4));print(out)
cr <- corr("specdata", 2000);n <- length(cr);cr <- corr("specdata", 1000);cr <- sort(cr);print(c(n, round(cr, 4)))

