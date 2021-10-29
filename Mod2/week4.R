#programming assignment

#downloadfile
FILEPATH="https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
temp=tempfile()
download.file(FILEPATH,temp)
unzip(temp);unlink(temp)

#1
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

#2
best = function(state, outcome) {
  dat = read.csv("outcome-of-care-measures.csv")
  for (i in c(11,17,23)) {
    dat[,i] = suppressWarnings(as.numeric(dat[,i]))
  }
  
  #check valid state and valid outcome
  if (!(state %in% dat$State)) {stop("invalid state")}
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {stop("invalid outcome")}
  
  #map to col no
  if (outcome == "heart attack") {outcomeCol = 11}
  if (outcome == "heart failure") {outcomeCol = 17}
  if (outcome == "pneumonia") {outcomeCol = 23}

  #select only state, outcome & hospital, 
  #then extract hospital with lowest metric,
  #then sort hospitals and extract first one
  dat = dat[dat$State == state,c(2,outcomeCol)]
  dat = dat[dat[,2]== min(dat[,2],na.rm = 1),]
  dat = sort(dat[,1])[1]
  
  return (dat)
  
}

#3
rankhospital = function(state, outcome, num = "best") {
  dat = read.csv("outcome-of-care-measures.csv")
  for (i in c(11,17,23)) {
    dat[,i] = suppressWarnings(as.numeric(dat[,i]))
  }
  
  #check valid state and valid outcome
  if (!(state %in% dat$State)) {stop("invalid state")}
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {stop("invalid outcome")}
  
  #map to col no
  if (outcome == "heart attack") {outcomeCol = 11}
  if (outcome == "heart failure") {outcomeCol = 17}
  if (outcome == "pneumonia") {outcomeCol = 23}
  
  #select only state, outcome & hospital, 
  #then extract hospital with nth ranking,
  #then sort hospitals and extract first one
  dat = dat[dat$State == state,c(2,outcomeCol)]
  dat = dat[order(dat[,2], dat[,1]),]
  dat = dat[!is.na(dat[,2]),]
  
      #convert num to numeric
      if (num == "best") {num = 1}
      if (num == "worst") {num = nrow(dat)}
  
      #return na if num > total ranked hospital
      if(num > nrow(dat)) {return ("NA")}
  
  dat = dat[num,1]
  
  
  return (dat)
  
}

