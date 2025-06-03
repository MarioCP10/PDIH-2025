
# install.packages('tuneR', dep=TRUE)
# install.packages('seewave', dep=TRUE)
# install.packages('soundgen', dep=TRUE)

library(tuneR)
library(seewave)
library(audio)

# establecer el path concreto en cada caso a la carpeta de trabajo
setwd("C:/Users/mario/OneDrive/Escritorio/PDIH/Prácticas/P5")
# la siguiente linea solo para macOS
# setWavPlayer('/usr/bin/afplay')

# 					EJERCICIO 2 MÍNIMO

# cargar archivos de sonido (wav/mp3):
nombre <- readWave('nombre.wav')
apellidos  <- readWave('apellidos.wav')

# mostrar la onda del sonido:
plot( extractWave(nombre, from = 1, to = 23663) )
plot(extractWave(apellidos, from = 1, to = 42095) )

#					EJERCICIO 3 MÍNIMO

# mostrar los campos del archivo de sonido
str(nombre)
str(apellidos)

#					EJERCICIO 4 MÍNIMO

# unión de ambos sonidos del gato y perro
NombreApellidos <- pastew(apellidos, nombre, output="Wave")

nombre
apellidos
NombreApellidos

#					EJERCICIO 5 MÍNIMO

plot(extractWave(NombreApellidos, from = 1, to = 65758))  

# escuchar sonido
listen(NombreApellidos)

#					EJERCICIO 6 MÍNIMO

# guardar el fichero resultante de sonido en disco
writeWave(NombreApellidos, file.path("basico.wav") )

#					EJERCICIO 1 OPCIONAL

# eliminar las frecuencias entre 10000 Hz y 20000 Hz
eliminarFrecuencias <- bwfilter(NombreApellidos,f=48000, channel=1, n=1, from=1000,
 to=11000, bandpass = FALSE, listen = FALSE, output = "Wave")

# guardar el fichero resultando de la eliminación de frecuencias en disco
writeWave(eliminarFrecuencias, file.path("filtrado.wav") )

#					EJERCICIO 2 OPCIONAL

# aplicar eco a nuestro nombre y apellidos
NomYApe <- readWave('basico.wav')
EcoNombreApellidos <- echo(NomYApe, f=48000, amp=c(0.8,0.6,0.4), delay=c(1.5,3,4.5), output="Wave")
EcoNombreApellidos@left <- 10000 * EcoNombreApellidos@left

# guardamos nuestro nombre y apellidos con eco en disco
writeWave(EcoNombreApellidos, file.path("eco.wav"))

# damo la vuelta al sonido de nuestro nombre y apellido
alreves <- revw(NomYApe, output="Wave")

# guardamos el sonido de nuestro nombre y apellidos al reves en disco
writeWave(alreves , file.path("alreves.wav"))

#					EJERCICIO 1 ADICIONAL

# eliminamos el segundo apellido
NombreYPrimerApellido <- cutw(NombreApellidos, from=0.0,to=1, output="Wave")

# guardamos el sonido de nuestro nombre y primer apellido en disco
writeWave(NombreYPrimerApellido , file.path("nombreyprimerapellido.wav"))

#					EJERCICIO 2 ADICIONAL

# nos quedamos solo con nuestro nombre
NombreSinApellidos <- cutw(NombreApellidos, from=0.0,to=0.5, output="Wave")

# nos quedamos solo con nuestro segundo apellido
SegundoApellido <- cutw(NombreApellidos, from=1.0,to=1.35, output="Wave")

# unión del nombre y segundo apellido
NombreYSegundoApellido <- pastew(SegundoApellido, NombreSinApellidos , output="Wave")

# guardamos el sonido de nuestro nombre y segundo apellido en disco
writeWave(NombreYSegundoApellido , file.path("nombreysegundoapellido.wav"))

#					EJERCICIO 3 ADICIONAL

# datos del nombre con el primer y segundo apellido
NombreYPrimerApellido
NombreYSegundoApellido 

# mostrar los campos del archivo de sonido
str(NombreYPrimerApellido)
str(NombreYSegundoApellido)

# mostrar la onda de sonido de nombre con primer y con el segundo apellido
plot(extractWave(NombreYPrimerApellido , from = 1, to = 48000) )
plot(extractWave(NombreYSegundoApellido , from = 1, to = 40800) )

#					EJERCICIO 4 ADICIONAL

# añadir silencio al sonido
NombreApellidosSilencio <- addsilw(NombreApellidos, at = "end", d = 1, output = "Wave")
duration(NombreApellidosSilencio)

# guardamos el sonido de nuestro nombre y apellidos con un silencio adicional en disco
writeWave(NombreApellidosSilencio , file.path("basicoConSilencio.wav"))

#					EJERCICIO 5 ADICIONAL

