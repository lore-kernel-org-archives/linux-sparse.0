From: rubisher <rubisher@scarlet.be>
Subject: cgcc and REAL_CC help
Date: Thu, 17 Dec 2009 09:15:46 +0000
Message-ID: <4B29F6C2.7040800@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hel.is.scarlet.be ([193.74.71.26]:34929 "EHLO hel.is.scarlet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885AbZLQJPv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Dec 2009 04:15:51 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello all,

May be can I ask you some more help.

I trying to sparse a bit grub2 code but at some moment make call a sript wich failled with following error:
genkernsyms.sh: line 23: REAL_CC=gcc-4.4: command not found

this shell script is:
### The configure script will replace these variables.

: ${srcdir=/Sources/jso/Deb.grub2/exp-wrk1}
: ${CC=REAL_CC=gcc-4.4 /usr/bin/cgcc}

u=
grep "^#define HAVE_ASM_USCORE" config.h >/dev/null 2>&1 && u="_"

$CC -O0 -DGRUB_MACHINE_IEEE1275=1 -m32 -fno-stack-protector -Wbitwise -Wnon-pointer-null -DGRUB_SYMBOL_GENERATOR=1 -E -I. 
-Iinclude
-I"$srcdir/include" $* \
   | grep -v '^#' \
   | sed -n \
         -e '/EXPORT_FUNC *([a-zA-Z0-9_]*)/{s/.*EXPORT_FUNC *(\([a-zA-Z0-9_]*\)).*/'"$u"'\1 kernel/;p;}' \
         -e '/EXPORT_VAR *([a-zA-Z0-9_]*)/{s/.*EXPORT_VAR *(\([a-zA-Z0-9_]*\)).*/'"$u"'\1 kernel/;p;}' \
   | sort -u

Any idea how should I fix it?

Tia,
	J.

PS: I am runing a debian unstable with bash 4.0-7 dpkg as shell.
