Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536EAC433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 18 Jan 2022 23:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbiARXdO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 18 Jan 2022 18:33:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350196AbiARXdN (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jan 2022 18:33:13 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E63D1EC0464;
        Wed, 19 Jan 2022 00:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642548788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZgKZ23T/1gGugaFxB9VsyewKILJfjmGgGnZBi4guEjM=;
        b=R1UxKshY7Si5eXe6U5H6D4LdNotUwvORhmYiOZZ5tFJ6AS3DKVFshi6nKp0zNNM5JJdnUe
        EvGzovq7IAjkPkqAtqt/Gkq3APcpqO9lb0KQBmRMqziP5BtwHfnPr3teu5g+FBOiAAwJWH
        0UNo8jRiZngnRKCjiAI/UOnLws+g4Og=
Date:   Wed, 19 Jan 2022 00:33:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <YedOLva0zos3A1JE@zn.tnic>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
 <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118230120.pivvson7qekfiqic@treble>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jan 18, 2022 at 03:01:20PM -0800, Josh Poimboeuf wrote:
> With the two WARN_ONs in media_request_object_complete(), GCC apparently
> considers the two reachable() asm statements as duplicates, and it
> removes the second one.

Could that be the same thing:

net/xfrm/xfrm_output.o: warning: objtool: xfrm_output_resume()+0x2e0: unreachable instruction

I see two WARN_ONs in asm output there too...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
