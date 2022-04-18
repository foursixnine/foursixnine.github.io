---
layout: post
title: Interoperabilidad de Obsidian con Linux, iOS y OSX
categories:
- blog
- linux
- tech
- español
generated on: 2022-04-18
tags: #tooling #workflows #español #obsidian #interoperability
---

Hace tiempo en el grupo de Developers Ve en el mundo, preguntaba si alguien había utilizado Obsidian. Considerándome un power user de Evernote, sé lo que necesito, y en los años que llevo buscando una alternativa que funcione en linux, tenia el problema de que muy pocas realmente funcionan bien o siquiera tienen soporte para linux.

Decidí irme por [Obsidian](https://obsidian.md/), luego de considerar Notion y otras herramientas principalmente por los plugins, que tiene [Zettelkasten](https://es.wikipedia.org/wiki/Zettelkasten) como feature, esta pensado con las siguientes otras razones: 

- Es perfecto para [Zettelkasten](https://es.wikipedia.org/wiki/Zettelkasten) y para construir un segundo cerebro ([Building a Second Brain](https://robingeuens.com/blog/build-a-second-brain-obsidian)), y tiene un sistema de tags simple, pero poderoso.
- Soporte para Markdown _by default_.
- Los archivos están en mis dispositivos, no en la nube _by design_.
- Puedo elegir alternativas de respaldo, control de versiones y redundancia.
- Soporte para [Kanban Boards](obsidian://show-plugin?id=obsidian-kanban).
- Soporte para [Day Planners](https://github.com/lynchjames/obsidian-day-planner).
- Soporte para [Natural Language Dates](obsidian://show-plugin?id=nldates-obsidian) para cosas _like_: `@today`, `@tomorrow`.
- La interfaz es exactamente lo que me encanta de Sublime que es lo que había estado utilizando para tomar notas, junto a la aplicación de notas del teléfono y notas via el correo.
- Tiene un VIM mode :D.
- El [roadmap](https://trello.com/b/Psqfqp7I/obsidian-roadmap) promete.

![zettelkasten](https://upload.wikimedia.org/wikipedia/commons/1/1a/Zettelkasten_paper_schematic.png)

Revisando varias cosas, y realmente investigando un poco, llegue al siguiente workflow:

- Logre construir el workflow que hace lo que necesito:
	- Vault en git en mi VPS, en una instancia propia de gitea, la data es mia.
	- En Linux:
		- El manejo de las distintas _Vaults_ (Bóvedas) seria por **git** directamente.
			- [Nextcloud](nextcloud.com) como mecanismo de backup redundante en el [NAS](https://www.truenas.com/truenas-mini) en casa via *scsi* en un rpi.
			- A mediano, o largo plazo:
				- La solución de NAS podría ser FreeNAS, TrueNAS o Synology
				- VPS como gateway, utilizando vpn con wireguard para mantener todo en una red privada.
	- En *OSX*:
		- Seria igual que en _linux_, por **git** pero con la diferencia de que las bóvedas estarían alojadas en una carpeta en _iCloud_.
		- La llave ssh con permiso de escritura en el repo seria importada al _keystore_ (`ssh-add -K`), para que no de problemas a la hora de pedir contraseñas.
		- Queda pendiente revisar como hacer con las firmas de los commits con GPG, o _maybe_ usando [ssh para firmar commits](https://github.com/github/feedback/discussions/7744)
	- En *IOS*, los vaults se estarían abriendo via _iCloud_, dejando por fuera el manejo con git, mientras se agrega el soporte en para [ios/mobile en obsidian-git](https://github.com/denolehov/obsidian-git/issues/57).

![Conspiracy](https://media.giphy.com/media/l0IylOPCNkiqOgMyA/giphy-downsized.gif)

En un tiempo revisare este post, y actualizare seguramente a mi nuevo workflow... o hare una vista en retrospectiva de que pudo salir mejor, etc, sin embargo creo que la primera tarea que hare, sera escribir un plugin para poderlo integrar con la creación de posts de este blog, y utilizar el grafo de tags, que por ahora... se ve así:

![[images/blog_tag_cloud.png]]
