Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23768C83F2F
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Aug 2023 16:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbjHaQd5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbjHaQdu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2023 12:33:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF4CD7
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2023 09:33:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c8b2d6784so13161477b3.3
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2023 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693499627; x=1694104427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TLVkJMtFMtxqN/FlfG44AV8zInEiORUqCTslGqZ0Zos=;
        b=FEYbr5NOY/yssInoCh+qYqWCs8xJ6Zw8lt7EEsdNRJfgm5tHejPeICkoNzRXnhimlw
         OSKgb4BOlbWfp736fkGdp7k2/oTLuKvg+s1GrgAeW5EcW7QpVrnGrRiuKvJD5KnZiBPP
         ElQrl3ZI/As4Py9P2Xp+DG9wv01cNdfFpyS31Izn4+b6Uvyg7hvcjHAZBR6M+x/VZQiN
         slCRLnFGOPefHeKZN/FSDPcfuZIZQrv7ifMToTWvfcgkn5UwqQjVPIGCDPOIETGVVFmj
         tLP3/7BuF+tEJ7dyhXXn9ADDdTH0ggiUiq/Mjr/ENZAO/JZ8lr/yeuckxbveLPT3WLuc
         FuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693499627; x=1694104427;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLVkJMtFMtxqN/FlfG44AV8zInEiORUqCTslGqZ0Zos=;
        b=VIomTniDyM/WRKL6vEATj2bfHwTLsSehhgnQb4TAzZKvwHiVihIVVgCPqf025SpXUW
         Nl2ZJqWgVieQSah3KWRIhkAVuJSrKx1q3yXVQ0HDzZXCQxh/28FxMh4vwnONKOp0VL01
         ZOPWxVBppWEYBR/KBuYmIkzMTYRXZ3o3ckalVZv/0Qdkme/FyUedrKUZ0pd0KzcjwTPK
         sP+MjCr5LoBS8UrNTGiwleXLxPSc4SDl2z8Acib+yb0TgsV2fB4hblIzasN+8zS/6tj9
         n1b0JoFsYmVf9Sor9hwyf02rZDa4GCJOQ+efZ1K+EUZXsf/rVfWY+V0qQDIampULErbw
         F2cA==
X-Gm-Message-State: AOJu0Yx+7uhSKLGLL0qQsoXVP873TAO1t8HZsmq5xF8ykQuG7Fj6zJBW
        Sf4HPCzc3ckvpfVl0ATC+gibZTlqIYT3pl7rmOo=
X-Google-Smtp-Source: AGHT+IHBf6DssYHHHGzDp+ZZCZOF66xUxU07MR9mUuVHImcb4Q/TurPeCLfHb/qMIv/nPlAZpPXEVTmDap9poDfZ0rQ=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:892a:3b04:5286:6211])
 (user=ndesaulniers job=sendgmr) by 2002:a81:b105:0:b0:583:4f82:b9d9 with SMTP
 id p5-20020a81b105000000b005834f82b9d9mr206632ywh.5.1693499626839; Thu, 31
 Aug 2023 09:33:46 -0700 (PDT)
Date:   Thu, 31 Aug 2023 09:33:40 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOPA8GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC2ND3dK8zMLS1PjMFF0TC2NLY4vkZCODxEQloPqCotS0zAqwWdGxtbU AkP5UnlsAAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693499624; l=2689;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=5wJlHBCko6R4VUFetDJgQLAa+BBT8kcL3VLV3bHqTXY=; b=LyNW0ykOyhWizRHCLzYXMxm0Nq0Nar2lwxOuLhJQr3jkgWqXkdznUFQ0Vr5FqxY1CHeFwukok
 Xz0DnJ2LnRRCylfMQ3UT1JHRd46qHV9S1JN0HGfdbXA/7DCAAZZdFDl
X-Mailer: b4 0.12.3
Message-ID: <20230831-unique_id-v1-1-28bacd18eb1d@google.com>
Subject: [PATCH] compiler.h: unify __UNIQUE_ID
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jan Beulich <jbeulich@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <mmarek@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

commit 6f33d58794ef ("__UNIQUE_ID()")
added a fallback definition of __UNIQUE_ID because gcc 4.2 and older did
not support __COUNTER__.

Also, this commit is effectively a revert of
commit b41c29b0527c ("Kbuild: provide a __UNIQUE_ID for clang")
which mentions clang 2.6+ supporting __COUNTER__.

Documentation/process/changes.rst currently lists the minimum supported
version of these compilers as:
- gcc: 5.1
- clang: 11.0.0
It should be safe to say that __COUNTER__ is well supported by this
point.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-clang.h | 5 -----
 include/linux/compiler-gcc.h   | 2 --
 include/linux/compiler.h       | 5 +----
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 9b673fefcef8..ddab1ef22bee 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -14,11 +14,6 @@
 #undef __cleanup
 #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
 
-/* same as gcc, this was present in clang-2.6 so we can assume it works
- * with any version that can compile the kernel
- */
-#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
-
 /* all clang versions usable with the kernel support KASAN ABI version 5 */
 #define KASAN_ABI_VERSION 5
 
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7af9e34ec261..2ceba3fe4ec1 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -39,8 +39,6 @@
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
-#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
-
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a18b24f..174099fdc485 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -177,10 +177,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
-/* Not-quite-unique ID. */
-#ifndef __UNIQUE_ID
-# define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
-#endif
+#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 /**
  * data_race - mark an expression as containing intentional data races

---
base-commit: b97d64c722598ffed42ece814a2cb791336c6679
change-id: 20230831-unique_id-483938cc20aa

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

