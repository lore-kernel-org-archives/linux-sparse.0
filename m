Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B07C433EF
	for <linux-sparse@archiver.kernel.org>; Mon,  6 Sep 2021 04:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE4C60F70
	for <linux-sparse@archiver.kernel.org>; Mon,  6 Sep 2021 04:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhIFEWU (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbhIFEWT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Sep 2021 00:22:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BBDC061575
        for <linux-sparse@vger.kernel.org>; Sun,  5 Sep 2021 21:21:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g8so6417078edt.7
        for <linux-sparse@vger.kernel.org>; Sun, 05 Sep 2021 21:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=I1ogvLXeomwuDo+cXQ+IEIFNFTsm7ngYi4aLip2WYRI=;
        b=pa8C/tg+HRQfs95IeGWniB2EQQPrFpDzyhEOSv17uuoO8Cqk9qHu7uBNQrYM0Mzian
         2K8rjc1Wl3RdHa2CoawmADX+tNG+bOpjBS8xAujgx/3r08wAOn2/V9ieyvxE7DvPAKFC
         0tNzw27+oNc9/RKrtK9r+u4je7YJIoP/Ll+xjzpOxmcEhowrCeru++D3Gibo6sodvPrJ
         DmnIX23kzvioHJ03bS7nWjIiFmd8wpDAFkVjlXNeL49p79+FlDeOrMr9KTYXn/7RDW+m
         FvpaX6pK4iGPep8Zcrbg7jwslzAMLf3atre0AvY1GsotAF/t4m61B/gAUc29/kNu4QUX
         Mbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I1ogvLXeomwuDo+cXQ+IEIFNFTsm7ngYi4aLip2WYRI=;
        b=uV384SOUcLXDnIDlQcXmPNmqDZAdXgipGXZMQpvSIlj6yNGJyJeTvPHbOiq1VSjGxl
         eBaqjUWuZM4irhXmZb7NpMp6CAzZruXSnqTdEMnjjFNPz0o4WZOk6/weR29zhyRc9nDk
         xauUbSSV+r9+QqYDfN0miFsfz+wHD7wmA8Qoxv6Ztq6SCnr688+e7S5u3aYdSgdXW3vg
         Vn5LuxFeDnQ5Ajf0Cmxs0a3hBc1g4Zvk31W4x/vY+r7BxocgYDnMljuI912w7JWnARVL
         57HE/FETrQhSQQrrX393jpxVT/3GEFIyyBaBWmNWAlqQnoiDtgDIMDZQbnLKlnAupN3+
         CxJQ==
X-Gm-Message-State: AOAM53037/RNPASeN515Qnl9zJmPVESKSlE3yS81bbrTwPZQyrCrLxfl
        /jB1Or5Z93SU+2/ge8oaGh+Dtu/He8s=
X-Google-Smtp-Source: ABdhPJzHNH3nDOuD0zmg/JojMCP7gugL43kyMXw6jEsAdQ5BCM+Kc6Qc0JpzHSEByePpTujGl4KBXA==
X-Received: by 2002:a05:6402:4404:: with SMTP id y4mr11473005eda.52.1630902074167;
        Sun, 05 Sep 2021 21:21:14 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:dcb2:e1e7:c99b:fc91])
        by smtp.gmail.com with ESMTPSA id y20sm3082875eje.113.2021.09.05.21.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:21:13 -0700 (PDT)
Date:   Mon, 6 Sep 2021 06:21:11 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [ANNOUNCE] Sparse v0.6.4
Message-ID: <20210906042111.lhoq7egtpmw3jcv6@mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse v0.6.4 is now out.

The source code can be found at its usual repository:
   git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.4

The tarballs can be found at:
   https://www.kernel.org/pub/software/devel/sparse/dist/

Many thanks to people who have somehow contributed to the 299
patches of this release:
   Ramsay Jones, Linus Torvalds, Kyle Russell


Release notes for v0.6.4
------------------------

Changes since v0.6.4-rc1:
  * none

