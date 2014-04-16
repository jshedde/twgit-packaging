
clean:
	rm -rf twgit*deb
	rm -rf usr

build: clean
	git clone https://github.com/Twenga/twgit usr/local/share/twgit
	sed -i 's#TWGIT_HISTORY_LOG_PATH="$$TWGIT_ROOT_DIR/#TWGIT_HISTORY_LOG_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_HISTORY_ERROR_PATH="$$TWGIT_ROOT_DIR/#TWGIT_HISTORY_ERROR_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	sed -i 's#TWGIT_UPDATE_PATH="$$TWGIT_ROOT_DIR/#TWGIT_UPDATE_PATH="$$HOME/.twgit#g' usr/local/share/twgit/conf/twgit-dist.sh
	fpm -a all -s dir -t deb -n twgit -v 1.14.2-0ubuntu1 -C . --after-install after-install.sh --before-remove before-remove.sh usr/local/share/twgit/
