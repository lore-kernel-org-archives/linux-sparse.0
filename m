Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39223C00140
	for <linux-sparse@archiver.kernel.org>; Thu, 11 Aug 2022 03:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiHKDdL (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Aug 2022 23:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKDdK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Aug 2022 23:33:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA51748EB1
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2022 20:33:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x23so15932958pll.7
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2022 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc;
        bh=auiLol2oSfZpMSxSGpxC7SJSMQbADVIHVYu6+RIdKBE=;
        b=e8zjgsgG20pHcpBrBuiTUAmRQ1aCKJvzjnUTHWGN4Gkk+t6qQn+dQjV3amAkuFnkLV
         JL2VSiomC2yM94imlAGt7TYVAOYYknrd7lZtq5/SHDyRDRNVjoF8DtaHnWxo2+cdrAj6
         3UIIOarQVQ2rKvNuoXy+cg9p/HHtgREgL57xqq4MNfQPg1du1jiMwQe29fluLq1tXhwR
         idq6rU/CnddWyErwNjAHg7LLhtH9hYryOsB/h6WjOw89LPajrqIs2xWSDvSyX9ci3kXT
         r1GIGUzwsFKPkoEeY7e/ckMehJizBm0K78KpQg+UsQ519fE1JEfWGugcMo2VX/dFzIhz
         g/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc;
        bh=auiLol2oSfZpMSxSGpxC7SJSMQbADVIHVYu6+RIdKBE=;
        b=SvVYlFM4JzzOdgoJKZRmzKH1qycFUtMX5buHZFB9mszOP0BqUSHQwR7HYSiA7+et83
         ZWirdlTZxVzlRViY5n0KJDraTWej8GOKLFkmvpp+2aFD6Exx7C04F9XLUnzT9n+o56AF
         w625txC/hfKBw/FHdG00w+kxN932o/dVCz5DIyLT4Oj6n9VI6PUi3iSmYtNELr6oZvkJ
         am5GGUjB4MQCcukijBPLR9ibq5hoZhfSyuLVkoC85Bs25NpgGOomNlKzG+OLQzi3Vxb5
         dCQMjMqC2UEv/XqRYxTLWbEmMHPnDTdTMOsZMOaiV715sm7fYPVdHJDwYfqADWgtnRAz
         C9mg==
X-Gm-Message-State: ACgBeo2pGs5kXTlLjUwBh2sLW6GS70HOvR5oMTg2GvyMs7FLtkNTGapP
        v9JrBV8SIQ1xAC4CfgcbP2pCKICphxjj+A==
X-Google-Smtp-Source: AA6agR6qhv0ac6gweHRqtjJ/VsiIRtv30UTCY+97TVOO3rOFdnln4laWNqq3sdf/d7wCRuUBFO5Neg==
X-Received: by 2002:a17:903:32c9:b0:171:2846:eef8 with SMTP id i9-20020a17090332c900b001712846eef8mr9586895plr.117.1660188789094;
        Wed, 10 Aug 2022 20:33:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id iw18-20020a170903045200b0016d6d1b610fsm13690876plb.98.2022.08.10.20.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 20:33:08 -0700 (PDT)
Subject: [PATCH] RISC-V: Add support for the zicbom extension
Date:   Wed, 10 Aug 2022 20:31:38 -0700
Message-Id: <20220811033138.20676-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This was recently added to binutils and with any luck will soon be in
Linux, without it sparse will fail when trying to build new kernels on
systems with new toolchains.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target-riscv.c b/target-riscv.c
index 217ab7e8..db0f7e57 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -19,6 +19,7 @@
 #define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
 #define RISCV_ZICSR	(1 << 10)
 #define RISCV_ZIFENCEI	(1 << 11)
+#define RISCV_ZICBOM	(1 << 12)
 
 static unsigned int riscv_flags;
 
@@ -41,6 +42,7 @@ static void parse_march_riscv(const char *arg)
 		{ "c",		RISCV_COMP },
 		{ "_zicsr",	RISCV_ZICSR },
 		{ "_zifencei",	RISCV_ZIFENCEI },
+		{ "_zicbom",	RISCV_ZICBOM },
 	};
 	int i;
 
@@ -131,6 +133,8 @@ static void predefine_riscv(const struct target *self)
 		predefine("__riscv_zicsr", 1, "1");
 	if (riscv_flags & RISCV_ZIFENCEI)
 		predefine("__riscv_zifencei", 1, "1");
+	if (riscv_flags & RISCV_ZICBOM)
+		predefine("__riscv_zicbom", 1, "1");
 
 	if (cmodel)
 		predefine_strong("__riscv_cmodel_%s", cmodel);
-- 
2.34.1

