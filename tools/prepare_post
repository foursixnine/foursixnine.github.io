#!/usr/bin/ruby
require 'date'

@postDate = Date.today.to_s() 
puts "Layout type?: "
@layout = 'post' # $stdin.readline.chomp()?
puts "Title?: "
@title = $stdin.readline.chomp()
#category = $stdin.readline
@permalink = @title.tr(' ','-')+'.md'

def template

<<-HEREDOC
---
layout: #{@layout}
title: #{@title}
categories:
- blog
generated on: #{@postDate}
---
![Insomnia from XKCD](https://imgs.xkcd.com/comics/insomnia.png)
HEREDOC
end
puts template()
File.write("_posts/#@postDate-#@permalink", template())
