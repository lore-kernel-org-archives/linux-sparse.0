Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D6EC433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852B720720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2uWJ/YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGHXmB (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgGHXmA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F1C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:41:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so279573ejq.6
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5VUZyYR8Ws24HoRf33dgh74kOHN07JnlrqUnHFvy0w=;
        b=B2uWJ/YNLodL9bFb7WJfUvIsE7X5NNWDrKAp6C87/4gGsDVFLClOb4BLMlxfkAqgq+
         z373PwEbMB1mzNE/X78+/ghUZoM8Enln0SbheA98WNYZ9j7NYBzgbaTYZnGXei4ycuXK
         FuiIvXJa1V9ppUyU+VCgmV+GOQxlyUzsXGHLKzvA45FH+bJcuE2TU0Ke1c9I/NojrkVb
         9+ebgouMkRK+OvKAraxdT54M3BgfouG2s/jw1FOqArMJygvzwL9DX7qP+nfK4l+6BFrl
         e8sy0EhKmo5EXe+Fjrq/xDnXVcNodjIjJrj5q7hlqukZo15SPy0VC1hji5i6O49wDkE9
         bG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5VUZyYR8Ws24HoRf33dgh74kOHN07JnlrqUnHFvy0w=;
        b=H+dDTRIE8isEJHdotiPbe/Pm7f04FGt0WHQITsRUaaMCDz7ZGeomFZqBgU8r1GfzE2
         wVsD8uhdtDd/t6N/DhN7WYGgEk+lAjwvRiumbhotCIK9hqecp2Oz6mZ/ZsMQsMkjvaem
         hW+KqdFB35GFT2MFEXCRt20HqGSFdrn5pc6UNTaCi7e+ifTrvh9UQf5+Xju3YM3JYcpw
         P1tOG3hVLHVLKSRBBhPnuSDSPSp/wz8rWCG/6UgAYcoF5A0EtI8ciQMxVhzlDsQOQ+sa
         BdTb6baRlFNhOOBv0zIsgYWJsg3rzBYMnHYsXkUqxY2ggkucIXPmYESIIFeGOlp8Shkr
         wOfg==
X-Gm-Message-State: AOAM5318U3Qs4Ty4ZVHy8Ks76UngHowjeG/mZWwkTCkB8/U/PvFlrP8+
        mldcxtMO4BFGOIF80v1TID0mtd/w
X-Google-Smtp-Source: ABdhPJwFxwFNrDSQTPhV8cyEeWSnhmDzK7Cyh24noqtdVFg4txt/j1gNG8Lwh9Q7Oeit/obv9Ps5pw==
X-Received: by 2002:a17:906:c002:: with SMTP id e2mr50568759ejz.244.1594251718412;
        Wed, 08 Jul 2020 16:41:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:41:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/9] arch: add an option to specify the OS: --os=$OS
Date:   Thu,  9 Jul 2020 01:41:44 +0200
Message-Id: <20200708234151.57845-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is not needed when doing native 'compilation' but is
quite handy when testing the predefined types & macros.
The supported OSes are: 'linux', 'freebsd', 'openbsd', 'netbsd'
'darwin', 'sunos', 'cygwin' and a generic 'unix'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 machine.h |  1 +
 options.c | 11 +++++++++++
 sparse.1  | 10 ++++++++++
 target.c  | 29 +++++++++++++++++++++++++++++
 target.h  |  1 +
 5 files changed, 52 insertions(+)

diff --git a/machine.h b/machine.h
index 7407e71627e1..cc02818c81bf 100644
--- a/machine.h
+++ b/machine.h
@@ -94,6 +94,7 @@ enum fp_abi {
 
 enum {
 	OS_UNKNOWN,
+	OS_NONE,
 	OS_UNIX,
 	OS_CYGWIN,
 	OS_DARWIN,
diff --git a/options.c b/options.c
index 9f05bdf9cf4f..530d15adeffd 100644
--- a/options.c
+++ b/options.c
@@ -925,6 +925,16 @@ static char **handle_param(char *arg, char **next)
 	return next;
 }
 
+static char **handle_os(char *arg, char **next)
+{
+	if (*arg++ != '=')
+		die("missing argument for --os option");
+
+	target_os(arg);
+
+	return next;
+}
+
 static char **handle_version(char *arg, char **next)
 {
 	printf("%s\n", SPARSE_VERSION);
@@ -941,6 +951,7 @@ static char **handle_long_options(char *arg, char **next)
 {
 	static struct switches cmd[] = {
 		{ "arch", handle_arch, 1 },
+		{ "os",   handle_os, 1 },
 		{ "param", handle_param, 1 },
 		{ "version", handle_version },
 		{ NULL, NULL }
diff --git a/sparse.1 b/sparse.1
index d916ad9ee54e..82467b23330b 100644
--- a/sparse.1
+++ b/sparse.1
@@ -464,6 +464,16 @@ Look for system headers in the multiarch subdirectory \fIdir\fR.
 The \fIdir\fR name would normally take the form of the target's
 normalized GNU triplet. (e.g. i386-linux-gnu).
 .
+.TP
+.B \-\-os=\fIOS\fR
+Specify the target Operating System.
+This only makes a few differences with the predefined types.
+The accepted values are: linux, unix, freebsd, netbsd, opensd, sunos, darwin
+and cygwin.
+
+The default OS is the one of the machine used to build Sparse if it can be
+detected, oherwise some generic settings are used.
+.
 .SH DEBUG OPTIONS
 .TP
 .B \-fmem-report
diff --git a/target.c b/target.c
index 6776c3a1cbb0..8de1b1f3d9d2 100644
--- a/target.c
+++ b/target.c
@@ -136,6 +136,35 @@ enum machine target_parse(const char *name)
 	return MACH_UNKNOWN;
 }
 
+void target_os(const char *name)
+{
+	static const struct os {
+		const char *name;
+		int os;
+	} oses[] = {
+		{ "cygwin",	OS_CYGWIN },
+		{ "darwin",	OS_DARWIN },
+		{ "freebsd",	OS_FREEBSD },
+		{ "linux",	OS_LINUX },
+		{ "native",	OS_NATIVE, },
+		{ "netbsd",	OS_NETBSD },
+		{ "none",	OS_NONE },
+		{ "openbsd",	OS_OPENBSD },
+		{ "sunos",	OS_SUNOS },
+		{ "unix",	OS_UNIX },
+		{ NULL },
+	}, *p;
+
+	for (p = &oses[0]; p->name; p++) {
+		if (!strcmp(p->name, name)) {
+			arch_os = p->os;
+			return;
+		}
+	}
+
+	die("invalid os: %s", name);
+}
+
 
 void target_config(enum machine mach)
 {
diff --git a/target.h b/target.h
index 8f79426c096a..0a8e2deba306 100644
--- a/target.h
+++ b/target.h
@@ -105,6 +105,7 @@ extern const struct target target_x86_64;
 extern const struct target *arch_target;
 
 enum machine target_parse(const char *name);
+void target_os(const char *name);
 void target_config(enum machine mach);
 void target_init(void);
 
-- 
2.27.0

