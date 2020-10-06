Return-Path: <SRS0=85YD=DN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1114AC41604
	for <linux-sparse@archiver.kernel.org>; Tue,  6 Oct 2020 16:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2FF206F7
	for <linux-sparse@archiver.kernel.org>; Tue,  6 Oct 2020 16:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME2joqw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJFQfF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 6 Oct 2020 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFQfF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 6 Oct 2020 12:35:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED17C061755
        for <linux-sparse@vger.kernel.org>; Tue,  6 Oct 2020 09:35:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c22so17228584ejx.0
        for <linux-sparse@vger.kernel.org>; Tue, 06 Oct 2020 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zpalqsNnqgHexjoQsnleTkKDWwK8lRwWULgltByH1JA=;
        b=ME2joqw7F2rTvJY8T3HokB0bXg4qVdXtwS+ru7GVzbfRL/Mz+4OgShU4spAExV7zB3
         oYaM3X8toiIuCeI5aGi/1ufFIRMu5dCIlPhC4KcXYtZ56NgAriSd0LQ7UDmDwZgf/CRP
         XmED/3/nw3rpcMq9UmsAJvCgJ7OCeK8Y7ei3+I9H6aaNBETIb7o0Gq/ln787hY4B0OgP
         Hf5wt4p+j099N6xwGeX94V0bw/sPxxQBeMt/MxyPe0PwqMFMfyVLwPp/UEKyF5KoI95H
         r4X8rlomoaqzIJBs3NRu83EUdZDKZT4S3TH2I1zSyjefe3dUkPPOVhj8EjvbaWJXcm0M
         Gz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zpalqsNnqgHexjoQsnleTkKDWwK8lRwWULgltByH1JA=;
        b=lbNV1BoextyQMmcXMvqLgjLeMUFgrhPl0UUT5IGeJM3HRu+ERnhWEL/7M67QxyUpJ2
         rs8ktsWvQ6T6nQwzNqd4C4dhwcR5JTXGJpAYKMQfa5a0bmC7RHC/RDQ2FA5Id7Igofle
         QB66y/WfynVr8RirO4DjP3zlzD8qRWXMES/d7y9UHhNAkFy2WgnckZzuvysMEQq7OwgI
         7A+bkSOxrnsnHemKWf/1XkQK3fpckKdzsisBlYurgALIgiNLyGm46KLddtI0315AGs3z
         uzDcwxKOjsWegtx+BHx5KbmYU9JGPfVxzTziwRUp4xd26sIio7Ip9xxVgp4Cm7Cg66cB
         AWfA==
X-Gm-Message-State: AOAM532PVDPB7WnRpAfrdza/UtgBlqwJlei12LdoOvcFv1rVY1ZWyJ+C
        ObBacnOzQkdXjUpIS3VVxeYO/49h0zo=
X-Google-Smtp-Source: ABdhPJzyOCDGPbfUk2RRqmAvT1p0bphqXBh3hzhw0jGVMHQXUQ3hvzY1j1RBRiyFInEjDofYrPUvLw==
X-Received: by 2002:a17:906:17c6:: with SMTP id u6mr356070eje.95.1602002103284;
        Tue, 06 Oct 2020 09:35:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6cd8:b67a:a15c:19eb])
        by smtp.gmail.com with ESMTPSA id k18sm2523423ejk.42.2020.10.06.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:35:02 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove definition of removed OP_{AND,OR}_BOOL
Date:   Tue,  6 Oct 2020 18:34:58 +0200
Message-Id: <20201006163458.26069-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These instructions have been removed years ago, in 2016
but the corresponding opcode defines have been forgotten.

So remove them now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 opcode.def | 2 --
 1 file changed, 2 deletions(-)

diff --git a/opcode.def b/opcode.def
index 7959efaf64d4..1401d988d73a 100644
--- a/opcode.def
+++ b/opcode.def
@@ -33,8 +33,6 @@ OPCODE(FMUL,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
 OPCODE(FDIV,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
 
 /* Logical */
-OPCODE(AND_BOOL,        BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(OR_BOOL,         BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
 OPCODE(AND,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
 OPCODE(OR,              BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
 OPCODE(XOR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-- 
2.28.0

