Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82CC433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 25 Jan 2022 07:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359695AbiAYHZ5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 25 Jan 2022 02:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1324854AbiAYDeQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 24 Jan 2022 22:34:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C3C0604E7
        for <linux-sparse@vger.kernel.org>; Mon, 24 Jan 2022 15:26:51 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b9so4138154lfq.6
        for <linux-sparse@vger.kernel.org>; Mon, 24 Jan 2022 15:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBgHMhsHYb5HXQ+O8PZoHkhiHxJIdU56DUjgeOw50ZM=;
        b=amUCdiSL0m5afYkcJvlv6B+YX00vtkco0vuOXEaVXqw8zkY6/J8k55JTY1gMXpWQeG
         MrOUANHGnVZRZ4OEMRv34hVbAYiMOwcKvbuqGSPtBP/feL8rTOa1KGauoWc3GNbRoifL
         cEzuwMIVnp9s2HgdLfDn96sAidkeqIMJdiTlzcAewubkaT+1ZP53h+cN5JiSrEzKx2Sz
         ZO3UtZHAa5HlATWKb6J7doDopJXGZE+SejbRNdrtXmG2Csx5sjuxXJWSJkK1A6Inri+x
         TO6AhcwPqTGciG/mvJgThVqQMLYEAr4hIvzI0/r6dDxL+GVgmnjD9rYU2aQ8ASQd/M2k
         xXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBgHMhsHYb5HXQ+O8PZoHkhiHxJIdU56DUjgeOw50ZM=;
        b=EIx1fvSVpt8QtuG9r2EM34IypT81uN0NBw2oY9QQ5KuW5YvaaG+NjZLQ7cTXzzcjA8
         7gIAJ3bF0tvj+NByrlI7Vt/Ls1OTkMQCFzTeNx8fMHKfp3RasaQ4hDf3CRkZcygt7wcE
         nAtwz4LnQ778TktAsNi3VayjU22jDkzaQNw5A+S5Iy3jAkGI85BVy6PyCAuH2ngolJsd
         NpJeE9UHjCtc+Cg9s2kmI2H9Psp0HpB5R0eKZS1l6uXbKK5qQQo7q3U/IJfNPVFuYcFQ
         UuVblU8qnh7Vfm7tqUEITDxTzzrHVFreVngOia3qOd2mL3TLWbXWu1LS5p/oExUSGCQv
         /zwg==
X-Gm-Message-State: AOAM532YJjobKoebIkPTwcUrGkJuZMlfceOOj6MHPxJmEUYdOgz0wRTB
        F8uhsjyDXHQY6t+cXFQ8tZ8mp/4aAJIB2Wmby8URQg==
X-Google-Smtp-Source: ABdhPJwUjjq3BajrUcauIDw0MehhyBj1lXL0Gg39gSWaRyznsw8JT0rhyYaGKjQ3ShI7Cz2veBCs3/Z/0CCm81swu50=
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr15184153lfb.444.1643066809514;
 Mon, 24 Jan 2022 15:26:49 -0800 (PST)
MIME-Version: 1.0
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic> <20220118192256.jzk5dnceeusq7x7u@treble> <20220118230120.pivvson7qekfiqic@treble>
In-Reply-To: <20220118230120.pivvson7qekfiqic@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 15:26:36 -0800
Message-ID: <CAKwvOdmLzwz=02ypt0_1324_5-7i3Az7HizFaDMqZv__-D99uA@mail.gmail.com>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile & __COUNTER__
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

(sorry for the delay responding, took a week off last week; spent a
lot of it thinking about this case though)

On Tue, Jan 18, 2022 at 3:01 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Jan 18, 2022 at 11:22:59AM -0800, Josh Poimboeuf wrote:
> > On Sun, Jan 16, 2022 at 02:32:59PM +0100, Borislav Petkov wrote:
> > > so I like the local label and how it is more readable this way.
> > >
> > > So, provided the memory clobber works (I wonder here if Josh has some
> > > concrete failing cases which could be tested with your version) and
> > > after the nitpicks have been addressed
> > >
> > > Acked-by: Borislav Petkov <bp@suse.de>
> >
> > I think Nick was already able to recreate the original issue.  I'll run
> > it through some more testing.
> >
> > I wanted to make this change years ago, but couldn't because of legacy
> > toolchains.  Here's hoping this is the final solution for those @#$%^
> > macros.
> >
> > Boris, thanks for looping Nick in, I should have done so to begin with.

No worries, we'll get all this sorted.  There's also
linux-toolchains@vger.kernel.org that can help with spooky toolchain
behavior.

I suspect this is what's causing a flood of objtool warnings when we
specify different instruction schedules via -march= (such as via
CONFIG_MATOM), which are hiding some of the actual codegen bugs
objtool has found in LLVM that we still need to fix.

I was looking at the HAVE_ARCH_BUG implementation in
arch/x86/include/asm/bug.h 2 weeks ago, and got the sinking feeling
that we'll probably need labels in C code, then asm goto to ensure
that control flow doesn't get folded in an unexpected way and which
I'd imagine might help avoid the costs of a full compiler barrier
(i.e. reloading all pointed-to values across it).

I'll follow up more with Josh on IRC on some ideas for different
approaches.  Having 0day bot test Josh's branches is very much
appreciated.

> Apparently this patch isn't going to work after all :-(
>
>   https://lkml.kernel.org/r/202201190632.lhlaiCBk-lkp@intel.com

I noticed in that report and
https://lore.kernel.org/lkml/202201190702.XNSXrMTK-lkp@intel.com/
that gcc-9 was used.  I wonder if %= has been fixed in gcc-10+? Have
there been other reports with gcc-10+ for my patch?

Boris' case of xfrm_output_resume is yet a third case; Boris, what
version of gcc did you spot that with?

If this is fixed in gcc-10, then we can probably add a comment with a
FIXME link to the issue or commit to replace __COUNTER__ with %= one
day.  If not, then we can probably come up with a reduced test case
for the GCC devs to take a look at, then add the FIXME comment to
kernel sources.

I'm more confident that we can remove the `volatile` keyword (I was
thinking about adding a new diagnostic to clang to warn that volatile
is redundate+implied for asm goto or inline asm that doesn't have
outputs) though that's not the problem here and will probably generate
some kernel wide cleanup before we could enable such a flag.  Perhaps
there are known compiler versions that still require the keyword for
those cases for some reason.

>
> With the two WARN_ONs in media_request_object_complete(), GCC apparently
> considers the two reachable() asm statements as duplicates, and it
> removes the second one.

On Fri, Jan 14, 2022 at 1:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Perhaps it is worth mentioning in the next paragraph that this does not
> contradict GCC's own documentation that you link to below, which
> mentions that asm volatile statements can be reordered.
>
> "Note that the compiler can move even volatile asm instructions relative
> to other code, including across jump instructions."

On Sun, Jan 16, 2022 at 5:33 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Yah, Nathan's note about talking about gcc reordering volatile inline
> asms might make sense here as, apparently, that could have failed on gcc
> too but it didn't for whatever reason and the most important thing is
> that the memory clobber will prevent such reordering.

Very much YES to both points.  Will include those in the commit
message for whatever we come up with for the final solution.
-- 
Thanks,
~Nick Desaulniers
