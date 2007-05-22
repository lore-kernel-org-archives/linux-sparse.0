From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/5] Add cygwin support to cgcc
Date: Tue, 22 May 2007 19:12:42 +0100
Message-ID: <4653329A.9040407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-fallback-93.mail.demon.net ([194.217.242.93]:63328 "EHLO
	anchor-fallback-93.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764356AbXEWJ0q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 05:26:46 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4081 "EHLO
	anchor-post-34.mail.demon.net") by anchor-fallback-93.mail.demon.net
	with ESMTP id S358122AbXEVSRX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 19:17:23 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
  cgcc |   10 ++++++++++
  1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/cgcc b/cgcc
index e56226e..d50220c 100755
--- a/cgcc
+++ b/cgcc
@@ -214,6 +214,16 @@ sub add_specs {
  	    ' -D__STDC__=1';
      } elsif ($spec eq 'unix') {
  	return ' -Dunix=1 -D__unix=1 -D__unix__=1';
+    } elsif ( $spec =~ /^cygwin/) {
+	return &add_specs ('unix') .
+	    ' -D__STDC__=1 -D__CYGWIN__=1 -D__CYGWIN32__=1' .
+	    " -D'_cdecl=__attribute__((__cdecl__))'" .
+	    " -D'__cdecl=__attribute__((__cdecl__))'" .
+	    " -D'_stdcall=__attribute__((__stdcall__))'" .
+	    " -D'__stdcall=__attribute__((__stdcall__))'" .
+	    " -D'_fastcall=__attribute__((__fastcall__))'" .
+	    " -D'__fastcall=__attribute__((__fastcall__))'" .
+	    " -D'__declspec(x)=__attribute__((x))'";
      } elsif ($spec eq 'i86') {
  	return (' -Di386=1 -D__i386=1 -D__i386__=1' .
  		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
-- 
1.5.1
