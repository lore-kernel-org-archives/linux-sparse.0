From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cgcc: teach cgcc about ppc64[le]
Date: Wed, 21 Jun 2017 15:34:55 +0200
Message-ID: <20170621133455.97253-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36109 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdFUNfH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 09:35:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id 77so26553133wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 21 Jun 2017 06:35:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/cgcc b/cgcc
index 904695c81..f5f352234 100755
--- a/cgcc
+++ b/cgcc
@@ -283,6 +283,12 @@ sub add_specs {
 		&float_types (1, 1, 21, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
+    } elsif ($spec eq 'ppc64') {
+	return (' -D__powerpc__=1 -D__PPC__=1 -D_STRING_ARCH_unaligned=1' .
+		' -D__powerpc64__=1 -D__PPC64__=1' .
+		' -D_CALL_ELF=2' .
+		' -m64' .
+		&float_types (1, 1, 21, [24,8], [53,11], [113,15]));
     } elsif ($spec eq 's390x') {
 	return (' -D__s390x__ -D__s390__ -D_BIG_ENDIAN' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
@@ -307,6 +313,10 @@ sub add_specs {
 	    return &add_specs ('x86_64');
 	} elsif ($arch =~ /^(ppc)$/i) {
 	    return &add_specs ('ppc');
+	} elsif ($arch =~ /^(ppc64)$/i) {
+	    return &add_specs ('ppc64') . ' -mbig-endian';
+	} elsif ($arch =~ /^(ppc64le)$/i) {
+	    return &add_specs ('ppc64') . ' -mlittle-endian';
 	} elsif ($arch =~ /^(s390x)$/i) {
 	    return &add_specs ('s390x');
 	} elsif ($arch =~ /^(sparc64)$/i) {
-- 
2.13.0

