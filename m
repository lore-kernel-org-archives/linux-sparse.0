Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F26C433F5
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 23:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B50E61178
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 23:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbhI0XsM (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:48:12 -0400
Received: from avasout02.plus.net ([212.159.14.17]:40823 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhI0XsM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Sep 2021 19:48:12 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2021 19:48:12 EDT
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id V0HTmVrpBrasdV0HUmS0v0; Tue, 28 Sep 2021 00:43:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632786212; bh=w1+0xUja93NQiS1/Y4p24+0XgCa+xntM9i5LsJVExT8=;
        h=To:Cc:From:Subject:Date;
        b=JJA7yluCDM6aNr2LXB/yYM/jUPkdZxHGLzXpsQoKsjKXszR2nAj0o6uaraaXsaWB4
         TPfutRjLhdnbCDKP/IPq97dYAwOcyekaBgXm6ApNPvMdA+aqsGRcI3uj9GMzDXO31/
         pnku6Gk0cG+17O4qm20wxmcQQDxhYZv/S/HGEWVusHyLHU4CBZ9qnrvv8BjwComsAP
         ILdbbbd0Pg5fCmASEjikOmLNCfGO347G8DV0cRUAqql3vQS++zyc665Z2fWBmRkFvZ
         yuzulVbB8hYOgreHK/zCqyaa3GiOyRpr5tIDMVxAnAJmZGqaqwmIZPSn5f5U0I+cJF
         1qzKtnNCZBx8Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=dIE9ZNRb c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=RPXFKKry418IP0VToQ8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] sparse: fix broken 'memcpy-max-count' check
Message-ID: <256de5b4-7bb7-8259-c220-8a9c9dc785b1@ramsayjones.plus.com>
Date:   Tue, 28 Sep 2021 00:43:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOnVPxaHsRxrstYGH1+OKznpsbw9E0FVVKJbmEFqV+IObVcXwIdPsmd8m+ZlG8QH/TLFtH/l79JS9VbJx+Qv3IyZvWikwiyb3XXm/Za+XhflRH4mB1KM
 0EETXkzatPFUHDS/XOBrsW12y7drL39Nb1NjlXSzCynamU9Cnki8jPhyGbJxagBnsjYaAZMY93EFNQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


commit a69f8d70 ("ptrlist: use ptr_list_nth() instead of linearize_ptr_\
list()", 2021-02-14) replaced a call to a local helper with a more generic
ptr_list function. The local function, argument(), was used to retrieve
the 'argno' argument to a function call, counting the arguments from one.
This call was replaced by the generic ptr_list_nth() function, which
accessed the ptr_list counting from zero. The 'argno' passed to the call to
argument() was 3 (the byte count), which when passed to ptr_list_nth()
was attempting to access the 4th (non-existent) argument. (The resulting
null pointer was then passed to check_byte_count() function, which had
an null-pointer check and so did not dereference the null pointer). This
effectively disabled the memcpy-max-count check.

In order to fix the check, change the 'argno' of 3 to the 'index' of 2.
Also, add a simple regression test.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 sparse.c                    |  2 +-
 validation/byte-count-max.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 validation/byte-count-max.c

diff --git a/sparse.c b/sparse.c
index 9d62d4fe..e7cc6f55 100644
--- a/sparse.c
+++ b/sparse.c
@@ -165,7 +165,7 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
 
 static void check_memset(struct instruction *insn)
 {
-	check_byte_count(insn, ptr_list_nth(insn->arguments, 3));
+	check_byte_count(insn, ptr_list_nth(insn->arguments, 2));
 }
 
 #define check_memcpy check_memset
diff --git a/validation/byte-count-max.c b/validation/byte-count-max.c
new file mode 100644
index 00000000..0555a505
--- /dev/null
+++ b/validation/byte-count-max.c
@@ -0,0 +1,28 @@
+typedef unsigned long int size_t;
+typedef unsigned long ulong;
+
+extern void *memset(void *s, int c, size_t n);
+extern void *memcpy(void *dest, void *src, size_t n);
+extern ulong copy_to_user(void *to, const void *from, ulong count);
+extern ulong copy_from_user(void *to, const void *from, ulong count);
+
+static void func (char *s)
+{
+	char d[250000];
+
+	memset(d, 0, 250000);
+	memcpy(d, s, 250000);
+	copy_to_user(s, d, 250000);
+	copy_from_user(d, s, 250000);
+}
+
+/*
+ * check-name: byte-count-max
+ *
+ * check-error-start
+byte-count-max.c:13:15: warning: memset with byte count of 250000
+byte-count-max.c:14:15: warning: memcpy with byte count of 250000
+byte-count-max.c:15:21: warning: copy_to_user with byte count of 250000
+byte-count-max.c:16:23: warning: copy_from_user with byte count of 250000
+ * check-error-end
+ */
-- 
2.33.0
