library(ggplot2)
library(readr)
library(forecast)
library(astsa)
setwd("D:/STAT7995/final proj")
CarSale <- read_csv("used_car_sale.csv")
colnames(CarSale)<-c('Date','Sale')
before<-CarSale[1:191,]
after<-CarSale[212:345,]
carsalets<-ts(CarSale$Sale,frequency = 12,start=1992)
par(mar=c(1,1,1,1))
#trend in one year????
carsalets<-ts(CarSale$Sale,frequency = 12,start=1992)
ggseasonplot(carsalets)
plot(stl(carsalets,s.window="period"))

#construct model for data before Dec. 2007
#train data between Jan. 1992 and Nov. 2006

par(mfrow=c(2,1))
#differencing
plot.ts(diff(CarSale$Sale[1:179]),ylab="diff(CarSales)")

#unseasonal
plot.ts(diff(diff(CarSale$Sale[1:179],12)),ylab="diff(diff(CarSales),12)")
par(mfrow=c(1,1))
#acf and pacf plot
acf2(diff(diff(CarSale$Sale[1:179],12)),100,main="ACF and PACF Plot")
acf2(diff(diff(CarSale$Sale[1:179],24)),100,main="Series:diff(diff(carsale[1:312],12))")
sarima(CarSale$Sale[1:179],1,1,1,0,1,1,12)
sarima(CarSale$Sale[1:179],4,1,1,0,1,1,24)

######ts data construct before
plot.ts(diff(diff(carsalets[1:179],12)),ylab="diff(diff(Before),12)")
par(mfrow=c(1,1))
#acf and pacf plot
acf2(diff(diff(carsalets[1:179],12)),100,main="Series:diff(diff(carsale[1:312],12))")
acf2(diff(diff(carsalets[1:179],24)),100,main="Series:diff(diff(carsale[1:312],12))")
par(mfrow=c(2,1))
sarima(carsalets[1:179],1,1,1,0,1,1,12)
sarima(carsalets[1:179],4,1,1,0,1,1,24)

#before<-ts(carsalets[1:179],start=1992,frequency = 12)

#####forecast ts data before
#sarima_fore24<-sarima.for(before,43,4,1,1,0,1,1,24)
#lines(c(2007,12):c(2009,6), carsalets[180:191], type="b", col="blue")
#lines(192:210, carsalets[192:210], type="b", col='green')
#lines(211:222, carsalets[211:222], type="b", col='yellow')

#carsalets


par(mfrow=c(1,1))
#verify model using Dec.2006 to Nov. 2007
#forecast Dec. 2007 to July 2009(recession)
sarima_fore24<-sarima.for(CarSale$Sale[1:179],43,4,1,1,0,1,1,24)
lines(180:191, CarSale$Sale[180:191], type="b", col="blue")
lines(192:210, CarSale$Sale[192:210], type="b", col='green')
lines(211:222, CarSale$Sale[211:222], type="b", col='yellow')

par(mar=c(4,4,2,2))
sarima_fore24$pred
residual<-sarima_fore24$pred-CarSale$Sale[180:222]
styles<-c(rep("blue",12),rep("green",19),rep("yellow",12))
residualplot<-as.data.frame(cbind(residual,styles))
plot(residualplot$residual,lty=2,col=residualplot$styles,ylab='residuals')

sarima_fore12<-sarima.for(CarSale$Sale[1:179],44,1,1,1,0,1,1,12)
lines(180:191, CarSale$Sale[180:191], type="b", col="blue")
lines(192:211, CarSale$Sale[192:211], type="b", col='green')
lines(212:223, CarSale$Sale[212:223], type="b", col='yellow')

sarima_fore12$pred
residual<-sarima_fore12$pred-CarSale$Sale[180:223]
plot(residual)

#construct model for data between Aug. 2009 and Feb. 2020
#training data between Aug. 2009 and Feb. 2019

After<-CarSale[211:345,]


par(mfrow=c(2,1))

#differencing
logsale<-log(After$Sale[1:116])
plot.ts(diff(After$Sale[1:116]),ylab="diff(After)")
plot.ts(diff(logsale),ylab="diff(log)")

#unseasonal
plot.ts(diff(diff(After$Sale[1:116],12)),ylab="diff(diff(Before),12)")
plot.ts(diff(diff(logsale,12)),ylab="diff(diff(After),12)")

#acf and pacf plot
acf2(diff(diff(After$Sale[1:116],12)),100,main="Series:diff(diff(carsale[1:312],12))")
sarima(After$Sale[1:116],1,1,1,0,1,1,12)
sarima(After$Sale[1:116],1,1,1,1,1,1,12)


par(mfrow=c(1,1))
#verify model using Mar.2019 to Mar. 2020
#forecast Apr. 2020 to Sep. 2021(Covid)
forecastCovid<-sarima.for(After$Sale[1:116],34,1,1,1,0,1,1,12)
lines(117:128, After$Sale[117:128], type="b", col="blue")
lines(129:135, After$Sale[129:135], type="b", col='green')

residualCovid<-forecastCovid$pred[1:19]-After$Sale[117:135]
prediction<-forecastCovid$pred[20:34]-mean(residualCovid[16:19])
lines(136:150, prediction, type="b", col=6)

stylesCovid<-c(rep("blue",12),rep("green",7))
residualCovidplot<-as.data.frame(cbind(residualCovid,stylesCovid))
plot(x=c(117:135),residualCovidplot$residualCovid,lty=2,col=residualCovidplot$stylesCovid,ylab='residuals',xlab='index')

prediction

sarima.for(After$Sale[1:115],34,4,1,1,0,1,1,24)
lines(116:127, After$Sale[116:127], type="b", col="blue")
lines(128:134, After$Sale[128:134], type="b", col='green')
















