From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 26/28] bad-label: check for unused labels
Date: Tue, 19 May 2020 02:57:26 +0200
Message-ID: <20200519005728.84594-27-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgESA57 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D57C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n24so2399519ejd.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:59 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Issue a warning if a label is defined but not used.

Note: this should take in account the attribute 'unused'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scope.c                   | 8 ++++++++
 validation/label-unused.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/scope.c b/scope.c
index 017c0dcd8600..03593d823d6d 100644
--- a/scope.c
+++ b/scope.c
@@ -150,6 +150,14 @@ void start_label_scope(void)
 
 void end_label_scope(void)
 {
+	struct symbol *sym;
+
+	FOR_EACH_PTR(label_scope->symbols, sym) {
+		if (!sym->stmt || sym->used)
+			continue;
+		warning(sym->pos, "unused label '%s'", show_ident(sym->ident));
+	} END_FOR_EACH_PTR(sym);
+
 	end_scope(&label_scope);
 }
 
diff --git a/validation/label-unused.c b/validation/label-unused.c
index c136c7a8813e..a654ef7742be 100644
--- a/validation/label-unused.c
+++ b/validation/label-unused.c
@@ -15,7 +15,6 @@ l:
 
 /*
  * check-name: label-unused
- * check-known-to-fail
  *
  * check-error-start
 label-unused.c:3:1: warning: unused label 'l'
-- 
2.26.2
