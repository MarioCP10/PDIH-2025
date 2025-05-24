import sys
from PIL import Image, ExifTags

img = Image.open(sys.argv[1])
img_exif = img.getexif()
print(type(img_exif))

if img_exif is None:
     print("La imagen no tiene metadatos EXIF.")
else:
 img_exif_dict = dict(img_exif)
 print(img_exif_dict)
 for key, val in img_exif_dict.items():
     if key in ExifTags.TAGS:
         print(f"{ExifTags.TAGS[key]}:{repr(val)}")
