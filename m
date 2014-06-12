From: Vitaly Osipov <vitaly.osipov@gmail.com>
Subject: Re: [PATCH][RFC] err.h: silence sparse warning: dereference of
 noderef expression
Date: Thu, 12 Jun 2014 18:06:25 +1000
Message-ID: <CAH42NiXUE70oVnZJNhkvgKT5FSfnMVOBEWau84E9YAbufBDHMw@mail.gmail.com>
References: <1402436329-24750-1-git-send-email-jlayton@poochiereds.net>
 <20140611052040.GM5500@mwanda> <20140611070632.639e07ce@f20.localdomain>
 <20140611131146.GS5500@mwanda> <20140611095102.5bba1200@f20.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:41883 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbaFLIHH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 Jun 2014 04:07:07 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so192101lab.24
        for <linux-sparse@vger.kernel.org>; Thu, 12 Jun 2014 01:07:05 -0700 (PDT)
In-Reply-To: <20140611095102.5bba1200@f20.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-sparse@vger.kernel.org, Jeff Layton <jlayton@primarydata.com>

Nothing shows up for me on x86_64, allmodconfig, linux-next from 10 of
June. My sparse has been compiled from sources.

$ make fs/locks.o C=3D2 CHECK=3D"/home/vosipov/bin/sparse"
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHECK   scripts/mod/empty.c
  CHECK   fs/locks.c

$ sparse =E2=80=94version
v0.5.0

$ which sparse
/home/vosipov/bin/sparse

Regards,
Vitaly


On Wed, Jun 11, 2014 at 11:51 PM, Jeff Layton <jlayton@poochiereds.net>=
 wrote:
> On Wed, 11 Jun 2014 16:11:46 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
>> On Wed, Jun 11, 2014 at 07:06:32AM -0400, Jeff Layton wrote:
>> > $ rpm -q sparse
>> > sparse-0.5.0-1.fc20.x86_64
>> >
>> > I see it all over the tree, but an easy example is fs/locks.c:
>> >
>> > $ make fs/locks.o C=3D1
>> > make[1]: Nothing to be done for `all'.
>> > make[1]: Nothing to be done for `relocs'.
>> >   CHK     include/config/kernel.release
>> >   CHK     include/generated/uapi/linux/version.h
>> >   CHK     include/generated/utsrelease.h
>> >   CALL    scripts/checksyscalls.sh
>> >   CHECK   fs/locks.c
>> > include/linux/err.h:35:16: warning: dereference of noderef express=
ion
>> > include/linux/err.h:30:23: warning: dereference of noderef express=
ion
>> > include/linux/err.h:35:16: warning: dereference of noderef express=
ion
>> > include/linux/err.h:30:23: warning: dereference of noderef express=
ion
>> >   CC      fs/locks.o
>> >
>> > It has two IS_ERR calls and two PTR_ERR calls, and each generates =
the
>> > warning.
>> >
>>
>> I downloaded the Fedora SRPM and built the binary but I still wasn't
>> able to reproduce the bug.
>>
>> dcarpenter@speke:~/progs/kernel/devel$ /tmp/sparse/sparse-0.5.0/spar=
se --version
>> 0.5.0
>> dcarpenter@speke:~/progs/kernel/devel$ make C=3D2 CHECK=3D/tmp/spars=
e/sparse-0.5.0/sparse fs/locks.o
>>   CHK     include/config/kernel.release
>>   CHK     include/generated/uapi/linux/version.h
>>   CHK     include/generated/utsrelease.h
>>   CALL    scripts/checksyscalls.sh
>> <stdin>:1226:2: warning: #warning syscall finit_module not implement=
ed [-Wcpp]
>> <stdin>:1229:2: warning: #warning syscall sched_setattr not implemen=
ted [-Wcpp]
>> <stdin>:1232:2: warning: #warning syscall sched_getattr not implemen=
ted [-Wcpp]
>> <stdin>:1235:2: warning: #warning syscall renameat2 not implemented =
[-Wcpp]
>>   CHECK   scripts/mod/empty.c
>>   CHECK   fs/locks.c
>> dcarpenter@speke:~/progs/kernel/devel$
>>
>> I'm on today's linux-next.  I can't think of a kernel configuration
>> issue which would cause this...
>>
>> regards,
>> dan carpenter
>
> Could it be arch-specific then? What arch are you using? I'm on x86_6=
4.
> I know that quite a few other people have mentioned seeing these
> warnings as well, so I'm pretty sure it's not just me.
>
> --
> Jeff Layton <jlayton@poochiereds.net>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
