Return-Path: <SRS0=hzTE=DS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF686C433DF
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Oct 2020 22:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F8020781
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Oct 2020 22:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn1/x83+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgJKW6J (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 11 Oct 2020 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgJKW6I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Oct 2020 18:58:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A8C0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 11 Oct 2020 15:58:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so20683512eja.2
        for <linux-sparse@vger.kernel.org>; Sun, 11 Oct 2020 15:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=TEirXBDMgOHYf8l9QXRi2fpWmphOtZqnLmmcboc+M78=;
        b=Qn1/x83+lkLHMsr2dNFR5X5DTE54wTIZrkLxH1sY8TatFMCDkJ8Vkh3suvdWa3p7BI
         376RYH4UNJt+j04FTI1meIE2npJz8hCzaQA5RA6XZl8M36NccCHhLTPCjLWVvXL03i/g
         A5QFmsxrGOWi4vGblsh+SVKds3jx1A/PTDuxLbzbnkOFit8UFRcbEyPHjO9BKxLz1F9h
         IodHRJxZqtliHBm8S1r6alNDcsU1ZO1v2S5GurVW874jcFBsgzGM+rQOkDZ4LFfZlgRJ
         orF4Vr310o0LhHENGe0fNzGDT9nQdnDg0XJPmsVL2yC+odITaNrLgsko1b+PS2IgL0oZ
         hwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=TEirXBDMgOHYf8l9QXRi2fpWmphOtZqnLmmcboc+M78=;
        b=oDOmpVCTLdW20Fkw/roR5Kh/8pHZS7XiAB4Bd/BDaVw/9WikpZOLNEmv/SzrWXCpjw
         v6JJYmNqxOTFrqFKMAm4LNrBJNJ1DwDVSzVQ1V1rCOi8eGFJI31lc4S47xHb9Uxg8D1i
         Q0d3vYF6MTfKQ9AxVYHwvxaJUdeV/on3DlJEBN7EyekVxmZv6ZThnjnE0Tw6YT0vqtWV
         QUF0DpuDm74xzHql7ytWO+HEFZOun2Qmd0RKjOyQ992HHez6p7N6QtUJgeDBKip8DHvd
         93GBXRA8kzYHuld2GS6ttSusnN4cqD6F0aPJB9hjmR6/31xOMhFqgr7SsmoLVHxgXvX+
         Jbmg==
X-Gm-Message-State: AOAM533hz1aWLzFtJcmM/odSUo2qwlBVYu9Yyp4IT8xaOZHP09VqH9Ll
        xfQCcKskvMkOfXb0XRJpF1WLvctCxgE=
X-Google-Smtp-Source: ABdhPJwHHds76218jrjBR+AfFUmBxys2nf9eL0s4K792xvmIFfPyE3HO4+3UcKy59J0cHKI3O4ndvA==
X-Received: by 2002:a17:906:715a:: with SMTP id z26mr25691372ejj.300.1602457086000;
        Sun, 11 Oct 2020 15:58:06 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:282e:befe:3e3b:44bb])
        by smtp.gmail.com with ESMTPSA id b3sm9543458edx.27.2020.10.11.15.58.04
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 15:58:05 -0700 (PDT)
Date:   Mon, 12 Oct 2020 00:58:04 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Subject: [ANNOUNCE] Sparse v0.6.3-rc1
Message-ID: <20201011225804.fgpismx45eqjivay@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse v0.6.3-rc1 is now out.

The source code can be found at its usual repository:
   git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.3-rc1

The tarballs can be found at:
   https://www.kernel.org/pub/software/devel/sparse/dist/

Many thanks to people who have contributed to the 197 patches
of this release:
   Alexey Gladkov, Ilya Maximets, Uwe Kleine-König, Ramsay Jones,
   Oleg Nesterov, Peter Zijlstra, Linus Torvalds, Davidson Francis,
   Valentin Schneider, Herbert Xu, Ard Biesheuvel and the kernel test robot.

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

------------------------

