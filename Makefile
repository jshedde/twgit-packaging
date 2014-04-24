TWGIT_VERSION=1.14.2
DEB_VERSION=3
DESCRIPTION=Twgit is a free and open source assisting tools for managing features, hotfixes and releases on Git repositories.
MAINTAINER=Jean-Sébastien Hedde <jeanseb@au-fil-du.net>

clean:
	rm -rf twgit*deb
	rm -rf usr

build: clean
	git clone https://github.com/Twenga/twgit usr/local/share/twgit
	sed -i 's#TWGIT_HISTORY_LOG_PATH="$$TWGIT_ROOT_DIR/#TWGIT_HISTORY_LOG_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_HISTORY_ERROR_PATH="$$TWGIT_ROOT_DIR/#TWGIT_HISTORY_ERROR_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_UPDATE_PATH="$$TWGIT_ROOT_DIR/#TWGIT_UPDATE_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_UPDATE_AUTO=1#TWGIT_UPDATE_AUTO=0#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#local_config_file="${TWGIT_USER_REPOSITORY_ROOT_DIR:-.}/.twgit"#local_config_file="~/.twgit"#g' usr/local/share/twgit/twgit
	fpm -a all -s dir -t deb --description "$(DESCRIPTION)" --maintainer "$(MAINTAINER)" -n twgit -v $(TWGIT_VERSION)-0ubuntu$(DEB_VERSION) -C . --after-install after-install.sh --before-remove before-remove.sh usr/local/share/twgit/
