##cfas/sems with additional latent variable

#load libraries
library(semTools) #load lavaan & other tools
library(semPlot) #for plots

#variables glossary
#acce : acceptability/aceptabilidad de gm foods
#risk : risk/riesgo percibido respecto a gm foods
#bene : benefit/beneficio percibido respecto a gm foods
#trus : trust/confianza en gm food developers/scientists/regulators
#cona : conative/intenciones conductuales respecto a gm foods (willingness to buy)
#gtru : general trust in institutions (not specified as gm foods)

#cfa que tendría que haber hecho siegrist (1999,2000,etc) (cfa - "el malo")
#df=284
siegr01 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
trus =~ trus01r + trus02r + trus03d + trus04d
cona =~ cona01r + cona02r + cona03d + cona04d
gtru =~ tru1 + tru2 + tru3 + tru4 + tru5 + tru6'

#sem que tendría que haber hecho siegrist (1999,2000,etc) (sem - "el malo")
#df=293
siegr02 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
trus =~ trus01r + trus02r + trus03d + trus04d
cona =~ cona01r + cona02r + cona03d + cona04d
cona ~ acce
acce ~ risk + bene
risk ~ trus
bene ~ trus
gtru =~ tru1 + tru2 + tru3 + tru4 + tru5 + tru6'

#cfa que podría haber utilizado eiser et al (2002, etc) (cfa - "el feo")
#df=293
eiser01 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
trus =~ trus01r + trus02r + trus03d + trus04d
cona =~ cona01r + cona02r + cona03d + cona04d
atti =~ acce + risk + bene + trus + cona
gtru =~ tru1 + tru2 + tru3 + tru4 + tru5 + tru6'

#cfa bifactor que podría haber utilizado eiser et al (2002, etc) (cfa - "el feo", otra versión)
#df=284
eiser02 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
trus =~ trus01r + trus02r + trus03d + trus04d
cona =~ cona01r + cona02r + cona03d + cona04d
atti =~ acce01r + acce02r + acce03d + acce04d +
risk01r + risk02r + risk03i + risk04i +
bene01d + bene02r + bene03r + bene04d +
trus01r + trus02r + trus03d + trus04d +
cona01r + cona02r + cona03d + cona04d
atti ~~ 0*acce
atti ~~ 0*risk
atti ~~ 0*bene
atti ~~ 0*cona
atti ~~ 0*trus
acce ~~ 0*risk
acce ~~ 0*bene
acce ~~ 0*cona
acce ~~ 0*trus
risk ~~ 0*bene
risk ~~ 0*cona
risk ~~ 0*trus
bene ~~ 0*cona
bene ~~ 0*trus
cona ~~ 0*trus
atti ~~ 1*atti
acce ~~ 1*acce
risk ~~ 1*risk
bene ~~ 1*bene
cona ~~ 1*cona
trus ~~ 1*trus
gtru =~ tru1 + tru2 + tru3 + tru4 + tru5 + tru6
gtru ~~ 0*acce
gtru ~~ 0*risk
gtru ~~ 0*bene
gtru ~~ 0*cona
gtru ~~ 0*trus
'

#cfa inspirado por slovic (1993, 2002 etc) (cfa - "el bueno")
#df=292
elgue01 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
cona =~ cona01r + cona02r + cona03d + cona04d
atti =~ acce + risk + bene + cona
trus =~ trus01r + trus02r + trus03d + trus04d
gtru =~ tru1 + tru2 + tru3 + tru4 + tru5 + tru6'

#cfa bifactor inspirado por slovic (1993, 2002 etc) (cfa - "el bueno", otra versión)
#df=281
elgue02 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
cona =~ cona01r + cona02r + cona03d + cona04d
atti =~ acce01r + acce02r + acce03d + acce04d +
risk01r + risk02r + risk03i + risk04i +
bene01d + bene02r + bene03r + bene04d +
cona01r + cona02r + cona03d + cona04d
trus =~ trus01r + trus02r + trus03d + trus04d
atti ~~ 0*acce
atti ~~ 0*risk
atti ~~ 0*bene
atti ~~ 0*cona
acce ~~ 0*risk
acce ~~ 0*bene
acce ~~ 0*cona
risk ~~ 0*bene
risk ~~ 0*cona
bene ~~ 0*cona
atti ~~ 1*atti
acce ~~ 1*acce
risk ~~ 1*risk
bene ~~ 1*bene
cona ~~ 1*cona
gtru =~ tru1 + tru2 + tru3 + tru4 + tru5 + tru6
gtru ~~ 0*acce
gtru ~~ 0*risk
gtru ~~ 0*bene
gtru ~~ 0*cona'

