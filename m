From: Alexey zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 3/4] Document -gcc-base-dir in sparse.1
Date: Mon, 08 Dec 2008 12:20:55 +0300
Message-ID: <20081208092055.15890.58087.stgit@xl0.local>
References: <20081208091817.15890.27981.stgit@xl0.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.233]:26734 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYLHJLq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Dec 2008 04:11:46 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1611560qba.17
        for <linux-sparse@vger.kernel.org>; Mon, 08 Dec 2008 01:11:46 -0800 (PST)
In-Reply-To: <20081208091817.15890.27981.stgit@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-sparse@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Josh Triplett <josh@freedesktop.org>

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

