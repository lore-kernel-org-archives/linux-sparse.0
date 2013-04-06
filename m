From: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 3/3] Add description for -Winit-cstring option
Date: Sun,  7 Apr 2013 01:58:57 +0900
Message-ID: <1365267537-3787-3-git-send-email-yamato@redhat.com>
References: <1365267537-3787-1-git-send-email-yamato@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from h219-110-095-248.catv01.itscom.jp ([219.110.95.248]:53280 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751608Ab3DFRLU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Apr 2013 13:11:20 -0400
In-Reply-To: <1365267537-3787-1-git-send-email-yamato@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: yamato@redhat.com

This patch added description for -Winit-cstring option
to sparse.1.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 sparse.1 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sparse.1 b/sparse.1
index ae85b54..cd6be26 100644
--- a/sparse.1
+++ b/sparse.1
@@ -189,6 +189,24 @@ Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-enum\-mismatch\fR.
 .
 .TP
+.B \-Winit\-cstring
+Warn about initialization of a char array with a too long constant C string.
+
+If the size of the char array and the length of the string is the same,
+there is no space for the last nul char of the string in the array:
+
+.nf
+char s[3] = "abc";
+.fi
+
+If the array is used as a byte array, not as C string, this
+warning is just noise. However, if the array is passed to functions
+dealing with C string like printf(%s) and strcmp, it may cause a
+trouble.
+
+Sparse does not issue these warnings by default.
+.
+.TP
 .B \-Wnon\-pointer\-null
 Warn about the use of 0 as a NULL pointer.
 
-- 
1.7.11.7

