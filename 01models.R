##cfas/sems with lavaan here
library(semTools) #load lavaan & other tools

#glosario
#acce : acceptability/aceptabilidad de gm foods
#risk : risk/riesgo percibido respecto a gm foods
#bene : benefit/beneficio percibido respecto a gm foods
#trus : trust/confianza en gm food developers/scientists/regulators
#cona : conative/intenciones conductuales respecto a gm foods (willingness to buy)

#cfa que tendría que haber hecho siegrist (1999,2000,etc) (cfa - "el malo")
#es la base para la "cadena causal"
#5 factores oblicuos
siegr01 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
trus =~ trus01r + trus02r + trus03d + trus04d
cona =~ cona01r + cona02r + cona03d + cona04d'

#sem que tendría que haber hecho siegrist (1999,2000,etc) (sem - "el malo")
#es la base para la "cadena causal"
#5 factores oblicuos
siegr02 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
trus =~ trus01r + trus02r + trus03d + trus04d
cona =~ cona01r + cona02r + cona03d + cona04d
cona ~ acce
acce ~ risk + bene
risk ~ trus
bene ~ trus'

#cfa que podría haber utilizado eiser et al (2002, etc) (cfa - "el feo")
#5 factores de primer orden que cargan en un factor de segundo orden
#corresponde a una interpretación de la "perspectiva asociacionista" sobre las actitudes
#es conceptualmente diferente, pero estadísticamente equivalente a elgue01
eiser01 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
trus =~ trus01r + trus02r + trus03d + trus04d
cona =~ cona01r + cona02r + cona03d + cona04d
atti =~ acce + risk + bene + trus + cona'

#cfa bifactor que podría haber utilizado eiser et al (2002, etc) (cfa - "el feo", otra versión)
#modelo bifactorial con 5 factores oblicuos y un factor general ortogonal
#corresponde a una interpretación de la "perspectiva asociacionista" sobre las actitudes
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
'

#cfa inspirado por slovic (1993, 2002 etc) (cfa - "el bueno")
# 4 factores de primer orden cargan en un factor de segundo orden, además hay un factor oblicuo adicional de primer orden
#corresponde a mi interpretación del "heurístico afectivo" y el propuesto rol de la "confianza"
#es conceptualmente diferente al resto, pero es estadísticamente equivalente a eiser01
elgue01 <- '
acce =~ acce01r + acce02r + acce03d + acce04d
risk =~ risk01r + risk02r + risk03i + risk04i
bene =~ bene01d + bene02r + bene03r + bene04d
cona =~ cona01r + cona02r + cona03d + cona04d
atti =~ acce + risk + bene + cona
trus =~ trus01r + trus02r + trus03d + trus04d'

#cfa bifactor inspirado por slovic (1993, 2002 etc) (cfa - "el bueno", otra versión)
# 4 factores oblicuos, 1 factor general; además hay 1 factor oblicuo adicional
#corresponde a mi interpretación del "heurístico afectivo" y el propuesto rol de la "confianza"
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
'

#run models with MLR
fitsiegr01 <- cfa(siegr01, data=datosrec,estimator="MLR");
fitsiegr02 <- cfa(siegr02, data=datosrec,estimator="MLR");
fiteiser01 <- cfa(eiser01, data=datosrec,estimator="MLR");
fiteiser02 <- cfa(eiser02, data=datosrec,estimator="MLR");
fitelgue01 <- cfa(elgue01, data=datosrec,estimator="MLR");
fitelgue02 <- cfa(elgue02, data=datosrec,estimator="MLR");

#check fit indices
fitMeasures(fitsiegr01, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fitsiegr02, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fiteiser01, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fiteiser02, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fitelgue01, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))
fitMeasures(fitelgue02, c("chisq.scaled","df.scaled","pvalue.scaled","cfi.scaled","tli.scaled","rmsea.scaled","rmsea.ci.lower.scaled","rmsea.ci.upper.scaled","srmr.scaled","BIC","AIC"))

#compare models
anova(fitsiegr01,
			fitsiegr02,
			fiteiser01,
			fiteiser02,
			fitelgue01,
			fitelgue02)
