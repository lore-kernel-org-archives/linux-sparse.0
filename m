From: rubisher <rubisher@scarlet.be>
Subject: sparse 0.4.2: cgcc issue
Date: Sat, 05 Dec 2009 22:34:47 +0000
Message-ID: <4B1AE007.8000509@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hel.is.scarlet.be ([193.74.71.26]:36575 "EHLO hel.is.scarlet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756698AbZLEWoP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 5 Dec 2009 17:44:15 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello all,

Trying to 'sparse' grub2 with cgcc wrapper, I got following error:

REAL_CC=gcc-4.4 cgcc -v -Ikern -I/Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/kern -I. -I./include 
-I/Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/gnulib -I/Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/include -Wall -W 
-DGRUB_LIBDIR=\"/opt/grub2/exp1417/lib/`echo grub/i386-pc | sed 's,x,x,'`\" -DLOCALEDIR=\"\" -DGRUB_MACHINE_PCBIOS=1 
-Wbitwise -Wnon-pointer-null -DGRUB_UTIL=1  -MD -c -o grub_setup-kern_partition.o 
/Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/kern/partition.c
Use of uninitialized value $bits in exists at /usr/bin/cgcc line 139.
/usr/bin/cgcc: weird number of bits. at /usr/bin/cgcc line 139.
make: *** [grub_setup-kern_partition.o] Error 9

Fortunately debian pkg sparse (0.4.1+git20081218-1) doesn't shows this error?

Any idea?

Tia,
	J.

