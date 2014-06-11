From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH][RFC] err.h: silence sparse warning: dereference of
 noderef expression
Date: Wed, 11 Jun 2014 09:51:02 -0400
Message-ID: <20140611095102.5bba1200@f20.localdomain>
References: <1402436329-24750-1-git-send-email-jlayton@poochiereds.net>
	<20140611052040.GM5500@mwanda>
	<20140611070632.639e07ce@f20.localdomain>
	<20140611131146.GS5500@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:56665 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbaFKNvH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Jun 2014 09:51:07 -0400
Received: by mail-ie0-f180.google.com with SMTP id rl12so217244iec.11
        for <linux-sparse@vger.kernel.org>; Wed, 11 Jun 2014 06:51:07 -0700 (PDT)
In-Reply-To: <20140611131146.GS5500@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Jeff Layton <jlayton@primarydata.com>

On Wed, 11 Jun 2014 16:11:46 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Wed, Jun 11, 2014 at 07:06:32AM -0400, Jeff Layton wrote:
> > $ rpm -q sparse
> > sparse-0.5.0-1.fc20.x86_64
> >
> > I see it all over the tree, but an easy example is fs/locks.c:
> > 
> > $ make fs/locks.o C=1
> > make[1]: Nothing to be done for `all'.
> > make[1]: Nothing to be done for `relocs'.
> >   CHK     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> >   CHECK   fs/locks.c
> > include/linux/err.h:35:16: warning: dereference of noderef expression
> > include/linux/err.h:30:23: warning: dereference of noderef expression
> > include/linux/err.h:35:16: warning: dereference of noderef expression
> > include/linux/err.h:30:23: warning: dereference of noderef expression
> >   CC      fs/locks.o
> > 
> > It has two IS_ERR calls and two PTR_ERR calls, and each generates the
> > warning.
> >
> 
> I downloaded the Fedora SRPM and built the binary but I still wasn't
> able to reproduce the bug.
> 
> dcarpenter@speke:~/progs/kernel/devel$ /tmp/sparse/sparse-0.5.0/sparse --version
> 0.5.0
> dcarpenter@speke:~/progs/kernel/devel$ make C=2 CHECK=/tmp/sparse/sparse-0.5.0/sparse fs/locks.o
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
> <stdin>:1226:2: warning: #warning syscall finit_module not implemented [-Wcpp]
> <stdin>:1229:2: warning: #warning syscall sched_setattr not implemented [-Wcpp]
> <stdin>:1232:2: warning: #warning syscall sched_getattr not implemented [-Wcpp]
> <stdin>:1235:2: warning: #warning syscall renameat2 not implemented [-Wcpp]
>   CHECK   scripts/mod/empty.c
>   CHECK   fs/locks.c
> dcarpenter@speke:~/progs/kernel/devel$
> 
> I'm on today's linux-next.  I can't think of a kernel configuration
> issue which would cause this...
> 
> regards,
> dan carpenter

Could it be arch-specific then? What arch are you using? I'm on x86_64.
I know that quite a few other people have mentioned seeing these
warnings as well, so I'm pretty sure it's not just me.

-- 
Jeff Layton <jlayton@poochiereds.net>
