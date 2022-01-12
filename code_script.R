## ------------------------------------------------------------------------------------------------
library(curl)
df <- read.csv( curl("https://raw.githubusercontent.com/thanhqtran/code-tranqt19-chile-inflation/a1522186c7a02427a655148b282222443775e4d7/chile_data.csv"), header=TRUE, stringsAsFactors=FALSE)
df$lngdp <- log(df$gdp)


## ----echo = FALSE--------------------------------------------------------------------------------
library(ggplot2)
library(dplyr)
df$date = seq(as.Date('1980-03-01'), as.Date('2017-12-01'), by = '3 month')
df2 <- data.frame(df)
p = ggplot() + 
    geom_line(data = df2, aes(x = date, y = ir), color = "blue") +
    geom_vline(xintercept = as.numeric(as.Date("1991-03-01"))) +
    xlab('time')+ylab('inflation rate')
print(p)


## ----echo = FALSE--------------------------------------------------------------------------------
library(ggplot2)
p = ggplot() + 
    geom_line(data = df2, aes(x = date, y = lngdp), color = "blue") +
    geom_vline(xintercept = as.numeric(as.Date("1991-03-01"))) +
    xlab('time')+ylab('log(gdp)')
print(p)


## ----echo = FALSE--------------------------------------------------------------------------------
library(ggplot2)
p = ggplot() + 
    geom_line(data = df2, aes(x = date, y = r), color = "blue") +
    geom_line(data = df2, aes(x = date, y = u), color = "red") +
    geom_vline(xintercept = as.numeric(as.Date("1991-03-01"))) +
    geom_boxplot() +
    xlab('time')+ylab('percent')
print(p)


## ------------------------------------------------------------------------------------------------
library(stargazer)
stargazer(df, type = "text")


## ------------------------------------------------------------------------------------------------
library(urca)
summary(ur.df(df$lngdp, type = "none",lags=1))


## ------------------------------------------------------------------------------------------------
summary(ur.df(df$ir, type = "trend",lags=1))


## ------------------------------------------------------------------------------------------------
summary(ur.df(df$u, type = "trend",lags=1))


## ------------------------------------------------------------------------------------------------
summary(ur.df(df$r, type = "trend",lags=1))


## ------------------------------------------------------------------------------------------------
df$lnr <- log(df$r)
summary(ur.df(df$lnr, type = "trend",lags=1))


## ------------------------------------------------------------------------------------------------
model1 <- lm(lngdp ~ it + ir + u + r, data=df)
df$lnr <- log(df$r)
model2 <- lm(lngdp ~ it + ir + u + lnr, data=df)
stargazer(model1, model2, type = "text")

