From: Pekka Enberg <penberg@kernel.org>
Subject: Re: sparse-llvm segfaults when passing a struct pointer
Date: Fri, 20 Jul 2012 11:21:18 +0300
Message-ID: <CAOJsxLEuR5mfDr-1RrNXzL7S5stb-79Ez4dx2+7Qbr8fBL+WPg@mail.gmail.com>
References: <20120719131725.GA2836@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42351 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab2GTIVT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Jul 2012 04:21:19 -0400
Received: by obbuo13 with SMTP id uo13so4527316obb.19
        for <linux-sparse@vger.kernel.org>; Fri, 20 Jul 2012 01:21:18 -0700 (PDT)
In-Reply-To: <20120719131725.GA2836@debian.debian>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Christopher Li <sparse@chrisli.org>

Hello Jonathan,

[ Please CC me on sparse-llvm related issues. ]

On Thu, Jul 19, 2012 at 4:17 PM, Jonathan Neusch=E4fer
<j.neuschaefer@gmx.net> wrote:
> compiling a little real-world program with sparse-llvm, it segfaulted=
=2E
> Using a tool called "delta"[1] and some bash scripting, I managed to
> reduce the code to this test case:
>
>     //struct foo {int a;};
>     //struct foo;
>     extern struct foo *foop;
>     extern void func(struct foo *f);
>     int main(int argc, char **argv) {
>         func(foop);
>     }
>
> (Uncommenting the commented lines doesn't change the crashing)
>
> gdb gives me this backtrace:
>
>     (gdb) bt
>     #0  0x080b86c1 in LLVMBuildPtrToInt ()
>     #1  0x080530fd in output_op_load (insn=3D0xb742512c, fn=3D0xbf856=
24c) at sparse-llvm.c:595
>     #2  output_insn (insn=3D0xb742512c, fn=3D0xbf85624c) at sparse-ll=
vm.c:1008
>     #3  output_bb (generation=3D7, fn=3D0xbf85624c, bb=3D<optimized o=
ut>) at sparse-llvm.c:1096
>     #4  output_fn (module=3D0xb7738f0c, module@entry=3D0x8ccc750, ep=3D=
<error reading variable: Unhandled dwarf expression opcode 0xfa>,
>         ep=3D<error reading variable: Unhandled dwarf expression opco=
de 0xfa>) at sparse-llvm.c:1166
>     #5  0x080507ec in compile (list=3D0xb773858c, module=3D0x8ccc750)=
 at sparse-llvm.c:1227
>     #6  main (argc=3D2, argv=3D0xbf856684) at sparse-llvm.c:1246
>
> I'm using llvm version 3.0 (package version 1:3.0-14) from Debian and
> sparse v0.4.4-100-g063236f (the most recent commit in git).

The SIGSEGV is caused by pseudo_to_value() returning NULL for "foop".
AFAICT, we should use LLVMGetNamedGlobal() to look it up but
unfortunately output_data() is *not* called for "foop" at all so the
backend doesn't know about it.

Linus, Jeff, how does the sparse frontend deal with externs? Why isn't
"foop" visible after linearize_symbol()?

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
