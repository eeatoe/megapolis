=begin
secure: true – заставляет браузер отправлять куки только по HTTPS.
httponly: true – запрещает JavaScript доступ к куки, защищая от XSS-атак.
same_site: :strict – запрещает передачу куки при переходе с других сайтов.
:cookie_store – в RoR 7+ шифрует куки, так что их кража бесполезна.
=end

Rails.application.config.session_store :cookie_store, 
  key: '_megapolis_session', 
  secure: Rails.env.production?, 
  httponly: true, 
  same_site: :strict, 
  expire_after: 14.day
