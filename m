Return-Path: <SRS0=Te2Z=BR=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED69C433E0
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F0622C9F
	for <linux-sparse@archiver.kernel.org>; Fri,  7 Aug 2020 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvfHZPk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgHGUpN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHGUpN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Aug 2020 16:45:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5040C061756
        for <linux-sparse@vger.kernel.org>; Fri,  7 Aug 2020 13:45:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o18so3384415eje.7
        for <linux-sparse@vger.kernel.org>; Fri, 07 Aug 2020 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5M4PkrCuCRFM3X5e0j1NOATpvOuyXVdZ/dh8/1qOPgM=;
        b=YvfHZPk3ECdIk6k8nsgNtlai4Hs6OgnDMiPxI0ZhTs8q9BOX1nBVwRpqHj98QnGR7F
         10OjJwgRskSVwgCF21XoWKVZHiw3WAPSr+VIvQSrywPZXp1QM0RMWrs8TT5jylM+shFN
         DDvU4ALvYXFaMQydSeqJpf6Suk87tm/Il+R4CdMyJtQeq1SGlIqT7zAQWdRJRzJHh31Y
         cGlXMvfAVvIkedT7xqNKPRLmr9QTQZxDdUidsGMjSGvqyShhfwGMy+V3HsUji5aUbTKu
         13pIzmw0A1dMCkcDmvjWhvAGyF5Vw+VvxfnUQ4nrtL1zU6Rf+IR6rfvpQP5aU0NCn75x
         QPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5M4PkrCuCRFM3X5e0j1NOATpvOuyXVdZ/dh8/1qOPgM=;
        b=H7UVhEmpGQCW6m++7I4Ytp1RrY1XIrsm4RiQ+wDx8ZIFpkfpaRUR0M9KPOCT28mM+8
         FJhVBIWWHvBE4UdX7fYE3q1LhWqZjOEogv0Gb/fCCNsT5F7t+ba/vg80Q1wSvnRKxNtj
         K53IRwARXAi1zEnW67fFfvaF78m1ncjkxJDUUmlicf9kE78hu0drvorsmX9HUlIdgPnK
         ONc+pAHE2+SQNv1CDwWeLQAzmfnOWpRtg+xwiMMQbwGqP1IFoe0Pm+eYkJ450o9XxdKe
         thGFCdirI/7YEhguyGyLOzxl9AKPAheedh4u7RFYbxR2/oatYBHk1iRp/+PMxjqcfZYY
         SDYQ==
X-Gm-Message-State: AOAM532E3ZqL+vcxzO8ttQW+n3GvIZvxlK5+HvsVOyvJzakn75fL9pJW
        TtRXrPis3f2kk5emd5+XDhpssYII
X-Google-Smtp-Source: ABdhPJxDSEI354vsyssXbDeJ0xlveCH7L/HV0b9uSOYV/ATFHml4bZkPSv/EgYZs2ASAPfsqZqGjxg==
X-Received: by 2002:a17:906:4696:: with SMTP id a22mr11016266ejr.154.1596833110952;
        Fri, 07 Aug 2020 13:45:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:8076:aed9:5a81:5448])
        by smtp.gmail.com with ESMTPSA id u4sm6120883edy.18.2020.08.07.13.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:45:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] fix evaluation of __sync_{bool,val}_compare_and_swap()
Date:   Fri,  7 Aug 2020 22:45:03 +0200
Message-Id: <20200807204506.1100-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The builtins __sync_{bool,val}_compare_and_swap() were known
to sparse but the type of the arguments were not checked, and
more importantly, the return type was always 'int'.

This series adds real support for these polymorphic builtins.


Luc Van Oostenryck (3):
  add testcases for __sync_{bool,val}_compare_and_swap()
  export evaluate_arguments()
  add builtin support for __sync_{bool,val}_compare_and_swap()

 builtin.c                     | 60 +++++++++++++++++++++++++++++++++--
 evaluate.c                    |  7 ++--
 evaluate.h                    |  7 ++++
 validation/builtin-sync-cas.c | 25 +++++++++++++++
 4 files changed, 93 insertions(+), 6 deletions(-)
 create mode 100644 validation/builtin-sync-cas.c


base-commit: e1578773182e8f69c3a0cd8add8dfbe7561a8240
-- 
2.28.0

