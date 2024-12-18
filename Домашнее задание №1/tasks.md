# Домашнее задание №1

---

## Задание 1
```bash
[root@Server ~]# ip route get 1.1.1.1 | awk '{print $7}'
78.140.243.32
```

---

## Задание 2
```bash
[root@Server ~]# mkfifo /tmp/pipe
[root@Server ~]# ss -plnt > /tmp/pipe &
[1] 34532
[root@Server ~]# cat < /tmp/pipe > output.txt
[1]+  Done                    ss -plnt > /tmp/pipe 
```

---

## Задание 3
```bash
[root@Server ~]# mkfifo /tmp/logpipe
[root@Server ~]# cat /var/log/messages > /tmp/logpipe &
[1] 34662
[root@Server ~]# tar -czf archive.tar.gz -C /tmp logpipe
```

---

## Задание 4
```bash
[root@Server tmp]# date +%s | xargs -I{} date -d @{} +"%H:%M %d.%m.%Y"
03:34 12.11.2024
```

---

## Задание 5
```bash
[root@Server tmp]# cat <<BYE > message.txt
> h
> he
> hel
> hell
> hello
> hell
> hel
> he
> h
> BYE
[root@Server tmp]# cat message.txt
h
he
hel
hell
hello
hell
hel
he
h
```
