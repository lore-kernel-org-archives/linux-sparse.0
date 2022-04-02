Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B939C433EF
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Apr 2022 05:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbiDBFFp (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiDBFFp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Apr 2022 01:05:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A747569
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 22:03:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i10-20020a17090a2aca00b001ca56c9ab16so552997pjg.1
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 22:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:from
         :to;
        bh=pt28CI/CUZfKzeImx+crnaBPBjIw5tlt5FP9BkkbOnk=;
        b=JICF8PpMoN/BMIxdG+L7wXHrPvKGOXcpllMjbcfpHjVvnxYec7qI2S7wMm19yfOTRK
         mwSSqL8jLgrd0ZnbbUzF1aLtzl/fvARQDiOG2vW1gpp9mSzBT+aS9G2WK/2h+TWRQiiL
         wjhUy5K5RleDDtMi7hv6cy3IdD4xhldr9s6YzUXWHzBvBUVFCQ+8d3eRTabti3AWtEho
         wMa10AM/ofXd6Gau4QJSfupEZeMckvHHRkrf34cF/uAXeGIps0g/gUE1ldbNgwE5Soq4
         ecbriiPDSZSordzdy+kMi82sVqfQpT2I9PQudvP6mncpZKqVlhEMbh9jnhMZerllmvNK
         tCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:from:to;
        bh=pt28CI/CUZfKzeImx+crnaBPBjIw5tlt5FP9BkkbOnk=;
        b=Eh7ldFob4EVD7tjHXDvVRwE5ou+fxRs5ditO7fV+dvT0fKwMrSZeh0ApVjaZyS4QRp
         sYmrIT9Qe4LI9vy5bAQtJieC74oCD4/S1bpYDgTn+QW/hs7mKVAceIp1h+CcdKlYCu9y
         qKdj+OD5QsId/+33T7sDlK3DLike55ucOVxH9APuqWLE/13XXWjDvWjH2NC2rsZrIwEe
         1oBhjiBpPugmWUChHU5hV0w9m9kmVeGHgJLP1ZpE+Wdc9EL86Uru599TwKLKMsXgH+DY
         Ic7ktxYW1TUWyaOs4e+oHkjBLIMFX/5dRxWUwU+NnCNJtflpQ98nlxs1LIGB9Fyi7f01
         1fFg==
X-Gm-Message-State: AOAM532ZR45fOjqToNEJnpf6SyxDfZ2J2pJPU434JzFWWY9BZZ9ALMPe
        0O1tms0KOIhU8G3VZZ7RJdLreku76JBMSTEn
X-Google-Smtp-Source: ABdhPJy6chuMKCroWUFJTfh/44N0UlxWQx6dSuKXQdQqFZiKF2xU2isLg5ba7gIU4RetDNT4MD0IkA==
X-Received: by 2002:a17:90b:17ca:b0:1c7:3010:5901 with SMTP id me10-20020a17090b17ca00b001c730105901mr15723154pjb.22.1648875832467;
        Fri, 01 Apr 2022 22:03:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b004fae15ab86dsm4621244pfc.52.2022.04.01.22.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:03:52 -0700 (PDT)
Subject: [PATCH v1 0/6] RISC-V -march handling improvements
Date:   Fri,  1 Apr 2022 22:00:35 -0700
Message-Id: <20220402050041.21302-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

As pointed out recently [1], sparse is parsing -march on RISC-V in order
to obtain the default set of preprocessor macros to use.  Back when this
was written ISA string was a simple affair, but these days it's a lot
more complicated.  It's going to be a big chunk of work to get a proper
ISA string parser into sparse, but we can at least fix the breakages for
the subset of legal ISA strings that Linux currently uses (and are
breaking users).

This patch set does three things:

* Stops die()ing on unknown ISA strings, unless the user has passed
  -Wsparse-error.  This prints a warning and guesses at the macros to
  use, which is probably fine for Linux.
* Cleans up some of the differences between GCC's -march parsing and
  sparse's.  None of this should really matter for Linux, as GCC will
  blow up on bad ISA strings, but it just seemed worth doing when I was
  in there.
* Adds support for the Zicsr and Zifencei extensions, which were
  recently enabled.  With these the unknown ISA string warning goes away
  for Linux builds.

They're all sort of independent (and happen in this order), but they're
all touching the same code so I'm just sending it as a series.  It's my
first time touching sparse.

I've poked around with the first patch on its own and it seems to
largely work as expected: I'm still getting a bunch of sparse-related
warnings when I turn on sparse in my builds, but at least I don't get an
error (after updating to a binutils that supports the new arguments, so
Linux detects them).  I tried CF="-Wsparse-error", which also behaves as
expected (that trinary boolean tripped me up for a bit).

The first patch alone should be a sufficient band-aid for systems that
are actively broken right now, the rest are cleanups -- these may be
necessary to get the RISC-V port sparse-clean, but that's a WIP so there
might be more.  I'm going to play around with that, but just looking at
the volume of spew it's probably going to take a while.  I gave these
patches a bit of testing one-by-one, but not nearly as much as the
first.

I just spun up a sparse repo [2] at kernel.org, these are on the riscv
branch if that helps for anyone.  I've also started messing around with
parsing a few more of the multi-letter extensions, but there's so much
coupling I got fed up -- it's on riscv-wip, but I definitely don't like
that last patch.  I figured it's better to send out these bits, as they
look solid to me and builds are broken.  The new stuff (B, K, and V) are
all in GCC-12 anyway, so we have a bit of time before they're useful.

[1]: https://lore.kernel.org/linux-sparse/mhng-c280d48c-477d-4589-baee-255c774b5a51@palmer-mbp2014/T/#maef705f448e4a1f12d853c0d8bc756f037ce1ce0
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/palmer/sparse.git


