From: Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] cgcc: Fix preprocessing of assembler files
Date: Sat,  4 Jan 2014 11:20:48 +0100
Message-ID: <1388830848-2020-1-git-send-email-sw@weilnetz.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qemu.weilnetz.de ([37.221.198.45]:40951 "EHLO
	v2201305906712890.yourvserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751274AbaADKa2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Jan 2014 05:30:28 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Stefan Weil <sw@weilnetz.de>

The old code does not preprocess assembler files when cgcc is called like
this:

cgcc -E -o multiboot.asm multiboot.S

As the preprocessor is not called, no multiboot.asm is generated, and any
further build steps which need it will fail.

Fix this by using a new intermediate variable $do_preprocess.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

This patch allows using cgcc for QEMU builds. I did not run any other tests,
so please review carefully.

Thanks,
Stefan Weil

 cgcc |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/cgcc b/cgcc
index c075e5f..a43e074 100755
--- a/cgcc
+++ b/cgcc
@@ -10,6 +10,7 @@ my $has_specs = 0;
 my $gendeps = 0;
 my $do_check = 0;
 my $do_compile = 1;
+my $do_preprocess = 0;
 my $gcc_base_dir;
 my $verbose = 0;
 
@@ -44,8 +45,7 @@ while (@ARGV) {
         next;
     }
 
-    # If someone adds "-E", don't pre-process twice.
-    $do_compile = 0 if $_ eq '-E';
+    $do_preprocess = 1 if $_ eq '-E';
 
     $verbose = 1 if $_ eq '-v';
 
@@ -59,6 +59,11 @@ if ($gendeps) {
     $do_check = 0;
 }
 
+if ($do_check && $do_preprocess) {
+    # If someone adds "-E", don't pre-process twice.
+    $do_compile = 0;
+}
+
 if ($do_check) {
     if (!$has_specs) {
 	$check .= &add_specs ('host_arch_specs');
-- 
1.7.10.4

