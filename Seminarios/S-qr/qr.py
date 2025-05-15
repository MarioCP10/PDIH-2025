import qrcode

def generaQR(cadena, nombre_archivo):
    #Configuración del QR code
    qr = qrcode.QRCode(
        version=1,  
        error_correction=qrcode.constants.ERROR_CORRECT_L, 
        box_size=10, 
        border=4, 
    )

    #Añadimos la información que queremos codificar
    qr.add_data(cadena)
    qr.make(fit=True)

    #Generamos la imagen del QR code
    imagen = qr.make_image(fill_color="black", back_color="white")

    #Guardamos la imagen
    imagen.save(nombre_archivo)
    return nombre_archivo

if __name__ == "__main__":
    cadena = input("Introduce el texto a codificar en el QR: ")
    nombre_archivo = input("Introduce el nombre del archivo: ")

    generaQR(cadena, nombre_archivo)
    print(f"Código QR generado y guardado en: {nombre_archivo}")
