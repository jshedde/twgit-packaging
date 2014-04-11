
clean:
	rm -rf twgit*deb
	rm -rf usr

build: clean
	git clone https://github.com/Twenga/twgit usr/local/share/twgit
	fpm -a all -s dir -t deb -n twgit -v 1.14.2-0ubuntu1 -C . --after-install after-install.sh --before-remove before-remove.sh usr/local/share/twgit/
