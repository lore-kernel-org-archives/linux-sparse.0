From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cgcc: fix __DECIMAL_DIG__
Date: Mon, 29 May 2017 02:41:53 +0200
Message-ID: <20170529004153.3951-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36365 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2AmC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 20:42:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so13999125wmh.3
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 17:42:01 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There seems to be a mixup about how to calculate __DECIMAL_DIG__
especially for PPC.

Fix it by using the correct values: 21 for 80 bit long double (i386)
and 36 for 128 bits long double (all the others).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cgcc b/cgcc
index c29fa587e..456369655 100755
--- a/cgcc
+++ b/cgcc
@@ -258,25 +258,25 @@ sub add_specs {
     } elsif ($spec eq 'sparc') {
 	return (' -D__sparc=1 -D__sparc__=1' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
-		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
+		&float_types (1, 1, 36, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'sparc64') {
 	return (' -D__sparc=1 -D__sparc__=1 -D__sparcv9__=1 -D__sparc64__=1 -D__arch64__=1 -D__LP64__=1' .
 		&integer_types (8, 16, 32, 64, 64, 128) .
-		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
+		&float_types (1, 1, 36, [24,8], [53,11], [113,15]) .
 		&define_size_t ("long unsigned int") .
 		' -D__SIZEOF_POINTER__=8');
     } elsif ($spec eq 'x86_64') {
 	return (' -D__x86_64=1 -D__x86_64__=1' . ($m32 ? '' : ' -D__LP64__=1') .
 		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64, 128) .
-		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
+		&float_types (1, 1, 36, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m32 ? "unsigned int" : "long unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m32 ? '4' : '8'));
     } elsif ($spec eq 'ppc') {
 	return (' -D__powerpc__=1 -D_BIG_ENDIAN -D_STRING_ARCH_unaligned=1' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
-		&float_types (1, 1, 21, [24,8], [53,11], [113,15]) .
+		&float_types (1, 1, 36, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 's390x') {
-- 
2.13.0

