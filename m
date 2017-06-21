From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cgcc: teach cgcc about arm
Date: Wed, 21 Jun 2017 15:35:14 +0200
Message-ID: <20170621133514.97297-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32796 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdFUNf3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 09:35:29 -0400
Received: by mail-lf0-f66.google.com with SMTP id u62so21193393lfg.0
        for <linux-sparse@vger.kernel.org>; Wed, 21 Jun 2017 06:35:29 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cgcc b/cgcc
index f5f352234..a8d7b4f21 100755
--- a/cgcc
+++ b/cgcc
@@ -295,6 +295,9 @@ sub add_specs {
 		&float_types (1, 1, 36, [24,8], [53,11], [113,15]) .
 		&define_size_t ("long unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
+    } elsif ($spec eq 'arm') {
+	return (' -D__arm__=1 -m32' .
+		&float_types (1, 1, 36, [24,8], [53,11], [53, 11]));
     } elsif ($spec eq 'aarch64') {
 	return (' -D__aarch64__=1 -m64' .
 		&float_types (1, 1, 36, [24,8], [53,11], [113,15]));
@@ -321,6 +324,8 @@ sub add_specs {
 	    return &add_specs ('s390x');
 	} elsif ($arch =~ /^(sparc64)$/i) {
 	    return &add_specs ('sparc64');
+	} elsif ($arch =~ /^(arm)$/i) {
+	    return &add_specs ('arm');
 	} elsif ($arch =~ /^(aarch64)$/i) {
 	    return &add_specs ('aarch64');
 	}
-- 
2.13.0

