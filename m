From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] teach cgcc about OSX aka darwin
Date: Mon, 29 May 2017 02:37:57 +0200
Message-ID: <20170529003757.3848-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36193 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2AkE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 20:40:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id k15so13993942wmh.3
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 17:40:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

cgcc knows about a few unix OSes but not yet about OSX/darwin.

Fix this by adding the two needed defines to cgcc's specs.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cgcc b/cgcc
index c29fa587e..e4d4ff0bf 100755
--- a/cgcc
+++ b/cgcc
@@ -237,6 +237,9 @@ sub add_specs {
     } elsif ($spec eq 'openbsd') {
 	return &add_specs ('unix') .
 	    ' -D__OpenBSD__=1';
+    } elsif ($spec eq 'darwin') {
+	return
+	    ' -D__APPLE__=1 -D__MACH__=1';
     } elsif ($spec eq 'unix') {
 	return ' -Dunix=1 -D__unix=1 -D__unix__=1';
     } elsif ( $spec =~ /^cygwin/) {
-- 
2.13.0

