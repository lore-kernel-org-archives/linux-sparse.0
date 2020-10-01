Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FBFC4727F
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 09:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4AC20738
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 09:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgJAJ7I (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 05:59:08 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:50064 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAJ7I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 05:59:08 -0400
X-Greylist: delayed 2378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 05:59:06 EDT
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=rainbowdash.codethink.co.uk)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kNukJ-0006me-Ch; Thu, 01 Oct 2020 10:19:27 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.94)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1kNukI-001YtW-GO; Thu, 01 Oct 2020 10:19:26 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-sparse@vger.kernel.org
Cc:     thomas.preston@codethink.co.uk, christopher.phang@codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/4] add -Wformat
Date:   Thu,  1 Oct 2020 10:19:22 +0100
Message-Id: <20201001091923.372349-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
References: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add option to enable/disable format checking (and default it to off)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
---
 options.c |  2 ++
 options.h |  1 +
 sparse.1  | 10 ++++++++++
 3 files changed, 13 insertions(+)

diff --git a/options.c b/options.c
index 294dfd3b..ffd11798 100644
--- a/options.c
+++ b/options.c
@@ -100,6 +100,7 @@ int Wdesignated_init = 1;
 int Wdo_while = 0;
 int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
+int Wformat = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
@@ -840,6 +841,7 @@ static const struct flag warnings[] = {
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "external-function-has-definition", &Wexternal_function_has_definition },
+	{ "format", &Wformat },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
 	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
diff --git a/options.h b/options.h
index abdf0864..4e50db0b 100644
--- a/options.h
+++ b/options.h
@@ -99,6 +99,7 @@ extern int Wdesignated_init;
 extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
+extern int Wformat;
 extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
diff --git a/sparse.1 b/sparse.1
index 48dab7a9..860fde7c 100644
--- a/sparse.1
+++ b/sparse.1
@@ -257,6 +257,16 @@ Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-external\-function\-has\-definition\fR.
 .
 .TP
+.B \-Wformat
+Warn about parameter mismatch to any variadic function which specifies
+where the format string is specified with the 
+.BI __attribute__((format( type, message, va_start )))
+attribute.
+
+Sparse does not issue these warnings by default. To turn them on, use
+\fB\-W-format\fR.
+.
+.TP
 .B \-Winit\-cstring
 Warn about initialization of a char array with a too long constant C string.
 
-- 
2.28.0

