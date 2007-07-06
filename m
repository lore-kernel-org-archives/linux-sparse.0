From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 5/9] x86_64: arch_pick_mmap_layout() fixlet
Date: Fri, 6 Jul 2007 10:21:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707061010060.21374@woody.linux-foundation.org>
References: <200707060939.l669drk2019988@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41738 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754170AbXGFRXY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 13:23:24 -0400
In-Reply-To: <200707060939.l669drk2019988@imap1.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: akpm@linux-foundation.org, Josh Triplett <josh@freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org
Cc: adobriyan@sw.ru, ak@suse.de


This would be a sparse bug, I think.

Returning a void-valued expression in a void-valued function is 
proper C99 (and gcc has allowed it for longer). And it often makes for 
nicer-looking code, with no real downsides.

This seems to be a new bug introduced by Al Viro in sparse: -Wall should 
_not_ enable -Wreturn-void, I think (and I don't think Al meant it to: his 
commit message says "Conditional on -Wreturn-void", and he probably didn't 
think about the fact that -Wall will force them all on.

Josh, Al and sparse mailing list added to participants list, and patch 
dropped. I think -Wreturn-void is fine, but it just shouldn't be part of 
-Wall, and thus shouldn't trigger for the kernl.

		Linus

On Fri, 6 Jul 2007, akpm@linux-foundation.org wrote:
>
> From: Alexey Dobriyan <adobriyan@sw.ru>
> 
> sparse now warns about
> arch/x86_64/mm/mmap.c:15:3: warning: returning void-valued expression
> 
> Generated code looks correct: there is jump to the end of
> arch_pick_mmap_layout() after ia32_pick_mmap_layout(), but this should be
> fixed regardless.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@sw.ru>
> Cc: Andi Kleen <ak@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
>  arch/x86_64/mm/mmap.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86_64/mm/mmap.c~x86_64-arch_pick_mmap_layout-fixlet arch/x86_64/mm/mmap.c
> --- a/arch/x86_64/mm/mmap.c~x86_64-arch_pick_mmap_layout-fixlet
> +++ a/arch/x86_64/mm/mmap.c
> @@ -11,8 +11,10 @@
>  void arch_pick_mmap_layout(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_IA32_EMULATION
> -	if (current_thread_info()->flags & _TIF_IA32)
> -		return ia32_pick_mmap_layout(mm);
> +	if (current_thread_info()->flags & _TIF_IA32) {
> +		ia32_pick_mmap_layout(mm);
> +		return;
> +	}
>  #endif
>  	mm->mmap_base = TASK_UNMAPPED_BASE;
>  	if (current->flags & PF_RANDOMIZE) {
> _
> 
