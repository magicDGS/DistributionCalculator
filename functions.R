# Function for DistributionCalculator app
# Written by D Gomez-Sanchez


#Binomial plot
bin <- function(N, p, plotLine, plotMean) {
  N <- as.numeric(N)
  p <- as.numeric(p)
  omega <- 0:N
  probs <- dbinom(omega,size=N,p=p)
  plot(omega,probs,type="p",main=substitute(paste("Binomial (N=", N, ", p=", p, ")", sep="")), xlab=expression(theta), ylab=substitute(paste("Pr(", theta, " | N, p)", sep="")))
  if(plotLine) lines(omega, probs)
  if(plotMean) {
    if(p<0.5) {coord <- N; just <- c(1,1)} else { coord <- 0; just <- c(0,1)}
    meanVal <- N*p
    varVal <- N*p*(1-p)
    text(coord, max(probs), substitute(paste(mu, "=", meanVal, "; ", sigma^2, "=", varVal)), adj=just, cex=1.5)
  }
}
#Geometric plot
geom <- function(p, plotLine, plotMean, limits) {
  p <- as.numeric(p)
  omega=0:1000
  probs <- dgeom(omega,p=p)
  plot(omega,probs,type="p",main=substitute(paste("Geometric (p=", p, ")", sep="")), xlab=expression(theta), ylab=substitute(paste("Pr(", theta, " | p)", sep="")), xlim=limits)
  if(plotLine) lines(omega, probs)
  if(plotMean) {
    coord <- limits[2];just <- c(1,1)
    meanVal <- (1-p)/p
    varVal <- (1-p)/(p^2)
    text(coord, max(probs), substitute(paste(mu, "=", meanVal, "; ", sigma^2, "=", varVal)), adj=just, cex=1.5)
  }
}
#Poisson distribution
poiss <- function(m, plotLine, plotMean, limits) {
  m <- as.numeric(m)
  omega <- 0:1000
  probs <- dpois(omega,m)
  plot(omega,probs,type="p",main=substitute(paste("Poisson (",lambda, "=", m, ")", sep="")), xlab=expression(theta), ylab=substitute(paste("Pr(", theta, " | ", lambda, ")", sep="")), xlim=limits)
  if(plotLine) lines(omega, probs)
  if(plotMean) {
    #if(p<0.5) {coord <- N; just <- c(1,1)} else { coord <- 0; just <- c(0,1)}
    range <- (m-trunc(m/2)):(m+trunc(m/2))
    if(limits[2] %in% range) {coord <- 0;just <- c(0,1)} else {coord <- limits[2];just <- c(1,1)}
    meanVal <- m
    varVal <- m
    text(coord, max(probs), substitute(paste(mu, "=", meanVal, "; ", sigma^2, "=", varVal)), adj=just, cex=1.5)
  }
}
#Exponential (density or cdf)
expon <- function(b, plotMean, limits, type) {
  b <- as.numeric(b)
  x <- seq(0.005,20,0.01)
  if(type=="dens") {
    y <- dexp(x,b)
    plot(x,y,type="l",xlab=expression(theta), ylab=substitute(paste("Pr(", theta, " | b)", sep="")),main=substitute(paste("Exponential (b=", b, ")", sep="")),xlim=limits)
  } else if(type=="cdf") {
    cdf <- pexp(x,b)
    plot(x,cdf,type="l",xlab=expression(x), ylab=expression(F(x)),main=substitute(paste("Exponential (b=", b, ")", sep="")),xlim=limits, ylim=c(0,1))
  }
  if(plotMean) {
    if(type=="dens") {coord2 <- max(y); just <- c(1,1)} else if(type=="cdf") {coord2 <- 0;just <- c(1,0)}
    coord <- limits[2]
    meanVal <- 1/b
    varVal <- 1/(b^2)
    text(coord, coord2, substitute(paste(mu, "=", meanVal, "; ", sigma^2, "=", varVal)), adj=just, cex=1.5)
  }
}

