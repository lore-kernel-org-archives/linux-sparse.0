From: rubisher <rubisher@scarlet.be>
Subject: Re: sparse 0.4.2: cgcc issue
Date: Sun, 06 Dec 2009 12:01:46 +0000
Message-ID: <4B1B9D2A.6080804@scarlet.be>
References: <4B1AE007.8000509@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hel.is.scarlet.be ([193.74.71.26]:33158 "EHLO hel.is.scarlet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbZLFMBm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 6 Dec 2009 07:01:42 -0500
In-Reply-To: <4B1AE007.8000509@scarlet.be>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

rubisher wrote:
> Hello all,
> 
> Trying to 'sparse' grub2 with cgcc wrapper, I got following error:
> 
> REAL_CC=gcc-4.4 cgcc -v -Ikern 
> -I/Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/kern -I. -I./include 
> -I/Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/gnulib 
> -I/Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/include -Wall -W 
> -DGRUB_LIBDIR=\"/opt/grub2/exp1417/lib/`echo grub/i386-pc | sed 
> 's,x,x,'`\" -DLOCALEDIR=\"\" -DGRUB_MACHINE_PCBIOS=1 -Wbitwise 
> -Wnon-pointer-null -DGRUB_UTIL=1  -MD -c -o grub_setup-kern_partition.o 
> /Develop/jso/GRUB2/Grub2.deb/exp-bzr1417/kern/partition.c
> Use of uninitialized value $bits in exists at /usr/bin/cgcc line 139.
> /usr/bin/cgcc: weird number of bits. at /usr/bin/cgcc line 139.
> make: *** [grub_setup-kern_partition.o] Error 9
> 
> Fortunately debian pkg sparse (0.4.1+git20081218-1) doesn't shows this 
> error?
> 
> Any idea?
> 
> Tia,
>     J.
> 
> 
mmm, I figure out that's because the number of args to call this routine integer_types() should be the same as the number of 
  @types's elements (i.e. 6) which is not allways the case:
e.g.
  252     } elsif ($spec eq 'i86') {
253         return (' -Di386=1 -D__i386=1 -D__i386__=1' .
254                 &integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
255                 &float_types (1, 1, 21, [24,8], [53,11], [64,15]) .
256                 &define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
257     } elsif ($spec eq 'sparc') {
258         return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1' .
259                 &integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
260                 &float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
261                 &define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
262     } elsif ($spec eq 'sparc64') {
263         return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1 -D__sparcv9__=1 -D__sparc64__=1 -D__arch64__=1 -D__LP64__=1' .
264                 &integer_types (8, 16, 32, 64, 64, 128) .
265                 &float_types (1, 1, 33, [24,8], [53,11], [113,15]) .

so one possible fix could be:
--- /usr/bin/cgcc.orig	2009-11-28 17:41:28.000000000 +0000
+++ /usr/bin/cgcc	2009-12-06 11:55:32.000000000 +0000
@@ -133,7 +133,7 @@
      my @types = (['SCHAR',''], ['SHRT',''], ['INT',''], ['LONG','L'], ['LONG_LONG','LL'], ['LONG_LONG_LONG','LLL']);

      my $result = " -D__CHAR_BIT__=$char";
-    while (@types) {
+    while (@types && @_) {
  	my $bits = shift @_;
  	my ($name,$suffix) = @{ shift @types };
  	die "$0: weird number of bits." unless exists $pow2m1{$bits};
=== <> ===

Hth,
	J.

