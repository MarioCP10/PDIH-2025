import cv2

#Cargamos el clasificador en cascada para detección facial
cascadaRostro = cv2.CascadeClassifier('haarcascade_frontalface_alt.xml')

#Cargamos la imagen indicando la ruta de esta
imagen = cv2.imread("Marvel.jpeg")
#Conversión a escalas de grises
gris = cv2.cvtColor(imagen, cv2.COLOR_BGR2GRAY)

#Detectamos rostros usando el clasificador
rostros = cascadaRostro.detectMultiScale(gris, scaleFactor=1.1, minNeighbors=5)

#Dibujar rectángulos en las caras
for (x, y, w, h) in rostros:
    cv2.rectangle(imagen, (x, y), (x + w, y + h), (0, 255, 0), 2)

#Guardamos la imagen
cv2.imwrite("resultado.jpg", imagen)
