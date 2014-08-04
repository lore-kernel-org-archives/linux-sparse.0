From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 08/10] cgcc: use only the cc command to determine $gcc_base_dir
Date: Mon, 04 Aug 2014 19:39:55 +0100
Message-ID: <53DFD37B.4010104@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:52921 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751093AbaHDSrP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:47:15 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Capture the c-compiler command, in the $ccom variable, in order to
later invoke the compiler without extraneous command-line options.
In particular, use the $ccom variable in order to cleanly invoke the
compiler when setting the $gcc_base_dir variable.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 cgcc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cgcc b/cgcc
index ed35e39..f330116 100755
--- a/cgcc
+++ b/cgcc
@@ -3,6 +3,7 @@
 
 my $cc = $ENV{'REAL_CC'} || 'cc';
 my $check = $ENV{'CHECK'} || 'sparse';
+my $ccom = $cc;
 
 my $m32 = 0;
 my $m64 = 0;
@@ -72,7 +73,7 @@ if ($do_check) {
 	$check .= &add_specs ('host_os_specs');
     }
 
-    $gcc_base_dir = qx($cc -print-file-name=) if !$gcc_base_dir;
+    $gcc_base_dir = qx($ccom -print-file-name=) if !$gcc_base_dir;
     chomp($gcc_base_dir);  # possibly remove '\n' from compiler
     $check .= " -gcc-base-dir " . $gcc_base_dir if $gcc_base_dir;
 
-- 
2.0.0
