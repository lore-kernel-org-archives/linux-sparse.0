Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC3DC64EC4
	for <linux-sparse@archiver.kernel.org>; Mon,  6 Mar 2023 22:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCFWXg (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 6 Mar 2023 17:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFWXf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2023 17:23:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7E3E0BF
        for <linux-sparse@vger.kernel.org>; Mon,  6 Mar 2023 14:23:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D2A0B8112D
        for <linux-sparse@vger.kernel.org>; Mon,  6 Mar 2023 22:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E78C433D2;
        Mon,  6 Mar 2023 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678141412;
        bh=0ujwpBdDkTkrQ1BoCrcBZae0PDESaKbNQx1rzSbynJM=;
        h=From:To:Cc:Subject:Date:From;
        b=hOkvauOrLZgr4+yrS0NAKrC8yiFi7aK4vbptuUDsCXTf8VbEJ5LnN5kIaeMsPAZFI
         3XfLgl9ufy025qK+RhxB+qtDktYYlHFToplz10lV78ZuaJgyZITvoz4SOHZeYvrSVy
         wQ1Z4FYfm0Gjpj0fiaxKzAVg/m1GgWqRefcRZEc2ZfABM+c5eZuYzuYWZGvRKNokNy
         r/Ek87fhE5MgLyhdxNhefxiFW66lZJDhqQ6E4ktoreqFcrsaGxIU9UnzU/Rha2y1Mp
         v5lk4LKPhVFuvJSnAjscn+jNzsUWtQTu8MdhkOounYl5GE1wpQUdLH64aNXC1qPLOP
         hGMCJ/MX4Zlsw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        luc.vanoostenryck@gmail.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1] RISC-V: Add basic support for the vector extension
Date:   Mon,  6 Mar 2023 22:23:22 +0000
Message-Id: <20230306222321.1992900-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

I've started hitting this in CI while testing Andy's vector enablement
series. I'm not entirely sure if there is more to do here, other than
squeezing in the duplicate of what has been done for other extensions.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
This is based on top of patches already on the sparse list, adding
support for some multi-letter extensions for RISC-V:
https://lore.kernel.org/linux-sparse/20220811033138.20676-1-palmer@rivosinc.com/
https://lore.kernel.org/linux-sparse/20220811052957.16634-1-palmer@rivosinc.com/

CC: luc.vanoostenryck@gmail.com
CC: palmer@dabbelt.com
CC: linux-sparse@vger.kernel.org
CC: linux-riscv@lists.infradead.org
---
 target-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target-riscv.c b/target-riscv.c
index 8338d7a6..c8282814 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -21,6 +21,7 @@
 #define RISCV_ZIFENCEI		(1 << 11)
 #define RISCV_ZICBOM		(1 << 12)
 #define RISCV_ZIHINTPAUSE	(1 << 13)
+#define RISCV_VECTOR		(1 << 14)
 
 static unsigned int riscv_flags;
 
@@ -41,6 +42,7 @@ static void parse_march_riscv(const char *arg)
 		{ "f",			RISCV_FLOAT|RISCV_FDIV|RISCV_ZICSR },
 		{ "d",			RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
 		{ "c",			RISCV_COMP },
+		{ "v",			RISCV_VECTOR },
 		{ "_zicsr",		RISCV_ZICSR },
 		{ "_zifencei",		RISCV_ZIFENCEI },
 		{ "_zicbom",		RISCV_ZICBOM },
@@ -147,6 +149,8 @@ static void predefine_riscv(const struct target *self)
 		predefine("__riscv_zicbom", 1, "1");
 	if (riscv_flags & RISCV_ZIHINTPAUSE)
 		predefine("__riscv_zihintpause", 1, "1");
+	if (riscv_flags & RISCV_VECTOR)
+		predefine("__riscv_vector", 1, "1");
 
 	if (cmodel)
 		predefine_strong("__riscv_cmodel_%s", cmodel);
-- 
2.39.2

