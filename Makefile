# Vim makefile
# (c) Nikolas Skoufis, 2015
# Last updated: 11/10/15
# 
# This script should update any submodules, install the vimrc file and then
# should compile YouCompleteMe
#
update:
	@echo "Updating submodules"
	git submodule update --remote --merge --recursive
	@echo "Note: If the YCM libs have changed, you may need to recompile"
	@echo "YCM should notify you of this when you next launch Vim"


install: install-externals install-core

install-core:
	@echo "Core install tasks."
	@echo "Backing up your .zshrc iff neccessary..."
	!(ls $(HOME)/.vimrc > /dev/null 2> /dev/null) || mv $(HOME)/.vimrc $(PWD)/vimrc.bak # Make backup of -vimrc if necessary
	@echo "Creating .vimrc in your home directory..."
	@ln -s $(PWD)/vimrc $(HOME)/.vimrc # update the link to .vimrc
	@echo "Compiling YouCompleteMe"
	@echo "If this fails, consult the documentation at https://github.com/Valloric/YouCompleteMe#full-installation-guide"
	@echo "Creating a directory to build in"
	@mkdir $(PWD)/ycm_build
	@echo "Compiling YCM"
	@cd $(PWD)/ycm_build: cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
	@echo "Making YCM support libs"
	@cd $(PWD)/ycm_build: make ycm_support_libs
	@echo "DONE with core install tasks."

install-externals:
	@echo "Installing external dependencies (Vundle)"
	git submodule update --init --recursive
