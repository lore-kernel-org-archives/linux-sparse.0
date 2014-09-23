From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/7] Silence even more W=2 warnings
Date: Tue, 23 Sep 2014 10:01:20 +0200
Message-ID: <20140923080120.GA22072@pd.tnic>
References: <20140922153355.GB4510@pd.tnic>
 <AEF1C0F7-239C-436B-97A5-6AFF49FD9359@intel.com>
 <20140922184049.GB4709@pd.tnic>
 <3199350A-89CE-4BE7-8FE4-CA8CE4F87622@intel.com>
 <20140922192152.GD4709@pd.tnic>
 <1411415057.2513.8.camel@jtkirshe-mobl.jf.intel.com>
 <20140922195737.GE4709@pd.tnic>
 <1411416573.2513.19.camel@jtkirshe-mobl.jf.intel.com>
 <20140922203336.GF4709@pd.tnic>
 <1411420912.2513.32.camel@jtkirshe-mobl.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54140 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073AbaIWIB1 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Sep 2014 04:01:27 -0400
Content-Disposition: inline
In-Reply-To: <1411420912.2513.32.camel@jtkirshe-mobl.jf.intel.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "Rustad, Mark D" <mark.d.rustad@intel.com>, "sparse@chrisli.org" <sparse@chrisli.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Sep 22, 2014 at 02:21:52PM -0700, Jeff Kirsher wrote:
> Nothing is wrong with grepping for an error, especially when you know
> the error your grepping for.  But then again, why grep when it can be
> fixed to begin with?

Oh sure, but at what cost?

But we're on the same page here - if it can be fixed cleanly, it should
be fixed. I simply don't think that adding code just to shut up the
compiler is a good idea.

> The fact that there are over 100,000 warnings/errors to begin with
> is somewhat disconcerting. It makes me wonder whether it was due to
> coding laziness.

Yeah, the reasons should be multiple and scattered over the years, I
think. Maybe the warnings were added to gcc later than the code in the
kernel, or simply some of them are just silly:

=2E/arch/x86/include/asm/io_apic.h: In function =E2=80=98io_apic_modify=
=E2=80=99:
=2E/arch/x86/include/asm/io_apic.h:223:48: warning: declaration of =E2=80=
=98apic=E2=80=99 shadows a global declaration [-Wshadow]
 static inline void io_apic_modify(unsigned int apic, unsigned int reg,=
 unsigned int value)
                                                ^
In file included from ./arch/x86/include/asm/smp.h:12:0,
                 from include/linux/smp.h:59,
                 from include/linux/topology.h:33,
                 from include/linux/gfp.h:8,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from drivers/edac/amd64_edac.h:65,
                 from drivers/edac/amd64_edac.c:1:
=2E/arch/x86/include/asm/apic.h:366:21: warning: shadowed declaration i=
s here [-Wshadow]
 extern struct apic *apic;
                     ^

So gcc complains that an unsigned int shadows a struct apic pointer.
Yeah, that might be a problem in a big function (and it has been a
problem AFAIR) but here:

static inline void io_apic_modify(unsigned int apic, unsigned int reg, =
unsigned int value)
{
        x86_io_apic_ops.modify(apic, reg, value);
}

So yeah, it is debatable. Should it be fixed? Sure, the fix is very eas=
y.

But then fixing those could become a fighting windmills type of thing
as people don't see those warnings in normal builds. And new code will
get added which causes them again. And then the discussion would start
whether we should see those warnings...

I think you get the picture.

> To make a better (more solid) network driver?  Mark has found it usef=
ul
> to do the W=3D builds.  For me personally, I do not bother because th=
ere
> are over 100,000 warnings and it takes forever to get through a build
> and then grep for our drivers to see if they are generating any
> warnings.

Right.

> I could see this useful if there is no way to fix the issue that real=
ly
> is not an issue and the compiler just does not know any better, but t=
his
> concerns me that we would get into a bad habit.  "Oh I really do not
> want to fix this, so I will just make it so that people we not have t=
o
> see this warning/error"  Again, sounds lazy to me, of course I am jus=
t
> speaking in a generalization.

It doesn't have to be lazy - people simply don't see those warnings and
making them visible might turn out to be a net loss in the end. I think
it depends on the warning...

> I am sure that some of the warnings will fall into the category of,
> it needs to be silenced and not fixed because the fix is far more
> troublesome. I just cannot believe that most or all the warnings woul=
d
> be that way.

As I said above, I think it is a question of whether those should be
visible/enabled (which would make people fix them, more or less) or not=
=2E
And I think if someone comes up with a strong case for why a warning
should be enabled in the default build, then people wouldn't mind.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
