ruby-curses-conway
==================

A Ruby implementation of [Conway's Game of Life](http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) using [Curses](http://www.ruby-doc.org/stdlib-2.0.0/libdoc/curses/rdoc/Curses.html)



###How to play

```sh
$ git clone git@github.com:aka-bo/ruby-curses-conway.git ~/game-of-life
$ cd ~/game-of-life
$ ./game.rb
```

###Troubleshooting

```
(path-to-ruby-install)/kernel_require.rb:45:in `require': cannot load such file -- curses (LoadError)
    from ./game.rb:3:in `<main>'
```

* ruby-curses-conway requires the curses library (it's in the name!).
* To resolve the above issue, ensure your version of ruby includes the curses lib:
    * On Ubuntu/Debian `sudo apt-get libncurses-dev` then recompile Ruby.
