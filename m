Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95754C4363D
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D02076A
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF32X8J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbgI3XSp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgI3XSe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAD7C061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so1005149wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rgb0VvdMzNXWP8VVX8UMEg34f/cAHn7eK0tS+JGVuBM=;
        b=SF32X8J1hJxgQAN////CDK3CFWy6UVyqnjJ6gsN1YMoAooZ2hU+C3H4GE4N+gcKR1l
         UT4e/Q67qfep4ux04dsie9LYm8jXUeXmaDQrG4DkHPbSBDw6anR9fvMmAryONzRZcJpl
         gShxASqbVOF5IN6lxUvPWp8k/14dBKEzL27JMLHZPY7BCN2ykZaWhvhn4MOlgh7MUrR1
         roFourisqHJOqtef4nvQekFTB6DaTaZ2zhfmGHphUFQmfzkad5iMw3oFyXRwFyFTaRw+
         GWB606M48T6Weehk4Vx/OkeTuLb8HA7OnnQXTqWJokuR6Y45bjALd68aEz0ydC2Fo00u
         5FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rgb0VvdMzNXWP8VVX8UMEg34f/cAHn7eK0tS+JGVuBM=;
        b=Uj3pCGloIkUoRZ+bIRzXGklajQcMh2NNItFzGBRFnTbAQORNcvdDhSgTpspcj/JN0i
         76EGG+98lp6gwX7aDOXOLRTs6PiH/t5llEY6KelOuvSjMU3JB2yiSmEpCtlCsAPIZPb/
         IXpzpkQyPn16cPjk1w8CHAXPvimTgDxoB/WvsgKnmLG63WCEf+jda6qQtzBJzGmZibcE
         NWyWA/zC0LcnXPNWJDRpAOAScTDJ9vsESjV6EG/0ULBGcpdHPpS/Qo/EjrdwN3YhRiN7
         r2DPr1EdkIoYhKg7cksL/SEv2bmoDYA4omPf6HDM2w3cw4910fbJD9myAgW5r4Jp9GyC
         HcwA==
X-Gm-Message-State: AOAM530gCG09twE+i4P1DOvJKE5/cUxooX+MvFQZa0Xu7pONE8YfjFlL
        r0t+kaP4PTAiWAfomBPf064JZzF21z8=
X-Google-Smtp-Source: ABdhPJzhCpxBFXgv8rIwjaEihRevsgJ9ovghXYSf8EayoNtQJY1XS+znovKJvsMOtUdXXLHfRcxEng==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr5315715wmc.35.1601507912824;
        Wed, 30 Sep 2020 16:18:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:32 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/13] add warnings for flexible arrays
Date:   Thu,  1 Oct 2020 01:18:15 +0200
Message-Id: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Flexible array members have some restrictions (must be last
in a structure, not in a union) and a number of dangerous or
non-sensical usage (in an array, in nested structure or even
using sizeof() on the containing structure). Sparse currently
supports flexible array members but barely and doesn't help
finding bugs related to them. This series aims at improving this:
* fix structure alignment in the presence of a flexible array member
* issue an error if the flexible array is not last or in a union
* add an option to issue a warning:
  * on arrays of such 'flexible structures'
  * when using sizeof() on the containing structure
  * when declaring nested aggregate types with a flexible array member
  * if the flexible array adds some padding to the structure

When used on the kernel (v5.9-rc1) this results in no errors but
the following number of warnings:
      90 array of flexible structures
    5719 using sizeof on a flexible structure
    1909 flexible array member has padding
     888 nested flexible arrays

So, to begin with, the corresponding warning flags default to
	-Wflexible-array-array
	-Wno-flexible-array-nested
	-Wno-flexible-array-padding
	-Wno-flexible-array-sizeof

Notes:  implicit sizeof() on such 'flexible structures' like here
	under are not yet checked:
		struct s {
			...
			int flex[];
		} *dst, *src;
		...
		*dst = *src


Luc Van Oostenryck (13):
  flex-array: add testcases
  flex-array: factor out common part of lay_out_{struct,union}()
  flex-array: do not lay out invalid struct members
  flex-array: flexible array members have zero size and alignment is OK
  flex-array: detect structures with a flexible array member
  flex-array: warn on flexible arrays in unions
  flex-array: warn if flexible array is not last
  flex-array: identify structures with a flexible array member
  flex-array: add helper has_flexible_array()
  flex-array: warn when using sizeof() on a flexible array
  flex-array: warn an arrays containing a flexible array
  flex-array: warn on flexible array in nested aggregate types
  flex-array: warn when a flexible array member has some padding

 evaluate.c                      |  3 ++
 options.c                       |  8 ++++++
 options.h                       |  4 +++
 sparse.1                        | 27 ++++++++++++++++++
 symbol.c                        | 50 +++++++++++++++++++++------------
 symbol.h                        |  8 ++++++
 validation/flex-array-align.c   | 18 ++++++++++++
 validation/flex-array-array.c   | 15 ++++++++++
 validation/flex-array-error.c   | 26 +++++++++++++++++
 validation/flex-array-nested.c  | 29 +++++++++++++++++++
 validation/flex-array-padding.c | 21 ++++++++++++++
 validation/flex-array-sizeof.c  | 18 ++++++++++++
 12 files changed, 209 insertions(+), 18 deletions(-)
 create mode 100644 validation/flex-array-align.c
 create mode 100644 validation/flex-array-array.c
 create mode 100644 validation/flex-array-error.c
 create mode 100644 validation/flex-array-nested.c
 create mode 100644 validation/flex-array-padding.c
 create mode 100644 validation/flex-array-sizeof.c

-- 
2.28.0

