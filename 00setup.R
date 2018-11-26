##initial setup
options(scipen=999) #disables scientific notation
options(max.print=1000000) #enable long outputs

#read datasets
datosrec <- read.csv("datosrec.csv") #datos originales, recodificados desde googlesheets
datosimp <- read.csv("datosimp.csv") #datos imputados utilizando mice
datosror <- read.csv("datosror.csv") #datos originalespara que queden las variables adecuadas como "ordinales"
datosior <- read.csv("datosior.csv") #datos imputados para que queden las variables adecuadas como "ordinales"
datosio3 <- read.csv("datosio3.csv") #datos imputados para que queden las variables adecuadas como "ordinales" y recodificados de 5 a 3 puntos 

#para que variables adecuadas queden como "ordinales"
datosror[,c(
	"para01d","para02d","para03d","para04d","para05d",
	"pseu01d","pseu02r","pseu03d","pseu04d","pseu05r",
	"pseu06r","pseu07r","pseu08d","pseu09d","cons01r",
	"cons02r","cons03d","cons04d",
	"risk01r","risk02r","risk03i","risk04i",
	"cona01r","cona02r","cona03d","cona04d",
	"bene01d","bene02r","bene03r","bene04d",
	"acce01r","acce02r","acce03d","acce04d",
	"trus01r","trus02r","trus03d","trus04d",
	"tru1","tru2","tru3","tru4","tru5","tru6","tru7"
)] <- lapply(datosror[,c(
	"para01d","para02d","para03d","para04d","para05d",
	"pseu01d","pseu02r","pseu03d","pseu04d","pseu05r",
	"pseu06r","pseu07r","pseu08d","pseu09d","cons01r",
	"cons02r","cons03d","cons04d",
	"risk01r","risk02r","risk03i","risk04i",
	"cona01r","cona02r","cona03d","cona04d",
	"bene01d","bene02r","bene03r","bene04d",
	"acce01r","acce02r","acce03d","acce04d",
	"trus01r","trus02r","trus03d","trus04d",
	"tru1","tru2","tru3","tru4","tru5","tru6","tru7"
)], ordered)

#para que variables adecuadas queden como "ordinales"
datosior[,c(
	"para01d","para02d","para03d","para04d","para05d",
	"pseu01d","pseu02r","pseu03d","pseu04d","pseu05r",
	"pseu06r","pseu07r","pseu08d","pseu09d","cons01r",
	"cons02r","cons03d","cons04d",
	"risk01r","risk02r","risk03i","risk04i",
	"cona01r","cona02r","cona03d","cona04d",
	"bene01d","bene02r","bene03r","bene04d",
	"acce01r","acce02r","acce03d","acce04d",
	"trus01r","trus02r","trus03d","trus04d",
	"tru1","tru2","tru3","tru4","tru5","tru6","tru7"
)] <- lapply(datosior[,c(
	"para01d","para02d","para03d","para04d","para05d",
	"pseu01d","pseu02r","pseu03d","pseu04d","pseu05r",
	"pseu06r","pseu07r","pseu08d","pseu09d","cons01r",
	"cons02r","cons03d","cons04d",
	"risk01r","risk02r","risk03i","risk04i",
	"cona01r","cona02r","cona03d","cona04d",
	"bene01d","bene02r","bene03r","bene04d",
	"acce01r","acce02r","acce03d","acce04d",
	"trus01r","trus02r","trus03d","trus04d",
	"tru1","tru2","tru3","tru4","tru5","tru6","tru7"
)], ordered)

#para que variables adecuadas queden como "ordinales"
datosio3[,c(
	"para01d","para02d","para03d","para04d","para05d",
	"pseu01d","pseu02r","pseu03d","pseu04d","pseu05r",
	"pseu06r","pseu07r","pseu08d","pseu09d","cons01r",
	"cons02r","cons03d","cons04d",
	"risk01r","risk02r","risk03i","risk04i",
	"cona01r","cona02r","cona03d","cona04d",
	"bene01d","bene02r","bene03r","bene04d",
	"acce01r","acce02r","acce03d","acce04d",
	"trus01r","trus02r","trus03d","trus04d",
	"tru1","tru2","tru3","tru4","tru5","tru6","tru7"
)] <- lapply(datosio3[,c(
	"para01d","para02d","para03d","para04d","para05d",
	"pseu01d","pseu02r","pseu03d","pseu04d","pseu05r",
	"pseu06r","pseu07r","pseu08d","pseu09d","cons01r",
	"cons02r","cons03d","cons04d",
	"risk01r","risk02r","risk03i","risk04i",
	"cona01r","cona02r","cona03d","cona04d",
	"bene01d","bene02r","bene03r","bene04d",
	"acce01r","acce02r","acce03d","acce04d",
	"trus01r","trus02r","trus03d","trus04d",
	"tru1","tru2","tru3","tru4","tru5","tru6","tru7"
)], ordered)