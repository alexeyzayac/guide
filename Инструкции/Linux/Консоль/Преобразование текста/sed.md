### Команда sed

```bash
# Например заменить .jpg на .pngecho image.jpg
$ echo image.jpg | sed 's/\.jpg/.png/'
image.png

sed 's/old/new/' file #печатает результат в stdout, файл не меняет

sed -i 's/old/new/' file #правит файл на месте

sed 's/old/new/g' file #заменить все вхождения в каждой строке (без g - только первое).
```