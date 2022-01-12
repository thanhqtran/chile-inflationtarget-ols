The Impact of Chile’s Inflation Targeting Policy on Economic Growth (1991 - 2017)
=================================================================================

#### Tran Quang-Thanh

#### 2/9/2021

### Synopsis

**Original title:** [Nguyen, T. Hong., Nguyen, H. Cong., Tran, Q. Thanh., *Tác động của chính sách lạm phát mục tiêu đến tăng trưởng kinh tế Chile và bài học kinh nghiệm cho Việt Nam*, Tạp chí Kinh tế Đối ngoại, No.114/2019, p. 83 - 103](http://tracuutapchi.ftu.edu.vn/index.php/tcqlktqt/article/view/602)

**English title:** Nguyen, T. Hong., Nguyen, H. Cong., Tran, Q. Thanh., *The Impact of Chile’s Inflation Targeting Policy on Economic Growth and Lessons for Vietnam*, External Economics Review, No. 114/2019, p. 83-103

**Institution:** Foreign Trade University, Hanoi, Vietnam

**Introduction:** Chile has adopted the inflation targeting monetary policy framework since 1991. The output growth ever since has remained high and economic volatility reduced. In this framework, we employed an OLS model to confirm the impact of this change in policy conduct on economic growth. Our estimation shows that thanks to the policy, economic growth has been more than 20% higher. The data were collected from 1980q1 to 2017q4.

*The paper was done in Stata 12 software. Due to the growing popularity and reproducibility of R, the authors decide to redo the results in R and publish this report as a supplement to the original article. Due to the different programs being used and testing methodologies, there are some changes in numbers. Nevertheless, the authors claim that these discrepancies have no significant impact on the final conclusion.*

### Abstract

High inflation is always a threat to macroeconomic stability and long-term economic growth. Therefore, controlling inflation has become one of the most important tasks in many countries. In the early 1990s, a new trend in monetary policy conduct was formed. Numerous advanced industrial countries, as well as emerging market economies then, including Chile, started to shift towards an inflation targeting framework. From an emerging country with a high inflation rate of over 20%, Chile has become the most developed country in South America with an inflation rate of around 2% and high economic growth for many years.

How did Chile do under an inflation targeting regime? This paper will provide the background of inflation targeting policy, the performance of inflation targeting policy in Chile, and then evaluate the effect of inflation targeting policy on Chile’s economic growth. Base on this finding, the authors draw lessons for Vietnamese policymakers if they were to pursue this policy.

### The Model

To prove the effectiveness and impacts of inflation targeting policy, we used a simple OLS regression model with inflation targeting policy acting as a dummy variable. It takes the value of 0 during the period of no-inflation-targeting era and value of 1 during the period of inflation-targeting era. The choice of dependent and independent variables are based on [Ayisi, R.(2013)](https://thescipub.com/pdf/ajebasp.2013.22.28.pdf).

<img src="https://render.githubusercontent.com/render/math?math=\ln(GDP)_t=\beta_0%2B\beta_1it_t%2B\beta_2ir_t%2B\beta_3r_t%2B\varepsilon_t">

in which:

  Variable | Notation| Unit | Data source
  -------- | ------- | ---- | -----------
  natural log of quarterly output (ppp) | ln(gdp) | national currency | OECD, IMF
  inflation target | it | dummy | National Bank of Chile
  (observed) inflation rate | ir | percent | OECD
  unemployment | u | percent | OECD, various
  real interest | r | percent | OECD, various

**Time periods**: 1980q1 to 2017q4

**Dataset**:
[link](https://raw.githubusercontent.com/thanhqtran/code-tranqt19-chile-inflation/a1522186c7a02427a655148b282222443775e4d7/chile_data.csv) (discontinued)

### Regression Results

#### Read data file

``` {.r}
library(curl)
df <- read.csv( curl("https://raw.githubusercontent.com/thanhqtran/code-tranqt19-chile-inflation/a1522186c7a02427a655148b282222443775e4d7/chile_data.csv"), header=TRUE, stringsAsFactors=FALSE)
df$lngdp <- log(df$gdp)
```

#### Plotting

The vertical line divides the time into 2 parts. The part on the left
represents the era before the adoption of inflation targeting policy,
whereas the part on the right represents the era after the adoption of
inflation targeting policy.

Inflation rate:

```{.r}
library(ggplot2)
library(dplyr)
df$date = seq(as.Date('1980-03-01'), as.Date('2017-12-01'), by = '3 month')
df2 <- data.frame(df)
p = ggplot() + 
    geom_line(data = df2, aes(x = date, y = ir), color = "blue") +
    geom_vline(xintercept = as.numeric(as.Date("1991-03-01"))) +
    xlab('time')+ylab('inflation rate')
print(p)
```

![inflation rate history](https://i.imgur.com/oVpx9ew.png)

Output growth:

```{.r}
library(ggplot2)
p = ggplot() + 
    geom_line(data = df2, aes(x = date, y = lngdp), color = "blue") +
    geom_vline(xintercept = as.numeric(as.Date("1991-03-01"))) +
    xlab('time')+ylab('log(gdp)')
print(p)
```

![real gdp](https://i.imgur.com/5AeJES7.png)

Interest rate (blue) and unemployment (red)

```{.r}
library(ggplot2)
p = ggplot() + 
    geom_line(data = df2, aes(x = date, y = r), color = "blue") +
    geom_line(data = df2, aes(x = date, y = u), color = "red") +
    geom_vline(xintercept = as.numeric(as.Date("1991-03-01"))) +
    geom_boxplot() +
    xlab('time')+ylab('percent')
print(p)
```

![interest rate and unemployment](https://i.imgur.com/jXe6hD9.png)

It seems that the policy was very effective to stabilize the once highly
volatile variables like interest rate and inflation rate.

#### Descriptive summary

``` {.r}
library(stargazer)
```

```R
## 
## Please cite as:

##  Hlavac, Marek (2018). stargazer: Well-Formatted Regression and Summary Statistics Tables.

##  R package version 5.2.2. https://CRAN.R-project.org/package=stargazer
```

``` {.r}
stargazer(df, type = "text")
```

```R
## 
## =======================================================================
## Statistic  N     Mean      St. Dev.    Min   Pctl(25) Pctl(75)    Max  
## -----------------------------------------------------------------------
## gdp       152 207,148.700 101,672.600 74,397 109,182  292,551.5 393,257
## ir        152   10.350       9.457    0.006   3.170    17.156   39.012 
## u         152    9.007       2.917    5.505   6.623    10.295   19.974 
## r         152   15.257      13.360    0.483   4.227    23.240   60.640 
## it        152    0.711       0.455      0       0         1        1   
## lngdp     152   12.106       0.540    11.217  11.601   12.586   12.882 
## -----------------------------------------------------------------------
```

Chile started to adopt the inflation targeting framework from 1991. As the result, there are 1/3 of the data lie during the no-inflation-targeting era (1980q1 - 1990q4) while the rest (2/3 of the data) lie during the inflation-targeting era (1991q1 - 2017q4). Output growth during this period was remarkably high with approximately 12% per annum.

#### Unit Root Test

Since the time series data were used, we need to perform unit root test.
Test for Unit Root: Augmented Dickey-Fuller Test
Null Hypothesis: there is a unit root.

-   For output growth: **log(gdp)**

``` {.r}
library(urca)
summary(ur.df(df$lngdp, type = "none",lags=1))
```

    ## 
    ## ############################################### 
    ## # Augmented Dickey-Fuller Test Unit Root Test # 
    ## ############################################### 
    ## 
    ## Test regression none 
    ## 
    ## 
    ## Call:
    ## lm(formula = z.diff ~ z.lag.1 - 1 + z.diff.lag)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.041669 -0.005972  0.000445  0.008199  0.031734 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## z.lag.1    0.0006027  0.0001112   5.420 2.37e-07 ***
    ## z.diff.lag 0.3026977  0.0774644   3.908 0.000141 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.0133 on 148 degrees of freedom
    ## Multiple R-squared:  0.4204, Adjusted R-squared:  0.4126 
    ## F-statistic: 53.67 on 2 and 148 DF,  p-value: < 2.2e-16
    ## 
    ## 
    ## Value of test-statistic is: 5.4195 
    ## 
    ## Critical values for test statistics: 
    ##       1pct  5pct 10pct
    ## tau1 -2.58 -1.95 -1.62

We tested the stationary property of ln(gdp) with 1 period of lag. The
result shows that the data is stationary.

-   For inflation rate: **ir**

``` {.r}
summary(ur.df(df$ir, type = "trend",lags=1))
```

    ## 
    ## ############################################### 
    ## # Augmented Dickey-Fuller Test Unit Root Test # 
    ## ############################################### 
    ## 
    ## Test regression trend 
    ## 
    ## 
    ## Call:
    ## lm(formula = z.diff ~ z.lag.1 + 1 + tt + z.diff.lag)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -7.8348 -0.9869 -0.1185  0.9119  7.5657 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  3.294020   0.763125   4.316 2.91e-05 ***
    ## z.lag.1     -0.156145   0.029446  -5.303 4.14e-07 ***
    ## tt          -0.023702   0.006263  -3.784 0.000224 ***
    ## z.diff.lag   0.522924   0.067912   7.700 1.89e-12 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.968 on 146 degrees of freedom
    ## Multiple R-squared:  0.3498, Adjusted R-squared:  0.3365 
    ## F-statistic: 26.19 on 3 and 146 DF,  p-value: 1.3e-13
    ## 
    ## 
    ## Value of test-statistic is: -5.3028 9.793 14.38 
    ## 
    ## Critical values for test statistics: 
    ##       1pct  5pct 10pct
    ## tau3 -3.99 -3.43 -3.13
    ## phi2  6.22  4.75  4.07
    ## phi3  8.43  6.49  5.47

The inflation rate data is stationary.

-   For unemployment rate: **u**

``` {.r}
summary(ur.df(df$u, type = "trend",lags=1))
```

    ## 
    ## ############################################### 
    ## # Augmented Dickey-Fuller Test Unit Root Test # 
    ## ############################################### 
    ## 
    ## Test regression trend 
    ## 
    ## 
    ## Call:
    ## lm(formula = z.diff ~ z.lag.1 + 1 + tt + z.diff.lag)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.7418 -0.3899 -0.0244  0.3080  7.9224 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)   
    ## (Intercept)  1.176767   0.430856   2.731  0.00709 **
    ## z.lag.1     -0.098547   0.032976  -2.988  0.00329 **
    ## tt          -0.004098   0.002191  -1.870  0.06347 . 
    ## z.diff.lag   0.197955   0.081179   2.438  0.01595 * 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.894 on 146 degrees of freedom
    ## Multiple R-squared:  0.07846,    Adjusted R-squared:  0.05952 
    ## F-statistic: 4.143 on 3 and 146 DF,  p-value: 0.007489
    ## 
    ## 
    ## Value of test-statistic is: -2.9884 3.019 4.4666 
    ## 
    ## Critical values for test statistics: 
    ##       1pct  5pct 10pct
    ## tau3 -3.99 -3.43 -3.13
    ## phi2  6.22  4.75  4.07
    ## phi3  8.43  6.49  5.47

The unemployment rate data is stationary at 5% confidence.

-   For real interest rate: **r**

``` {.r}
summary(ur.df(df$r, type = "trend",lags=1))
```

    ## 
    ## ############################################### 
    ## # Augmented Dickey-Fuller Test Unit Root Test # 
    ## ############################################### 
    ## 
    ## Test regression trend 
    ## 
    ## 
    ## Call:
    ## lm(formula = z.diff ~ z.lag.1 + 1 + tt + z.diff.lag)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -10.6293  -1.5222  -0.2216   1.1359  25.5216 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  6.87450    1.73820   3.955 0.000119 ***
    ## z.lag.1     -0.19060    0.04597  -4.146 5.72e-05 ***
    ## tt          -0.05257    0.01399  -3.757 0.000248 ***
    ## z.diff.lag   0.03117    0.08069   0.386 0.699821    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.07 on 146 degrees of freedom
    ## Multiple R-squared:  0.1093, Adjusted R-squared:  0.09095 
    ## F-statistic: 5.969 on 3 and 146 DF,  p-value: 0.0007242
    ## 
    ## 
    ## Value of test-statistic is: -4.1457 5.8411 8.7342 
    ## 
    ## Critical values for test statistics: 
    ##       1pct  5pct 10pct
    ## tau3 -3.99 -3.43 -3.13
    ## phi2  6.22  4.75  4.07
    ## phi3  8.43  6.49  5.47

It is clear that the interest rate is non-stationary. This might be due
to the fact that the absolute values were highly volatile. To reduce the
volatility, we proposed a better measurement by log-linearizing it,
which gives us the following result.

``` {.r}
df$lnr <- log(df$r)
summary(ur.df(df$lnr, type = "trend",lags=1))
```

    ## 
    ## ############################################### 
    ## # Augmented Dickey-Fuller Test Unit Root Test # 
    ## ############################################### 
    ## 
    ## Test regression trend 
    ## 
    ## 
    ## Call:
    ## lm(formula = z.diff ~ z.lag.1 + 1 + tt + z.diff.lag)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.98824 -0.11818  0.03127  0.11624  1.14637 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  0.5807711  0.1418608   4.094 6.99e-05 ***
    ## z.lag.1     -0.1488570  0.0354596  -4.198 4.66e-05 ***
    ## tt          -0.0032675  0.0008515  -3.837 0.000185 ***
    ## z.diff.lag   0.3051266  0.0774137   3.942 0.000125 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.2345 on 146 degrees of freedom
    ## Multiple R-squared:  0.1607, Adjusted R-squared:  0.1435 
    ## F-statistic:  9.32 on 3 and 146 DF,  p-value: 1.119e-05
    ## 
    ## 
    ## Value of test-statistic is: -4.1979 6.0143 8.928 
    ## 
    ## Critical values for test statistics: 
    ##       1pct  5pct 10pct
    ## tau3 -3.99 -3.43 -3.13
    ## phi2  6.22  4.75  4.07
    ## phi3  8.43  6.49  5.47

After log-linearization, the interest rate variable no longer has unit root.

*To preserve the integrity of the original research, we ran 2 models: one with the original interest rate (r) and the other with log(r), then compared the results.*

#### Regression results

``` {.r}
model1 <- lm(lngdp ~ it + ir + u + r, data=df)
df$lnr <- log(df$r)
model2 <- lm(lngdp ~ it + ir + u + lnr, data=df)
stargazer(model1, model2, type = "text")
```

    ## 
    ## ===========================================================
    ##                                    Dependent variable:     
    ##                                ----------------------------
    ##                                           lngdp            
    ##                                     (1)            (2)     
    ## -----------------------------------------------------------
    ## it                                0.188**       0.198***   
    ##                                   (0.073)        (0.060)   
    ##                                                            
    ## ir                               -0.020***      -0.014***  
    ##                                   (0.003)        (0.003)   
    ##                                                            
    ## u                                -0.038***      -0.051***  
    ##                                   (0.008)        (0.006)   
    ##                                                            
    ## r                                -0.015***                 
    ##                                   (0.002)                  
    ##                                                            
    ## lnr                                             -0.226***  
    ##                                                  (0.019)   
    ##                                                            
    ## Constant                         12.743***      13.083***  
    ##                                   (0.124)        (0.110)   
    ##                                                            
    ## -----------------------------------------------------------
    ## Observations                        152            152     
    ## R2                                 0.868          0.908    
    ## Adjusted R2                        0.865          0.906    
    ## Residual Std. Error (df = 147)     0.199          0.166    
    ## F Statistic (df = 4; 147)        242.324***    363.699***  
    ## ===========================================================
    ## Note:                           *p<0.1; **p<0.05; ***p<0.01

#### Interpretation

-   All variables are statistically significant. Looking at the
    R-squared statistics, around 86.8 to 90.8 percent of the changes in output growth can be explained by the chosen independent variables.

-   Notably, the model with log-linearized real interest rates produces higher statistical significance.

-   With the coefficient of 0.198, this means that thanks to the existence of the inflation targeting policy, output in Chile has been <img src="https://render.githubusercontent.com/render/math?math=e^{0.198} = 1.22> times higher than that if there were no such policy.

### Reference:

-   Ayisi, R. (2013), ‘Single-digit inflation targeting and economic growth’, American Journal of Economics and Business Administration, No 5, pages 22-28
-   Banco Central de Chile (2001), ‘Indicadores económicos y sociales de Chile 1960-2000’
-   Morande, F. (2001). A Decade of Inflation Targeting in Chile: Developments, Lessons, and Challenges (No. 115). Banco Central de Chile.
