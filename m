From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: add link to the doc on kernel.org in the man page
Date: Sat, 13 Jun 2020 00:13:12 +0200
Message-ID: <20200612221312.12223-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWNV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 Jun 2020 18:13:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D75C03E96F
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 15:13:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gl26so11531748ejb.11
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 15:13:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The generated doc is hosted on readthedocs.io since a little
while but:
* it wasn't much publicised
* it's now also live on sparse.docs.kernel.org

So, add a link to this doc on the manpage.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse.1 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sparse.1 b/sparse.1
index 9a2df0a2df36..bbcffc418f9f 100644
--- a/sparse.1
+++ b/sparse.1
@@ -511,6 +511,10 @@ You do not have to be subscribed to the list to send a message there.
 Bugs can also be reported and tracked via the Linux kernel's bugzilla:
 http://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools .
 .
+.SH DOCUMENTATION
+More documentation about Sparse can be found at
+https://sparse.docs.kernel.org
+.
 .SH AUTHORS
 Sparse was started by Linus Torvalds.
 The complete list of contributors can be find at
-- 
2.27.0