# filtro de amplitud 1
NombreApellidosFiltro1 <- afilter(NombreApellidos,f=48000,threshold=15,colwave="green")
listen(NombreApellidosFiltro1,f=48000)

# filtro de amplitud 2
NombreApellidosFiltro2 <- afilter(NombreApellidos,f=48000,threshold=35,colwave="purple")
listen(NombreApellidosFiltro2,f=48000)

# dibujo de las ondas
plot(NombreApellidosFiltro1 [1:65758] , type = "l")
plot(NombreApellidosFiltro2[1:65758] , type = "l")

NombreApellidosFiltro1 <- Wave(NombreApellidosFiltro1)
NombreApellidosFiltro2 <- Wave(NombreApellidosFiltro2)

# guardamos los sonidos de nuestro nombre y apellidos con los filtros aplicados
writeWave(NombreApellidosFiltro1, file.path("basicoConFiltro15.wav"))
writeWave(NombreApellidosFiltro2, file.path("basicoConFiltro35.wav"))

#					EJERCICIO 6 ADICIONAL

# borramos nuestro primer apellido con deletew
DeletePrimerApellido <- deletew(NombreApellidos, output="Wave", from = 0.5, to = 1)
listen(DeletePrimerApellido)

# guardamos en disco el fichero de sonido
writeWave(DeletePrimerApellido, file.path("deletePrimerApellido.wav"))

#					EJERCICIO 7 ADICIONAL

# cogemos el primer apellido
PrimerApellido <- cutw(NombreApellidos, from=0.5,to=1, output="Wave")
listen(PrimerApellido)

# cogemos el segundo apellido
SegundoApellido <- cutw(NombreApellidos, from=1,to=1.35, output="Wave")
listen(SegundoApellido)

# borramos los apellidos
NombreSinApellidos <- deletew(NombreApellidos, output="Wave", from = 0.5, to = 1.35)
listen(NombreSinApellidos)

# insertamos el segundo apellido como el primero
NombreCambioPrimerApellido <- pastew(SegundoApellido , NombreSinApellidos, output="Wave")
listen(NombreCambioPrimerApellido )

#insertamos el primer apellido como el segundo
NombreCambioPrimerSegundoApellido <- pastew(PrimerApellido, NombreCambioPrimerApellido , output="Wave")
listen(NombreCambioPrimerSegundoApellido)

# guardamos en disco el fichero de sonido resultante
writeWave(NombreCambioPrimerSegundoApellido, file.path("nombreCambioPrimerSegundoApellido.wav"))

#					EJERCICIO ADICIONAL 8

#aumentamos el tono y la velocidad modificando la frecuencia de muestreo
NombreApellidosAumentado <- NombreApellidos
NombreApellidosAumentado@samp.rate <- round(NombreApellidos@samp.rate * 1.5)
listen(NombreApellidosAumentado)
writeWave(NombreApellidosAumentado, file.path("nombreApellidosAumentado.wav"))

#					EJERCICIO ADICIONAL 9

# combinación de segmentos de manera aleatoria a partir del nombre y apellidos 
tSeg <- 0.3 
tamSeg <- round(tSeg * NombreApellidos@samp.rate)
numSeg <- floor(length(NombreApellidos@left) / tamSeg)

segmentos <- list()
for(i in 1:numSeg) {
  inicio <- (i - 1) * tamSeg + 1
  fin <- i * tamSeg 
  segmentos[[i]] <- extractWave(NombreApellidos, from = inicio, to = fin)
}

reordenaSeg <- sample(segmentos, length(segmentos))

combinaSeg <- reordenaSeg[[1]]
for(i in 2:length(reordenaSeg)){
  combinaSeg <- pastew(combinaSeg , reordenaSeg[[i]], output="Wave")
}
listen(combinaSeg)
writeWave(combinaSeg, file.path("combinaSegmentosNombreApellidos.wav"))

#					EJERCICIO ADICIONAL 10

# Efecto con retraso atenuado (eco muy seguido)
retardo <- 0.2
muestrasRetardo <- round(retardo * NombreApellidos@samp.rate)
factorAtenuacion <- 0.6 

versionRetraso <- c(rep(0, muestrasRetardo), NombreApellidos@left[1:(length(NombreApellidos@left) - muestrasRetardo)])

retrasoAtenuado <- NombreApellidos
retrasoAtenuado @left <- retrasoAtenuado@left + versionRetraso * factorAtenuacion 

listen(retrasoAtenuado )
writeWave(retrasoAtenuado, file.path("retrasoAtenuado.wav"))

#					EJERCICIO ADICIONAL 11

# efecto de chorus
retrasoChorus <- round(0.03 * NombreApellidos@samp.rate)
chorus <- NombreApellidos

chorus@left <- chorus@left + c(rep(0, retrasoChorus), chorus@left[1:(length(chorus@left)-retrasoChorus)]) * 0.5

listen(chorus)
writeWave(chorus, file.path("chorus.wav"))





