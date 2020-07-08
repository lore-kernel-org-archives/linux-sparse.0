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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0063C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70AD20720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8OREuyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGHXmJ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgGHXmI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:08 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E45DC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:42:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so372215edr.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MQH+U/cDTolwgwu/R0iq+Av98e4ETTNg+kzmfLTXVk=;
        b=h8OREuyuc7KzeH/rtngPH8fd7kuGvWGYy+HMCn3UkSiyQw6ilOSDfsFRuvLjUEAQE4
         9WgjfXOd2awk/Nk1sn9ULzeunydCHntQsDDkmkYfJFrKhS0dSI+xUh/0jyPCGBH3k675
         rV5/0IhgUME6g2SxwX5SfyWk9cHR2XbbL6C/6BiDoK2gSVsA5jffDm06UemLkyAS7oVD
         +39Kj5OqO+uuBBkTjPRyxb5LmPfJoty1UBl1yfC5IaQGo9FZIXNs0IG+g2qXfNH44ZFI
         ikz3hqCGCh2nfxz22JEsuBn9lbOitlpvyixfOJnViPDBPZktqLC+FZSCqdNMjVxaKmlC
         m1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MQH+U/cDTolwgwu/R0iq+Av98e4ETTNg+kzmfLTXVk=;
        b=qmxBdEUUxg+MVafWDfwk6tZdoqSfYJyxcG1VNTM/P/FlE6pa+AtXjBd0jJfApbyG/1
         8wkYjGdAgXxcXzhvsoV6i4kodb9RmrC8zVl+52RHgeufJVd80nf5pn4oYpCGVbU6S+hY
         YQxaoAJ3Y7hWtASzytQ3eCbz3cmepd3UKWPf9k/YpaQGqutW7nsRJe2ge153a4YZMHdL
         emaf1d6rdYFsM9nEiFyzoN7dX4TAkq5s3Nsey0vmxLcxJF9zkU5buL/nrOD2+w9dqPBe
         E4FmsPXLUlas+C350anZTfT0k7HyIqG4gSOm4tJk4R9aZVzQfwM4x9VGC8XKTSJ2E+ZI
         +CSg==
X-Gm-Message-State: AOAM532bo/vW+qOLIPUHybn0QVXduD++mx2K1+PWzAcDA1mESESdScOh
        /Rg/oqcjZ57qIDbXu2rbwvNieEwF
X-Google-Smtp-Source: ABdhPJw9QrmBYp6kuVowkdKFCyUpF7tjLyN6UirkLd16zn6we5HNdELELtLpsjOqMWq8X2niCVuX5Q==
X-Received: by 2002:a05:6402:1a42:: with SMTP id bf2mr61175707edb.292.1594251725018;
        Wed, 08 Jul 2020 16:42:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:42:04 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] cgcc: remove now unneeded options & defines
Date:   Thu,  9 Jul 2020 01:41:51 +0200
Message-Id: <20200708234151.57845-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that the OS can be specified to sparse via an option (--os=$OS)
and that sparse knows about their specificities, it's no more
needed or useful to also define them in cgcc.

So, remove from cgcc the OS-specificities known to sparse (a few
few exotic ones remain for now) but ensure that the info about
the correct OS is passed to sparse.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/cgcc b/cgcc
index 9c6ad88367c1..cc356701380a 100755
--- a/cgcc
+++ b/cgcc
@@ -221,48 +221,32 @@ sub float_types {
 sub add_specs {
     my ($spec) = @_;
     if ($spec eq 'sunos') {
-	return &add_specs ('unix') .
-	    ' -D__sun__=1 -D__sun=1 -Dsun=1' .
-	    ' -D__svr4__=1 -DSVR4=1' .
+	return " --os=$specs" .
+	    ' -DSVR4=1' .
 	    ' -D__STDC__=0' .
 	    ' -D_REENTRANT' .
 	    ' -D_SOLARIS_THREADS' .
 	    ' -DNULL="((void *)0)"';
     } elsif ($spec eq 'linux') {
-	return &add_specs ('unix') .
-	    ' -D__linux__=1 -D__linux=1 -Dlinux=1';
+	return " --os=$specs";
     } elsif ($spec eq 'gnu/kfreebsd') {
 	return &add_specs ('unix') .
 	    ' -D__FreeBSD_kernel__=1';
     } elsif ($spec eq 'openbsd') {
-	return &add_specs ('unix') .
-	    ' -D__OpenBSD__=1';
+	return " --os=$specs";
     } elsif ($spec eq 'freebsd') {
-	return &add_specs ('unix') .
-	    ' -D__FreeBSD__=1';
+	return " --os=$specs";
     } elsif ($spec eq 'netbsd') {
-	return &add_specs ('unix') .
-	    ' -D__NetBSD__=1';
+	return " --os=$specs";
     } elsif ($spec eq 'darwin') {
-	return
-	    ' -D__APPLE__=1 -D__APPLE_CC__=1 -D__MACH__=1';
+	return " --os=$specs";
     } elsif ($spec eq 'gnu') {		# Hurd
 	return &add_specs ('unix') .	# So, GNU is Unix, uh?
 	    ' -D__GNU__=1 -D__gnu_hurd__=1 -D__MACH__=1';
     } elsif ($spec eq 'unix') {
 	return ' -Dunix=1 -D__unix=1 -D__unix__=1';
     } elsif ( $spec =~ /^cygwin/) {
-	return &add_specs ('unix') .
-	    ' -fshort-wchar' .
-	    ' -D__CYGWIN__=1' .
-	    ($m32 ? ' -D__CYGWIN32__=1' : '') .
-	    " -D'_cdecl=__attribute__((__cdecl__))'" .
-	    " -D'__cdecl=__attribute__((__cdecl__))'" .
-	    " -D'_stdcall=__attribute__((__stdcall__))'" .
-	    " -D'__stdcall=__attribute__((__stdcall__))'" .
-	    " -D'_fastcall=__attribute__((__fastcall__))'" .
-	    " -D'__fastcall=__attribute__((__fastcall__))'" .
-	    " -D'__declspec(x)=__attribute__((x))'";
+	return ' --os=cygwin';
     } elsif ($spec eq 'i386') {
 	$m32 = 1;
 	return (
-- 
2.27.0

