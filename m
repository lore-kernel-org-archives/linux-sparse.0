Return-Path: <SRS0=GL7X=A5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B64AC433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 18:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E285A2080D
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 18:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmG05eaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGRSkD (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRSkD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Jul 2020 14:40:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB934C0619D2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 11:40:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b15so10082716edy.7
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkMU5WxzqNT/tJltNN+TdSn8hLXu/mh8R6/9qizJaaI=;
        b=DmG05eaT3VmangYNN9qds/hV1MumfggYszE1ul4cj9JUIWb/Sd50jd8E36Rvtjz4p4
         EyxHL8JbzwWAD4GUTJ5eJ5hwOUC6+6XqfQK/aWwMXRBy8nHyDpaq/v/vMx9+jSapaRqv
         dMPFfjZX/dIpyElkLG2lZQDpkP6430jboZ1ei5Pvu49rvaWjSlCNV3UyiaKIEIAbpH1V
         5ZX6r/gCjle0ziIF72TFxb5B4HX3qQ0x6Ku8l2ySLEzGNqpOgQA64mnWGWMKX4vYhcWD
         pxv0PpZNoNRpHzvVS3/32MNf/SUjtfvztVa135kxmBc6voGsNvjDmCv/c+eD7MNl8vTS
         e5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkMU5WxzqNT/tJltNN+TdSn8hLXu/mh8R6/9qizJaaI=;
        b=bX18bveCfgSumWpolSXy8U9sE/l+aXQ77Ku1+4ZxxAFDtw97+dlM962CqppQxw/msc
         Std0btAtZeL1VoEnAJ2tLAUU4uqrC64fRjhBJgKfelOvlyztiQXJ16r06hj0hl3CtZM0
         XSH2EYS1cUTE2iSdbPQUSvLWJPk53YOnYbRcjFWAHpLcRmg0vHd5nbnsea+UkF9n1PGo
         VRsVKrZDYuLjfu9AqneT5GXDITyN251WkCVucTrHw3x4b5pLBehCEoJ/phlJyvA+BR0M
         o11KPiYx8NMICmSYIgXFek4m6JE0NlntPvoKza1kJfUBrxQgsdVZgrs96MqjRmvwBovl
         wR5Q==
X-Gm-Message-State: AOAM533D6PENQP1enRD41iCsilHdIJwykXBoE0Z5yUcdxKR9YkXoNqAV
        a7o9bW8X2y9rB23m5PBpuZqTpNBB
X-Google-Smtp-Source: ABdhPJyAikxWXXo9wPlY4QoUL+AMksaxc5oklq2s/4KuyyvVJvkKpcqb2u9N85Tkot3fmoTO5yPnlg==
X-Received: by 2002:aa7:c504:: with SMTP id o4mr14421394edq.311.1595097601075;
        Sat, 18 Jul 2020 11:40:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:358b:7402:ba12:5a9])
        by smtp.gmail.com with ESMTPSA id b4sm11676185edx.96.2020.07.18.11.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 11:40:00 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] warnings: ensure the source filename is shown at least once
Date:   Sat, 18 Jul 2020 20:39:55 +0200
Message-Id: <20200718183955.16718-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When checking a series of files, if some warnings or errors
are issued but only coming from some includes, it's not possible
to identify which source file is responsible since its filename
is not displayed.

So, if the first warning is from a file other than the source
file, display first a note coming from the source file itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                         | 13 +++++++++++++
 validation/cast-kinds-check.c |  1 +
 2 files changed, 14 insertions(+)

diff --git a/lib.c b/lib.c
index 4e8d7b451747..b94c2c83c1c5 100644
--- a/lib.c
+++ b/lib.c
@@ -50,6 +50,18 @@
 #include "bits.h"
 
 
+static void show_top_filename(const char *name)
+{
+	static const char *last;
+
+	if (name == base_filename)
+		return;
+	if (name == last)
+		return;
+	fprintf(stderr, "%s: note: in included file:\n", base_filename);
+	last = name;
+}
+
 static void do_warn(const char *type, struct position pos, const char * fmt, va_list args)
 {
 	static char buffer[512];
@@ -63,6 +75,7 @@ static void do_warn(const char *type, struct position pos, const char * fmt, va_
 	name = stream_name(pos.stream);
 		
 	fflush(stdout);
+	show_top_filename(name);
 	fprintf(stderr, "%s:%d:%d: %s%s%s\n",
 		name, pos.line, pos.pos, diag_prefix, type, buffer);
 }
diff --git a/validation/cast-kinds-check.c b/validation/cast-kinds-check.c
index 0c0cd67368a3..32a106d413da 100644
--- a/validation/cast-kinds-check.c
+++ b/validation/cast-kinds-check.c
@@ -6,6 +6,7 @@
  * check-assert: sizeof(long) == 8
  *
  * check-error-start
+cast-kinds-check.c: note: in included file:
 optim/cast-kinds.c:5:45: warning: cast drops bits
 optim/cast-kinds.c:6:47: warning: cast drops bits
 optim/cast-kinds.c:7:46: warning: cast drops bits
-- 
2.27.0

