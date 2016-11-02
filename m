From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/3] By default disable the new warning flag '-Wunknown-attribute'
Date: Thu,  3 Nov 2016 00:07:39 +0100
Message-ID: <20161102230739.64519-4-luc.vanoostenryck@gmail.com>
References: <20161102230739.64519-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34628 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756859AbcKBXJu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 19:09:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id p190so5265459wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 16:09:49 -0700 (PDT)
In-Reply-To: <20161102230739.64519-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Generally, we won't be interested by those warnings, but we
can always explicitly ask for them if needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                               | 2 +-
 validation/Wunknown-attribute-def.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 138736e7..b4b09a78 100644
--- a/lib.c
+++ b/lib.c
@@ -240,7 +240,7 @@ int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
-int Wunknown_attribute = 1;
+int Wunknown_attribute = 0;
 int Wvla = 1;
 
 int dbg_entry = 0;
diff --git a/validation/Wunknown-attribute-def.c b/validation/Wunknown-attribute-def.c
index 0c0868d6..defe643d 100644
--- a/validation/Wunknown-attribute-def.c
+++ b/validation/Wunknown-attribute-def.c
@@ -4,6 +4,5 @@ static int foo(void) __attribute__((unknown_attribute));
  * check-name: warn-unknown-attribute
  *
  * check-error-start
-Wunknown-attribute-def.c:1:37: warning: attribute 'unknown_attribute': unknown attribute
  * check-error-end
  */
-- 
2.10.1

