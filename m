Return-Path: <SRS0=Dp15=DZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A503EC433E7
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Oct 2020 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBF322201
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Oct 2020 16:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUjcTVS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgJRQkX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Oct 2020 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgJRQkW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Oct 2020 12:40:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EC9C061755
        for <linux-sparse@vger.kernel.org>; Sun, 18 Oct 2020 09:40:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lw21so10544911ejb.6
        for <linux-sparse@vger.kernel.org>; Sun, 18 Oct 2020 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=RHNREoyoNJPrttKy46HdA8AH+YrR7eLyUquyaecv1pc=;
        b=JUjcTVS13O+bdB/HYdUcFZp1xuTM+SirWsM1jfE/ZTlwHCtKFPjjXH2Hb1L6Z7g//y
         qLelthWXQ3qdWfyBX/rZJFBCWihrDng+9jVDHsMuzllXtBq5Z0yaa/FegwP3gSggtU34
         Z+JTV4v2P1TLEvAKnFZ2+52V/Jz7Vs1vxsAGBHD/ttjUgBnCt/oBfqGHbLU7bJedilq9
         GCjTMnUcmfPzmizDLMA1JzVJyQY1I2StmZZ0KttbC8/LW1MiZQ7HKL5CGgf2LjgIehER
         ayzTq4kMIa8ENDVyXh3LP9IrtX1I1/C1o4QwmiLmx+Yk9IkSjdMsp8KlpPb5xjyYNWcO
         UinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=RHNREoyoNJPrttKy46HdA8AH+YrR7eLyUquyaecv1pc=;
        b=L0bAc7fAHULY+NtzUIna71vO9drBPim9agQU+SM7GrZZ9ZY7OVvMhLihpM65slh7gi
         REgfcbw1+8Ni+7oaPgZUlGeRgXfvH7dZu2xdqL4jMwH8gBZWSIF4W9P+aj4bG5Ohlcwr
         iTm3MljUdCNeH467lBj+/b9J2ghQv4FBQjaj35VasSRKibGBKwHMCvOELrUSzhLfKxie
         heKvuD1fV8q9pDPKkl3Tl1EnVOaPkOquo6enIJikhhuAUe8m2547LJGYnb3bXAuxYK+R
         gKPcMBsTGS8hlHrCBFoOOJBSlOI1ukAtLK+QjIl4cJ1B4Ygna/h8MTdXx+1hkppYZoSW
         0spw==
X-Gm-Message-State: AOAM532SbjJOzh0elnzyu3l1bqrB3Wlv5+FGCcEWBsiJTst2QvLlj3jr
        C1tMPUyWeypj+biftQEqhgXE1O/RwgY=
X-Google-Smtp-Source: ABdhPJxkEfi3+qY69quM4ynvIDxZUHQLs9SOzhKUzLPSQ4RSH71OawpdawEguangcDR5Zw9va8+RJA==
X-Received: by 2002:a17:906:eb15:: with SMTP id mb21mr13904769ejb.318.1603039218662;
        Sun, 18 Oct 2020 09:40:18 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:71f5:2f27:5802:67e0])
        by smtp.gmail.com with ESMTPSA id a20sm7664011ejg.41.2020.10.18.09.40.17
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 09:40:17 -0700 (PDT)
Date:   Sun, 18 Oct 2020 18:40:16 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Subject: [ANNOUNCE] Sparse v0.6.3
Message-ID: <20201018164016.d7hoonfebij7eqve@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse v0.6.3 is now out.

The source code can be found at its usual repository:
   git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.3

The tarballs can be found at:
   https://www.kernel.org/pub/software/devel/sparse/dist/

Many thanks to people who have contributed to the 201 patches
of this release:
   Alexey Gladkov, Ilya Maximets, Uwe Kleine-König, Ramsay Jones,
   Oleg Nesterov, Peter Zijlstra, Linus Torvalds, Davidson Francis,
   Valentin Schneider, Herbert Xu, Ard Biesheuvel and the kernel test robot.

Special thanks to Ramsay Jones for testing the pre-release.


Release notes for v0.6.3
------------------------

Bug fixes:
  * fix missing inlining of _Generic expression
  * fix evaluation error with assignment of qualified arrays
  * delay 'empty character constant' warning to phase 5
  * simplify & fix parsing of array declarators
  * accept whitespace after option -U
  * teach dissect about _Generic
  * reset locale after gtk_init() to workaround problems with strtold()
  * fix linearization of shift-assign
  * force to 0 expressions which are erroneously non-constant
  * fix evaluate_ptr_add() when sizeof(offset) != sizeof(pointer)
  * fix access to defining instruction in simplify_unop()
  * fix evaluation of pointer to bool conversions
  * fix usual conversion of integers
  * fix null pointer deref on return expression with invalid type

New features:
  * add support for arch specific asm constraints
  * add memory asm constraint for PPC & S390
  * prepend diagnostics with source's path and include chain
  * add support for h8300, microblaze, nds32, openrisc, sh & xtensa
  * add support for '-march=....' and use it for riscv
  * add an option to specify the OS: --os=$OS
  * add predefines for OS identification
  * add predefines for __INT_LEAST${N}_TYPE__ & __INT_FAST${N}_TYPE__
  * document the sparse's extensions
  * sindex/semind: allow indexing outside the project tree
  * rename tool 'sindex' to 'semind'
  * add builtin support for __sync_{bool,val}_compare_and_swap()
  * add support for wide strings
  * union-cast: teach sparse about union casts
  * add support for a new instruction: OP_FMADD
  * add various warnings for dangerous usage of flexible array members
  * add builtin support for  __builtin_ia32_pause()

Misc changes:
  * cleanup the handling of options flags
  * avoid multiple warnings when inlining undeclared calls
  * small fixes for alpha, arm, nios2, ppc, sparc & x86
  * add missing predefines for endianness on arm, arm64, mips
  * add various missing arch-specific predefines
  * add the predefines '__cdecl', ... on cygwin
  * warn on empty assignments & initializations
  * reorganize the keyword parsing table
  * the message in _Static_assert() is now optional (C2x)
  * small fixes & improvement to the [online] documentation
  * allow [*] in array declarators
  * do not accept comma expressions in array declarator
  * simplify parsing of attributes & storage class
  * bad-shift: wait dead code elimination to warn about bad shifts
  * fix is_scalar_type(): fouled types are scalars too
  * better support for linearization of builtins
  * remove definition of removed OP_{AND,OR}_BOOL

