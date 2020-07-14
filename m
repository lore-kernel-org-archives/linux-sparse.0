Return-Path: <SRS0=VjVX=AZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C362CC433E0
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF8B206F0
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 21:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYNxjaN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGNVqL (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgGNVqK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Jul 2020 17:46:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C3C061755
        for <linux-sparse@vger.kernel.org>; Tue, 14 Jul 2020 14:46:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id by13so69408edb.11
        for <linux-sparse@vger.kernel.org>; Tue, 14 Jul 2020 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCvI//l2H86sDx7Yl0YlYcJqWotVV/MSlmGGUSe/NJ0=;
        b=eYNxjaN8FB1C5nhCzDpZ+bZ2BNJFClfyFr8D0qbegPeBisHhIN0Jbj5HPprRbaJBWw
         7kRKDBqXpDbDQt61t3zY2ISExfYHk42qM+al3A6pSB/oDyeDROL6YOTdwp0l98VzbsNB
         84MtBF+gMHkDdFSq9FGBJHG9uqpNilhBq09pgS4zDV8yZ2nbaMwzvpIgbDMgdRLzTH2v
         1FIVh5j7tmjfL4O0/Uua867dgJ21iAIEYxzKQsV6rUMnrYzdivwk4UHuMhJLdZiWxlQC
         aTir3XqRR7uQ+rm5yF7yv1hX5Zs70E1iL4F4MN7Ti5Fud4/dl72XHB1j0WtluKSsvEsI
         4QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCvI//l2H86sDx7Yl0YlYcJqWotVV/MSlmGGUSe/NJ0=;
        b=FdmbCxe82T2JXqY/oTOInn3Q6fJxXV1ii/iSSt8fuQu2p00ewdYED3NpDF7d4aVpEE
         v4zwlBkvbDOLrUqKwzF6Y1JHMPsGjj3OAfKhN0P5o6S5yBr9BFjWQZLXFy0hTeCV1w0C
         rXEaWh+JaWsrFsv52b6VA4HrqzN3oNE9Th9WMYt2GRsVYgAAly/wIsgutjxDXGsHoaSu
         QAo5MVJ3sLIqUkgi4PlfgnWiTxJzH1Ve1SZeer7a6Gcjp64XnprFis6P21w+vW5jFebI
         gOZeKKNQv7aBSvVbO7T2GY5vql+x1PWbrlEdtxdeDq17T3BZvXKk5ufKoCijV/6oFvOi
         f21Q==
X-Gm-Message-State: AOAM533bD3E0d1vTcUIuojBSP3dblB5a3fI9YrHSz6rdXqzlgU7yVTay
        vrfYj21wbRMQV8/w/tdnQALugFdJ
X-Google-Smtp-Source: ABdhPJyFz4CuU/XYG28w9P/03suTRs/LpfXwwtLwjEJ8JaEro9kcHCdp9ujKMBz9wQMQGojPNaeNYA==
X-Received: by 2002:a05:6402:2c5:: with SMTP id b5mr6315284edx.316.1594763168624;
        Tue, 14 Jul 2020 14:46:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:5cd9:fc:d7bc:c84f])
        by smtp.gmail.com with ESMTPSA id d19sm55118ejk.47.2020.07.14.14.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:46:08 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] teach sparse about -fmax-errors
Date:   Tue, 14 Jul 2020 23:45:59 +0200
Message-Id: <20200714214559.15137-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, the maximum number of displayed errors is 100.
This is nice to not be flooded with error messages when things
are really broken but in some situation, for example testing,
it is desirable to have all error messages.

So, teach sparse about '-fmax-errors=COUNT'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c     | 2 +-
 options.c | 8 ++++++++
 options.h | 1 +
 sparse.1  | 6 ++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index d4f4dd3015c8..4e8d7b451747 100644
--- a/lib.c
+++ b/lib.c
@@ -90,7 +90,7 @@ static void do_error(struct position pos, const char * fmt, va_list args)
 		return;
 	/* Shut up warnings after an error */
 	has_error |= ERROR_CURR_PHASE;
-	if (errors > 100) {
+	if (errors > fmax_errors) {
 		static int once = 0;
 		show_info = 0;
 		if (once)
diff --git a/options.c b/options.c
index 9f05bdf9cf4f..c46ad4f52cbb 100644
--- a/options.c
+++ b/options.c
@@ -73,6 +73,7 @@ int dump_macros_only = 0;
 
 unsigned long fdump_ir;
 int fhosted = 1;
+unsigned int fmax_errors = 100;
 unsigned int fmax_warnings = 100;
 int fmem_report = 0;
 unsigned long long fmemcpy_max_count = 100000;
@@ -492,6 +493,12 @@ static int handle_fmemcpy_max_count(const char *arg, const char *opt, const stru
 	return 1;
 }
 
+static int handle_fmax_errors(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	opt_uint(arg, opt, &fmax_errors, OPTNUM_UNLIMITED);
+	return 1;
+}
+
 static int handle_fmax_warnings(const char *arg, const char *opt, const struct flag *flag, int options)
 {
 	opt_uint(arg, opt, &fmax_warnings, OPTNUM_UNLIMITED);
@@ -504,6 +511,7 @@ static struct flag fflags[] = {
 	{ "freestanding",	&fhosted, NULL, OPT_INVERSE },
 	{ "hosted",		&fhosted },
 	{ "linearize",		NULL,	handle_fpasses,	PASS_LINEARIZE },
+	{ "max-errors=",	NULL,	handle_fmax_errors },
 	{ "max-warnings=",	NULL,	handle_fmax_warnings },
 	{ "mem-report",		&fmem_report },
 	{ "memcpy-max-count=",	NULL,	handle_fmemcpy_max_count },
diff --git a/options.h b/options.h
index 7fd01ec6cebe..070c0dd87183 100644
--- a/options.h
+++ b/options.h
@@ -72,6 +72,7 @@ extern int dump_macros_only;
 
 extern unsigned long fdump_ir;
 extern int fhosted;
+extern unsigned int fmax_errors;
 extern unsigned int fmax_warnings;
 extern int fmem_report;
 extern unsigned long long fmemcpy_max_count;
diff --git a/sparse.1 b/sparse.1
index d916ad9ee54e..dbef62682b6e 100644
--- a/sparse.1
+++ b/sparse.1
@@ -20,6 +20,12 @@ off those warnings, pass the negation of the associated warning option,
 .
 .SH WARNING OPTIONS
 .TP
+.B \-fmax-errors=COUNT
+Set the maximum number of displayed errors to COUNT, which should be
+a numerical value or 'unlimited'.
+The default limit is 100.
+.
+.TP
 .B \-fmax-warnings=COUNT
 Set the maximum number of displayed warnings to COUNT, which should be
 a numerical value or 'unlimited'.
-- 
2.27.0

