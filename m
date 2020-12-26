Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE15DC433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B39520809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgLZRwj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgLZRwi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:52:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FDC061757
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:51:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g185so5679959wmf.3
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dP575lKdFRJ3w8ITY2O6C0U8NEVV7J17lfY3yr2c7bw=;
        b=DfnCJq61lR9HNklMaDcihD7QPrbJ5u60xxjnpptNgSgGC/KmbyshraHVMJ2HNeDf+j
         2CKAppLtt9gcq6O0h2ojGFgG6Noj/DbasdLCwhra7m7ZBoK2iFVyl+6HpVUK4oRdO5tF
         NYg62dtUaNCQ1PP0C3gN0wF4K47jI+KrHcFU+QAEqZcQ0WI+quE1GAL2DZI0lxLEAdKS
         BM94NKirsQkSJjEUbrk0oB+7mw2dTQ3lZvQd23VFcwc41DftmsKrqFVE8vIlvlWgHlM/
         bCWvC2UqryKRv6XWTMIIuOyB5yodw/mSSuQDJWj7n90cdBGQ1+yozY267f9HYGXBKbMp
         M0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dP575lKdFRJ3w8ITY2O6C0U8NEVV7J17lfY3yr2c7bw=;
        b=FaqAaBLxzOBC4erLOJNqm8p9tBjLhm/2mUrzE665UDNx3VPIbNwIm1CiK55teyvL2i
         C6rT0+dIxPOHqwPzRO/cSSvb33JbGhYR2FmyZYHlHj+UrNEb0/hhdKbhNSQYPxrOY2Fk
         s9K6RIqhJBPZra2Q/soXKsyKIJZYTQ7ERWuEGJJidPJ3TcYXfajI355rNuIwuw6Nflq/
         e2DCEKvrvRNHUrKZxg10t2UyU3mMNNZJOXQ14wkRe2x1uHboz/OoemSc7NnsYVKx9BQJ
         89UYLAi9d1HWBqUcAK0qXB5tVzPUy5+bb4940pTxR6+sYxo3/0ZTkzAzKvf/sqgeTl23
         gYyQ==
X-Gm-Message-State: AOAM533vyaIJTKskXcIFabAwu5PUSvNiQ9fArm5z48g4CQ/TFS1DdhvM
        6dvilyhsTGR2yFcZ5nrsWUsG5r0Wj8A=
X-Google-Smtp-Source: ABdhPJxhoQs8pOt93wrUJSjhOCHUFNiqLrDBxLfeRlCOpGyE3sOl8X7o+IVjeiGVGG6VAtPM6c6gaA==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr13507236wmd.49.1609005116826;
        Sat, 26 Dec 2020 09:51:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:51:56 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 00/16] support __packed struct
Date:   Sat, 26 Dec 2020 18:51:13 +0100
Message-Id: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

During parsing, Sparse recognizes the attribute 'packed' but this
attribute is otherwise ignored for several reasons:
1) the attribute in 'struct __attr { ... }' is wrongly handled as
   belonging to the whole declaration but it should belong to the type,
2) the attribute in 'struct <name> { ... } __attr;' is simply ignored,
3) the layout of packed bitfields need special care.

This series contains 2 parts:
1) handling of type attributes
2) correct layout of packed structs, including packed bitfields.


This series is also available for review and testing at:
  git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git packed-v2


Changes since v1:
* fix layout of packed bitfields

Luc Van Oostenryck (16):
  add testcases for dubious enum values
  add testcases for exotic enum values
  add testcases for enum attributes
  add testcases for type attributes
  add testcases for packed structures
  add testcases for packed bitfields
  apply_ctype: use self-explanatory argument name
  apply_ctype: reverse the order of arguments
  apply_ctype: move up its declaration
  struct-attr: prepare to handle attributes at the end of struct definitions (1)
  struct-attr: prepare to handle attributes at the end of struct definitions (2)
  struct-attr: prepare to handle attributes at the end of struct definitions (3)
  struct-attr: fix type attribute like 'struct __attr { ... }'
  struct-attr: fix: do not ignore struct/union/enum type attributes
  packed: no out-of-bound access of packed bitfields
  packed: add support for __packed struct

 linearize.c                       | 13 +++++-
 parse.c                           | 71 ++++++++++++++++---------------
 symbol.c                          | 12 ++++--
 symbol.h                          |  2 +
 validation/enum-type-dubious.c    | 18 ++++++++
 validation/enum-type-exotic.c     | 28 ++++++++++++
 validation/packed-bitfield0.c     | 66 ++++++++++++++++++++++++++++
 validation/packed-bitfield1.c     | 27 ++++++++++++
 validation/packed-bitfield2.c     | 15 +++++++
 validation/packed-bitfield3.c     | 28 ++++++++++++
 validation/packed-bitfield4.c     | 18 ++++++++
 validation/packed-bitfield5.c     | 20 +++++++++
 validation/packed-deref0.c        | 23 ++++++++++
 validation/packed-struct.c        | 32 ++++++++++++++
 validation/parsing/enum-attr.c    | 29 +++++++++++++
 validation/type-attribute-align.c | 19 +++++++++
 validation/type-attribute-as.c    | 33 ++++++++++++++
 validation/type-attribute-mod.c   | 21 +++++++++
 validation/type-attribute-qual.c  | 12 ++++++
 19 files changed, 448 insertions(+), 39 deletions(-)
 create mode 100644 validation/enum-type-dubious.c
 create mode 100644 validation/enum-type-exotic.c
 create mode 100644 validation/packed-bitfield0.c
 create mode 100644 validation/packed-bitfield1.c
 create mode 100644 validation/packed-bitfield2.c
 create mode 100644 validation/packed-bitfield3.c
 create mode 100644 validation/packed-bitfield4.c
 create mode 100644 validation/packed-bitfield5.c
 create mode 100644 validation/packed-deref0.c
 create mode 100644 validation/packed-struct.c
 create mode 100644 validation/parsing/enum-attr.c
 create mode 100644 validation/type-attribute-align.c
 create mode 100644 validation/type-attribute-as.c
 create mode 100644 validation/type-attribute-mod.c
 create mode 100644 validation/type-attribute-qual.c


base-commit: 1b896707d95982c7c9cdd5cd0ab4afd80f766a94
Cc: Jacob Keller <jacob.e.keller@intel.com>
-- 
2.29.2

