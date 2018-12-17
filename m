From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
Date: Mon, 17 Dec 2018 11:54:13 +0900
Message-ID: <CAK7LNARcSYvc-3xhdwFMk=q20LYW2i1ahscofYsYka2hg0Oszw@mail.gmail.com>
References: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com> <9691ECB6-D659-4E88-B8AF-4947B9431AF1@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9691ECB6-D659-4E88-B8AF-4947B9431AF1@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Richard Biener <rguenther@suse.de>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Michal Marek <michal.lkml@markovi.net>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Sun, Dec 16, 2018 at 12:29 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Dec 15, 2018, at 6:50 PM, Masahiro Yamada <yamada.masahiro@socionext=
.com> wrote:
> >
> > Revert the following 9 commits:
> >
> > [1] 5bdcd510c2ac ("x86/jump-labels: Macrofy inline assembly code to
> >    work around GCC inlining bugs")
> >
> >    This was partially reverted because it made good cleanups
> >    irrespective of the inlining issue; the error message is still
> >    unneeded, and the conversion to STATIC_BRANCH_{NOP,JUMP} should
> >    be kept.
> >
> > [2] d5a581d84ae6 ("x86/cpufeature: Macrofy inline assembly code to
> >    work around GCC inlining bugs")
> >
> > [3] 0474d5d9d2f7 ("x86/extable: Macrofy inline assembly code to work
> >    around GCC inlining bugs")
> >
> > [4] 494b5168f2de ("x86/paravirt: Work around GCC inlining bugs when
> >    compiling paravirt ops")
> >
> > [5] f81f8ad56fd1 ("x86/bug: Macrofy the BUG table section handling,
> >    to work around GCC inlining bugs")
> >
> > [6] 77f48ec28e4c ("x86/alternatives: Macrofy lock prefixes to work
> >   around GCC inlining bugs")
> >
> > [7] 9e1725b41059 ("x86/refcount: Work around GCC inlining bug")
> >
> >    Resolved conflicts in arch/x86/include/asm/refcount.h caused by
> >    288e4521f0f6 ("x86/asm: 'Simplify' GEN_*_RMWcc() macros").
> >
> > [8] c06c4d809051 ("x86/objtool: Use asm macros to work around GCC
> >    inlining bugs")
> >
> > [9] 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in inline
> >    assembly code to work around asm() related GCC inlining bugs")
> >
> > A few days after those commits applied, discussion started to solve
> > the issue more elegantly with the help of compiler:
> >
> >  https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l.org%2Flkml%2F2018%2F10%2F7%2F92&amp;data=3D02%7C01%7Cnamit%40vmware.com%7=
Ce893ce88065e4c59236308d663019424%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C=
0%7C636805255787607178&amp;sdata=3DmiiUndmPfGNKvrzD5mttC1%2Bn6rNaoIFebjZOAk=
Br24Y%3D&amp;reserved=3D0
> >
> > The new syntax "asm inline" was implemented by Segher Boessenkool, and
> > now queued up for GCC 9. (People were positive even for back-porting it
> > to older compilers).
> >
> > Since the in-kernel workarounds merged, some issues have been reported:
> > breakage of building with distcc/icecc, breakage of distro packages for
> > module building. (More fundamentally, we cannot build external modules
> > after 'make clean'.)
> >
> > I do not want to mess up the build system any more.
> >
> > Given that this issue will be solved in a cleaner way sooner or later,
> > let's revert the in-kernel workarounds, and wait for GCC 9.
> >
> > Reported-by: Logan Gunthorpe <logang@deltatee.com> # distcc
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com> # deb/rpm package
>
> It is customary to cc those who report an issue.

OK.

> The distcc issue has already been resolved both in distcc

Precisely, the fix-up was submitted,
but not pulled yet as of writing.
https://github.com/distcc/distcc/pull/313


> and in the patches
> I=E2=80=99ve sent: https://lkml.org/lkml/2018/11/15/467 .

I was scared by this ugly fix-up, so I rejected it.



> So I cannot understand why
> it is mentioned as a motivation.
>
> It sounds that the external modules can easily be resolved. Can you pleas=
e
> provide a link for the bug report?


https://www.spinics.net/lists/linux-kbuild/msg20037.html

We can fix it under circumstances "we can do anything"
although I am scared by endless Makefile hacks.



> Please regard my comments regarding v1.

I will try my best, although I felt some of your requests were too much.
I am not an x86 developer.


I posted this so people can play with 'asm inline'
https://lore.kernel.org/patchwork/patch/1024590/

You can confirm vmlinux size is increased,
and some symbols disappears.



> I must admit that I=E2=80=99m very surprised
> that you don=E2=80=99t like the patches since you ack=E2=80=99d the origi=
nal patch-set


I think ack and "I like it" are different.

There are situations where we had to accept something reluctantly.


Without my ack, your patch series would not have been
merged via x86 tree.

There was no other solution at that time.
Also, I could not predict potential problems, which turned out later.

So I let it go.

It would have been better if
the following discussion had stared earlier.
https://lkml.org/lkml/2018/10/7/92


Now, we got a much cleaner solution.

I believe we should replace the workarounds with it.



> (and
> actually assisted me in changing the Makefile).

You were clearly breaking the build system.
So, I provided a less ugly solution.

Again, the in-kernel hack was the only solution at that time,
but the situation has changed then.



--=20
Best Regards
Masahiro Yamada
