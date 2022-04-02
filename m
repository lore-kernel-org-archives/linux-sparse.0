Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D6CC433EF
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Apr 2022 05:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbiDBFGE (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbiDBFFt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Apr 2022 01:05:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E771B17E340
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 22:03:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso4274373pjh.3
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 22:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=/fso4SvqY0T0Qc0lJoOtYLQfWSaSLReduQ9sUe6VaJs=;
        b=uGosKXDu+hscZuRzge/vediHFAPVq1SdtFOr9eZrABDXdNBO3pgfgBZx3uaSYpNzRp
         wz/ApkQxH/EQ3IcY8ZFNK7Yl86tb8BPAeLnIkdrpUPE6MhuadxjIX2zpFo649gdl0Vo+
         jKsMsnJGU1g9eQz8donGaVhSVWFuVDE4wmf6nSnoAmdqEugZjfK1wl0Asf5wUQoHSwRn
         xaXNEx+ALURQymZzxaGvkpArTOs/7xFXrZ2LVyyukJmNZZUIP85mHp1aws9F+GDbcPEh
         nwIuw6dCr4BMYt2EAyITAOsrkWIzDsHVR8kvbGsXbqU1cmjjNVy3ll+C5CMH51m8YxW6
         bvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=/fso4SvqY0T0Qc0lJoOtYLQfWSaSLReduQ9sUe6VaJs=;
        b=cZQ2GGJX7FOu9bqsEXGSESSeHphzn8hKjAotO6m5kU0WfNqjSAPGcEmOCxi4YDR6gw
         OAzW+erxXghTkJbKz3hxmqmgb/bMz/gdgMy6lRBojLB+/PtmsKj5YWzoTvo1AzLdgX1I
         iqwG5AKbhqpIFf+zsNR9HLdHAAucZYu5E/4ZBZMJtEootn2t/noPnsEyObXW7KztVmQL
         HadkwrpCz2jNkHgC3iaKfJFlAMvHR/fMD3/TxHo1FqIZlve3NbeUySXdfIlRlpETD/qX
         vPPer2kXVSgSZzDvBW3wxO2nn2HW6TYQjXYS7Yt3k5/VE/X371pVoasCgpNZE7FXDFGl
         nrkw==
X-Gm-Message-State: AOAM5316i3Z92IQJhNZckkFOiNzViKTK+R+c0rD+1GXm2DGtN7wRqovs
        aQrM0Ns9ce7w5ZFkDNOGFLqLwCPTLPpxTA==
X-Google-Smtp-Source: ABdhPJymdt4noevXnrvhSXtRg7cNfDareVVHTnYVduYX1299M3qBHo5UqJ8QZ4RN5IjJvLAivXOqWQ==
X-Received: by 2002:a17:90b:352:b0:1c6:77e:a4f7 with SMTP id fh18-20020a17090b035200b001c6077ea4f7mr15403578pjb.77.1648875838401;
        Fri, 01 Apr 2022 22:03:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a060800b001c7936791d1sm3959110pjj.7.2022.04.01.22.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:03:58 -0700 (PDT)
Subject: [PATCH v1 6/6] RISC-V: Add the Zifencei extension
Date:   Fri,  1 Apr 2022 22:00:41 -0700
Message-Id: <20220402050041.21302-7-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220402050041.21302-1-palmer@rivosinc.com>
References: <20220402050041.21302-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Recent versions of binutils default to an ISA spec version that doesn't
include Zifencei as part of I, so Linux has recently started passing
this in -march.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target-riscv.c b/target-riscv.c
index afd6fafa..ff4dfba3 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -18,6 +18,7 @@
 #define RISCV_FPU	(RISCV_FLOAT|RISCV_DOUBLE|RISCV_FDIV)
 #define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
 #define RISCV_ZICSR	(1 << 10)
+#define RISCV_ZIFENCEI	(1 << 11)
 
 static unsigned int riscv_flags;
 
@@ -39,6 +40,7 @@ static void parse_march_riscv(const char *arg)
 		{ "d",		RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
 		{ "c",		RISCV_COMP },
 		{ "_zicsr",	RISCV_ZICSR },
+		{ "_zifencei",	RISCV_ZIFENCEI },
 	};
 	int i;
 
@@ -132,6 +134,8 @@ static void predefine_riscv(const struct target *self)
 		predefine("__riscv_muldiv", 1, "1");
 	if (riscv_flags & RISCV_ZICSR)
 		predefine("__riscv_zicsr", 1, "1");
+	if (riscv_flags & RISCV_ZIFENCEI)
+		predefine("__riscv_zifencei", 1, "1");
 
 	if (cmodel)
 		predefine_strong("__riscv_cmodel_%s", cmodel);
-- 
2.34.1

