From: Dan McGee <dan@archlinux.org>
Subject: 'make install' target issues
Date: Tue, 27 Oct 2009 19:37:45 -0500
Message-ID: <449c10960910271737s4acf67dfsf29daf25fed9b53b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50628 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004AbZJ1Ahk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Oct 2009 20:37:40 -0400
Received: by yxe17 with SMTP id 17so250534yxe.33
        for <linux-sparse@vger.kernel.org>; Tue, 27 Oct 2009 17:37:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I was updating the PKGBUILD for sparse for Arch Linux in the AUR
tonight (http://aur.archlinux.org/packages.php?ID=11999), and I
noticed something odd- all files were getting installed with 755
permissions, including headers, .a libraries, etc. It looks like the
following commit is the offender:

commit bb54f9a83eaa7c683e292a90fdfeebb54381c313
Author: Christopher Li <sparse@chrisli.org>
Date:   Fri Dec 26 01:37:01 2008 -0800
Subject: Clean up Makefile long lines

Is there something I am missing? By default, the install program
installs all files with rwxr-xr-x. I'd be happy to submit a patch to
fix this.

-Dan


$ tar tvf /home/makepkg/packages/sparse-0.4.2-1-x86_64.pkg.tar.gz
-rw-r--r-- root/root       477 2009-10-27 19:37 .PKGINFO
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/include/
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/share/
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/lib/
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/bin/
-rwxr-xr-x root/root    279776 2009-10-27 19:37 usr/bin/sparse
-rwxr-xr-x root/root    217280 2009-10-27 19:37 usr/bin/c2xml
-rwxr-xr-x root/root      9475 2009-10-27 19:37 usr/bin/cgcc
-rwxr-xr-x root/root    584320 2009-10-27 19:37 usr/lib/libsparse.a
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/lib/pkgconfig/
-rwxr-xr-x root/root       167 2009-10-27 19:37 usr/lib/pkgconfig/sparse.pc
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/share/licenses/
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/share/man/
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/share/man/man1/
-rwxr-xr-x root/root      3401 2009-10-27 19:37 usr/share/man/man1/sparse.1.gz
-rwxr-xr-x root/root       565 2009-10-27 19:37 usr/share/man/man1/cgcc.1.gz
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/share/licenses/sparse/
-rw-r--r-- root/root     11013 2009-10-27 19:37
usr/share/licenses/sparse/LICENSE
drwxr-xr-x root/root         0 2009-10-27 19:37 usr/include/sparse/
-rwxr-xr-x root/root       768 2009-10-27 19:37 usr/include/sparse/dissect.h
-rwxr-xr-x root/root      8771 2009-10-27 19:37 usr/include/sparse/ptrlist.h
-rwxr-xr-x root/root      1749 2009-10-27 19:37 usr/include/sparse/storage.h
-rwxr-xr-x root/root      2269 2009-10-27 19:37 usr/include/sparse/allocate.h
-rwxr-xr-x root/root      1392 2009-10-27 19:37 usr/include/sparse/flow.h
-rwxr-xr-x root/root       713 2009-10-27 19:37 usr/include/sparse/compat.h
-rwxr-xr-x root/root      3521 2009-10-27 19:37 usr/include/sparse/ident-list.h
-rwxr-xr-x root/root      1436 2009-10-27 19:37 usr/include/sparse/bitmap.h
-rwxr-xr-x root/root      7065 2009-10-27 19:37 usr/include/sparse/linearize.h
-rwxr-xr-x root/root       993 2009-10-27 19:37 usr/include/sparse/target.h
-rwxr-xr-x root/root      5273 2009-10-27 19:37 usr/include/sparse/expression.h
-rwxr-xr-x root/root       951 2009-10-27 19:37 usr/include/sparse/scope.h
-rwxr-xr-x root/root     10363 2009-10-27 19:37 usr/include/sparse/symbol.h
-rwxr-xr-x root/root      6005 2009-10-27 19:37 usr/include/sparse/lib.h
-rwxr-xr-x root/root      3555 2009-10-27 19:37 usr/include/sparse/parse.h
-rwxr-xr-x root/root      4934 2009-10-27 19:37 usr/include/sparse/token.h
