Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008FC433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B04C2225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwNJltKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgJSQMg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgJSQMg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D89C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e22so14718944ejr.4
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVLEJT0ZVxtgRWnOxJIIVHT3GBrlIwdemFUbYpagKrs=;
        b=MwNJltKWos2rr1hTKBnFj5KDj1jK0FbBQ8WHNqCOdnjxqhLAjoGGDwSiZNgi2GWLqK
         RUxj95bMjRZbV9IQrMOn2E5wpks1U3FOjeW5Q3ws/4bREjhHgDvFhGnKj6oc7Qr5mqmX
         +qhhGsYw2z4240k4kiv5c3fnYsG/l2UWgseHheQakkLmn7bIPNkwmBKBx1hB10fPt2HA
         EWITp+lUcLx7gRM6Iq3aBKvsiPfCNLXL9CVSrldZAfDn7neAWoJmdvXdyqmuweI44Uvj
         F+8hPEoiN9JIJUbDdY3EkfACvRpj/ntoP9s6CroIzCKPAjv36y7O3zGvLcVluX5CvaKk
         m0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVLEJT0ZVxtgRWnOxJIIVHT3GBrlIwdemFUbYpagKrs=;
        b=el/HcewLtAk1Eyu/ul5XDuiRXW1uXiLb0FDlEKjgmBXvw4RuQhDNCJglmrupsg89+Z
         h8m6zpMevk17wF+ORkr3Q/T7OPcNfKB/ttxG3xi/QDarwUhfYniay60xj/EjP4p66yi0
         WylqitxLMA5f905xOO7B/rvpd2c65X5RtlPVDEif/rd6Jo9uHnB8OZtABbXBh47EXx7i
         gkmp+S21gQwsnjNTTcVdKudYCMEy4sys3arHuk4s0fY8UpG31FfedlU0XGXLb6mY+0g/
         68QL04RigiNxGAY/QwAaUzvufQyEmgQcVrFbdD4dmjWsrGqXRlKerhIB20ndYr+Dbj1A
         SQhw==
X-Gm-Message-State: AOAM532/knaiNYb1rVwhVe8Xf5dayYM4jGlGM6ZvxXTzCpBR2KK/ubu1
        qeGbRFQAFjzb8jeXOr/BbbxaQDMsH7k=
X-Google-Smtp-Source: ABdhPJxWmXITDFCvNzWD60nR2RycYq03PUOg0oalvBl5+qvzyRorTIhLk6NrgeU4xiRxnyqwZZ0ubA==
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr567175ejh.383.1603123954851;
        Mon, 19 Oct 2020 09:12:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 00/12] fix and complete the evaluation of atomic builtins
Date:   Mon, 19 Oct 2020 18:12:14 +0200
Message-Id: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse knew about the __sync_*() builtin functions but without real
type checking and nothing about the more commonly used __atomic_*().

This series fixes this by adding the full type evaluation for both sets.

Changes since v1:
* fix comment about the first argument (patch 3)
* add a comment showng when the return type is set (patch 3).


Luc Van Oostenryck (12):
  builtin: add generic .args method
  builtin: add builtin type for volatile void *
  builtin: make eval_sync_compare_and_swap() more generic
  builtin: evaluate __sync_*_fetch*()
  builtin: fix evaluation of __sync_lock_release
  builtin: __sync_synchronize() too is variadic
  builtin: add predefines for __ATOMIC_RELAXED & friends
  builtin: add support for __atomic_add_fetch(), ...
  builtin: add support for others generic atomic builtins
  builtin: add builtin type: [volatile] pointer to bool
  builtin: add support for __atomic_clear()
  builtin: add support for remaining atomic builtins

 builtin.c                         | 114 +++++++++++++++++++++---------
 predefine.c                       |   7 ++
 symbol.c                          |   6 ++
 symbol.h                          |   2 +
 validation/builtin-atomic-clear.c |  15 ++++
 validation/builtin-sync-fetch.c   |  24 +++++++
 6 files changed, 136 insertions(+), 32 deletions(-)
 create mode 100644 validation/builtin-atomic-clear.c
 create mode 100644 validation/builtin-sync-fetch.c


base-commit: 5192dc1ff23dae8644480a89ada8ff420ebb674a
-- 
2.28.0