The full changes since v0.6.2 are:
  Alexey Gladkov (3):
    dissect: add support for _Generic
    sindex: allow indexing outside the project tree
    sindex: rename it to 'semind'

  Davidson Francis (1):
    test-inspect: reset locale after gtk_init()

  Ilya Maximets (2):
    add helpers is_struct_type() &  is_union_type()
    flex-array: allow arrays of unions with flexible members.

  Luc Van Oostenryck (188):
    gensel: remove unneeded test/uninitialized warning
    teach sparse about __STDC_HOSTED__
    testsuite: fix 'format help' / validate number of arguments
    remove unneeded BSD & Solaris compatibility layer
    options: let handle_onoff_switch() use null terminated arrays
    options: move -Wsparse-all's processing out of handle_onoff_switch()
    options: move on top the definition of warning type enums
    options: make Wsparse_error less special
    options: handle_onoff_switch() can handle any flags, not only warnings
    options: move helpers up
    options: alphasort the handle_switch_[a-zA_Z]()
    options: avoid spaces between function name and arguments list
    options: move declaration of tabstop out of "token.h"
    options: add a small helper: handle_switch_finalize()
    options: move option parsing in a separate file
    options: keep the options sorted
    cleanup: move predefines in a separate file
    avoid multiple warnings when inlining undeclared calls
    testsuite: add new flag '-p' to subcommand 'format'
    add support for arch specific asm constraints
    add memory asm constraint for PPC
    add memory asm constraint for S390
    sindex: avoid a warning with 'case -1:'
    cleanup: move parsing helpers to parse.c
    cleanup: move hexval() to utils.c
    arch: add minimal support for microblaze
    testsuite: add testcase for bogus linearization of >>= & /=
    predefine: add testcase for multi-token predefines
    predefine: fix multi-token predefine
    predefine: add helper predefine_{strong,weak}()
    predefine: avoid add_pre_buffer() for targets
    predef: simplify add_pre_buffer()
    arch: teach sparse about the '-march' option
    riscv: parse '-march=....'
    riscv: add the predefines for the extensions
    nios2: long double is 64-bit
    nios2: add non-trailing double underscore predefines
    c2x: message in _Static_assert() is now optional
    mips: add predefines __MIPSEL__ or __MIPSEB__ & friends
    arm64: add predefine for endianness
    arm: add predefine __ARMEL__ or __ARMEB__
    keyword: reorganize the keyword table
    keyword: reorder the keywords
    keyword: use some macros to avoid duplication
    x86: reorg the target file
    add a testcase for assignment to const <type> (*)[]
    add another testcase  with const array/pointer
    add testcase for missing warning for assignment to const
    teach sparse about -fmax-errors
    arch: add an option to specify the OS: --os=$OS
    predefine: add __linux__ & __linux
    predefine: no __unix__ for Darwin
    x86: fixes types for NetBSD & OpenBSD
    sparc: char are unsigned on Solaris
    arch: add predefines for OS identification
    cygwin: add the predefines '__cdecl', ...
    cgcc: remove now unneeded options & defines
    arm: fix int32_t & uint32_t on bare-metal.
    target: keep tables sorted
    h8300: add minimal support
    xtensa: add minimal support
    nds32: add minimal support
    sh: add minimal support
    openrisc: add minimal support
    fix evaluation error with assignment of qualified arrays
    sparc: add 'sparcv8' predefines for sparc32
    alpha: has 64-bit long double & int128
    ppc: add predefines __LONGDOUBLE128 & __LONG_DOUBLE_128__
    arch: add predefines __INT_LEAST${N}_TYPE__
    arch: add predefines __INT_FAST${N}_TYPE__
    predefine: teach sparse about __SIG_ATOMIC_TYPE__
    arch: allow target specific [u]intptr_t & ptrdiff_t
    x86-x32: fix it by defining a separate target for it
    add testcase for incorrect empty expressions
    warn on empty assignments
    warn on empty initializations
    syntax errors in numbers are not fatal
    predefine: let predefine_width() take the usual interface
    prepend diagnostics with source's path and include chain
    delay 'empty character constant' warning to phase 5
    add position to struct stream
    doc: document the sparse's extensions
    doc: replace nocast-vs-bitwise document with its lore link
    doc: simplify the toctree
    doc: add index to the sidebar
    doc: remove link "edit on github"
    doc: shorter title for "submitting-patches.md"
    add testcase for comma in array declarator
    do not accept comma expressions in array declarator
    add testcases for C99 array declarators
    simplify & fix parsing of array declarators
    remove now unused match_idents()
    allow [*] in array declarators
    generic: fix missing inlining of generic expression
    show-mod: add helper to show the modifiers but without ending space
    show-mod: no ending space when showing a single modifier
    show-mod: no extra space when showing modifiers + ident
    manpage: replace homepage to sparse.docs.kernel.org
    doc: use https URLs
    doc: do not display bugzilla's URL, it's too long
    option: accept 'sparse -U ...'
    use lookup_keyword() for qualifiers
    attribute: split handle_asm_name() from handle_attributes()
    attribute: fold parse_asm_declarator() into handle_asm_name()
    attribute: remove argument 'keywords' from handle_attributes()
    attribute: directly use attribute_specifier() to handle attributes
    attribute: factorize matching of '__attribute__'
    attribute: no need to lookup '__attribute__' in NS_KEYWORD
    testing for SYM_KEYWORD is unneeded for lookup_keyword()
    testing for sym->op is unneeded for lookup_keyword()
    attribute: simplify parsing of attributes
    keyword type is a bitmask and must be tested so
    remove unsed field for EXPR_GENERIC
    xtensa: fix configuration of endianness
    dissect: use struct symbol::visited/inspected instead of ::examined/evaluated
    fix stream_prev() for invalid (negative) stream
    fix diagnostic source path from command line
    fix build on Hurd which doesn't define PATH_MAX
    shift-assign: add more testcases for bogus linearization
    shift-assign: fix linearization of shift-assign
    shift-assign: restrict shift count to unsigned int
    bad-shift: wait dead code elimination to warn about bad shifts
    add testcases for __sync_{bool,val}_compare_and_swap()
    export evaluate_arguments()
    add builtin support for __sync_{bool,val}_compare_and_swap()
    wstring: add support for evaluation of wide string
    wstring: add support for checking size in string initializer
    wstring: add support for examination of string initialization
    wstring: add helper is_wchar_type()
    wstring: extend is_string_type() to also detect wide strings
    wstring: call is_string_type() only when needed
    warning: conditionalize "advancing past deep designator"
    fix checking if type is void
    force to 0 expressions which are erroneously non-constant
    parse: rework handling of storage_class
    parse: associate modifiers with their keyword
    parse: let asm_modifier() use the keyword modifier
    parse: improve error messages concerning storage specifiers
    parse: simplify set_storage_class()
    doc: use a smaller logo in the sidebar
    doc: make the sidebar more compact
    doc: decrease vertical spacing
    doc: move down info about tarballs, after git repositories
    doc: reorganize the table of content
    doc: use shorter titles
    doc: add links to some external doc
    fix is_scalar_type(): fouled types are scalars too
    union-cast: add some testcases
    union-cast: extract evaluate_compound_literal()
    fix typo in warning
    union-cast: teach sparse about union casts
    fix evaluate_ptr_add() when sizeof(offset) != sizeof(pointer)
    remove unneeded predeclaration of evaluate_cast()
    add helper replace_with_value()
    use replace_with_value()
    replace_with_{pseudo,value}() can be tail-calls
    testsuite: easier testing via script & makefile
    add support for a new instruction: OP_FMADD
    builtin: allow linearization to fail
    builtin: add declaration for __builtin_fma{,f,l}()
    builtin: teach sparse to linearize __builtin_fma()
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
    fix Hurd PATH_MAX ...
    testsuite: fix erroneous comment
    add builtin type for wide strings
    add builtin types for signed char* and short *
    add builtin types for size_t*, intmax_t* & ptrdiff_t*
    flex-array: remove unneeded test
    remove definition of removed OP_{AND,OR}_BOOL
    unop: fix access to defining instruction in simplify_unop()
    build: rule for validation needs to be FORCEd
    fix evaluation of pointer to bool conversions
    fix usual conversion of integers
    flex-array: fix location for nesting of flexible members
    builtin: teach sparse about __builtin_ia32_pause()
    doc: add release notes for incoming v0.6.3
    Sparse v0.6.3-rc1

  Oleg Nesterov (1):
    dissect: support _Generic() a bit more

  Ramsay Jones (1):
    bug-assign-op0.c: fix test on 32-bit builds

  Uwe Kleine-König (1):
    sindex.1: Use ' for a plain quote char

