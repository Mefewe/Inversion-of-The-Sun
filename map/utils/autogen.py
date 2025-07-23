from PIL import Image, ImageDraw
import random
import re
import os
current_directory = os.getcwd()
print(f"Текущая рабочая директория: {current_directory}")
image = Image.open('test2.bmp') 
width = 2000
coordinate=0

for i in range(200):
    R, G, B = random.randint(85,254), random.randint(85,254), random.randint(80,254)
    fileprovinces = open('definition.csv')
    fileprovincestext = fileprovinces.read()
    fileprovinces.close()
    search = re.findall(re.compile(r'.*?;{};{};{};.*?;.*?;.*?;.*?$'.format(R,G,B)),fileprovincestext)
    if search:
        print("Эти значения уже использовались!")
    else:
        provs = fileprovincestext.split('\n')
        lastestprovid = re.sub(r'\A(.*?);(.*?);(.*?);(.*?);(.*?);(.*?);(.*?);(.*?)$', r"\1",provs[len(provs)-1])
        with open('definition.csv', 'a') as file:
            file.write('\n{};{};{};{};land;false;plains;1'.format(str(int(lastestprovid)+1),R,G,B))
        image.putpixel((coordinate, 0), (int(R),int(G),int(B)))
        coordinate += 1
image.save('testnew2.bmp')
