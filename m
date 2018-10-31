From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 31 Oct 2018 14:11:10 +0100
Message-ID: <20181031131110.GA13257@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
	<20181009145330.GT29268@gate.crashing.org>
	<alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
	<20181010072240.GB103159@gmail.com>
	<20181010080324.GV29268@gate.crashing.org>
	<20181010081906.GA5533@zn.tnic>
	<20181010185432.GB29268@gate.crashing.org>
	<20181010191427.GF5533@zn.tnic> <20181013193335.GD31650@zn.tnic>
	<20181031125526.GA13219@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181031125526.GA13219@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Chris Zankel <chris@zankel.net>, Michael Matz <matz@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Thomas
List-Id: linux-sparse@vger.kernel.org

On Wed, Oct 31, 2018 at 01:55:26PM +0100, Peter Zijlstra wrote:
> On Sat, Oct 13, 2018 at 09:33:35PM +0200, Borislav Petkov wrote:
> > Ok,
> > 
> > with Segher's help I've been playing with his patch ontop of bleeding
> > edge gcc 9 and here are my observations. Please double-check me for
> > booboos so that they can be addressed while there's time.
> > 
> > So here's what I see ontop of 4.19-rc7:
> > 
> > First marked the alternative asm() as inline and undeffed the "inline"
> > keyword. I need to do that because of the funky games we do with
> > "inline" redefinitions in include/linux/compiler_types.h.
> > 
> > And Segher hinted at either doing:
> > 
> > asm volatile inline(...
> > 
> > or
> > 
> > asm volatile __inline__(...
> > 
> > but both "inline" variants are defined as macros in that file.
> > 
> > Which means we either need to #undef inline before using it in asm() or
> > come up with something cleverer.
> 
> # git grep -e "\<__inline__\>" | wc -l
> 488
> # git grep -e "\<__inline\>" | wc -l
> 56
> # git grep -e "\<inline\>" | wc -l
> 69598
> 
> And we already have scripts/checkpatch.pl:
> 
>   # Check for __inline__ and __inline, prefer inline
> 
> Which suggests we do:
> 
> git grep -l "\<__inline\(\|__\)\>" | while read file
> do
> 	sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
> done
> 
> and get it over with.
> 
> 
> Anyway, with the below patch, I get:
> 
>    text    data     bss     dec     hex filename
> 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux

  17387603        5065468 1953892 24406963        1746bb3 defconfig-build/vmlinux

If I do an additional:

git grep -l "asm volatile" | while read file
do
	sed -i -e 's/asm volatile/asm_volatile/g' $file
done

on the tree...

No changes for:

-#define asm_volatile_goto(x...)        do { asm goto(x); asm (""); } while (0)
+#define asm_volatile_goto(x...)        do { asm __inline__ goto (x); asm (""); } while (0)

I suppose all our goto's are small now (my tree includes Nadav's patch
to static_cpu_has).
