From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 09/10] cgcc: use $ccom to set $multiarch_dir if not specified
Date: Mon, 04 Aug 2014 19:40:32 +0100
Message-ID: <53DFD3A0.10106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:52919 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbaHDSrP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:47:15 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 cgcc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cgcc b/cgcc
index f330116..d7daa99 100755
--- a/cgcc
+++ b/cgcc
@@ -77,6 +77,8 @@ if ($do_check) {
     chomp($gcc_base_dir);  # possibly remove '\n' from compiler
     $check .= " -gcc-base-dir " . $gcc_base_dir if $gcc_base_dir;
 
+    $multiarch_dir = qx($ccom -print-multiarch) if ! defined $multiarch_dir;
+    chomp($multiarch_dir);  # possibly remove '\n' from compiler
     $check .= " -multiarch-dir " . $multiarch_dir if $multiarch_dir;
 
     print "$check\n" if $verbose;
-- 
2.0.0
