Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF6C4332B
	for <linux-sparse@archiver.kernel.org>; Thu, 18 Mar 2021 23:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2092164E99
	for <linux-sparse@archiver.kernel.org>; Thu, 18 Mar 2021 23:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhCRXzR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 18 Mar 2021 19:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhCRXyn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Mar 2021 19:54:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D3C061761
        for <linux-sparse@vger.kernel.org>; Thu, 18 Mar 2021 16:54:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 11so4609676pfn.9
        for <linux-sparse@vger.kernel.org>; Thu, 18 Mar 2021 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WJ6qFjujuk84HtZNxKJ3XhHk2SJ/KWCJ14sG1Kz83s=;
        b=CdkMN8s18bbHU7BWYnXpDrRJmP+p4loTeWJJyqcx4HuZvW1Vda8z98Y2ASlcHTIJGT
         kfGOknuMJnd5wDtVN36rhZHHw/YqtK0aGw06udFaXsPxfcgyueVtA7HHrkGtkhobE5G7
         5dNTO5PUp7Y4vbrkQ5AISjIAmImTZQcvd/6NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WJ6qFjujuk84HtZNxKJ3XhHk2SJ/KWCJ14sG1Kz83s=;
        b=Mn+WYHSXGXjnXYSk9+0zn1dLEsZvfj5J5aNUKyMF2IRKz+pCBdDPgpindTPotSOf5M
         z7G/Bz4O8llFo9BKZPGaXqdnsMWrjbm82rnori5UgNMDnFLXEi0GZ9bwDIkOg7e06as2
         88vu68kQfXx4CP4+gickfRCpZJ4KfHszUCCsTIjQBbu8wyKd7DHVSKc3CdbwOCMQNdZk
         Siy4eybaL7zN0AC6qn4TSpW7vFRb7NU8X3UP2Umd2ywIRIf0SOe3lvJ1TCRxOXewbbCd
         kTQkTF/NnF7QEEbwEf0bvbeEkA1ltWxnron5ZJeEfBDHV39TltkXKKHaAUY7a9w+GXs6
         AezQ==
X-Gm-Message-State: AOAM5311IIEN8PB7Ml2sTAhMsJHrYRPxnlSkKvEH8R8PcjBXLQYm22g9
        ePJQ3TIleSQXDi9DVrPS3vUerQ==
X-Google-Smtp-Source: ABdhPJxXmm1o5PbpOMlqhlmpnaK9uuEh/v/JENGCPwg/wnedfsiovOHRc3DPwhGQCHSShTfkWFXJGg==
X-Received: by 2002:a62:e119:0:b029:1f8:9345:a099 with SMTP id q25-20020a62e1190000b02901f89345a099mr6618116pfh.21.1616111682271;
        Thu, 18 Mar 2021 16:54:42 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:dc70:2def:a801:e21b])
        by smtp.gmail.com with ESMTPSA id t7sm3295816pfg.69.2021.03.18.16.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 16:54:41 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     stable@vger.kernel.org
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christopher Li <sparse@chrisli.org>,
        Daniel Axtens <dja@axtens.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sparse@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [for-stable-4.19 PATCH 0/2] Backport patches to fix KASAN+LKDTM with recent clang on ARM64
Date:   Fri, 19 Mar 2021 07:54:14 +0800
Message-Id: <20210318235416.794798-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


Backport 2 patches that are required to make KASAN+LKDTM work
with recent clang (patch 2/2 has a complete description).
Tested on our chromeos-4.19 branch.

Patch 1/2 is context conflict only, and 2/2 is a clean backport.

These patches have been merged to 5.4 stable already. We might
need to backport to older stable branches, but this is what I
could test for now.


Mark Rutland (1):
  lkdtm: don't move ctors to .rodata

Thomas Gleixner (1):
  vmlinux.lds.h: Create section for protection against instrumentation

 arch/powerpc/kernel/vmlinux.lds.S |  1 +
 drivers/misc/lkdtm/Makefile       |  2 +-
 drivers/misc/lkdtm/rodata.c       |  2 +-
 include/asm-generic/sections.h    |  3 ++
 include/asm-generic/vmlinux.lds.h | 10 ++++++
 include/linux/compiler.h          | 54 +++++++++++++++++++++++++++++++
 include/linux/compiler_types.h    |  4 +++
 scripts/mod/modpost.c             |  2 +-
 8 files changed, 75 insertions(+), 3 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

