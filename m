From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 04/16] Let cgcc pass -gcc-base-dir to sparse.
Date: Fri, 19 Dec 2008 00:52:15 +0300
Message-ID: <20081218215215.28136.22788.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:8093 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYLRVnG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 16:43:06 -0500
Received: by ug-out-1314.google.com with SMTP id 39so508461ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 13:43:05 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 cgcc |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/cgcc b/cgcc
index cda8dab..fdda6d1 100755
--- a/cgcc
+++ b/cgcc
@@ -10,9 +10,11 @@ my $has_specs = 0;
 my $gendeps = 0;
 my $do_check = 0;
 my $do_compile = 1;
+my $gcc_base_dir;
 my $verbose = 0;
 
-foreach (@ARGV) {
+while (@ARGV) {
+    $_ = shift(@ARGV);
     # Look for a .c file.  We don't want to run the checker on .o or .so files
     # in the link run.  (This simplistic check knows nothing about options
     # with arguments, but it seems to do the job.)
@@ -36,6 +38,12 @@ foreach (@ARGV) {
 	next;
     }
 
+    if (/^-gcc-base-dir$/) {
+        $gcc_base_dir = shift @ARGV;
+        die ("$0: missing argument for -gcc-base-dir option") if !$gcc_base_dir;
+        next;
+    }
+
     # If someone adds "-E", don't pre-process twice.
     $do_compile = 0 if $_ eq '-E';
 
@@ -56,6 +64,10 @@ if ($do_check) {
 	$check .= &add_specs ('host_arch_specs');
 	$check .= &add_specs ('host_os_specs');
     }
+
+    $gcc_base_dir = qx($cc -print-file-name=) if !$gcc_base_dir;
+    $check .= " -gcc-base-dir " . $gcc_base_dir if $gcc_base_dir;
+
     print "$check\n" if $verbose;
     if ($do_compile) {
 	system ($check);

