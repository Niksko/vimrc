# Niksko's Vimrc

This is my personal vimrc, with bits and pieces of config accumulated over time

Lots of the config here is based off of Doug Black's [A Good Vimrc](http://dougblack.io/words/a-good-vimrc.html)
and from the comments of the [Reddit thread](https://www.reddit.com/r/linux/comments/3o7lel/a_good_vimrc/),
particularly [this comment](https://www.reddit.com/r/linux/comments/3o7lel/a_good_vimrc/cvutodo).

## Instructions

Clone this repository into a directory in your home directory called .zsh.
Run the following from your home directory:

```
git clone https://github.com/Niksko/vimrc .vim
```

Now we have do some additional setup like symlinking .vim to the included
vimrc, loading the Vundle plugins and compiling and making YCM.

Do this with the following from your .vim directory

```
make install
```
