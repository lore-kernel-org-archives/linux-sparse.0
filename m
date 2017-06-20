From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cgcc: teach cgcc about arm64
Date: Wed, 21 Jun 2017 00:12:51 +0200
Message-ID: <20170620221251.93292-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36578 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdFTWNB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 18:13:01 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so21166779wrb.3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 15:13:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is needed to use sparse on the git tree on an arm64
machine (where a bug in the __builtin_bswapXX() expansion
was discovered).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/cgcc b/cgcc
index fd9d482fa..28c55335a 100755
--- a/cgcc
+++ b/cgcc
@@ -289,6 +289,10 @@ sub add_specs {
 		&float_types (1, 1, 36, [24,8], [53,11], [113,15]) .
 		&define_size_t ("long unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
+    } elsif ($spec eq 'aarch64') {
+	return (' -D__aarch64__=1 -m64' .
+		&integer_types (8, 16, 32, 64, 64) .
+		&float_types (1, 1, 36, [24,8], [53,11], [113,15]));
     } elsif ($spec eq 'host_os_specs') {
 	my $os = `uname -s`;
 	chomp $os;
@@ -308,6 +312,8 @@ sub add_specs {
 	    return &add_specs ('s390x');
 	} elsif ($arch =~ /^(sparc64)$/i) {
 	    return &add_specs ('sparc64');
+	} elsif ($arch =~ /^(aarch64)$/i) {
+	    return &add_specs ('aarch64');
 	}
     } else {
 	die "$0: invalid specs: $spec\n";
-- 
2.13.0

