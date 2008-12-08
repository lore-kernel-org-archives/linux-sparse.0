From: Alexey zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 2/4] Let cgcc pass -gcc-base-dir to sparse.
Date: Mon, 08 Dec 2008 12:20:48 +0300
Message-ID: <20081208092048.15890.82300.stgit@xl0.local>
References: <20081208091817.15890.27981.stgit@xl0.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:26734 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbYLHJLj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Dec 2008 04:11:39 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1611560qba.17
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2008 01:11:39 -0800 (PST)
In-Reply-To: <20081208091817.15890.27981.stgit@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Josh Triplett <josh@freedesktop.org>


---
 cgcc |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/cgcc b/cgcc
index 89adbed..b59f7d6 100755
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

