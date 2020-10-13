Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE0C433E7
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8100420878
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR75A0VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgJNJUa (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbgJNJUI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77D3C05BD37
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p15so2139841ejm.7
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/JvTb126QV+80NBtR2WROH2033g+ofTSJfzhsB69Gk=;
        b=HR75A0VHxzqgoQq2x677iUR0qLJ1yy/k1UB2vC6bb1uz/2QRNhTquFxial198dpzte
         vrrx59rZnKblebZ/pSl0WgIzo6TjqOzJsiaDKFCelT0qb3hGKS9dztU8XLmLtsMXJ7SO
         15lwPAQdcNvDI30U9yVt9hD773cgXZA1iRuqB3T26newjnFrRWsr6ftNNRyamC3N8xPf
         0FDRwp3buPc/1RrdgdjeS+7nIiKJECNWZNdRgIb1cbhVxyGh9EY7N+dyBDCwenR6qKjU
         0+j+IBQP1c/kzvCPvdRb5jB8XG/qpCWdU3jXdS4EGzQz+yt2ZyLaw0bzLr9uXdH7vmS5
         Rcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/JvTb126QV+80NBtR2WROH2033g+ofTSJfzhsB69Gk=;
        b=IPv2yZo3wJ6jSjMmNZn0yk7cSGbV0aJtn/H7/4wbf+oPY7bMmThqPIOFnKvVzWM7c2
         3HXTiDCVpXu3HzQ+c1qAGg1J4hoViUl/C+dnclOwjQkwl9tatJofRyLqt6/3o0mRk4M8
         LRcIjOb+Nvi9irF2jbI/78PtWZ1uw8HCJSk14tTGAAG8xlDVXMP/gukU2aNS9kFCgeM4
         HrGMmyMUh0nWAwCiOp+yviFIE7MhZAiFPHdPRTKj2JDRCDceKAmHFDW7zHazibuCf5Wq
         WGu1tMjyUFYLZ6c7rg7jGBrkgBWKOi/qPZe/xzGHIv+dnIvwLeAp1ki0Se2nN2X9BzCQ
         BenA==
X-Gm-Message-State: AOAM532APIasiRriN5QvfOc11h6b4lZYqd8QqkUrLHLNEqzsaon5qW+N
        dx2td9W61mCoG1/sTIf8B0d4Ei5J+LY=
X-Google-Smtp-Source: ABdhPJx26OjbyFBhEx2bcf1BcbQTQ7ABLHbPZ5aedTO+YBMJ2zmq4h5bQfLA3e75s9yIrOMx7+uiww==
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr2218704eja.233.1602631361276;
        Tue, 13 Oct 2020 16:22:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/13] format-check: void * is not OK for strings, fix the test
Date:   Wed, 14 Oct 2020 01:22:19 +0200
Message-Id: <20201013232231.10349-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/varargs-format-addrspace1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/validation/varargs-format-addrspace1.c b/validation/varargs-format-addrspace1.c
index 3370ac67849c..53c210b78ae0 100644
--- a/validation/varargs-format-addrspace1.c
+++ b/validation/varargs-format-addrspace1.c
@@ -4,8 +4,8 @@ extern int variadic2(char *msg, int , ...) __attribute__((format (printf, 1, 3))
 extern int variadic3(int, char *msg,  ...) __attribute__((format (printf, 2, 3)));
 
 static void test(void) {
-	void __attribute__((noderef, address_space(1))) *a;
-	void *b;
+	const char __attribute__((noderef, address_space(1))) *a;
+	const char *b;
 
 	variadic("%s\n", a);
 	variadic("%s\n", b);
@@ -22,15 +22,15 @@ static void test(void) {
  * check-error-start
 varargs-format-addrspace1.c:10:26: warning: incorrect type in argument 2 (different address spaces)
 varargs-format-addrspace1.c:10:26:    expected char const *
-varargs-format-addrspace1.c:10:26:    got void [noderef] <asn:1> *a
+varargs-format-addrspace1.c:10:26:    got char const [noderef] <asn:1> *a
 varargs-format-addrspace1.c:12:32: warning: incorrect type in argument 3 (different address spaces)
 varargs-format-addrspace1.c:12:32:    expected char const *
-varargs-format-addrspace1.c:12:32:    got void [noderef] <asn:1> *a
+varargs-format-addrspace1.c:12:32:    got char const [noderef] <asn:1> *a
 varargs-format-addrspace1.c:13:36: warning: incorrect type in argument 4 (different address spaces)
 varargs-format-addrspace1.c:13:36:    expected char const *
-varargs-format-addrspace1.c:13:36:    got void [noderef] <asn:1> *a
+varargs-format-addrspace1.c:13:36:    got char const [noderef] <asn:1> *a
 varargs-format-addrspace1.c:14:36: warning: incorrect type in argument 4 (different address spaces)
 varargs-format-addrspace1.c:14:36:    expected char const *
-varargs-format-addrspace1.c:14:36:    got void [noderef] <asn:1> *a
+varargs-format-addrspace1.c:14:36:    got char const [noderef] <asn:1> *a
  * check-error-end
  */
-- 
2.28.0

