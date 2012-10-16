From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each
 BB
Date: Tue, 16 Oct 2012 16:53:48 -0400
Message-ID: <507DC95C.7010106@gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net> <5074BD6B.2090501@pobox.com> <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com> <20121010163306.GA2846@debian.debian> <CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com> <CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com> <20121016201426.GD2932@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49683 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab2JPUxq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Oct 2012 16:53:46 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1456491qcr.19
        for <linux-sparse@vger.kernel.org>; Tue, 16 Oct 2012 13:53:46 -0700 (PDT)
In-Reply-To: <20121016201426.GD2932@debian.debian>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 10/16/12 4:14 PM, Jonathan Neusch=C3=A4fer wrote:
> Actually, the situation of Phi nodes in LLVM is actually slightly mor=
e
> complex: They require "one pair (of value and BB) for each predecesso=
r
> basic block of the current block"[1]. This mean that we'll sometimes
> need to insert phi nodes into BBs that don't directly use a value.

I ran into the same problem before.  I would suggest a simpler and safe=
r
way: don't emit LLVM phi; instead emit load/store (of some alloca).

phi    =3D> load from some alloca
phisrc =3D> store to some alloca

You can find sample code from splay here (emit_phi & emit_phisrc):

https://github.com/xiw/splay/blob/master/function.c#L356

> Consider the following piece of C code:
>=20
> 	extern int done(void);
> 	extern void foo(int);
>=20
> 	static void test(void) {
> 		int i;
> 		for (i =3D 0; ; i++) {
> 			if (done())
> 				break;
> 			foo(i);
> 		}
> 	}

This is what splay emits:

define internal void @test() {
entry:
  %0 =3D alloca i32
  store i32 0, i32* %0
  br label %bb

bb:                                               ; preds =3D %bb1, %en=
try
  %1 =3D call i32 @done()
  %2 =3D icmp ne i32 %1, 0
  br i1 %2, label %bb2, label %bb1

bb1:                                              ; preds =3D %bb
  %3 =3D load i32* %0
  call void @foo(i32 %3)
  %4 =3D add nsw i32 %3, 1
  store i32 %4, i32* %0
  br label %bb

bb2:                                              ; preds =3D %bb
  ret void
}

After "-mem2reg" you get:

define internal void @test() {
entry:
  br label %bb

bb:                                               ; preds =3D %bb1, %en=
try
  %.0 =3D phi i32 [ 0, %entry ], [ %2, %bb1 ]
  %0 =3D call i32 @done()
  %1 =3D icmp ne i32 %0, 0
  br i1 %1, label %bb2, label %bb1

bb1:                                              ; preds =3D %bb
  call void @foo(i32 %.0)
  %2 =3D add nsw i32 %.0, 1
  br label %bb

bb2:                                              ; preds =3D %bb
  ret void
}

- xi
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
