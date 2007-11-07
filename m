From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: assertion when running sparse on current linux.git
Date: Wed, 7 Nov 2007 12:25:01 -0800
Message-ID: <70318cbf0711071225v5357edd5hebb2b7eeacfcc524@mail.gmail.com>
References: <20071107175847.GA19586@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:16808 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbXKGUZB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Nov 2007 15:25:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2152418rvb
        for <linux-sparse@vger.kernel.org>; Wed, 07 Nov 2007 12:25:01 -0800 (PST)
In-Reply-To: <20071107175847.GA19586@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

Looks like the local label problem which is already fixed in tip of sparse git.

Have you try the sparse git tree?

Chris

On Nov 7, 2007 9:58 AM, Dave Jones <davej@redhat.com> wrote:
> $ make kernel/sched.o C=1
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHECK   kernel/sched.c
> kernel/sched_idletask.c:69:26: warning: symbol 'idle_sched_class' was not declared. Should it be static?
> kernel/sched_rt.c:239:26: warning: symbol 'rt_sched_class' was not declared. Should it be static?
> kernel/sched.c:1885:17: warning: symbol 'schedule_tail' was not declared. Should it be static?
> kernel/sched.c:3616:15: warning: incorrect type in assignment (different signedness)
> kernel/sched.c:3616:15:    expected long *switch_count
> kernel/sched.c:3616:15:    got unsigned long *<noident>
> kernel/sched.c:3638:16: warning: incorrect type in assignment (different signedness)
> kernel/sched.c:3638:16:    expected long *switch_count
> kernel/sched.c:3638:16:    got unsigned long *<noident>
> kernel/sched.c:5624:12: warning: symbol 'migration_init' was not declared. Should it be static?
> kernel/sched.c:5841:25: error: cannot size expression
> sparse: flow.c:805: rewrite_parent_branch: Assertion `changed' failed.
> /bin/sh: line 1: 19800 Aborted                 sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -D__x86_64__ -m64 -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.1.2/include -Wp,-MD,kernel/.sched.o.d -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/4.1.2/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -mtune=generic -m64 -mno-red-zone -mcmodel=kernel -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -fstack-protector -fomit-frame-pointer -g -fno-stack-protector -Wdeclaration-after-stateme
 nt -Wno-pointer-sign -fno-omit-frame-pointer -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(sched)" -D"KBUILD_MODNAME=KBUILD_STR(sched)" kernel/sched.c
> make[1]: *** [kernel/sched.o] Error 134
> make: *** [kernel/sched.o] Error 2
>
>
>
>         Dave
>
> --
> http://www.codemonkey.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
