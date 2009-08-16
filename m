From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sun, 16 Aug 2009 11:56:08 -0700
Message-ID: <20090816185608.GA7806@feather>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
 <1250367991.14751.1.camel@penberg-laptop>
 <20090815223602.GA4516@feather>
 <1250406233.32343.9.camel@penberg-laptop>
 <20090816105114.GA6489@feather>
 <1250420733.9535.1.camel@penberg-laptop>
 <20090816124157.GA6936@feather>
 <70318cbf0908161050w4b95c04cme5f30157cba684df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-v.mail.gandi.net ([217.70.178.77]:52331 "EHLO
	relay3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbZHPS4R (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 16 Aug 2009 14:56:17 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0908161050w4b95c04cme5f30157cba684df@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-sparse@vger.kernel.org

On Sun, Aug 16, 2009 at 10:50:46AM -0700, Christopher Li wrote:
> On Sun, Aug 16, 2009 at 5:41 AM, Josh Triplett<josh@joshtriplett.org> wrote:
> > On Sun, Aug 16, 2009 at 02:05:33PM +0300, Pekka Enberg wrote:
> >> Of course. Here's the final patch. *fingers crossed*
> >
> > Looks good to me.
> >
> > Acked-by: Josh Triplett <josh@joshtriplett.org>
> >
> 
> Looks good to me too. I will apply.
> 
> The linux kernel has a STRING macro. I will rename to match
> that if nobody objects.

Matching Linux seems sensible, but I don't see that macro in any general
code, just a bunch of local defines with various names.  A few quick
greps on current git master turned up at least:

Documentation/trace/ftrace.txt:#define _STR(x) #x
Documentation/trace/ftrace.txt-#define STR(x) _STR(x)
arch/cris/boot/tools/build.c:#define STRINGIFY(x) #x
arch/cris/include/arch-v10/arch/irq.h:#define __STR(x) #x
arch/cris/include/arch-v10/arch/irq.h-#define STR(x) __STR(x)
arch/cris/include/arch-v32/arch/hwregs/supp_reg.h-#ifndef STRINGIFYFY
arch/cris/include/arch-v32/arch/hwregs/supp_reg.h:#define STRINGIFYFY(i) #i
arch/cris/include/arch-v32/arch/irq.h:#define STR2(x) #x
arch/cris/include/arch-v32/arch/irq.h-#define STR(x) STR2(x)
arch/m68k/include/asm/entry_mm.h-#define STR(X) STR1(X)
arch/m68k/include/asm/entry_mm.h:#define STR1(X) #X
arch/m68k/lib/checksum.c-#define STR(X) STR1(X)
arch/m68k/lib/checksum.c:#define STR1(X) #X
arch/mips/include/asm/mipsregs.h-#ifndef __STR
arch/mips/include/asm/mipsregs.h:#define __STR(x) #x
arch/mips/include/asm/sim.h:#define __str2(x) #x
arch/mips/include/asm/sim.h-#define __str(x) __str2(x)
arch/mips/kernel/unaligned.c-#define STR(x)  __STR(x)
arch/mips/kernel/unaligned.c:#define __STR(x)  #x
arch/powerpc/boot/reg.h:#define __stringify_1(x)        #x
arch/powerpc/boot/reg.h-#define __stringify(x)          __stringify_1(x)
arch/sh/include/cpu-sh5/cpu/registers.h:#define __str(x)  #x
arch/um/drivers/mconsole_user.c:#define STRINGX(x) #x
arch/um/drivers/mconsole_user.c-#define STRING(x) STRINGX(x)
arch/um/sys-i386/shared/sysdep/kernel-offsets.h:#define STR(x) #x
arch/um/sys-x86_64/shared/sysdep/kernel-offsets.h:#define DEFINE_STR1(x) #x
arch/x86/kernel/machine_kexec_32.c:#define __STR(X) #X
arch/x86/kernel/machine_kexec_32.c-#define STR(X) __STR(X)

And probably more.  (Also, the above didn't necessarily capture both macros
from each pair.)

So, I don't see any particular consistency here that we can follow, other than
that the macro should probably have "str" in it somewhere. :)  And if we have
to choose, I think STRINGIFY seems more descriptive than just STRING.

- Josh Triplett
