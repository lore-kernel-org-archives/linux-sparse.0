From: Joe Perches <joe@perches.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 01 Nov 2018 02:20:40 -0700
Message-ID: <02085d90af8a81b69cb38e0fdd6a018f151a58d8.camel@perches.com>
References: <20181009145330.GT29268@gate.crashing.org>
         <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
         <20181010072240.GB103159@gmail.com>
         <20181010080324.GV29268@gate.crashing.org> <20181010081906.GA5533@zn.tnic>
         <20181010185432.GB29268@gate.crashing.org> <20181010191427.GF5533@zn.tnic>
         <20181013193335.GD31650@zn.tnic>
         <20181031125526.GA13219@hirez.programming.kicks-ass.net>
         <5f987ecbb4962b4796615928d9d71f2cf9b21a3b.camel@perches.com>
         <20181101090114.GE3159@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101090114.GE3159@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Segher Boessenkool <segher@kernel.crashing.org>, Ingo Molnar <mingo@kernel.org>, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Thu, 2018-11-01 at 10:01 +0100, Peter Zijlstra wrote:
> On Wed, Oct 31, 2018 at 10:20:00PM -0700, Joe Perches wrote:
> > On Wed, 2018-10-31 at 13:55 +0100, Peter Zijlstra wrote:
> > > Anyway, with the below patch, I get:
> > > 
> > >    text    data     bss     dec     hex filename
> > > 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> > > 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux
> > > 
> > > Which shows we inline more (look for asm_volatile for the actual
> > > changes).
> > []
> > >  scripts/checkpatch.pl                              |  8 ++---
> > >  scripts/genksyms/keywords.c                        |  4 +--
> > >  scripts/kernel-doc                                 |  4 +--
> > 
> > I believe these should be excluded from the conversions.
> 
> Probably, yes. It compiled, which was all I cared about :-)
> 
> BTW, if we do that conversion, we should upgrade the checkpatch warn to
> an error I suppose.

More like remove altogether as __inline and __inline__
will no longer be #defined

$ git grep -P 'define\s+__inline'
include/linux/compiler_types.h:#define __inline__ inline
include/linux/compiler_types.h:#define __inline   inline
