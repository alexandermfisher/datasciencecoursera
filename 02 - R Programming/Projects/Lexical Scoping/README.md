## Project 2: Lexical Scoping

This is the second project in the R Prgramming course. It explores lexical scoping in R by creating two functions. The two functions can be found in makeCacheMatrix.R. The goal is two write a pair of functions that cache the inverse of a matrix. 

### Function 1:

makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.

```r
makeCacheMatrix <- function(x=matrix()){
        inv <- NULL
        set <- function(y){
                x <<- y
                inv <<- NULL
        }
        get <- function() {x}
        setInverse <- function(inverse) {inv <<- inverse}
        getInverse <- function() {inv}
        list(set=set, get=get, setInverse=setInverse, getInverse=getInverse)
}
```

### Function 2:

cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.


```r
cacheSolve <- function(x, ...){
        inv <- x$getInverse()
        if (!is.null(inv)){
                message("getting cached data")
                return(inv)
        }
        mat <- x$get()
        inv <- solve(mat, ...)
        x$setInverse(inv)
        inv
}
```

