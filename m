From: Richard Biener <rguenther@suse.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 29 Nov 2018 14:09:25 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1811291408400.1827@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com> <20181129130718.GA3070@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129130718.GA3070@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Segher Boessenkool <segher@kernel.crashing.org>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, matz@suse.de, gcc@gcc.gnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: linux-sparse@vger.kernel.org

On Thu, 29 Nov 2018, Borislav Petkov wrote:

> On Thu, Nov 29, 2018 at 08:46:34PM +0900, Masahiro Yamada wrote:
> > But, I'd like to ask if x86 people want to keep this macros.s approach.
> > Revert 77b0bf55bc675 right now
> > assuming the compiler will eventually solve the issue?
> 
> Yap, considering how elegant the compiler solution is and how much
> problems this macros-in-asm thing causes, I think we should patch
> out the latter and wait for gcc9. I mean, the savings are not so
> mind-blowing to have to deal with the fallout.
> 
> But this is just my opinion.

I'd be not opposed to backporting the asm inline support.

Of course we still have to be happy with it and install the patch ;)

Are you (kernel folks) happy with asm inline ()?

Richard.

> Thx.
> 
> 

-- 
Richard Biener <rguenther@suse.de>
SUSE LINUX GmbH, GF: Felix Imendoerffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nuernberg)
