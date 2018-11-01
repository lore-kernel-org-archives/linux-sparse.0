From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 1 Nov 2018 12:15:54 +0100
Message-ID: <20181101111554.GC3178@hirez.programming.kicks-ass.net>
References: <20181010072240.GB103159@gmail.com>
	<20181010080324.GV29268@gate.crashing.org>
	<20181010081906.GA5533@zn.tnic>
	<20181010185432.GB29268@gate.crashing.org>
	<20181010191427.GF5533@zn.tnic> <20181013193335.GD31650@zn.tnic>
	<20181031125526.GA13219@hirez.programming.kicks-ass.net>
	<5f987ecbb4962b4796615928d9d71f2cf9b21a3b.camel@perches.com>
	<20181101090114.GE3159@hirez.programming.kicks-ass.net>
	<02085d90af8a81b69cb38e0fdd6a018f151a58d8.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <02085d90af8a81b69cb38e0fdd6a018f151a58d8.camel@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Chris Zankel <chris@zankel.net>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kerne
List-Id: linux-sparse@vger.kernel.org

On Thu, Nov 01, 2018 at 02:20:40AM -0700, Joe Perches wrote:
> On Thu, 2018-11-01 at 10:01 +0100, Peter Zijlstra wrote:
> > On Wed, Oct 31, 2018 at 10:20:00PM -0700, Joe Perches wrote:
> > > On Wed, 2018-10-31 at 13:55 +0100, Peter Zijlstra wrote:
> > > > Anyway, with the below patch, I get:
> > > > 
> > > >    text    data     bss     dec     hex filename
> > > > 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> > > > 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux
> > > > 
> > > > Which shows we inline more (look for asm_volatile for the actual
> > > > changes).
> > > []
> > > >  scripts/checkpatch.pl                              |  8 ++---
> > > >  scripts/genksyms/keywords.c                        |  4 +--
> > > >  scripts/kernel-doc                                 |  4 +--
> > > 
> > > I believe these should be excluded from the conversions.
> > 
> > Probably, yes. It compiled, which was all I cared about :-)
> > 
> > BTW, if we do that conversion, we should upgrade the checkpatch warn to
> > an error I suppose.
> 
> More like remove altogether as __inline and __inline__
> will no longer be #defined

That's the point, therefore checkpatch should error when it sees them.
Otherwise we'll grow new instances, because it will compile just file.