Fixes:
  * build: fix version.h dependencies
  * fix and complete the evaluation of atomic builtins
  * fix some testcases related to bitfield manipulation
  * llvm: fix crash with llvm-11 / use real phi-nodes
  * fix: OP_INLINE should not use the function symbol
  * fix testing if a OP_CALL's function is pure
  * warn on all missing parameter types
  * fix init_linearized_builtins()
  * fix usage count in linearize_fma()
  * linearize: fix a couple of 'selfcheck' warnings
  * cfg: remove phi-sources when merging BBs
  * cfg: remove phi-nodes when merging BBs
  * cfg: add missing REPEAT_CFG_CLEANUP
  * fix: rebuild dominance tree during CFG cleanup
  * fix: drop qualifiers of casts and comma or statement expressions
  * fix kill_insn(OP_SETVAL)
  * fix trivial_phi() when the target is before the single value
  * memops: fix wrong killing of stores partially dominated by a load
  * memops: kill dead loads before phi-node conversion
  * memops: kill more dead stores
  * fix rem_usage() when the pseudo has a use list but is not PSEUDO_REG
  * shut up a silly -Wmaybe-uninitialized warning
  * fix add_join_conditional() when one of the alternative is VOID
  * asm: fix killing OP_ASM
  * asm: fix a test failure on 32-bit systems
  * asm: output *memory* operands need their address as *input*
  * asm: teach dominates() about OP_ASM
  * fix the type in the assignment of 0 to a restricted variable
  * fix SSA conversion of mismatched memops
  * fix and improve the check that protects try_to_simplify_bb()
  * fix remove_merging_phisrc() with duplicated CFG edges.
  * fix null-pointer crash with with ident same as one of the attributes

New:
  * improve CFG simplification
  * teach sparse about -funsigned-bitfields
  * add a symbolic checker
  * expand __builtin_object_size()
  * let plain bitfields default to signed
  * add support for __packed struct
  * handle qualified anonymous structures
  * move check_access() to late_warnings()
  * let phi-sources to directly access to their phi-node
  * small improvements to the ptrlist API
  * warn when taking the address of a built-in function
  * handle more graciously labels with no statement
  * give an explicit type to compare's operands
  * give a type to OP_SYMADDR
  * add some notes about pseudos being typeless
  * shrink struct basic_block
  * pre-proc: strip leading "./" from include paths
  * pre-proc: do some path normalization
  * linearize __builtin_isdigit()

IR Simplifications:
  * simplify: essential OP_ADD & OP_SUB simplifications
  * simplify and canonicalize unsigned compares
  * simplify: basic unop simplifications
  * simplify SEL(SEL(...), ...)
  * simplify SEL(x == y, x, y) and friends
  * simplify SEL(x, x, x) and SEL(x, 0, x)
  * simplify & canonicalize compares
  * simplify CBR-CBR on the same condition
  * simplify unrestricted postop
  * simplification of computed gotos with 1 or 2 targets
  * simplify kill_insn() of unops and unop-ish instructions
  * simplify: put PSEUDO_ARGS and PSEUDO_REGs in canonical order too
  * simplify (~x {&,|,^} x) --> {0,~0,~0}
  * simplify ((x cmp y) {&,|,^} (x !cmp y)) --> {0,1,1}
  * simplify LSR + SEXT into ASR
  * simplify and canonicalize signed compares
  * simplify CMP(AND(x,M), C) and CMP(OR(x,M), C)
  * simplify AND(x >= 0, x < C) --> (unsigned)x < C
  * simplify TRUNC(x) {==,!=} C --> AND(x,M) {==,!=} C
  * simplify of TRUNC(NOT(x)) --> NOT(TRUNC(x))
  * factorize (x OP1 z) OP2 (y OP1 z) into (x OP2 y) OP1 z
  * factorize SHIFT(x, s) OP SHIFT(y, s) into SHIFT((x OP y), s)
  * factorize SEL(x, OP(y,z), y) into OP(SEL(x, z, 0), y)
  * convert SEL(x & BIT1, BIT2, 0) into SHIFT(x & BIT1, S)
  * canonicalize ((x & M) == M) --> ((x & M) != 0) when M is a power-of-2

Testsuite:
  * testsuite: add new tags: check-output-{match,returns}
  * testsuite: fix parsing of tags used in the testcases
  * testsuite: add option '-r' to 'test-suite format'

Documentation:
  * doc: fix: Sphinx's option ':noindex:' renamed into ':noindexentry:'
  * doc: fix extracted autodoc when short description ends with a '?'
  * doc: add some doc about using NULL or VOID in pointer lists
  * doc: add some doc to flowgraph.h
  * doc: extract doc related to simplification

Cleanups:
  * slice: small reorg of OP_SLICE in preparation for some incoming changes
  * cleanup: removed an unused parameter for show_symbol_list()
  * cleanup linearize_cond_branch()
  * cleanup: remove unneeded REPEAT_SYMBOL_CLEANUP
  * cleanup: no needs to use MARK_CURRENT_DELETED() for multi-jumps
  * linearize: remove unneeded forward declarations
  * linearize: only allocate call instructions when needed

-- Luc Van Oostenryck
