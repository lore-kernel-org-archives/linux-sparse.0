From: Vitaly Osipov <vitaly.osipov@gmail.com>
Subject: Re: [PATCH][RFC] err.h: silence sparse warning: dereference of noderef expression
Date: Sun, 15 Jun 2014 00:05:22 +1000
Message-ID: <C8A16F18-29FD-48E3-9744-D2119A6CF384@gmail.com>
References: <1402436329-24750-1-git-send-email-jlayton@poochiereds.net> <20140611052040.GM5500@mwanda> <20140611070632.639e07ce@f20.localdomain> <20140611131146.GS5500@mwanda> <20140611095102.5bba1200@f20.localdomain> <CAH42NiXUE70oVnZJNhkvgKT5FSfnMVOBEWau84E9YAbufBDHMw@mail.gmail.com> <20140613080537.75635d81@f20.localdomain> <20140613155650.GA13426@thin> <20140614094443.4554cf96@tlielax.poochiereds.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:63803 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678AbaFNOFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Jun 2014 10:05:30 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so2979276pdi.23
        for <linux-sparse@vger.kernel.org>; Sat, 14 Jun 2014 07:05:30 -0700 (PDT)
In-Reply-To: <20140614094443.4554cf96@tlielax.poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Josh Triplett <josh@joshtriplett.org>, Dan Carpenter <dan.carpenter@oracle.com>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Jeff Layton <jlayton@primarydata.com>

Which GCC? I built sparse on Ubuntu with 4.8 and -fpic - still nothing.=
 This must be Fedora specific somehow.=20


Regards,

Vitaly=20

