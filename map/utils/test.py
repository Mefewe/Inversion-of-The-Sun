import re
fileprovinces = open('definition.csv')
fileprovincestext = fileprovinces.read()
fileprovinces.close()
provs = fileprovincestext.split('\n')
#lastestprovid = re.sub(r'\A(.*?);(.*?);(.*?);(.*?);(.*?);(.*?);(.*?);(.*?)$', r"\1",provs[len(provs)-1])
#print(lastestprovid)

search = re.findall(re.compile(r'.*?;{};{};{};.*?;.*?;.*?;.*?\Z'.format("141","181","88")),fileprovincestext)
print(search)
