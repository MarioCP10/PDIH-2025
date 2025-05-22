
# install.packages('tuneR', dep=TRUE)
# install.packages('seewave', dep=TRUE)
# install.packages('soundgen', dep=TRUE)

library(tuneR)
library(seewave)
library(audio)

# establecer el path concreto en cada caso a la carpeta de trabajo
setwd("C:/Users/mario/OneDrive/Escritorio/PDIH/S5-P5-ejemplo/ejemplo")
# la siguiente linea solo para macOS
# setWavPlayer('/usr/bin/afplay')

# cargar archivos de sonido (wav/mp3):
perro <- readWave('perro.wav')
gato  <- readMP3('gato.mp3')

# mostrar la onda del sonido:
plot( extractWave(gato, from = 1, to = 393984) )
plot(extractWave(perro, from = 1, to = 159732) )

# mostrar los campos del archivo de sonido
str(gato)
str(perro)

# unión de ambos sonidos del gato y perro
GatoPerro <- pastew(perro, gato, output="Wave")

gato
perro
GatoPerro

# escuchar sonido
listen(GatoPerro)

# guardar el sonido
writeWave(GatoPerro, file.path("unidos.wav") )


