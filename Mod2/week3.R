#1 2
library(datasets)
data(iris)

mean(iris$Sepal.Length)

names(iris)
colMeans(iris[,1:4]) == apply(iris[,1:4],2, mean)

#3 4
library(datasets)
data(mtcars)

with(mtcars,tapply(mpg,cyl,mean))
sapply(split(mtcars$mpg,mtcars$cyl),mean)
tapply(mtcars$mpg,mtcars$cyl, mean)

dat = tapply(mtcars$hp, mtcars$cyl, mean);
round(dat[3]-dat[1],0)


# Programming assingment

## Put comments here that give an overall description of what your
## functions do

## Function to create a special "vector", which is really a list containing a function to
#-set the matrix
#-get the matrix
#-set the inverse of the matrix
#-get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(solve) m <<- solve
  getinverse <- function() m
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## Function to check if inverse is already calculated, else will calculate and cache it

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}

A <- matrix( c(5, 1, 0,
               3,-1, 2,
               4, 0,-1), nrow=3, byrow=TRUE)

#test
my_Matrix <- makeCacheMatrix(A)
my_Matrix$get()
my_Matrix$getinverse()
cacheSolve(my_Matrix)



