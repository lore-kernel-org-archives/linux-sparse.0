Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A43C433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403C9207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgLaKLW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgLaKLV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:11:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287F5C061573
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c133so6986239wme.4
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZ02k1G5Y1m0k9XJEDD59Qq2OxH74L3IgcMHpZW9g5o=;
        b=H+nILcjC+h6RwhntAzw+IOLwsDW2ULtxKVT8yrdXLWs8vBUeLuC2szyCRqpV5EnonH
         cGB92+nQ/CrO0F9daO0qxj/rHqYtzE8I+pRhjeqpVcA3zeplXtkPKtxL8UJGqPP6LEoE
         vawHnBnxX44W08jHfGjie6PcTXghMX4uTZjlZ+uc4FKEWCjDNoOs/Ns0sKUKJeoaOHAC
         y0JyGvroKlp2m8muj4dnMz2ymhG2vu6q1CF1vwivZsfplRE0Msybj/6Ona759GgyMJhR
         vXW2wXrGA6QUcZF3EbcKHv9Mj01xujtuTxCopBBn37rWbvALSnTuyW+YF7bbsm9De2po
         cWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZ02k1G5Y1m0k9XJEDD59Qq2OxH74L3IgcMHpZW9g5o=;
        b=YQvlozka/+XTMfglczi9r0vLg/jZ15flR0cxYQu3w7Xy4jn6lqCR4QoqdLW+xuYsuV
         vewWkE5LX1hasdOf6YvdMBwEaxVkFaWvcd/N7OkdlRtq3fn+dB+U7VQv31hcSsa6Bp5I
         p+SK+BK/xJmdKuaaPNqpAgBcVFiMXzK7c0sgCTKW58ED1y3Jz2ORGqnTlfLOeX3MtHKu
         mjr3pG/9n94K8lVWNqmXwBVFAqcKedGBAd/Ru67AymyL/Pv4qfn7H+Ng0mbZQzTOcDaw
         C5lteMhDddm5oA8AkV6KdL46X2ll0Hnbz5bBYwOdcDwg5XYwvgcSjaPqDgK0xTG35NBe
         Ca5Q==
X-Gm-Message-State: AOAM531xVJRHT0SPWRP5w7n36UKqhd66hm32gbSduIJ6StUtDIlyxS6Z
        Nhk0c93c8YOROtSREoH0GrB2ibL9isc=
X-Google-Smtp-Source: ABdhPJx+NgJKg4Kdsz5DVoEPdH8/ZqMLyX2Us7x5hfFhVay5EE6RjW7JY+NnN5Fi4rZuHlqp4yRQpA==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr11505302wmm.42.1609409439966;
        Thu, 31 Dec 2020 02:10:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 00/16] support __packed struct
Date:   Thu, 31 Dec 2020 11:10:18 +0100
Message-Id: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
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
  git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git packed-v3


Changes since v2 (all thanks to Ramsay Jones):
* correct several typos
* add an explanation for one of the test
* avoid sizeof() in tests where the size is constrained to some fixed value
* remove a redundency in a test (struct sb identical to struct sa)
* reformulate the commit message for apply_ctype()'s arguments reversal
* tweak the not-so-1-to-1 code movement
* fix the truncated commit message of the last patch

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
  struct-attr: prepare to handle attributes at the end of struct
    definitions (1)
  struct-attr: prepare to handle attributes at the end of struct
    definitions (2)
  struct-attr: prepare to handle attributes at the end of struct
    definitions (3)
  struct-attr: fix type attribute like 'struct __attr { ... }'
  struct-attr: fix: do not ignore struct/union/enum type attributes
  packed: no out-of-bound access of packed bitfields
  packed: add support for __packed struct

 Documentation/TODO.md             |  3 --
 linearize.c                       | 13 +++++-
 parse.c                           | 78 ++++++++++++++++---------------
 symbol.c                          | 12 +++--
 symbol.h                          |  2 +
 validation/enum-type-dubious.c    | 18 +++++++
 validation/enum-type-exotic.c     | 28 +++++++++++
 validation/packed-bitfield0.c     | 58 +++++++++++++++++++++++
 validation/packed-bitfield1.c     | 27 +++++++++++
 validation/packed-bitfield2.c     | 15 ++++++
 validation/packed-bitfield3.c     | 28 +++++++++++
 validation/packed-bitfield4.c     | 18 +++++++
 validation/packed-bitfield5.c     | 20 ++++++++
 validation/packed-deref0.c        | 23 +++++++++
 validation/packed-struct.c        | 32 +++++++++++++
 validation/parsing/enum-attr.c    | 29 ++++++++++++
 validation/type-attribute-align.c | 19 ++++++++
 validation/type-attribute-as.c    | 33 +++++++++++++
 validation/type-attribute-mod.c   | 21 +++++++++
 validation/type-attribute-qual.c  | 15 ++++++
 20 files changed, 447 insertions(+), 45 deletions(-)
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

-- 
2.29.2

