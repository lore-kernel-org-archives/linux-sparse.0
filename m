From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/4] test-suite: remove bashism to avoid test failures
Date: Sat, 11 Oct 2014 20:56:16 +0100
Message-ID: <54398B60.9080009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:46162 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751006AbaJKT4S (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Oct 2014 15:56:18 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


The use of the '==' operator in a test/[ conditional is a non-POSIX
bash extension. In order to avoid test failures on systems that do
not have bash as the system shell (/bin/sh), replace the use of the
'==' operator with the POSIX compatible '=' operator.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

Sorry for not spotting this earlier; I just looked at your patch in
my email client and thought 'yep, that looks good', without actually
testing the change. :(

Since Linux Mint is a Ubuntu derivative my /bin/sh is actually dash.
(I hear Fedora are looking to change /bin/sh to dash as well. :-D ).

ATB,
Ramsay Jones

 validation/test-suite | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 7f0f83e..df5a7c6 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -114,7 +114,7 @@ do_test()
 	set -- $cmd
 	base_cmd=`basename $1`
 	for i in $disabled_cmds; do
-		if [ "$i" == "$base_cmd" ] ; then
+		if [ "$i" = "$base_cmd" ] ; then
 			disabled_tests=`expr $disabled_tests + 1`
 			echo "     DISABLE $test_name ($file)"
 			return 3
-- 
2.1.0
