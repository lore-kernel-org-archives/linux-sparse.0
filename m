From: Borislav Petkov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Date: Sun, 16 Dec 2018 11:00:42 +0100
Message-ID: <20181216100042.GA815@zn.tnic>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
	<20181213105146.GH5289@hirez.programming.kicks-ass.net>
	<CAK7LNASB=HvU8DwUQQkz_r3sY1DN8Vv-qfNa54-ZDXSpfvEYpg@mail.gmail.com>
	<07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
Reply-To: Borislav Petkov <bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <07BE39B2-1F99-4AE4-97F3-0871A39C5E7D@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Juergen Gross <jgross@suse.com>, Michal Marek <michal.lkml@markovi.net>, Richard Biener <rguenther@suse.de>, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>, Alok Kataria <akataria@vmware.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Dec 16, 2018 at 02:33:39AM +0000, Nadav Amit wrote:
> In general, I think that from the start it was clear that the motivation for
> the patch-set is not just performance and also better code. For example, I
> see no reason to revert the PV-changes or the lock-prefix changes that
> improved the code readability.

One thing that has caught my eye with the asm macros, which actually
decreases readability, is that I can't see the macro properly expanded
when I do

make <filename>.s

For example, I get

#APP
# 164 "./arch/x86/include/asm/cpufeature.h" 1
        STATIC_CPU_HAS bitnum=$8 cap_byte="boot_cpu_data+35(%rip)" feature=123 t_yes=.L75 t_no=.L78 always=117  #, MEM[(const char *)&boot_cpu_data + 35B],,,,
# 0 "" 2
        .loc 11 164 2 view .LVU480
#NO_APP

but I'd like to see the actual asm as it is really helpful when hacking
on inline asm stuff. And I haven't found a way to make gcc expand asm
macros in .s output.

Now, assuming the gcc inline patch will be backported to gcc8, I think
we should be covered on all modern distros going forward. So I think we
should revert at least the more complex macros.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
