From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: fix manpage formatting
Date: Sun, 21 Jan 2018 05:46:44 +0100
Message-ID: <20180121044644.90500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42991 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeAUEsz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 23:48:55 -0500
Received: by mail-wm0-f66.google.com with SMTP id b141so10409330wme.1
        for <linux-sparse@vger.kernel.org>; Sat, 20 Jan 2018 20:48:54 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A '.TP' was missing when describing '-fmem-report'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse.1 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sparse.1 b/sparse.1
index fbe1784da..88343f317 100644
--- a/sparse.1
+++ b/sparse.1
@@ -371,6 +371,7 @@ The \fIdir\fR name would normally take the form of the target's
 normalized GNU triplet. (e.g. i386-linux-gnu).
 .
 .SH DEBUG OPTIONS
+.TP
 .B \-fmem-report
 Report some statistics about memory allocation used by the tool.
 .
-- 
2.16.0

