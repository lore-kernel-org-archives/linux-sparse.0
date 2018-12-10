From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 10 Dec 2018 17:16:28 +0900
Message-ID: <CAK7LNARSRZEctnTGiB8GOC-D5Q9_d5GpNm8JQ1EJ--WioDe_DA@mail.gmail.com>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
 <20181129122500.GX23873@gate.crashing.org> <CF26ACBE-500C-47E8-B79D-E1ABE938031D@alien8.de>
 <20181130131633.GU23873@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130131633.GU23873@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, rguenther@suse.de, matz@suse.de, gcc@gcc.gnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

Hi Segher,


On Sun, Dec 2, 2018 at 3:48 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Nov 30, 2018 at 10:06:02AM +0100, Boris Petkov wrote:
> > On November 29, 2018 1:25:02 PM GMT+01:00, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > >This will only be fixed from GCC 9 on, if the compiler adopts it.  The
> > >kernel wants to support ancient GCC, so it will need to have a
> > >workaround
> > >for older GCC versions anyway.
> >
> > What about backporting it, like Richard says?
>
> Let me first get it into GCC trunk :-)
>
> It should backport fine, sure; and I'll work on that.
>



Now, I can see it in the GCC trunk.  Hooray!!!



commit 6de46ad5326fc5e6b730a2feb8c62d09c1561f92
Author: segher <segher@138bc75d-0d04-0410-961f-82ee72b054a4>
Date:   Thu Dec 6 17:56:58 2018 +0000

    asm inline

    The Linux kernel people want a feature that makes GCC pretend some
    inline assembler code is tiny (while it would think it is huge), so
    that such code will be inlined essentially always instead of
    essentially never.

    This patch lets you say "asm inline" instead of just "asm", with the
    result that that inline assembler is always counted as minimum cost
    for inlining.  It implements this for C and C++, making "inline"
    another asm-qualifier (supplementing "volatile" and "goto").




-- 
Best Regards
Masahiro Yamada
