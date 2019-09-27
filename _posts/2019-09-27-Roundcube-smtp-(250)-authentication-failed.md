---
layout: post
title: Roundcube smtp (250) authentication failed
categories:
- blog
generated on: 2019-09-27
---

So, say you find yourself, somehow having the following error in the roundcube logs:

```
[27-Sep-2019 12:44:48 +0000]: <f930f680> PHP Error: SMTP server does not support authentication (POST /?_task=mail&_unlock=loading1569588324419&_framed=1&_lang=es&_action=send)
[27-Sep-2019 12:44:48 +0000]: <f930f680> SMTP Error: Authentication failure: SMTP server does not support authentication (Code: ) in /roundcube/program/lib/Roundcube/rcube.php on line 1674 (POST /correo/?_task=mail&_unlock=loading 1569588324419&_framed=1&_lang=es&_action=send)
```

You have tried everything, but still can't seem to be able to send email from roundcube, you keep getting this annoying
"SMTP (250) authentication failed" notification, every time you click "Send".

Well... Make sure that your server is connecting to the right place. It took me a while to realize that roundcube was
trying to connect to localhost, but somehow the authentication mechanism stopped working (it was before upgrading).

Since I don't really want to debug too much today (it's friday after all), and because my configuration/use case is
over ssl/tls, the solution to the probem was simply:

`$config['smtp_server'] = 'tls://services.host.co';`

Et voilà, ma chérie!

![It's alive!](https://media.giphy.com/media/xT5LMDi8H2A1FtLlpC/giphy.gif)
