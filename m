Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BFFC433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846B164DE5
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhCJWLO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhCJWLF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:05 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218FBC061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ci14so41810139ejc.7
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSOlVvhpswOd0XzkaKOLANb7F+1Hjr1lBL8ZmMILtMo=;
        b=ooV70CbWoTAtdl9a7hzjrPFYZemf48JETSHY/YdqsbsGioe/sfX3w+SlTYvCFncjQH
         I53in//WO2csZK1Rz2jUsKz1gkuHY/k6hg6a3j2bJIPyjRUJWlDPGocgeEK5GeMA60nk
         5bvnQ985M2N5YSoMEIiCMJuwxHTve2cWlOLbm2DPBxYCeytGpT+bUx8H7tMIonyEAlLb
         5wKXBgSKb/RLsHNPkgKEOHGsm0wIh6rR0PSB2uCr6pld2rq9KONDwAKlz278vgkRrgje
         DRF80JFV5QDpKVV2v4de7RGIOUvPY80h2bvXLXDkRJjWeSD+TNkgv7I+j1pKKSrDZNDi
         vABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSOlVvhpswOd0XzkaKOLANb7F+1Hjr1lBL8ZmMILtMo=;
        b=e+oC+wmMtkQqZWcyBJN7j0lxL+43eAx6CIi/J97jKh75ZZMG6U66K49vYiG0m7gvk4
         nFmHePtJQxP61jQ5pI4Wp/cCgS8TtcpxdMY0b9vOd44hLrYcqMKn1ZGrq3rPOi8wRiDH
         hxcl0++YyELf6tmiP4fSmbKENs97GI9GNESGa8iq6yuFDwXg+VgHOpDx4JBQdzGkSmLp
         DqRXhmMNthNj9LnhGdYQqVKbZRJK6My84PZioFeFew+QwgkwSKGyg4bRMPCGa6R51tZ/
         ywAJ4ATpcYjgT6b4hFRXUh1gJlC5ffD3qd0n3sfAxTQQTnGTUHhMt3cPDa0iuwLOh4B0
         kyjA==
X-Gm-Message-State: AOAM532fuBiqfeaU1Zhy0BQWy/Fkgzhdjm4oyvQfy0LdXN16chCZ5v/0
        oy3jX0Gx58CNTXDaKY0LTXx/2BFoTR8=
X-Google-Smtp-Source: ABdhPJzNRPnZPa0smfKxVnKuGd+lkMIx4l/L4gYV15sq+iZJ3/mkxVbLgV6HfsXd3alHRHupZbHCcQ==
X-Received: by 2002:a17:906:f9db:: with SMTP id lj27mr48648ejb.399.1615414263882;
        Wed, 10 Mar 2021 14:11:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:03 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] simplify (x & M) cmps 0
Date:   Wed, 10 Mar 2021 22:49:46 +0100
Message-Id: <20210310214950.84192-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
References: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                    | 4 ++++
 validation/optim/cmps0-and0.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index ee29c9619bdc..6c11018ea3bf 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1271,6 +1271,8 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 				return replace_with_value(insn, 0);
 			if (value >= (long long)bits)
 				return replace_with_value(insn, 1);
+			if (value == 0)
+				return replace_opcode(insn, OP_SET_EQ);
 			break;
 		case OP_SET_GT:
 			value = sign_extend(value, def->size);
@@ -1280,6 +1282,8 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 				return replace_with_value(insn, 1);
 			if (value >= (long long)bits)
 				return replace_with_value(insn, 0);
+			if (value == 0)
+				return replace_opcode(insn, OP_SET_NE);
 			break;
 		case OP_SET_B:
 			if (value > bits)
diff --git a/validation/optim/cmps0-and0.c b/validation/optim/cmps0-and0.c
index 819a1dc2a793..8316916abc8c 100644
--- a/validation/optim/cmps0-and0.c
+++ b/validation/optim/cmps0-and0.c
@@ -6,7 +6,6 @@ int cmps_and_sgt0(int a) { return ((a & M) >  0) == ((a & M) != 0); }
 /*
  * check-name: cmps0-and
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