> On 14 Jun 2014, at 11:44 pm, Jeff Layton <jlayton@poochiereds.net> wr=
ote:
>=20
> On Fri, 13 Jun 2014 08:56:50 -0700
> Josh Triplett <josh@joshtriplett.org> wrote:
>=20
>>> On Fri, Jun 13, 2014 at 08:05:37AM -0400, Jeff Layton wrote:
>>> On Thu, 12 Jun 2014 18:06:25 +1000
>>> Vitaly Osipov <vitaly.osipov@gmail.com> wrote:
>>>=20
>>>> Nothing shows up for me on x86_64, allmodconfig, linux-next from 1=
0 of
>>>> June. My sparse has been compiled from sources.
>>>>=20
>>>> $ make fs/locks.o C=3D2 CHECK=3D"/home/vosipov/bin/sparse"
>>>>  CHK     include/config/kernel.release
>>>>  CHK     include/generated/uapi/linux/version.h
>>>>  CHK     include/generated/utsrelease.h
>>>>  CALL    scripts/checksyscalls.sh
>>>>  CHECK   scripts/mod/empty.c
>>>>  CHECK   fs/locks.c
>>>>=20
>>>> $ sparse =97version
>>>> v0.5.0
>>>>=20
>>>> $ which sparse
>>>> /home/vosipov/bin/sparse
>>>>=20
>>>> Regards,
>>>> Vitaly
>>>>=20
>>>>=20
>>>>> On Wed, Jun 11, 2014 at 11:51 PM, Jeff Layton <jlayton@poochiered=
s.net> wrote:
>>>>> On Wed, 11 Jun 2014 16:11:46 +0300
>>>>> Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>>>=20
>>>>>>> On Wed, Jun 11, 2014 at 07:06:32AM -0400, Jeff Layton wrote:
>>>>>>> $ rpm -q sparse
>>>>>>> sparse-0.5.0-1.fc20.x86_64
>>>>>>>=20
>>>>>>> I see it all over the tree, but an easy example is fs/locks.c:
>>>>>>>=20
>>>>>>> $ make fs/locks.o C=3D1
>>>>>>> make[1]: Nothing to be done for `all'.
>>>>>>> make[1]: Nothing to be done for `relocs'.
>>>>>>>  CHK     include/config/kernel.release
>>>>>>>  CHK     include/generated/uapi/linux/version.h
>>>>>>>  CHK     include/generated/utsrelease.h
>>>>>>>  CALL    scripts/checksyscalls.sh
>>>>>>>  CHECK   fs/locks.c
>>>>>>> include/linux/err.h:35:16: warning: dereference of noderef expr=
ession
>>>>>>> include/linux/err.h:30:23: warning: dereference of noderef expr=
ession
>>>>>>> include/linux/err.h:35:16: warning: dereference of noderef expr=
ession
>>>>>>> include/linux/err.h:30:23: warning: dereference of noderef expr=
ession
>>>>>>>  CC      fs/locks.o
>>>>>>>=20
>>>>>>> It has two IS_ERR calls and two PTR_ERR calls, and each generat=
es the
>>>>>>> warning.
>>>>>>=20
>>>>>> I downloaded the Fedora SRPM and built the binary but I still wa=
sn't
>>>>>> able to reproduce the bug.
>>>>>>=20
>>>>>> dcarpenter@speke:~/progs/kernel/devel$ /tmp/sparse/sparse-0.5.0/=
sparse --version
>>>>>> 0.5.0
>>>>>> dcarpenter@speke:~/progs/kernel/devel$ make C=3D2 CHECK=3D/tmp/s=
parse/sparse-0.5.0/sparse fs/locks.o
>>>>>>  CHK     include/config/kernel.release
>>>>>>  CHK     include/generated/uapi/linux/version.h
>>>>>>  CHK     include/generated/utsrelease.h
>>>>>>  CALL    scripts/checksyscalls.sh
>>>>>> <stdin>:1226:2: warning: #warning syscall finit_module not imple=
mented [-Wcpp]
>>>>>> <stdin>:1229:2: warning: #warning syscall sched_setattr not impl=
emented [-Wcpp]
>>>>>> <stdin>:1232:2: warning: #warning syscall sched_getattr not impl=
emented [-Wcpp]
>>>>>> <stdin>:1235:2: warning: #warning syscall renameat2 not implemen=
ted [-Wcpp]
>>>>>>  CHECK   scripts/mod/empty.c
>>>>>>  CHECK   fs/locks.c
>>>>>> dcarpenter@speke:~/progs/kernel/devel$
>>>>>>=20
>>>>>> I'm on today's linux-next.  I can't think of a kernel configurat=
ion
>>>>>> issue which would cause this...
>>>>>>=20
>>>>>> regards,
>>>>>> dan carpenter
>>>>>=20
>>>>> Could it be arch-specific then? What arch are you using? I'm on x=
86_64.
>>>>> I know that quite a few other people have mentioned seeing these
>>>>> warnings as well, so I'm pretty sure it's not just me.
>>>=20
>>> Ha! It turns out that my hand-built sparse also works fine, so the
>>> problem seems to be in the Fedora package.
>>>=20
>>> With a little trial-and-error, I figured out what's causing the
>>> problem, but I'm a little baffled as to why it's occurring.=20
>>>=20
>>> The Fedora SRPM builds the program with -fpic. When I remove that f=
lag,
>>> this problem goes away. I'd appreciate any insight into why that wo=
uld
>>> break things. I doubt PIC really makes much difference security-wis=
e in
>>> sparse, so removing it shouldn't matter much, but I wonder if this
>>> indicates an underlying bug in sparse itself?
>>=20
>> Wow, that's horrifying.  I wonder if it might indicate a miscompilat=
ion
>> by GCC.  Does the problem persist if you build with -fpic -g?  If so=
,
>> you could set a few breakpoints and try to determine at what point t=
he
>> behavior of the two sparse binaries diverges.
>=20
> Yeah, this is a bit disturbing. Fedora already builds with -g, so yes=
,
> the problem does persist. I made a very small, simple C file that jus=
t
> calls IS_ERR to test with.
>=20
> Broken sparse (built with -fpic):
>=20
> Breakpoint 1, expand_dereference (expr=3D0x7ffff6f12210) at expand.c:=
629
> 629        if (expr->ctype->ctype.modifiers & MOD_NODEREF)
> (gdb) p expr->ctype->ctype.modifiers
> $3 =3D 0x65686374616d6e75
>=20
> Built w/o -fpic at the same breakpoint:
>=20
> Breakpoint 1, expand_dereference (expr=3D0x7ffff5e61bd0) at expand.c:=
629
> 629        if (expr->ctype->ctype.modifiers & MOD_NODEREF)
> (gdb) p expr->ctype->ctype.modifiers
> $2 =3D 0x0
>=20
> The stack at that point is:
>=20
> (gdb) bt
> #0  expand_dereference (expr=3D0x7ffff5e61bd0) at expand.c:629
> #1  expand_preop (expr=3D0x7ffff5e61bd0) at expand.c:736
> #2  expand_expression (expr=3Dexpr@entry=3D0x7ffff5e61bd0) at expand.=
c:984
> #3  0x000000000041217a in expand_cast (expr=3D0x7ffff5e61c50) at expa=
nd.c:777
> #4  expand_expression (expr=3Dexpr@entry=3D0x7ffff5e61c50) at expand.=
c:992
> #5  0x00000000004123e2 in expand_compare (expr=3D0x7ffff5e61cd0) at e=
xpand.c:514
> #6  expand_expression (expr=3D<optimized out>) at expand.c:978
> #7  0x00000000004127ba in expand_preop (expr=3D0x7ffff5e61d10) at exp=
and.c:752
> #8  expand_expression (expr=3D<optimized out>) at expand.c:984
> #9  0x00000000004127ba in expand_preop (expr=3D0x7ffff5e61d50) at exp=
and.c:752
> #10 expand_expression (expr=3D<optimized out>) at expand.c:984
> #11 0x0000000000412364 in expand_arguments (head=3D0x7ffff5e39810) at=
 expand.c:767
