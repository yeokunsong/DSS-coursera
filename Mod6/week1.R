#Mod 6 week1

#1
'Let m be p(mum diseased), d be p(dad diseased)

p(m & d) = .06
p(d) = .12
p(d or m or m&d) = p(d) + p(m) -p(m&d) = .17
p(m) = .17 + .06 - .12 = .11
'

#2
qunif(.75)

#3
#expected earning for both shd be the same
p*X = (1-p)*Y

Y/X = p/(1-p)

#4
#Median = 0, cus median only looks at the one or two middle-most values, which is zero or ~ zero. 

#5
x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp

sum(x*p) #3

#6
'
p(+|preg) = .75
p(-|~preg) = .52
p(preg) = .3

'
(.75*.3)/ (.75*.3+(1-.52)*.7) #0.4010695


