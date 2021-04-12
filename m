Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3825C433ED
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23D461278
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhDLVVk (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbhDLVVk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07FC061574
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g5so15904250ejx.0
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jbq/cm8iIZ017+WXbyzBxEfFiHNAPj3tM0FXZwwD9ZE=;
        b=VsDtQqr9raroptkpwR8OHssPGT2fGEYc08KqVHBbPURYM3adUw9FjicYNPbjUJpPnY
         CRQjJmUW7HHxc23eRrDBy/rO9VOMZGuy8HZEPwiANMNbCEMYA8ePwg0DFjoxlIYj42dm
         UGHZy3cKmvjOlR2RwwxRHdWOhd/i7Wmnz7uRYvDT7hIllJq8l4zItfDsWFgp38PjEZ3E
         +dShlKgTM0Em9VDGJ7grCFeE89xXN11FZg9VCHi0SQONREFBnK4wKpSvSTorEnqPaQ7g
         gdQFFLCMElPZLfhKIs5Y0P3Gj8oiiQelSkAVdJjn6ara02G6KTNCQiDNXxFAkVZ75skT
         ZqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jbq/cm8iIZ017+WXbyzBxEfFiHNAPj3tM0FXZwwD9ZE=;
        b=kwjYI72k/R+XE/N4bLPJ752KLkviuuk+Lf32Nspq6P2GfwAqv/28vTamq1rWQhyROq
         jMQ0C0stpa+o8HujIq2kbt0qe66kE+joP9j8kxkxcRUNHTgIsLzpuwxaS4oRHn/5YH0F
         HCae3oS2j6E0EIxbQxxYHHlfUTHho8uVvRmWhZVzGKUTJG6AnIlS1/qDPgITFyIIKMzN
         M6N2JJX45Sj9FmVayQggcyrugICxpUpsAYyQuzxN03TFK/hCIvE9LRjiD6cr/e72OvgP
         NccgouSJovAX6SZ928gE9N9vmK13VTYoy+T2Ge02BhautGB9XdhNDhhhJX8/e87nmz9h
         68hg==
X-Gm-Message-State: AOAM530ytkZZcAYTkXYmDWZoiz2c8OOYhuIFKjS21rB2PnFiswya/z1v
        ZKj+cFZKtTVaDyRROEU8UZM7Iwm4OwU=
X-Google-Smtp-Source: ABdhPJyFsxMD4x5UAQMUxMEycSXqpVdiabMRrpoCy/ZdS8ghILSQgT+ALd/gFw/XnqYAqxCpsRgXWA==
X-Received: by 2002:a17:907:3da3:: with SMTP id he35mr28351380ejc.148.1618262480274;
        Mon, 12 Apr 2021 14:21:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:19 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/8] scheck: add a symbolic checker
Date:   Mon, 12 Apr 2021 23:21:03 +0200
Message-Id: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Some instruction simplifications can be quite tricky and thus
easy to get wrong. Often, they are also hard to test (for example,
you can test them with a few input values but of course not all
combinations, it's not clear what are the conditions for which
they're valid, ...).

This series add a tool, scheck, which feeds Sparse's IR into a
bitvector SMT solver (Boolector). This, together with assertions
added at C level, allows to symbolically check the validity of these
assertions. In other words, it allows to check if these assertions
are valid for all possible values (but these expressions are limited
to pure integer expressions, so no floats, no branches, no memory
accesses, no functions calls).

Now, you may ask yourself "Nice, but how can I be sure that this
checker is working correctly?". And the answer to this question
is obviously "You should write another checker, of course. And
then another one, all the way down!".

Notes: This needs to have the SMT solver's librarie installed
       and having 'BOOLECTORDIR' and 'HAVE_BOOLECTOR' configured.

Changes since v1:
* Rewrite evaluate_generic_int_op() which was very broken
  (thanks to Ramsay Jones for noticing it).
* When translating compare instructions, the input bitvectors
  must use the instructions' input type, not the target type).


Luc Van Oostenryck (8):
  export declare_builtins()
  builtin: define a symbol_op for a generic op acting on integer
  .gitignore is a bit too greedy
  scheck: add a symbolic checker
  scheck: assert_eq()
  scheck: allow multiple assertions
  scheck: assert_const()
  scheck: support pre-conditions via __assume()

 .gitignore             |  35 ++--
 Makefile               |   7 +
 builtin.c              |  63 ++++++-
 builtin.h              |   4 +
 ident-list.h           |   6 +
 scheck.c               | 361 +++++++++++++++++++++++++++++++++++++++++
 validation/scheck/ko.c |  10 ++
 validation/scheck/ok.c |  22 +++
 validation/test-suite  |   6 +
 9 files changed, 496 insertions(+), 18 deletions(-)
 create mode 100644 scheck.c
 create mode 100644 validation/scheck/ko.c
 create mode 100644 validation/scheck/ok.c

-- 
2.31.1

