From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 1/2] By default disable the warning flag '-Wunknown-attribute'
Date: Wed, 14 Feb 2018 00:21:08 +0100
Message-ID: <20180213232109.20933-2-luc.vanoostenryck@gmail.com>
References: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33123 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966007AbeBMXVQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 18:21:16 -0500
Received: by mail-wr0-f196.google.com with SMTP id s5so20252307wra.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 15:21:16 -0800 (PST)
In-Reply-To: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Lance Richardson <lrichard@redhat.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Randy Dunlap <rdunlap@infradead.org>, Rui Teng <rui.teng@linux.vnet.ibm.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Generally, we're not interested by those warnings, but we
can always explicitly ask for them if needed.

So make the flag '-Wunknown-attribute' off by default.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                               | 2 +-
 validation/Wunknown-attribute-def.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index fcd31e84c..aec52a6fa 100644
--- a/lib.c
+++ b/lib.c
@@ -251,7 +251,7 @@ int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
-int Wunknown_attribute = 1;
+int Wunknown_attribute = 0;
 int Wvla = 1;
 
 int dump_macro_defs = 0;
diff --git a/validation/Wunknown-attribute-def.c b/validation/Wunknown-attribute-def.c
index 0c0868d6b..defe643db 100644
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
2.16.0

