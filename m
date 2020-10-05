Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E8C4363D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF8E2073A
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUcl//qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgJECAK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECAJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFEC0613CE
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so7702999wrw.11
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=magGOrBbBi78VY0f+JfqP+GY11q9fpeccdmQ4h+ueT0=;
        b=aUcl//qj1DGJA2iYjPbC/J8p63BcC/TllhGp4RVdqyVsMGt9kTQ70S5hFQ7bNlp3/z
         N/tuoRB7A1X1IGKB1K9SOMSZ6d8NsKyH9836bFIIzq3uTvLTfYzM8fevTmyzOfF4JpRZ
         jUPd8OAxf8qSHyehEhgIwlgAUIUzj6iIVPwz56M443/+sMGkDZgYQ80nLfCyOFmqxLfq
         eH6mPLTGRQeZD4hGhhLxvQq23JB5mgFU1FHU1Na7WJsNG9vkiNsApyrZGwqF0EaVwcu0
         OmVD091O7eus4g4LBmj8Ombf/s7Tc7259Q7R5yPiO2hAO9vu/L/AorTw8SftzyFq+Iky
         69Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=magGOrBbBi78VY0f+JfqP+GY11q9fpeccdmQ4h+ueT0=;
        b=Y2+0dZCq6uylS712kJm5FoZcy5SOqpONKDA3Q84XuS1tp0W2ZPmeCxDn67tRv0UBX/
         FFtfFXlMezry6Lv2ExRCYA+kdROsC685KjxWI7S/PDlhigKcrKfkLqfWHpXEu9+/cc0I
         ffzCGJzPTpg5P72PDmMTb526PSsp/sU6uT6f7RPa4HWRF8q1WUYKrbihPyxcwM/aFpUd
         0pyqNxpOWeVWVNzXnuDkOz2dcjZdiOQF6F01ufzrJHi2ttvZSNgW3/lyq6min8u7FNCS
         csSsyler8YcHrAWR5V35ZPfS7PhpMPGXjyO6kCfxgpUUy/nKsWZZ84EBkOeBqxcNEeGX
         CGHg==
X-Gm-Message-State: AOAM533cmYsK/i1i0LZfqLtqceONm7ngT/8M5q6bwO99PKiyDZj2PY6R
        d2j+tG7txiTe2R7QYRsVzKz18MhaozI=
X-Google-Smtp-Source: ABdhPJxpQMvXn8Gxf4DTVXrG0e9/fbQeGgUl510NCtIbAMajtigu9hGpHvlguvkkhCMzsJC2hTMBGA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr14761030wrs.19.1601863207918;
        Sun, 04 Oct 2020 19:00:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:07 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] format check tweaks
Date:   Mon,  5 Oct 2020 03:59:54 +0200
Message-Id: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Ben, these are small changes I think should be applied with
your series, on top of the patches I send yesterday.
I've pushed everything at:
	git://github.com/lucvoo/sparse-dev.git format-check
If you're fine with these, I can squeeze them with the series.

There are also a few tests I don't agree with:
	const void *ptr = ...
	printf("%s", ptr);
These tests silently accept this, but they should warn.
But this can be fixed at a later step.


Luc Van Oostenryck (8):
  need to strip SYM_NODE before comparing types
  add helper get_nth_expression()
  move the definition of FMT_{PRINTF,SCANF}
  parse format attribute less verbosely
  call verify_format_attribute() unconditionally
  s/data/type/ for struct format_type
  add support for "%ls"
  add support for "%Lx" (and "%Ls")

 evaluate.c                           |  4 +--
 lib.h                                |  5 +++
 parse.c                              | 30 +++++++----------
 symbol.h                             |  7 ++++
 validation/varargs-format-dyn-prec.c | 11 ++++++
 verify-format.c                      | 50 ++++++++++++++++------------
 6 files changed, 65 insertions(+), 42 deletions(-)
 create mode 100644 validation/varargs-format-dyn-prec.c

-- 
2.28.0

