From: "Damien Lespiau" <damien.lespiau@gmail.com>
Subject: [PATCH] trivial: more .gitignore stuff
Date: Sun, 19 Nov 2006 00:46:59 +0100
Message-ID: <cbf3148c0611181546s46431944hb1da14c18fe32ae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:16620 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755376AbWKRXrB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Nov 2006 18:47:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1823775nfa
        for <linux-sparse@vger.kernel.org>; Sat, 18 Nov 2006 15:46:59 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Ignore tags and git frontends' files.

Signed-off-by: Damien Lespiau <damien.lespiau@gmail.com>
---

diff --git a/.gitignore b/.gitignore
index 3e12ce7..6a12c5c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,3 +18,15 @@ test-dissect
test-linearize
example
test-unssa
+
+# tags
+tags
+TAGS
+
+# stgit generated dirs
+patches-*
+
+# quilt's files
+patches
+series
+
