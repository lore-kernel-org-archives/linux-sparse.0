From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 0/7] Silence even more W=2 warnings
Date: Tue, 23 Sep 2014 07:49:36 -0700
Message-ID: <20140923144936.GA9844@thin>
References: <AEF1C0F7-239C-436B-97A5-6AFF49FD9359@intel.com>
 <20140922184049.GB4709@pd.tnic>
 <3199350A-89CE-4BE7-8FE4-CA8CE4F87622@intel.com>
 <20140922192152.GD4709@pd.tnic>
 <1411415057.2513.8.camel@jtkirshe-mobl.jf.intel.com>
 <20140922195737.GE4709@pd.tnic>
 <1411416573.2513.19.camel@jtkirshe-mobl.jf.intel.com>
 <20140922203336.GF4709@pd.tnic>
 <1411420912.2513.32.camel@jtkirshe-mobl.jf.intel.com>
 <20140923080120.GA22072@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140923080120.GA22072@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>, "sparse@chrisli.org" <sparse@chrisli.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Sep 23, 2014 at 10:01:20AM +0200, Borislav Petkov wrote:
> ./arch/x86/include/asm/io_apic.h: In function =E2=80=98io_apic_modify=
=E2=80=99:
> ./arch/x86/include/asm/io_apic.h:223:48: warning: declaration of =E2=80=
=98apic=E2=80=99 shadows a global declaration [-Wshadow]
>  static inline void io_apic_modify(unsigned int apic, unsigned int re=
g, unsigned int value)
>                                                 ^
> In file included from ./arch/x86/include/asm/smp.h:12:0,
>                  from include/linux/smp.h:59,
>                  from include/linux/topology.h:33,
>                  from include/linux/gfp.h:8,
>                  from include/linux/kmod.h:22,
>                  from include/linux/module.h:13,
>                  from drivers/edac/amd64_edac.h:65,
>                  from drivers/edac/amd64_edac.c:1:
> ./arch/x86/include/asm/apic.h:366:21: warning: shadowed declaration i=
s here [-Wshadow]
>  extern struct apic *apic;
>                      ^
>=20
> So gcc complains that an unsigned int shadows a struct apic pointer.

Here, I think the right fix involves picking a more descriptive name
than "apic" for the global varible.

- Josh Triplett
