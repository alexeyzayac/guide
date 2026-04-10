```bash
#вывод подобный cut
$ paste prm.txt2
Alexey
Egor
Artem

#объединяет соответствующие строки из разных файлов в одну строку вывода
$ paste test2.txt prm.txt3
Artem	Alexey
Alexey	Egor
Andrey	Artem

# (-s) последовательное объединение строк внутри каждого файла 
$ paste -s test2.txt prm.txt3
Artem	Alexey	Andrey
Alexey	Egor	Artem

# (-d,) изменить разделитель на другой символ 
$ paste -sd, test2.txt prm.txt3
Artem,Alexey,Andrey
Alexey,Egor,Artem

# (-d "\n") символ новой строки чередует строки
$ paste -d "\n" test2.txt prm.txt3
Artem
Alexey
Alexey
Egor
Andrey
```