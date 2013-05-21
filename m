From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/5] Add support for the MinGW platform
Date: Tue, 21 May 2013 20:16:38 +0100
Message-ID: <519BC816.3000304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:33939 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752054Ab3EUT2L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 15:28:11 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 cgcc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/cgcc b/cgcc
index c075e5f..e94a965 100755
--- a/cgcc
+++ b/cgcc
@@ -226,6 +226,19 @@ sub add_specs {
 	    ' -D__OpenBSD__=1';
     } elsif ($spec eq 'unix') {
 	return ' -Dunix=1 -D__unix=1 -D__unix__=1';
+    } elsif ($spec =~ /^mingw/) {
+	return ' -isystem /mingw/include' .
+	    ' -D__MINGW32__=1' .
+	    ' -D__MSVCRT__=1' .
+	    ' -DWIN32=1 -D_WIN32=1 -D__WIN32=1 -D__WIN32__=1' .
+	    ' -DWINNT=1 -D__WINNT=1 -D__WINNT__=1' .
+	    " -D'_cdecl=__attribute__((__cdecl__))'" .
+	    " -D'__cdecl=__attribute__((__cdecl__))'" .
+	    " -D'_stdcall=__attribute__((__stdcall__))'" .
+	    " -D'__stdcall=__attribute__((__stdcall__))'" .
+	    " -D'_fastcall=__attribute__((__fastcall__))'" .
+	    " -D'__fastcall=__attribute__((__fastcall__))'" .
+	    " -D'__declspec(x)=__attribute__((x))'";
     } elsif ( $spec =~ /^cygwin/) {
 	return &add_specs ('unix') .
 	    ' -D__CYGWIN__=1 -D__CYGWIN32__=1' .
-- 
1.8.2

