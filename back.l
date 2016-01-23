# 02dec14abu
# (c) Software Lab. Alexander Burger

(unless (= *PW (pw))
   (quit "back.l" *PW) )

(load "@lib/too.l")
(admin
   ## (call "sh" "-c" "tar cfz bak/wiki$(date +%a).tgz db/wiki/")
   (snapshot "/bak/wiki" "db/wiki") )

# vi:et:ts=3:sw=3
