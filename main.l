# 01dec14abu
# (c) Software Lab. Alexander Burger

(allowed ("wiki/" "db/wiki/blob/")
   *PW "!work" "!stop" "@lib.css" "!latex" "!pdf" "!psh"
   *PRG *Search "!download"
   "!home"
)


(scl 2)
(load
   "@lib/http.l" "@lib/xhtml.l" "@lib/form.l" "@lib/tex.l" "@lib/adm.l"
   "@lib/socialshareprivacy/lib.l"
   "@lib/boss.l" )

(setq
   *Pool "db/wiki/"
   *Blob "db/wiki/blob/"
   *Jnl (and (info "fifo/wiki") "fifo/wiki")
   *Salt (16 . "$6$@1$")
   #*Css '("wiki/css/ungrid.css" "wiki/css/container.css")
   *WikiPort 5000 )

(setq *WikiCss 
   (list
      "wiki/css/ungrid.css" 
      "wiki/css/container.css" 
      "wiki/css/typograph.css"
      "wiki/css/responsive-utils.css"
      "wiki/wiki.css") )

(setq *HomeCss 
  (list
    #"css/normalize.css"
    "wiki/css/utils.css" 
    "wiki/css/responsive-utils.css"
    "wiki/css/ungrid.css" 
    "wiki/css/container.css"
    "wiki/css/typography.css"
    "https://fonts.googleapis.com/css?family=Exo:700,500,300"
    "wiki/css/forms.css"
    "wiki/css/nav.css"
    "wiki/css/header.css"
    "wiki/css/main-page.css") )

(load "wiki/er.l" "wiki/lib.l" "wiki/gui.l" "wiki/home.l")

(permission
   Wiki        "Edit Wiki Documents"
   System      "Edit System Data"
   Upload      "File upload"
   RoleAdmin   "Role Administration"
   UserAdmin   "User Administration"
   Password    "Password"
   Delete      "Delete" )

(mime "d" NIL 120)

# Entry point
(de main ()
   (call 'mkdir "-p" *Pool *Blob)
   (pool *Pool *Dbs *Jnl)
   (unless (seq *DB)
      (load "wiki/init.l") )
   (unless (db 'nm '+Doc "home")
      (msg "No home document") )
   (if (db 'nm '+Doc "menu")
      (setq *WikiMenu (id @ T))
      (msg "No menu document") ) )

(de go ()
   (rollback)
   (retire 20)
   (gc 4)
   (server (or (format (sys "PORT")) *WikiPort) "!work") )

# vi:et:ts=3:sw=3
