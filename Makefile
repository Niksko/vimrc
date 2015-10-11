# Vim makefile
# (c) Nikolas Skoufis, 2015
# Last updated: 11/10/15
# 
# This script should update any submodules, install the vimrc file and then
# should compile YouCompleteMe

# Color code variables for pretty output
ccgreen=$(shell echo -e "\033[1;32m")
ccyellow=$(shell echo -e "\033[1;33m")
ccblue=$(shell echo -e "\033[1;34m")
ccend=$(shell echo -e "\033[0m")

update:
	@echo "${ccyellow}Updating submodules$(ccend)"
	git submodule update --remote --merge --recursive
	@echo "${ccblue}Note: If the YCM libs have changed, you may need to recompile"
	@echo "YCM should notify you of this when you next launch Vim$(ccend)"


install: install-externals install-core

install-core:
	@echo "$(ccyellow)Core install tasks."
	@echo "Backing up your .zshrc iff neccessary...$(ccend)"
	!(ls $(HOME)/.vimrc > /dev/null 2> /dev/null) || mv $(HOME)/.vimrc $(PWD)/vimrc.bak # Make backup of -vimrc if necessary
	@echo "$(ccyellow)Linking to temporary vimrc for installing Vundle plugins"
	@echo "Creating temporary vimrc"
	cat $(PWD)/vimrc | awk 'NR==1,/^call vundle#end()/' > temp_vimrc # Grab only the plugin portion of the vimrc into a temporary file
	@ln -s $(PWD)/temp_vimrc $(HOME)/.vimrc # link to the temporary vimrc
	@echo "Install Vundle plugins"
	vim +PluginInstall +qall
	@echo "Link to real vimrc"
	ln -s $(PWD)/vimrc $(HOME)/.vimrc # link to real vimrc
	@echo "Delete temporary vimrc"
	rm $(PWD)/temp_vimrc
	@echo "Compiling YouCompleteMe"
	@echo "If this fails, consult the documentation at https://github.com/Valloric/YouCompleteMe#full-installation-guide"
	@echo "Creating a directory to build in"
	mkdir $(PWD)/ycm_build
	@echo "Compiling YCM"
	cd $(PWD)/ycm_build: cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
	@echo "Making YCM support libs"
	cd $(PWD)/ycm_build: make ycm_support_libs
	@echo "DONE with core install tasks."

install-externals:
	@echo "Installing external dependencies (Vundle)"
	git submodule update --init --recursive
