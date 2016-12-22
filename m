From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cgcc should not define non-reserved identifiers
Date: Thu, 22 Dec 2016 01:44:33 +0100
Message-ID: <20161222004433.563-1-luc.vanoostenryck@gmail.com>
References: <349d321e-43f7-f7c0-b985-7303fdb78ef9@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34977 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756850AbcLVAot (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Dec 2016 19:44:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so7801442wml.2
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2016 16:44:48 -0800 (PST)
In-Reply-To: <349d321e-43f7-f7c0-b985-7303fdb78ef9@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joe Lawrence <joe.lawrence@redhat.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Since the original x86-64 support in cgcc
(commit 0fcbcbf4: "Implement x86-64 support in cgcc")
cgcc define some non-reserved identifiers like i386, x86_64, ...
It should not since these are valid identifiers which could be used
for some variable names.

Current versions of gcc only define those prefixed with a double
underscore and cgcc also define those. So ...

Remove the defines of the non-prefixed ones.

Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Investigated-by: Joe Lawrence <joe.lawrence@redhat.com>
Originally-From: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cgcc b/cgcc
index d7b1c99c..c29fa587 100755
--- a/cgcc
+++ b/cgcc
@@ -250,25 +250,25 @@ sub add_specs {
 	    " -D'__fastcall=__attribute__((__fastcall__))'" .
 	    " -D'__declspec(x)=__attribute__((x))'";
     } elsif ($spec eq 'i86') {
-	return (' -Di386=1 -D__i386=1 -D__i386__=1' .
+	return (' -D__i386=1 -D__i386__=1' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
 		&float_types (1, 1, 21, [24,8], [53,11], [64,15]) .
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'sparc') {
-	return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1' .
+	return (' -D__sparc=1 -D__sparc__=1' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'sparc64') {
-	return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1 -D__sparcv9__=1 -D__sparc64__=1 -D__arch64__=1 -D__LP64__=1' .
+	return (' -D__sparc=1 -D__sparc__=1 -D__sparcv9__=1 -D__sparc64__=1 -D__arch64__=1 -D__LP64__=1' .
 		&integer_types (8, 16, 32, 64, 64, 128) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ("long unsigned int") .
 		' -D__SIZEOF_POINTER__=8');
     } elsif ($spec eq 'x86_64') {
-	return (' -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1' . ($m32 ? '' : ' -D__LP64__=1') .
+	return (' -D__x86_64=1 -D__x86_64__=1' . ($m32 ? '' : ' -D__LP64__=1') .
 		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64, 128) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m32 ? "unsigned int" : "long unsigned int") .
-- 
2.9.3

