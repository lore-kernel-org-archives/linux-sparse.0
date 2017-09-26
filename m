From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] cgcc: provide __ARM_PCS_VFP for armhf
Date: Tue, 26 Sep 2017 09:15:20 +0200
Message-ID: <20170926071520.26507-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:47042 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965122AbdIZHPf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Sep 2017 03:15:35 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This fixes:

	$ uname -m
	armv8l
	$ env CHECK=./sparse ./cgcc -no-compile memops.c
	/usr/include/arm-linux-gnueabihf/gnu/stubs.h:7:12: error: unable to open 'gnu/stubs-soft.h'

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

I added

	env CHECK=./sparse ./cgcc -no-compile memops.c

to the package building process and that failed on armhf (i.e.  Armv7
CPU with Thumb-2 and VFP3D16 or better) with the above error.

With that applied all Debian primary architectures work fine; see
https://buildd.debian.org/status/package.php?p=sparse&suite=unstable

Best regards
Uwe

 cgcc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/cgcc b/cgcc
index a8d7b4f..ee59201 100755
--- a/cgcc
+++ b/cgcc
@@ -296,7 +296,14 @@ sub add_specs {
 		&define_size_t ("long unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'arm') {
-	return (' -D__arm__=1 -m32' .
+	chomp (my $gccmachine = `$cc -dumpmachine`);
+	my $cppsymbols = ' -D__arm__=1 -m32';
+
+	if ($gccmachine eq 'arm-linux-gnueabihf') {
+	    $cppsymbols .= ' -D__ARM_PCS_VFP=1';
+	}
+
+	return ($cppsymbols .
 		&float_types (1, 1, 36, [24,8], [53,11], [53, 11]));
     } elsif ($spec eq 'aarch64') {
 	return (' -D__aarch64__=1 -m64' .
@@ -324,7 +331,7 @@ sub add_specs {
 	    return &add_specs ('s390x');
 	} elsif ($arch =~ /^(sparc64)$/i) {
 	    return &add_specs ('sparc64');
-	} elsif ($arch =~ /^(arm)$/i) {
+	} elsif ($arch =~ /^arm(?:v[78]l)?$/i) {
 	    return &add_specs ('arm');
 	} elsif ($arch =~ /^(aarch64)$/i) {
 	    return &add_specs ('aarch64');
-- 
2.11.0

