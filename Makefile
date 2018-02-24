SHELL = /bin/sh
.PHONY: bundle-install sunzi

bundle-install:
	bundle install

sunzi: bundle-install
	cd sunzi; bundle exec sunzi deploy ubu16 web --sudo
	cd sunzi; bundle exec sunzi deploy ubu16 db --sudo

run-warietan-deploy:
	cd warietan-deploy; bundle exec ruby ./app.rb -p 3002
