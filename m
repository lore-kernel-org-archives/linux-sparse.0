From: Borislav Petkov <bp@alien8.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 25 Oct 2018 12:24:05 +0200
Message-ID: <20181025102405.GE14020@nazgul.tnic>
References: <20181008073128.GL29268@gate.crashing.org>
 <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
 <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
 <20181010072240.GB103159@gmail.com>
 <20181010080324.GV29268@gate.crashing.org>
 <20181010081906.GA5533@zn.tnic>
 <20181010185432.GB29268@gate.crashing.org>
 <20181010191427.GF5533@zn.tnic>
 <20181013193335.GD31650@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181013193335.GD31650@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>, Ingo Molnar <mingo@kernel.org>, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-sparse@vger.kernel.org

Ping.

This is a good point in time, methinks, where kernel folk on CC here
should have a look at this and speak up whether it is useful for us in
this form.

Frankly, I'm a bit unsure on the aspect of us using this and supporting
old compilers which don't have it and new compilers which do. Because
the old compilers should get to see the now upstreamed assembler macros
and the new compilers will simply inline the "asm volatile inline"
constructs. And how ugly that would become...

I guess we can try this with smaller macros first and keep them all
nicely hidden in header files.

On Sat, Oct 13, 2018 at 09:33:35PM +0200, Borislav Petkov wrote:
> Ok,
> 
> with Segher's help I've been playing with his patch ontop of bleeding
> edge gcc 9 and here are my observations. Please double-check me for
> booboos so that they can be addressed while there's time.
> 
> So here's what I see ontop of 4.19-rc7:
> 
> First marked the alternative asm() as inline and undeffed the "inline"
> keyword. I need to do that because of the funky games we do with
> "inline" redefinitions in include/linux/compiler_types.h.
> 
> And Segher hinted at either doing:
> 
> asm volatile inline(...
> 
> or
> 
> asm volatile __inline__(...
> 
> but both "inline" variants are defined as macros in that file.
> 
> Which means we either need to #undef inline before using it in asm() or
> come up with something cleverer.
> 
> Anyway, did this:
> 
> ---
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 4cd6a3b71824..7c0639087da7 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -165,11 +165,13 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   * For non barrier like inlines please define new variants
>   * without volatile and memory clobber.
>   */
> +
> +#undef inline
>  #define alternative(oldinstr, newinstr, feature)                       \
> -       asm volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
> +       asm volatile inline(ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory")
>  
>  #define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
> -       asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
> +       asm volatile inline(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
>  
>  /*
>   * Alternative inline assembly with input.
> ---
> 
> Build failed at link time with:
> 
> arch/x86/boot/compressed/cmdline.o: In function `native_save_fl':
> cmdline.c:(.text+0x0): multiple definition of `native_save_fl'
> arch/x86/boot/compressed/misc.o:misc.c:(.text+0x1e0): first defined here
> arch/x86/boot/compressed/cmdline.o: In function `native_restore_fl':
> cmdline.c:(.text+0x10): multiple definition of `native_restore_fl'
> arch/x86/boot/compressed/misc.o:misc.c:(.text+0x1f0): first defined here
> arch/x86/boot/compressed/error.o: In function `native_save_fl':
> error.c:(.text+0x0): multiple definition of `native_save_fl'
> 
> which I had to fix with this:
> 
> ---
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 15450a675031..0d772598c37c 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -14,8 +14,7 @@
>   */
>  
>  /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
> -extern inline unsigned long native_save_fl(void);
> -extern inline unsigned long native_save_fl(void)
> +static inline unsigned long native_save_fl(void)
>  {
>         unsigned long flags;
>  
> @@ -33,8 +32,7 @@ ex
> ---
> 
> That "extern inline" declaration looks fishy to me anyway, maybe not really
> needed ? Apparently, gcc < 4.9 complains with -Werror=missing-prototypes...
> 
> Then the build worked and the results look like this:
> 
>    text    data     bss     dec     hex filename
> 17287384        5040656 2019532 24347572        17383b4 vmlinux-before
> 17288020        5040656 2015436 24344112        1737630 vmlinux-2nd-version
> 
> so some inlining must be happening.
> 
> Then I did this:
> 
> ---
> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index 9c5606d88f61..a0170344cf08 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -20,7 +20,7 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
>         /* no memory constraint because it doesn't change any memory gcc knows
>            about */
>         stac();
> -       asm volatile(
> +       asm volatile inline(
>                 "       testq  %[size8],%[size8]\n"
>                 "       jz     4f\n"
>                 "0:     movq $0,(%[dst])\n"
> ---
> 
> to force inlining of a somewhat bigger asm() statement. And yap, more
> got inlined:
> 
>    text    data     bss     dec     hex filename
> 17287384        5040656 2019532 24347572        17383b4 vmlinux-before
> 17288020        5040656 2015436 24344112        1737630 vmlinux-2nd-version
> 17288076        5040656 2015436 24344168        1737668 vmlinux-2nd-version__clear_user
> 
> so more stuff gets inlined.
> 
> Looking at the asm output, it had before:
> 
> ---
> clear_user:
> # ./arch/x86/include/asm/current.h:15:  return this_cpu_read_stable(current_task);
> #APP
> # 15 "./arch/x86/include/asm/current.h" 1
>         movq %gs:current_task,%rax      #, pfo_ret__
> # 0 "" 2
> # arch/x86/lib/usercopy_64.c:51:        if (access_ok(VERIFY_WRITE, to, n))
> #NO_APP
>         movq    2520(%rax), %rdx        # pfo_ret___12->thread.addr_limit.seg, _1
>         movq    %rdi, %rax      # to, tmp93
>         addq    %rsi, %rax      # n, tmp93
>         jc      .L3     #,
> # arch/x86/lib/usercopy_64.c:51:        if (access_ok(VERIFY_WRITE, to, n))
>         cmpq    %rax, %rdx      # tmp93, _1
>         jb      .L3     #,
> # arch/x86/lib/usercopy_64.c:52:                return __clear_user(to, n);
>         jmp     __clear_user    #
> ---
> 
> note the JMP to __clear_user. After marking the asm() in __clear_user() as
> inline, clear_user() inlines __clear_user() directly:
> 
> ---
> clear_user:
> # ./arch/x86/include/asm/current.h:15:  return this_cpu_read_stable(current_task);
> #APP
> # 15 "./arch/x86/include/asm/current.h" 1
>         movq %gs:current_task,%rax      #, pfo_ret__
> # 0 "" 2
> # arch/x86/lib/usercopy_64.c:51:        if (access_ok(VERIFY_WRITE, to, n))
> #NO_APP
>         movq    2520(%rax), %rdx        # pfo_ret___12->thread.addr_limit.seg, _1
>         movq    %rdi, %rax      # to, tmp95
>         addq    %rsi, %rax      # n, tmp95
>         jc      .L8     #,
> # arch/x86/lib/usercopy_64.c:51:        if (access_ok(VERIFY_WRITE, to, n))
>         cmpq    %rax, %rdx      # tmp95, _1
>         jb      .L8     #,
> # ./arch/x86/include/asm/smap.h:58:     alternative("", __stringify(__ASM_STAC), X86_FEATURE_SMAP);
> ...
> 
> this last line is the stac() macro which gets inlined due to the
> alternative() inlined macro above.
> 
> So I guess this all looks like what we wanted.
> 
> And if this lands in gcc9, we would need to do a asm_volatile() macro
> which is defined differently based on the compiler used.
> 
> Thoughts, suggestions, etc are most welcome.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
