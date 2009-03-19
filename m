From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Thu, 19 Mar 2009 14:46:23 +0000
Message-ID: <20090319144622.GA28946@ZenIV.linux.org.uk>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35179 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbZCSOq1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 10:46:27 -0400
Content-Disposition: inline
In-Reply-To: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Thu, Mar 19, 2009 at 02:49:21PM +0100, Hannes Eder wrote:
> running sparse (from Christopher's tree) on linux-2.6/kernel/cred.c
> (as of next-20090318, problem may appeared earlier, I have not tried
> yet) causes a segfault at evaluate.c:341:
> 
>         if (type->type == SYM_NODE)
>                 type = type->ctype.base_type;
>         if (type->type == SYM_TYPEOF) {        <======== SEGFAULT (type == NULL)
>                 type = evaluate_expression(type->initializer);
>                 if (type->type == SYM_NODE)
>                         type = type->ctype.base_type;
>         }
> 
> the complete command line:
> 
> sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
> -Wno-return-void -D__x86_64__ -m64 -nostdinc -isystem
> /usr/lib/gcc/x86_64-redhat-linux/4.3.2/include
> -Wp,-MD,kernel/.cred.o.d -nostdinc -isystem
> /usr/lib/gcc/x86_64-redhat-linux/4.3.2/include -Iinclude
> -I/home/hannes/linux-2.6/arch/x86/include -include
> include/linux/autoconf.h -D__KERNEL__ -Wall -Wundef
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> -Werror-implicit-function-declaration -Os -m64 -mtune=generic
> -mno-red-zone -mcmodel=kernel -funit-at-a-time
> -maccumulate-outgoing-args -fstack-protector -fstack-protector-all
> -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -pipe
> -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx
> -mno-sse2 -mno-3dnow -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -g -pg -Wdeclaration-after-statement
> -Wno-pointer-sign -D"KBUILD_STR(s)=#s"
> -D"KBUILD_BASENAME=KBUILD_STR(cred)"
> -D"KBUILD_MODNAME=KBUILD_STR(cred)" -D"DEBUG_HASH=36"
> -D"DEBUG_HASH2=28" kernel/cred.c
> 
> 
> using "git bisect" i narrowed to problem down to:
> 
> [db31fd91f8231110ce8d8d48ce402f8cad068e44] Fix handling of ident-less
> declarations
> 
> Does that help? Should I provide any further information?

Preprocessed input would help (note that knowing the kernel tree in
question is not enough - .config affects what comes out of preprocessing,
after all).

Just slap -E in command line above and dump the output someplace public...
