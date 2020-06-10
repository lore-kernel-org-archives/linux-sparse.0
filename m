From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/7] builtin: add support for arch-specific builtins
Date: Wed, 10 Jun 2020 22:27:32 +0200
Message-ID: <20200610202735.84968-5-luc.vanoostenryck@gmail.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbgFJU1s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Jun 2020 16:27:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8EC03E96F
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so4070223eja.7
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:47 -0700 (PDT)
In-Reply-To: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that a table is used for the declaration of builtin functions
it's easy to support arch-specific builtins.

The main objective is to not 'pollute' the main table with
arch-specfic entries for uncommon architectures.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 4 ++++
 target.h  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/builtin.c b/builtin.c
index bb9ec65b2d20..dcf8200ec002 100644
--- a/builtin.c
+++ b/builtin.c
@@ -391,6 +391,9 @@ static void declare_one_builtin(const struct builtin_fn *entry)
 
 static void declare_builtins(const struct builtin_fn tbl[])
 {
+	if (!tbl)
+		return;
+
 	while (tbl->name)
 		declare_one_builtin(tbl++);
 }
@@ -587,5 +590,6 @@ void init_builtins(int stream)
 {
 
 	declare_builtins(builtins_common);
+	declare_builtins(arch_target->builtins);
 	init_linearized_builtins(stream);
 }
diff --git a/target.h b/target.h
index a89e21b63563..1202c0be1ac9 100644
--- a/target.h
+++ b/target.h
@@ -54,6 +54,8 @@ extern int bits_in_enum;
 extern int enum_alignment;
 
 
+struct builtin_fn;
+
 struct target {
 	enum machine	mach;
 	enum bitness	bitness;
@@ -71,6 +73,8 @@ struct target {
 	const struct target *target_32bit;
 	const struct target *target_64bit;
 
+	const struct builtin_fn *builtins;
+
 	void (*init)(const struct target *self);
 	void (*predefine)(const struct target *self);
 };
-- 
2.27.0
