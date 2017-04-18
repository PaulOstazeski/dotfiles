.PHONY: all bin default dotfiles install

default: dotfiles bin

bin:
	# add aliases for things in bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name "*-backlight"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

dotfiles:
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done

vim_setup:
	mkdir -p $(HOME)/.vim_swap
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim -c PlugInstall -c q
	echo "You need to install rubocop, jshint, and eslint yourself for async linters"
	echo "You need to install rcodetools for eval-ing '#=>' inline
