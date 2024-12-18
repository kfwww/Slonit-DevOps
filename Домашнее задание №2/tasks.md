# Домашнее задание №1

---

## Задание 1
```bash
[root@Server log]# cd /var/log && last -n 7 -f wtmp
root     pts/0        178.71.58.38     Thu Nov 21 19:31   still logged in
root     pts/0        178.71.58.38     Thu Nov 21 18:15 - 18:46  (00:30)
root     pts/0        178.71.58.38     Thu Nov 21 18:10 - 18:14  (00:03)
root     pts/0        178.71.58.38     Tue Nov 12 03:52 - 05:06  (01:13)
root     pts/0        178.71.58.38     Tue Nov 12 02:12 - 03:46  (01:34)
root     pts/0        178.71.58.38     Mon Nov 11 20:59 - 02:07  (05:07)
root     pts/0        178.71.58.38     Sun Nov 10 19:56 - 22:22  (02:25)

wtmp begins Wed Sep 21 08:11:39 2022
```

---

## Задание 2
```bash
[root@Server ~]# logger -p kern.info "Добра и мира посланникам из Альфа-Центавра!"
[root@Server ~]# journalctl | grep "Добра и мира"
Nov 21 20:39:27 Server.local root[210213]: Добра и мира посланникам из Альфа-Центавра!
```

---

## Задание 3
```bash
[root@Server ~]# journalctl -u systemd-logind -n 25
-- Logs begin at Thu 2024-11-07 16:02:53 UTC, end at Thu 2024-11-21 20:39:27 UTC. --
Nov 21 18:10:52 Server.local systemd-logind[673]: New session 9 of user root.
Nov 21 18:14:39 Server.local systemd-logind[673]: Session 9 logged out. Waiting for processes to exit.
Nov 21 18:14:39 Server.local systemd-logind[673]: Removed session 9.
Nov 21 18:15:17 Server.local systemd-logind[673]: New session 11 of user root.
Nov 21 18:46:08 Server.local systemd-logind[673]: Session 11 logged out. Waiting for processes to exit.
Nov 21 18:46:08 Server.local systemd-logind[673]: Removed session 11.
Nov 21 19:31:48 Server.local systemd-logind[673]: New session 13 of user root.
Nov 21 20:25:20 Server.local systemd-logind[673]: Session 13 logged out. Waiting for processes to exit.
Nov 21 20:25:20 Server.local systemd-logind[673]: Removed session 13.
Nov 21 20:26:01 Server.local systemd-logind[673]: New session 15 of user root.
```

---

## Задание 4
```bash
[root@Server ~]# sudo vi /etc/rsyslog.d/mylog.conf
```
Записать в редакторе:
```bash
*.info    /var/log/my.log
```
Сохранить и закрыть редактор.

```bash
[root@Server ~]# sudo systemctl restart rsyslog
[root@Server ~]# logger -p user.info "Hello :)"
[root@Server ~]# cat /var/log/my.log | grep "Hel"
Nov 21 21:17:48 Server root[210292]: Hello :)
```

---

## Задание 5
```bash
[root@Server rsyslog.d]# sudo nano /etc/rsyslog.d/ssh.conf
```
Записать в редакторе:
```bash
if $programname == 'sshd' then /var/log/ssh.log
& stop
```
Сохранить и закрыть редактор.
```bash
[root@Server logrotate.d]# sudo nano /etc/logrotate.d/ssh
```
Записать в редакторе:
```bash
/var/log/ssh.log {
    daily 
    rotate 10
    size 1M 
    compress 
    missingok
    notifempty 
    create 0600 root root
}
```
Сохранить и закрыть редактор.
```bash
[root@Server logrotate.d]# sudo systemctl restart rsyslog
[root@Server logrotate.d]# ls /var/log/ | grep ssh
ssh.log
ssh.log.1.gz
```

---

## Задание 6
```bash
[root@Server logrotate.d]# journalctl -b
[root@Server logrotate.d]# journalctl --since "1 hour ago" -b
```