export SRCDIR="$PWD"
export PKGDIR="$PWD/abdist"

# Autobuild settings
recsr $AB/etc/defaults/*

. autobuild/defines || return 1

if [ -d $AB/spec ]; then
	recsr $AB/spec/*.sh
fi

for i in `cat $AB/params/*`; do
	export $i
done

export PYTHON=/usr/bin/python2