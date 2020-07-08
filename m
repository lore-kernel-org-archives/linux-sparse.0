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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5501C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822B120720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+KnxveE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgGHXmH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGHXmG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBFC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:42:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so338420edb.13
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3fv49LMNfTwzFVqSWKccOkjxPIcAzVyOhSvck3VJ4s=;
        b=f+KnxveETQjwfk+/Ur+IRI6AiiJsVeoaYzqLkH2EHMZGrTWJ4s24FDmjbMsq0FXEtO
         iLGdvOUa9K40S9NoAEzunViYIvD4c+c6STDH4/MwKzvEln0UQH3fzTQ1nd8nZSM7/p8d
         MCICeSPDdjiljWuJnmms8TJQccGcb6Hy/3OB5KKFB44aj143Lzv8FPPpZOuv3WLMr/oY
         F0nLi+tlJnSpMmRdDTwRF8QtrLxg2wWRYMbv+Yvv9Yu64W5XDgWwjlv2neKhBX/JJLAs
         Nf+r4aXV3B8e0DWu5Z70ercB03AbgWeecXsOSOP6Tfa8319VjWsBCDnJnLRomFjNheiR
         OVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3fv49LMNfTwzFVqSWKccOkjxPIcAzVyOhSvck3VJ4s=;
        b=sLQIg8luCGnVJ7HSKADvB3LLPSfo9+tmc1PU5/usiIDEro5VLZiOegX6lmrLDd3xyK
         AZ8MRak17Qnl5I22tfGP+luNBGRclQ3wOXXwkvYgFJ/MyQL21+DKBNAlroJ2PFwkSBc0
         0S4tM91uMpIVT+49aO0Czep2rPtXGZCHtCz3KYMILWiNCrdIVJ3y6vk3Nb28KnPN6tRR
         NhA5S/gzYirSkcT6Y2QmmkAkPgoQ9IGOka21UA51fZ4Y37JjH4vkaUxCeZFDjazNAULd
         KWQZ/nJegNSi2piPMu8c1uGHPwBGybst/0VHxZ2GwEuD44Et74u96c0S6Fayx1kOYb6X
         GuYg==
X-Gm-Message-State: AOAM530+OiZpkRCuJ2VYaEEnY61KKvq2wWrgi28ipNQmmQNF9RxEbBhm
        ymBmUvv6AzNAGkMFJIXOKOctDJVs
X-Google-Smtp-Source: ABdhPJwgdGd5kdIKS/W67Dlop1YBZjTf2WAZcm1VWzBnzgBxu/bVwVWk0S1uu51eVzqDzTVbEGZJMA==
X-Received: by 2002:aa7:d754:: with SMTP id a20mr10242471eds.375.1594251724127;
        Wed, 08 Jul 2020 16:42:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:42:03 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/9] cygwin: add the predefines '__cdecl', ...
Date:   Thu,  9 Jul 2020 01:41:50 +0200
Message-Id: <20200708234151.57845-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

For CygWin, GCC defines some pseudo-specifiers like '__cdecl',
'__stdcall' or '_thiscall'. Some of these are already defined by cgcc.

So, add these predefines to sparse itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/predefine.c b/predefine.c
index 0f36f7ef56d2..94952e81d1df 100644
--- a/predefine.c
+++ b/predefine.c
@@ -221,6 +221,15 @@ void predefined_macros(void)
 		predefine("__CYGWIN__", 1, "1");
 		if (arch_m64 == ARCH_LP32)
 			predefine("__CYGWIN32__", 1, "1");
+		add_pre_buffer("#define __cdecl __attribute__((__cdecl__))\n");
+		add_pre_buffer("#define __declspec(x) __attribute__((x))\n");
+		add_pre_buffer("#define __fastcall __attribute__((__fastcall__))\n");
+		add_pre_buffer("#define __stdcall __attribute__((__stdcall__))\n");
+		add_pre_buffer("#define __thiscall __attribute__((__thiscall__))\n");
+		add_pre_buffer("#define _cdecl __attribute__((__cdecl__))\n");
+		add_pre_buffer("#define _fastcall __attribute__((__fastcall__))\n");
+		add_pre_buffer("#define _stdcall __attribute__((__stdcall__))\n");
+		add_pre_buffer("#define _thiscall __attribute__((__thiscall__))\n");
 		break;
 	case OS_DARWIN:
 		predefine("__APPLE__", 1, "1");
-- 
2.27.0

