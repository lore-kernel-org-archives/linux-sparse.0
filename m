From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 05/16] Document -gcc-base-dir in sparse.1
Date: Fri, 19 Dec 2008 00:52:29 +0300
Message-ID: <20081218215229.28136.17429.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:17250 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYLRVnQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 16:43:16 -0500
Received: by ey-out-2122.google.com with SMTP id 22so44126eye.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 13:43:14 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

Signed-off-by: Alexey zaytsev <alexey.zaytsev@gmail.com>
---
 sparse.1 |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sparse.1 b/sparse.1
index d242dc7..92a1cae 100644
--- a/sparse.1
+++ b/sparse.1
@@ -287,6 +287,11 @@ However, this behavior can lead to subtle errors.
 
 Sparse does not issue these warnings by default.
 .
+.SH MISC OPTIONS
+.TP
+.B \-gcc-base-dir \fIdir\fR
+Look for compiler-provided system headers in \fIdir\fR/include/ and \fIdir\fR/include-fixed/.
+.
 .SH SEE ALSO
 .BR cgcc (1)
 .

