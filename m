Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898FAC432BE
	for <linux-sparse@archiver.kernel.org>; Wed,  1 Sep 2021 05:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C37461058
	for <linux-sparse@archiver.kernel.org>; Wed,  1 Sep 2021 05:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbhIAFCz (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhIAFCz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 1 Sep 2021 01:02:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E3C061575
        for <linux-sparse@vger.kernel.org>; Tue, 31 Aug 2021 22:01:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g22so1865944edy.12
        for <linux-sparse@vger.kernel.org>; Tue, 31 Aug 2021 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=22Z7Vttl/DsWSxg2K3fwNLKgVGLe63cGsEZccICH2HQ=;
        b=UARPnAkNhVmm7GvXQHbHmrmMK26DDspjcS5sWxJ/+bXYtCdCM5yyZZUopXtzqvjgTL
         AuzrAVEGjFwBSwV8SHpPYYqsyjgJu3Y0/FS4cMC+VRFjcTyWPf+K/946EgOV+j/F1SDk
         2KpBdn6qsBp/eGuxyRTQFd9zFP29qj7gJtVsC8uAs/Un7b1WYdIkAADZ7mStBTlcxxAZ
         IDJYW/pRZYq4hYDj90DmTvPsfBxHao/TAtuex48vlIZGVrD5JbC439E6hZxikFdt35Lg
         ebFsBOKgNqDMlveEiVHXxQHSNCpGcCrDdTsGvs35t3vE0UcZi2g/ckI97Z3fLQ9mCIBG
         daEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=22Z7Vttl/DsWSxg2K3fwNLKgVGLe63cGsEZccICH2HQ=;
        b=n05p9L6thigwtReWJjntEBWwV5TSDguulLZ8L5mfVPnS1ha112X5TnRK9A4QxLTYAX
         PSe+6AiYIy4ukn01PXDLJ9P02Ez1UdiL0TyTFn1LAIwUh4zdW1wL3ekXqQ2l4wQpYnDx
         qte7ODVPdynBNxp7ZAoYUjc761iCP0oODMcqaHh6t8gurqgzNi2VAuVClX+Nl/supEae
         2IUYQSqvFBkMqpQJxsiT1skYdGZjgDZfnb+iDl3qkmEhbCGT1mlZb5dN0WPmhoMCaDSI
         egElpe29FnxqwNzjBCYgmfCVq0rVXn5CTjmSkfBOs2+RmbsQg7MUf6sVIpMdI6L1OwAy
         TuGQ==
X-Gm-Message-State: AOAM530Q8W+Ks7sDku4Yz10yHWc3wplj4d6TTm/6dJr9iMbvNcETZm/w
        IXgk8d6TEVVyUyFDv8mp/LOeLQgRKIE=
X-Google-Smtp-Source: ABdhPJwqh1SLybogI+JLJRdbP/EHpcTv22XBcpVJ4Y8SRuYIr8R47Jygkg2BHuFpDZCt/JGAYPJK3A==
X-Received: by 2002:a05:6402:2708:: with SMTP id y8mr34022391edd.84.1630472517590;
        Tue, 31 Aug 2021 22:01:57 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:b8a9:48b7:67d9:7826])
        by smtp.gmail.com with ESMTPSA id eg14sm10507997edb.64.2021.08.31.22.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 22:01:57 -0700 (PDT)
Date:   Wed, 1 Sep 2021 07:01:56 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>
Subject: [ANNOUNCE] Sparse v0.6.4-rc1
Message-ID: <20210901050156.nzzi7dzcwjw4lsj4@mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse v0.6.4-rc1 is finally out.

The source code can be found at its usual repository:
   git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.4-rc1

The tarballs can be found at:
   https://www.kernel.org/pub/software/devel/sparse/dist/

Many thanks to people who have somehow contributed to the 299
patches of this release:
   Ramsay Jones, Linus Torvalds, Kyle Russell


Release notes for v0.6.4
------------------------

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

-- Luc

