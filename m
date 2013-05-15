From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Wed, 15 May 2013 15:05:52 +0300
Message-ID: <CAOJsxLGizp=f5RziV2fKFR=wGQXWr+nvVZXLWGoeKa23gD_5Fw@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
	<5074BD6B.2090501@pobox.com>
	<CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
	<20121010163306.GA2846@debian.debian>
	<CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
	<CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
	<20121016201426.GD2932@debian.debian>
	<507DC95C.7010106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36172 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383Ab3EOMFx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 May 2013 08:05:53 -0400
Received: by mail-wg0-f54.google.com with SMTP id x12so1457008wgg.33
        for <linux-sparse@vger.kernel.org>; Wed, 15 May 2013 05:05:52 -0700 (PDT)
In-Reply-To: <507DC95C.7010106@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

Hello,

On Tue, Oct 16, 2012 at 11:53 PM, Xi Wang <xi.wang@gmail.com> wrote:
> On 10/16/12 4:14 PM, Jonathan Neusch=E4fer wrote:
>> Actually, the situation of Phi nodes in LLVM is actually slightly mo=
re
>> complex: They require "one pair (of value and BB) for each predecess=
or
>> basic block of the current block"[1]. This mean that we'll sometimes
>> need to insert phi nodes into BBs that don't directly use a value.
>
> I ran into the same problem before.  I would suggest a simpler and sa=
fer
> way: don't emit LLVM phi; instead emit load/store (of some alloca).
>
> phi    =3D> load from some alloca
> phisrc =3D> store to some alloca
>
> You can find sample code from splay here (emit_phi & emit_phisrc):
>
> https://github.com/xiw/splay/blob/master/function.c#L356
>
>> Consider the following piece of C code:
>>
>>       extern int done(void);
>>       extern void foo(int);
>>
>>       static void test(void) {
>>               int i;
>>               for (i =3D 0; ; i++) {
>>                       if (done())
>>                               break;
>>                       foo(i);
>>               }
>>       }
>
> This is what splay emits:
>
> define internal void @test() {
> entry:
>   %0 =3D alloca i32
>   store i32 0, i32* %0
>   br label %bb
>
> bb:                                               ; preds =3D %bb1, %=
entry
>   %1 =3D call i32 @done()
>   %2 =3D icmp ne i32 %1, 0
>   br i1 %2, label %bb2, label %bb1
>
> bb1:                                              ; preds =3D %bb
>   %3 =3D load i32* %0
>   call void @foo(i32 %3)
>   %4 =3D add nsw i32 %3, 1
>   store i32 %4, i32* %0
>   br label %bb
>
> bb2:                                              ; preds =3D %bb
>   ret void
> }
>
> After "-mem2reg" you get:
>
> define internal void @test() {
> entry:
>   br label %bb
>
> bb:                                               ; preds =3D %bb1, %=
entry
>   %.0 =3D phi i32 [ 0, %entry ], [ %2, %bb1 ]
>   %0 =3D call i32 @done()
>   %1 =3D icmp ne i32 %0, 0
>   br i1 %1, label %bb2, label %bb1
>
> bb1:                                              ; preds =3D %bb
>   call void @foo(i32 %.0)
>   %2 =3D add nsw i32 %.0, 1
>   br label %bb
>
> bb2:                                              ; preds =3D %bb
>   ret void
> }

Ping, anyone interested in turning Xi's suggestion into a patch
against current sparse master?

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
