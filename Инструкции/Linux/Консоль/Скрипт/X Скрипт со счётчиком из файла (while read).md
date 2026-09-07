



#### Пример качественного скрипта:
```bash
cat > sum.sh << 'EOF'
#!/bin/sh

s="0"
while read -r n; do
    s=$((s + n))
done < input.txt

echo "$s"
EOF

#Использована опция -r у read, чтобы не интерпретировать обратные слеши (даже если их нет — привычка хорошая).
```

```bash
cat > sum.sh << 'EOF'
#!/bin/sh

awk '{s+=$1} END {print s}' input.txt
EOF

#То же самое тольео через awk
```