# Vim makefile
# (c) Nikolas Skoufis, 2015
# Last updated: 11/10/15
# 
# This script should update any submodules, install the vimrc file and then
# should compile YouCompleteMe

# Color code variables for pretty output
ccgreen=$(shell echo -e "\033[1;32m")
ccyellow=$(shell echo -e "\033[1;33m")
ccred=$(shell echo -e "\033[1;31m")
ccend=$(shell echo -e "\033[0m")

update:
	@echo "${ccyellow}Updating submodules$(ccend)"
	git submodule update --remote --merge --recursive
	@echo "${ccred}Note: If the YCM libs have changed, you may need to recompile"
	@echo "YCM should notify you of this when you next launch Vim$(ccend)"

install: backup-vimrc install-vundle install-plugins build-ycm install-core

install-core:
	@echo "$(ccyellow)Core install tasks."
	@echo "Link to real vimrc$(ccend)"
	ln -s $(PWD)/vimrc $(HOME)/.vimrc # link to real vimrc
	@echo "$(ccgreen)DONE with core install tasks.$(ccend)"

backup-vimrc:
	@echo "$(ccyellow)Backing up your .vimrc iff neccessary...$(ccend)"
	!(ls $(HOME)/.vimrc > /dev/null 2> /dev/null) || mv $(HOME)/.vimrc $(PWD)/vimrc.bak # Make backup of -vimrc if necessary

install-plugins:
	@echo "$(ccyellow)Linking to temporary vimrc for installing Vundle plugins"
	@echo "Creating temporary vimrc$(ccend)"
	cat $(PWD)/vimrc | awk 'NR==1,/^call vundle#end()/' > temp_vimrc # Grab only the plugin portion of the vimrc into a temporary file
	@ln -s $(PWD)/temp_vimrc $(HOME)/.vimrc # link to the temporary vimrc
	@echo "$(ccyellow)Install Vundle plugins$(ccend)"
	vim +PluginInstall +qall
	@echo "$(ccyellow)Delete temporary vimrc$(ccend)"
	rm $(PWD)/temp_vimrc

build-ycm:
	@echo "$(ccyellow)Compiling YouCompleteMe"
	@echo "$(ccred)If this fails, consult the documentation at https://github.com/Valloric/YouCompleteMe#full-installation-guide"
	@echo "$(ccyellow)Creating a directory to build in$(ccend)"
	mkdir $(PWD)/ycm_build
	@echo "$(ccyellow)Compiling YCM$(ccend)"
	cd $(PWD)/ycm_build; cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
	@echo "$(ccyellow)Making YCM support libs$(ccend)"
	cd $(PWD)/ycm_build; make ycm_support_libs
	@echo "$(ccyellow)Remove build directory$(ccend)"
	rm -rf $(PWD)/ycm_build

install-vundle:
	@echo "$(ccyellow)Installing Vundle$(ccend)"
	git submodule update --init --recursive
