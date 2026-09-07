## Контекст

Базовая ветка «делать X, если условие Y» - половина скриптов на проде: если порт занят - перейти на запасной, если конфига нет - взять дефолтный, если место кончается - алертить.

## Подсказки

- `[ -e file ]` - путь существует (любого типа).
- `[ -f file ]` - обычный файл.
- `[ -d dir ]` - каталог.
- `[ -L link ]` - симлинк.
- `[ -r file ]` / `[ -w file ]` / `[ -x file ]` - читается / пишется / исполняется.
- Сокращённый if: `[ -e file ] && echo exists || echo missing` (но опасно: если echo exists упадёт, выполнится echo missing).
- Классическое: `if … then … else … fi`.

#### Пример качественного скрипта:
```bash
cat > check.sh << 'EOF'
#!/bin/sh
[ -e /tmp/secret ] && echo exists || echo missing
EOF
```
```bash
cat > check.sh << 'EOF'
#!/bin/sh
if [ -e /tmp/secret ]; then
  echo exists;
else
  echo missing;
fi
EOF
```
