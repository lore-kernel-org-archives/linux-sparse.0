From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix cgcc ELF version for ppc64/pcc64le
Date: Wed, 27 Sep 2017 23:11:37 +0200
Message-ID: <20170927211137.16461-1-luc.vanoostenryck@gmail.com>
References: <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:48673 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdI0VLo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 27 Sep 2017 17:11:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id m127so22676369wmm.3
        for <linux-sparse@vger.kernel.org>; Wed, 27 Sep 2017 14:11:44 -0700 (PDT)
In-Reply-To: <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Commit e0306fe0 "cgcc: teach cgcc about ppc64[le]" add support
for PPC64 to cgcc by adding the needed options like '-m64' &
'-m{little,big}-endian' and defines likes '-D__PPC64__=1'.

In this commit the defined '-D_CALL_ELF=2' was also added
but the value of 2 is for ELF v2 ABI, normally used for ppc64le,
while the older ELF ABI, normally used for plain ppc64 should use
'-D_CALL_ELF=2'.

Fix this by using the value of 1 or 2 for '_CALL_ELF' depending
if the architecture is ppc64 or ppc64le.

Fixes: e0306fe0b725af6e2e7ff59d7f0d99c96315791a
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/cgcc b/cgcc
index a8d7b4f21..909cd2477 100755
--- a/cgcc
+++ b/cgcc
@@ -286,7 +286,6 @@ sub add_specs {
     } elsif ($spec eq 'ppc64') {
 	return (' -D__powerpc__=1 -D__PPC__=1 -D_STRING_ARCH_unaligned=1' .
 		' -D__powerpc64__=1 -D__PPC64__=1' .
-		' -D_CALL_ELF=2' .
 		' -m64' .
 		&float_types (1, 1, 21, [24,8], [53,11], [113,15]));
     } elsif ($spec eq 's390x') {
@@ -317,9 +316,9 @@ sub add_specs {
 	} elsif ($arch =~ /^(ppc)$/i) {
 	    return &add_specs ('ppc');
 	} elsif ($arch =~ /^(ppc64)$/i) {
-	    return &add_specs ('ppc64') . ' -mbig-endian';
+	    return &add_specs ('ppc64') . ' -mbig-endian -D_CALL_ELF=1';
 	} elsif ($arch =~ /^(ppc64le)$/i) {
-	    return &add_specs ('ppc64') . ' -mlittle-endian';
+	    return &add_specs ('ppc64') . ' -mlittle-endian -D_CALL_ELF=2';
 	} elsif ($arch =~ /^(s390x)$/i) {
 	    return &add_specs ('s390x');
 	} elsif ($arch =~ /^(sparc64)$/i) {
-- 
2.14.0

