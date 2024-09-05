SHELL = /bin/sh
help:
	@echo "make install      install betterfetch"
	@echo "make uninstall     remove betterfetch"
	@echo "make help           show this message"

install:
	cp nudo.sh /usr/bin/nudo
	sudo chmod +x /usr/bin/nudo

uninstall:
	rm /usr/bin/nudo