#Normal (density or cdf)
normal <- function(mn, s, plotMean, type) {
  mn <- as.numeric(mn)
  s <- as.numeric(s)
  x <- seq(-40,40,0.01)
  if(type=="dens") {
    y <- dnorm(x,mean=mn,sd=s)
    plot(x,y,type="l",xlab=expression(theta), ylab=substitute(paste("Pr(", theta, " | ", mu,", ", sigma,")", sep="")),main=substitute(paste("Normal (", mu, "=", mn, ", ",sigma, "=", s, ")", sep="")))
  } else if(type=="cdf") {
    cdf <- pnorm(x,mean=mn,sd=s)
    plot(x,cdf,type="l",xlab=expression(x), ylab=expression(F(x)),main=substitute(paste("Normal (", mu, "=", mn, ", ",sigma, "=", s, ")", sep="")), ylim=c(0,1))
  }
  if(plotMean) {
    if(type=="dens") {coord2 <- max(y); if(mn*s < 200) {coord <- max(x);just <- c(1,1)} else {coord <- min(x);just <- c(0,1)}} else if(type=="cdf") {coord2 <- 0;just <- c(1,0); coord <- max(x)}
    
    meanVal <- mn
    varVal <- s^2
    text(coord, coord2, substitute(paste(mu, "=", meanVal, "; ", sigma^2, "=", varVal)), adj=just, cex=1.5)
  }
}

normal.prob <- function(mn, s, value, lower=FALSE) {
  mn <- as.numeric(mn)
  s <- as.numeric(s)
  y <- function(x) {dnorm(x,mean=mn,sd=s)}
  curve(y,from=mn-4*s, to=mn+4*s,xlab=expression(X), ylab=substitute(paste("Pr(X", " | ", mu,", ", sigma,")", sep="")),main=substitute(paste("Normal (", mu, "=", mn, ", ",sigma, "=", s, ")", sep="")))
  if(lower) {
    coord.x <- c(mn-3*s, seq(mn-3*s, value, 0.01),value)
    coord.y <- c(0, y(seq(mn-3*s, value, 0.01)),0)
  } else {
    coord.x <- c(value, seq(value, mn+3*s, 0.01), mn+3*s)
    coord.y <- c(0, y(seq(value, mn+3*s, 0.01)) ,0)
  }
  polygon(coord.x, coord.y, col="grey")
}

normal.prob2 <- function(mn, s, value1, value2) {
  mn <- as.numeric(mn)
  s <- as.numeric(s)
  y <- function(x) {dnorm(x,mean=mn,sd=s)}
  curve(y,from=mn-4*s, to=mn+4*s,xlab=expression(X), ylab=substitute(paste("Pr(X", " | ", mu,", ", sigma,")", sep="")),main=substitute(paste("Normal (", mu, "=", mn, ", ",sigma, "=", s, ")", sep="")))
  coord.x1 <- c(mn-3*s, seq(mn-3*s, value1, 0.01),value1)
  coord.y1 <- c(0, y(seq(mn-3*s, value1, 0.01)),0)
  coord.x2 <- c(value2, seq(value2, mn+3*s, 0.01), mn+3*s)
  coord.y2 <- c(0, y(seq(value2, mn+3*s, 0.01)) ,0)
  polygon(coord.x1, coord.y1, col="grey")
  polygon(coord.x2, coord.y2, col="grey")
}

norm.pval <- function(mn, s, value1=FALSE, value2=FALSE) {
  mn <- as.numeric(mn)
  s <- as.numeric(s)
  pval <- 0
  if(is.numeric(value1)) {
    pval <- pval + pnorm(value1, mn, s, lower.tail=TRUE)
  }
  if(is.numeric(value2)) {
    pval <- pval + pnorm(value2, mn, s, lower.tail=FALSE)
  }
  round(pval, digits=6)
}
