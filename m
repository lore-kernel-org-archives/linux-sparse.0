From: Joe Perches <joe@perches.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 31 Oct 2018 22:20:00 -0700
Message-ID: <5f987ecbb4962b4796615928d9d71f2cf9b21a3b.camel@perches.com>
References: <20181008073128.GL29268@gate.crashing.org>
         <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
         <20181009145330.GT29268@gate.crashing.org>
         <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
         <20181010072240.GB103159@gmail.com>
         <20181010080324.GV29268@gate.crashing.org> <20181010081906.GA5533@zn.tnic>
         <20181010185432.GB29268@gate.crashing.org> <20181010191427.GF5533@zn.tnic>
         <20181013193335.GD31650@zn.tnic>
         <20181031125526.GA13219@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031125526.GA13219@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Ingo Molnar <mingo@kernel.org>, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Philippe Ombredanne <pombredanne@nex>
List-Id: linux-sparse@vger.kernel.org

On Wed, 2018-10-31 at 13:55 +0100, Peter Zijlstra wrote:
> 
> Anyway, with the below patch, I get:
> 
>    text    data     bss     dec     hex filename
> 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux
> 
> Which shows we inline more (look for asm_volatile for the actual
> changes).
[]
>  scripts/checkpatch.pl                              |  8 ++---
>  scripts/genksyms/keywords.c                        |  4 +--
>  scripts/kernel-doc                                 |  4 +--

I believe these should be excluded from the conversions.

Other than that, generic conversion by script seems a good idea.
