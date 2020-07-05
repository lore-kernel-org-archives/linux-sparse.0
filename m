From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] predefine: avoid add_pre_buffer() for targets
Date: Sun,  5 Jul 2020 15:16:04 +0200
Message-ID: <20200705131605.26551-3-luc.vanoostenryck@gmail.com>
References: <20200705131605.26551-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgGENQO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:16:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96794C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:16:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so39610714ejj.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:16:14 -0700 (PDT)
In-Reply-To: <20200705131605.26551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Avoid add_pre_buffer() and use one of the predefine...()
variant instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-arm64.c | 2 +-
 target-riscv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target-arm64.c b/target-arm64.c
index d491b65e5154..8619bd842f9b 100644
--- a/target-arm64.c
+++ b/target-arm64.c
@@ -21,7 +21,7 @@ static void predefine_arm64(const struct target *self)
 	predefine("__aarch64__", 1, "1");
 
 	if (cmodel)
-		add_pre_buffer("#define __AARCH64_CMODEL_%s__ 1\n", cmodel);
+		predefine_strong("__AARCH64_CMODEL_%s__", cmodel);
 }
 
 const struct target target_arm64 = {
diff --git a/target-riscv.c b/target-riscv.c
index 08d036ca04b7..d68fb585c254 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -24,7 +24,7 @@ static void predefine_riscv(const struct target *self)
 	predefine("__riscv_xlen", 1, "%d", ptr_ctype.bit_size);
 
 	if (cmodel)
-		add_pre_buffer("#define __riscv_cmodel_%s 1\n", cmodel);
+		predefine_strong("__riscv_cmodel_%s", cmodel);
 }
 
 const struct target target_riscv32 = {
-- 
2.27.0
