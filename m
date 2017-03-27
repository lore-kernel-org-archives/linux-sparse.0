From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] fix test for cast to bool on 32bit machines
Date: Mon, 27 Mar 2017 16:19:14 +0200
Message-ID: <20170327141918.61151-2-luc.vanoostenryck@gmail.com>
References: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34621 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbdC0OWL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 10:22:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so10897995wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 07:21:41 -0700 (PDT)
In-Reply-To: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The result implicitely depended on longs and/or pointers
being 64 bit or just bigger than ints.

Fix this by running the test with the -m64 flag.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bool-cast-explicit.c | 2 +-
 validation/bool-cast-implicit.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/bool-cast-explicit.c b/validation/bool-cast-explicit.c
index 6f9c4d461..4e3c2b7ce 100644
--- a/validation/bool-cast-explicit.c
+++ b/validation/bool-cast-explicit.c
@@ -16,7 +16,7 @@ static _Bool fres(le16 a) { return (_Bool)a; }
 
 /*
  * check-name: bool-cast-explicit
- * check-command: test-linearize $file
+ * check-command: test-linearize -m64 $file
  * check-output-ignore
  * check-output-excludes: cast\\.
  *
diff --git a/validation/bool-cast-implicit.c b/validation/bool-cast-implicit.c
index 0e0e69a45..ee8b705b9 100644
--- a/validation/bool-cast-implicit.c
+++ b/validation/bool-cast-implicit.c
@@ -16,7 +16,7 @@ static _Bool fres(le16 a) { return a; }
 
 /*
  * check-name: bool-cast-implicit
- * check-command: test-linearize $file
+ * check-command: test-linearize -m64 $file
  * check-output-ignore
  * check-output-excludes: cast\\.
  *
-- 
2.12.0