> #12 expand_call (expr=3D0x7ffff5e61b90) at expand.c:832
> #13 expand_expression (expr=3Dexpr@entry=3D0x7ffff5e61b90) at expand.=
c:995
> #14 0x000000000041217a in expand_cast (expr=3D0x7ffff5e61e10) at expa=
nd.c:777
> #15 expand_expression (expr=3D<optimized out>) at expand.c:992
> #16 0x0000000000411c75 in expand_statement (stmt=3Dstmt@entry=3D0x7ff=
ff5fe3920) at expand.c:1202
> #17 0x0000000000411e13 in expand_compound (stmt=3D0x7ffff5fe38d0) at =
expand.c:1133
> #18 expand_statement (stmt=3Dstmt@entry=3D0x7ffff5fe38d0) at expand.c=
:1164
> #19 0x00000000004124ec in expand_expression (expr=3D<optimized out>) =
at expand.c:1007
> #20 0x0000000000411dad in expand_statement (stmt=3Dstmt@entry=3D0x7ff=
ff5fe3880) at expand.c:1161
> #21 0x0000000000411e13 in expand_compound (stmt=3D0x7ffff5fe3830) at =
expand.c:1133
> #22 expand_statement (stmt=3D0x7ffff5fe3830) at expand.c:1164
> #23 0x0000000000411c21 in expand_symbol (sym=3Dsym@entry=3D0x7ffff5e3=
12d0) at expand.c:1068
> #24 0x0000000000401675 in check_symbols (list=3D0x7ffff6a63610) at sp=
arse.c:281
> #25 0x0000000000401208 in main (argc=3D<optimized out>, argv=3D<optim=
ized out>) at sparse.c:300
>=20
> ...so something is corrupting the modifiers field at least and maybe
> the whole ctype itself? I don't know the sparse code that well, so I'=
ll
> need to do some more digging to determine the root cause.
>=20
> --=20
> Jeff Layton <jlayton@poochiereds.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
