TWGIT_VERSION=1.15.1
DEB_VERSION=1
DESCRIPTION=Twgit is a free and open source assisting tools for managing features, hotfixes and releases on Git repositories.
MAINTAINER=Jean-Sébastien Hedde <jeanseb@au-fil-du.net>

FILE=twgit_$(TWGIT_VERSION)-0ubuntu$(DEB_VERSION)_all.deb
REPOSITORY_DIR=/home/lafourchette/www/apt/lafourchette
REPOSITORY_HOST=lafourchette@dev7

clean:
	rm -rf twgit*deb
	rm -rf usr

build: clean
	git clone https://github.com/Twenga/twgit usr/local/share/twgit
	cd usr/local/share/twgit; git checkout v$(TWGIT_VERSION)
	sed -i 's#TWGIT_HISTORY_LOG_PATH="$$TWGIT_ROOT_DIR/#TWGIT_HISTORY_LOG_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_HISTORY_ERROR_PATH="$$TWGIT_ROOT_DIR/#TWGIT_HISTORY_ERROR_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_UPDATE_PATH="$$TWGIT_ROOT_DIR/#TWGIT_UPDATE_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_UPDATE_AUTO=1#TWGIT_UPDATE_AUTO=0#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#local_config_file="$${TWGIT_USER_REPOSITORY_ROOT_DIR:-.}/.twgit"#local_config_file="$$HOME/.twgit"#g' usr/local/share/twgit/twgit
	fpm -a all -s dir -t deb --description "$(DESCRIPTION)" \
       --maintainer "$(MAINTAINER)" \
       -n twgit \
       -v $(TWGIT_VERSION)-0ubuntu$(DEB_VERSION) \
       --url https://github.com/Twenga/twgit \
       --depends 'git-core >= 1:1.7.2' \
       -C . \
       --after-install after-install.sh \
       --before-remove before-remove.sh \
       usr/local/share/twgit/

publish:
	scp $(FILE) $(REPOSITORY_HOST):$(REPOSITORY_DIR)/incoming
	ssh $(REPOSITORY_HOST) reprepro -Vb $(REPOSITORY_DIR) includedeb lucid $(REPOSITORY_DIR)/incoming/$(FILE)