#run models with MLR; datos originales "numericos"
fitsiegr01 <- cfa(siegr01, data=datosrec,estimator="MLR");
fitsiegr02 <- cfa(siegr02, data=datosrec,estimator="MLR");
fiteiser01 <- cfa(eiser01, data=datosrec,estimator="MLR");
fiteiser02 <- cfa(eiser02, data=datosrec,estimator="MLR");
fitelgue01 <- cfa(elgue01, data=datosrec,estimator="MLR");
fitelgue02 <- cfa(elgue02, data=datosrec,estimator="MLR");

#run models with ULSMV; datos originales "ordinales"
fitsiegr01 <- cfa(siegr01, data=datosror,estimator="ULSMV");
fitsiegr02 <- cfa(siegr02, data=datosror,estimator="ULSMV");
fiteiser01 <- cfa(eiser01, data=datosror,estimator="ULSMV");
fiteiser02 <- cfa(eiser02, data=datosror,estimator="ULSMV");
fitelgue01 <- cfa(elgue01, data=datosror,estimator="ULSMV");
fitelgue02 <- cfa(elgue02, data=datosror,estimator="ULSMV");

#check fit indices
fitMeasures(fitsiegr01, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fitsiegr02, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fiteiser01, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fiteiser02, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fitelgue01, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fitelgue02, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))


#check long outputs
summary(fitsiegr01, fit.measures = TRUE) #long outputs
summary(fitsiegr02, fit.measures = TRUE) #long outputs
summary(fiteiser01, fit.measures = TRUE) #long outputs
summary(fiteiser02, fit.measures = TRUE) #long outputs
summary(fitelgue01, fit.measures = TRUE) #long outputs
summary(fitelgue02, fit.measures = TRUE) #long outputs


#standardided solutions
standardizedSolution(fitsiegr01) #short
standardizedSolution(fitsiegr02) #short
standardizedSolution(fiteiser01) #short
standardizedSolution(fiteiser02) #short
standardizedSolution(fitelgue01) #short
standardizedSolution(fitelgue02) #short

#complementary checks
warnings()
lavInspect(fitsiegr02, "cov.lv");lavInspect(fitsiegr02, "cor.lv")
lavInspect(fiteiser01, "cov.lv");lavInspect(fiteiser01, "cor.lv")
lavInspect(fitelgue01, "cov.lv");lavInspect(fitelgue01, "cor.lv")
lavInspect(fitsiegr02, "optim.gradient") 
lavInspect(fiteiser01, "optim.gradient") 
lavInspect(fitelgue01, "optim.gradient") 
inspect(fitsiegr02, what="est")
inspect(fiteiser01, what="est")
inspect(fitelgue01, what="est")
eigen(inspect(fitsiegr02,"cov.lv"))$values
eigen(inspect(fiteiser01,"cov.lv"))$values
eigen(inspect(fitelgue01,"cov.lv"))$values


#plots?
semPaths(fitsiegr01)
semPaths(fitsiegr02)
semPaths(fiteiser01)
semPaths(fiteiser02)
semPaths(fitelgue01)
semPaths(fitelgue02)


#compare models from same "theory"
anova(fitsiegr01,fitsiegr02) #with MLR siegr02 is "better"; with ULSMV siegr02 is "better"  
anova(fiteiser01,fiteiser02) #with MLR eiser02 is "better"; with ULSMV eiser01 is "better"  
anova(fitelgue01,fitelgue02) #with MLR elgue02 is "better"; with ULSMV elgue01 is "better"  

#compare chosen models with different dfs
anova(fitsiegr02,fitelgue01) #with MLR elgue01 is "better"; with ULSMV siegr02 is "better"
anova(fiteiser01,fitelgue01) #with MLR eiser01 is "better"; with ULSMV eiser01 is "better"

#compare models with same df, runs only with ML(R) 
cat("AIC=",AIC(fitsiegr02),"BIC=",BIC(fitsiegr02)) #siegrist has the larger BIC
cat("AIC=",AIC(fiteiser01),"BIC=",BIC(fiteiser01)) #eiser has the smaller BIC
cat("AIC=",AIC(fitelgue01),"BIC=",BIC(fitelgue01)) #elgueta has intermediate BIC