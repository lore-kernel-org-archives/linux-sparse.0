From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/5] test-suite: Add -b option to ignore CR at eol on MinGW
Date: Tue, 21 May 2013 20:18:21 +0100
Message-ID: <519BC87D.5080002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:33945 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752428Ab3EUT2L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 15:28:11 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 validation/test-suite | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 3c011c6..ded93fc 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -126,7 +126,7 @@ do_test()
 	actual_exit_value=$?
 
 	for stream in output error; do
-		diff -u "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
+		diff -ub "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
 		if [ "$?" -ne "0" ]; then
 			error "actual $stream text does not match expected $stream text."
 			error  "see $file.$stream.* for further investigation."
-- 
1.8.2

