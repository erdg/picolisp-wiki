# 21jul14abu
# (c) Software Lab. Alexander Burger

(must "User Administration" Wiki)

(menu "User Administration"
   (idForm "User" '(choUser) 'nm '+User
      '(or (may UserAdmin) (== *Login (: home obj)))
      '(or (may Delete) (== *Login (: home obj)))
      '((: nm))
      (<grid> 2
         "Login Name" (gui '(+E/R +Cue +TextField) '(nm : home obj) "User" 30)
         "Password"
         (gui '(+Able +PasswdField)
            '(or (may Password) (== *Login (: home obj)))
            30 )
         "Role"
         (gui '(+Able +E/R +Obj +TextField)
            '(may RoleAdmin)
            '(role : home obj)
            '(nm +Role)
            T )
         "Full Name" (gui '(+E/R +TextField) '(name : home obj) 40)
         "EMail" (gui '(+E/R +MailField) '(em : home obj) 40)
         "Picture"
         (prog
            (gui '(+Able +UpField) '(not (: home obj jpg)) 30)
            (gui '(+Drop +Button) '(field -1)
               '(if (: home obj jpg) "Uninstall" "Install")
               '(cond
                  ((: home obj jpg)
                     (ask "Uninstall Picture?"
                        (put!> (: home top 1 obj) 'jpg NIL) ) )
                  ((: drop) (blob! (: home obj) 'jpg @)) ) ) )
         NIL
         (gui '(+Upd +Img) 
            '(and (: home obj jpg) (allow (blob (: home obj) 'jpg)))
            "Picture" )
         "Created" (gui '(+Able +E/R +DateField) '(may System) '(ca : home obj) 10)
         "New" (gui '(+Able +E/R +Checkbox) '(may System) '(new : home obj)) )
      (gui '(+QueryChart) 12
         '(goal
            (quote
               @User (list (cons (: home obj) T) (: home obj))
               (db u +Mup @User @@) ) )
         3
         '((This) (list This (: t) (: sum))) )
      (<table> 'chart "Postings"
         '((em7 "Date") (em7 "Time") (NIL "Summary"))
         (do 12
            (<row> (alternating)
               (gui 1 '(+ObjView +DateField) '(: d))
               (gui 2 '(+TimeField))
               (gui 3 '(+TextField)) ) ) )
      (scroll 12)
      (<spread> NIL
         (editButton '(or (may UserAdmin) (== *Login (: home obj)))) ) ) )

# vi:et:ts=3:sw=3
