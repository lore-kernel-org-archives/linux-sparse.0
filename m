Return-Path: <SRS0=9mpR=AJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D87C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Jun 2020 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75AB20724
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Jun 2020 09:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGbJucpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgF1JJK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Jun 2020 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgF1JJK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Jun 2020 05:09:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F086C061794
        for <linux-sparse@vger.kernel.org>; Sun, 28 Jun 2020 02:09:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so13339533ejd.0
        for <linux-sparse@vger.kernel.org>; Sun, 28 Jun 2020 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vHgs1IzKYJf4giQCQ9NzkgHBJ5bxNXjzrd+rpHbMc0=;
        b=HGbJucpQzw2S2RGf8ZKs9FE5AXAkOVKVcnr+UTAd/HD4VzlYC0O30o8r7VDuFNy3un
         v6+RLCgEHlETbDbpOd+t1o49maLMgUTS6CYxtN0sFIEvSs2HntUQYaWGBFqJpPl3nkN7
         94kgPw16ZKuZg2tfCwB1bpubsG3qnr/h7AHJNE2KCh63MyUqzFXNi4QtKcJksACc94uB
         b6oHTNoqc0JbJmd7i+Tt4cpkTYJSleOOs5xU66ruNcxCR4pUXqMNHhpseu+gVexfkyWB
         0Ox0ZKFnEXVavXLVdnxj7PnSa9jP1k4TgSAIl9Userk8yHCiCDF+gb5oDQvS7xvNwvPm
         W/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vHgs1IzKYJf4giQCQ9NzkgHBJ5bxNXjzrd+rpHbMc0=;
        b=QipUC3OIz8+v740md2MZN8y97idk1il9ahqa3THBH+tvzQRx4gSU9rrPaWj0axTe0q
         6uGuUm8S/dk0qT46ueYk3BJylzCFD3OYReu7IwY/A2g3MQG0MHeLD1dNCs7nrdKgp4Jb
         dME7JhWq4RBByb/Uz2BMohEaOuNKSSuMNGj/1fxIarrvmWWEcas+BvrksGX+9Vt0d/BN
         Msb6bK/bnza7EatiaXQgkBlFZe5QRg2wcZyC5u5uVOZUQyWcMFiB5UQe90ToEujYxYUe
         3to816OGDlJMO9YKI6Q9JGyYL+Ukgw+dgnguSsE4x+RXUwxU50spfd48QcjMmMC/HTre
         lnGw==
X-Gm-Message-State: AOAM531CneZNlJImkcl0wp5ItiR49TEJrJtTF+p+jsSPhU9oUp0H3dEi
        tElXqlKRkh/mkdtcpCZSHS1X0h0r
X-Google-Smtp-Source: ABdhPJwNnw565LI73o22yq4HvuWwQawlYo0GGJp3rozJaKaLYtWGrdRG+5p9Y2gQPqpIx6+n05XBSQ==
X-Received: by 2002:a17:906:fb14:: with SMTP id lz20mr9857228ejb.217.1593335348368;
        Sun, 28 Jun 2020 02:09:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:f51f:7c31:2fc7:f95b])
        by smtp.gmail.com with ESMTPSA id a37sm15270818edf.86.2020.06.28.02.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 02:09:07 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove unneeded BSD & Solaris compatibility layer
Date:   Sun, 28 Jun 2020 11:09:04 +0200
Message-ID: <20200628090904.69011-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200628090904.W4eHMlf8DqXDOXm0wIiucn-aEdHJ-WRxPkggw1QvE5Y@z>

None of the BSDs need "compat-bsd.c" anymore. Same for
Solaris and "compat-solaris.c", even for Solaris 10.

The only problem was lacking C99's strtold() but it seems
that this was solved many years ago and they're all doing
quite fine with "compat-linux.c".

So, simply replace the content of these file by an include of
"compat-linux.c".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 compat-bsd.c     | 14 +-------------
 compat-solaris.c | 34 +---------------------------------
 2 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/compat-bsd.c b/compat-bsd.c
index d8acf40b1dcb..43c716ca2f87 100644
--- a/compat-bsd.c
+++ b/compat-bsd.c
@@ -21,16 +21,4 @@
  * THE SOFTWARE.
  */
 
-#include <sys/types.h>
-#include <string.h>
-
-#include "lib.h"
-#include "allocate.h"
-#include "token.h"
-
-#include "compat/mmap-blob.c"
-
-long double string_to_ld(const char *nptr, char **endptr)
-{
-	return strtod(nptr, endptr);
-}
+#include "compat-linux.c"
diff --git a/compat-solaris.c b/compat-solaris.c
index 7253a892d50d..58bc43387c60 100644
--- a/compat-solaris.c
+++ b/compat-solaris.c
@@ -1,33 +1 @@
-#include "lib.h"
-#include "allocate.h"
-
-#include "compat/mmap-blob.c"
-
-#include <floatingpoint.h>
-#include <limits.h>
-#include <errno.h>
-
-long double string_to_ld(const char *str, char **endptr)
-{
-	long double res;
-	decimal_record dr;
-	enum decimal_string_form form;
-	decimal_mode dm;
-	fp_exception_field_type excp;
-	char *echar;
-
-	string_to_decimal ((char **)&str, INT_MAX, 0,
-			   &dr, &form, &echar);
-	if (endptr) *endptr = (char *)str;
-
-	if (form == invalid_form) {
-		errno = EINVAL;
-		return 0.0;
-	}
-
-	dm.rd = fp_nearest;
-	decimal_to_quadruple (&res, &dm, &dr, &excp);
-        if (excp & ((1 << fp_overflow) | (1 << fp_underflow)))
-                errno = ERANGE;
-	return res;
-}
+#include "compat-linux.c"
-- 
2.27.0

