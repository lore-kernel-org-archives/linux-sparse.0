From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cgcc: teach cgcc about freebsd & netbsd
Date: Tue,  7 Nov 2017 20:45:56 +0100
Message-ID: <20171107194556.69251-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51226 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbdKGTqE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Nov 2017 14:46:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id b9so6365929wmh.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Nov 2017 11:46:03 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/cgcc b/cgcc
index 16b37310f..0b191f62e 100755
--- a/cgcc
+++ b/cgcc
@@ -241,6 +241,12 @@ sub add_specs {
     } elsif ($spec eq 'openbsd') {
 	return &add_specs ('unix') .
 	    ' -D__OpenBSD__=1';
+    } elsif ($spec eq 'freebsd') {
+	return &add_specs ('unix') .
+	    ' -D__FreeBSD__=1';
+    } elsif ($spec eq 'netbsd') {
+	return &add_specs ('unix') .
+	    ' -D__NetBSD__=1';
     } elsif ($spec eq 'darwin') {
 	return
 	    ' -D__APPLE__=1 -D__MACH__=1';
-- 
2.14.0

