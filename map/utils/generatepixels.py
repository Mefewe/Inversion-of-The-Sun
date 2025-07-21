from PIL import Image, ImageDraw
import re
import os
current_directory = os.getcwd()
print(f"Текущая рабочая директория: {current_directory}")

image = Image.open('test.bmp') 
width = 2000


fileerrors = open('errorlog.txt')
fileerrorstext = fileerrors.read()
fileerrors.close()
errorprovinces = fileerrorstext.split("\n")

fileprovinces = open('../definition.csv')
fileprovincestext = fileprovinces.read()
fileprovince = fileprovincestext.split("\n")
fileprovinces.close()

def getRGB(provid):
    res = re.sub(re.compile(r'{};(.*?);(.*?);(.*?);(.*?);(.*?);(.*?);(.*?)'.format(provid)), r"\1 \2 \3",fileprovince[int(provid)])
    return res.split(" ")

prov = 0
for x in range(width):
    if prov <= len(errorprovinces)-1:
        provid = errorprovinces[prov]
        rgb = getRGB(provid)
        print(rgb)
        image.putpixel((x, 0), (int(rgb[0]),int(rgb[1]),int(rgb[2][:-1])))
        prov += 1
    else:
        break

image.save('test.bmp')
print ('DONE')
