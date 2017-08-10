From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1/2] Adding document for sparse patch submit process
Date: Wed, 9 Aug 2017 23:27:56 -0400
Message-ID: <CANeU7Qm9+-++i6U9DYXn-NYVj-k4r63JkK3srESyboTxQiP=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35595 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHJD16 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 23:27:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id l82so5413259ywc.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 20:27:57 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

Reference to the linux kernel patches submitting process
and difference to sparse.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Documentation/submitting-patches.md | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/submitting-patches.md

diff --git a/Documentation/submitting-patches.md
b/Documentation/submitting-patches.md
new file mode 100644
index 0000000..f526d44
--- /dev/null
+++ b/Documentation/submitting-patches.md
@@ -0,0 +1,21 @@
+Submitting patches: the sparse version
+======================================
+
+Sparse use a patch submit process similar to the Linux Kernel
+[Submitting Patches](https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html)
+
+This document mostly focus on the parts might be different from the Linux
+Kernel submitting process.
+
+1. Git clone a sparse repository:
+
+        git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
+
+2. [Coding Style](https://www.kernel.org/doc/html/v4.12/process/coding-style.html)
remain the same.
+
+2. Sign off the patch.
+
+   The usage of the Signed-off-by tag is the same as [Linux Kernel
Sign your work](https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin).
+
+   Notice that sparse is MIT License.
+
-- 
2.13.3
