#!/bin/bash
##  strip routine adapted from ArchLinux's makepkg script.

#   makepkg - make packages compatible for use with pacman
#   @configure_input@
#
#   Copyright (c) 2006-2015 Pacman Development Team <pacman-dev@archlinux.org>
#   Copyright (c) 2002-2006 by Judd Vinet <jvinet@zeroflux.org>
#   Copyright (c) 2005 by Aurelien Foret <orelien@chez.com>
#   Copyright (c) 2006 by Miklos Vajna <vmiklos@frugalware.org>
#   Copyright (c) 2005 by Christian Hamar <krics@linuxforum.hu>
#   Copyright (c) 2006 by Alex Smith <alex@alex-smith.me.uk>
#   Copyright (c) 2006 by Andras Voroskoi <voroskoi@frugalware.org>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

abreqexe strip file

elf_iself()
{
	file -F $'\n' "$1" | grep -q '^ ELF'
}

elf_strip()
{
	case "$(readelf -h $1)" in
		*Type:*'DYN (Shared object file)'*)
			strip --strip-unneeded --remove-section=.comment --remove-section=.note $1 ;;
                *Type:*'EXEC (Executable file)'*)
			strip --strip-all --remove-section=.comment --remove-section=.note $1 ;;
		*Type:*'REL (Relocatable file)'*)
			case "$1" in
				*.ko)
					strip --strip-unneeded --remove-section=.comment --remove-section=.note $1 ;;
				*)
					strip --strip-debug --enable-deterministic-archives --remove-section=.comment --remove-section=.note $1 ;;
			esac ;;
		*)
			true ;;
	esac
}

