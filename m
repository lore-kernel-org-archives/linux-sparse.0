Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1797DC433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FD664DA8
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 17:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhA0RCH (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhA0Q7s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 27 Jan 2021 11:59:48 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41BBC06174A
        for <linux-sparse@vger.kernel.org>; Wed, 27 Jan 2021 08:59:07 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 19so2387213qkh.3
        for <linux-sparse@vger.kernel.org>; Wed, 27 Jan 2021 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ynd9ok2zmAXXWWCDtjq4+9/8OkzUW2GlkP5uLBOZKBI=;
        b=ZEJ4+w99/03b6Bp7iTxX+QBRViwbK4qdlKzkrDjCsL9fEbYDZK7GZTVFaCydXLmlgV
         rqZ5PIZrjrXJ+RFDCzwjUoy0GzRRgi6u+ryfVIBoQTShZQOR8uf40wgK3ax6K7VDU5AM
         JZT+THuuEIBHabeKMv8hRW17MC4bAQzJhH7DJ15HB0cSVWQGxrGb+DOqy8odwkVQmhA4
         u3Z1GnXWz/UbqDMJPOAUl5460vu9cV0xKweBNWxE20Vu+aZdaZ0GLiijAb9Udwsp7BiC
         f415hKYEYsgCy+lvF75GyK0walRDttTohW+2VxJweJHL9ZfIJvf+75IJfDAalul3zi/j
         ivjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ynd9ok2zmAXXWWCDtjq4+9/8OkzUW2GlkP5uLBOZKBI=;
        b=h12MNWnkq+qQ3Bi5QV9U2PH4cNDHtVPy3cCPpg/dSCsbnBunUKQzxmlFSzgLHvYZZV
         EsJX3YsKbNbE9ACkmkV7wySPu0wFu4ndaAbflo8s5eyW4iBQwohKVFSXQR5P1bCwp1tL
         PQuEkSjCVJjSJleWsmwdC3ijo60AyQh/dqvQXkXe+8wndg8qkj/IGypkfM6lfW/CKtMU
         tq6dkrb02VBf43dA4vBox9xgeLkp0b99OBLW/PNCP2M9UH/DsDAHl4fHXMgl3z+4NPbs
         WlpPDcqwr9HooWInw6z29s5TVHI1/aN2dZn5ZWxYm+O5YEUO09970f344PIcwrMP7NmO
         KQDA==
X-Gm-Message-State: AOAM532Bnw4a64g5ZiStZEvTWS7xer6CZ5amXygFYQEEkxhSb46u1MOL
        r+Vbxf5VRPwphDzMVZit6F91TaosCR6VEw==
X-Google-Smtp-Source: ABdhPJy0+xfmOyyfBbaVktpDIpHKuGl78tThTAWyOK5xZILEKR9HwpOkDfaUOHCG2/vKlH12Vx1jqg==
X-Received: by 2002:ae9:ddc4:: with SMTP id r187mr11240929qkf.391.1611766746775;
        Wed, 27 Jan 2021 08:59:06 -0800 (PST)
Received: from poirot.caas.local (2603-6010-3300-220b-2013-1a4a-6037-bf0f.res6.spectrum.com. [2603:6010:3300:220b:2013:1a4a:6037:bf0f])
        by smtp.gmail.com with ESMTPSA id p23sm1684431qtu.4.2021.01.27.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 08:59:06 -0800 (PST)
From:   Kyle Russell <bkylerussell@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Kyle Russell <bkylerussell@gmail.com>
Subject: [PATCH] Makefile: add version.h dependency on all objects
Date:   Wed, 27 Jan 2021 11:58:56 -0500
Message-Id: <20210127165856.2090337-1-bkylerussell@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This guarantees the generated version.h will exist before attempting
to compile any c files that include it.

Several source files include the generated version.h, but not all
declare a proper make dependency.

$ grep -r 'version\.h' *.c
compile-i386.c:#include "version.h"
lib.c:#include "version.h"
options.c:#include "version.h"

This allows a sufficiently parallelized make invocation to encounter
ENOENT.

  CC      compile-i386.o
compile-i386.c:60:21: fatal error: version.h: No such file or directory
compilation terminated.
Makefile:253: recipe for target 'compile-i386.o' failed
make: *** [compile-i386.o] Error 1

Signed-off-by: Kyle Russell <bkylerussell@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 31366446..dbad0f7a 100644
--- a/Makefile
+++ b/Makefile
@@ -249,7 +249,7 @@ libsparse.a: $(LIB_OBJS)
 
 
 cflags   += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
-%.o: %.c
+%.o: %.c version.h
 	@echo "  CC      $@"
 	$(Q)$(CC) $(cflags) -c -o $@ $<
 
@@ -260,7 +260,6 @@ cflags   += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
 selfcheck: $(OBJS:.o=.sc)
 
 SPARSE_VERSION:=$(shell git describe --dirty 2>/dev/null || echo '$(VERSION)')
-lib.o: version.h
 version.h: FORCE
 	@echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h.tmp
 	@if cmp -s version.h version.h.tmp; then \
-- 
2.25.1

