# Rikiki
A Minimalist wiki created with sinatra, haml, sass, jQuery and twitter bootstrap

Version: **0.2 - works and usable GUI**

## wiki where you are, as you want !
rikiki create markdown files (.md) in the pages directory, you can edit them directly in your web browser using rikiki or on your desktop with the excellent application [Moi](http://mouapp.com/).

I personally use it placed in my [DropBox](http://www.dropbox.com). So I can :

- use and edit pages on my iPhone
- get wiki sync on all my machines

# Usage

clone this repo

	git clone git://github.com/yarmand/rikiki.git

You can simply start ruby interpreter

	ruby rikiki.rb

But rikiki have a rack standard ``config.ru`` so you can easily install it with [Pow](http://pow.cx/), [Passenger](http://www.modrails.com/) or any rack deployment system.
	

# todo

- add version on pages with git
- use [kickStrap](http://ajkochanowicz.github.com/Kickstrap/index.html) to make user customize aspect easily
- Test server side
- Tests client side
- make it a gem
- create a gem binary to create new rikiki wikis instantly, [Pow](http://pow.cx/) enabled
