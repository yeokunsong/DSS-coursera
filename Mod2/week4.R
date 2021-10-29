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
  dat = dat[dat$State == state,c(2,outcomeCol)] #col2 is Hospital
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

#4
rankall = function(outcome, num = "best") {
  dat = read.csv("outcome-of-care-measures.csv")
  for (i in c(11,17,23)) {
    dat[,i] = suppressWarnings(as.numeric(dat[,i]))
  }
  
  #check valid outcome
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {stop("invalid outcome")}
  
  #map to col no
  if (outcome == "heart attack") {outcomeCol = 11}
  if (outcome == "heart failure") {outcomeCol = 17}
  if (outcome == "pneumonia") {outcomeCol = 23}
  
  #split by state, sort by outcome & hospital name, 
  #then extract hospital with nth ranking
  dat = dat[,c(7,2,outcomeCol)] #col7 is state, col2 is hospital
  dat = split(dat, dat$State)
  dat = lapply(dat, function(x,num){
    x = x[!is.na(x[,3]),]
    x = x[order(x[,3], x[,2]),] #sort by outcome then hospital
    
        #convert num to numeric
        if (num == "best") {num = 1}
        if (num == "worst") {num = nrow(x)}
    
    
    return (x[num,c(2,1)])
    },num)
  
  #convert list to dataframe, https://stackoverflow.com/questions/4227223/convert-a-list-to-a-data-frame
  dat = do.call(rbind.data.frame, dat)
  names(dat) = c('hospital','state')
  return (dat) 
}
# head(rankall("heart attack", 20), 10)
# tail(rankall("pneumonia", "worst"), 3)
# tail(rankall("heart failure"), 10)

# Quiz
best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")
rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)