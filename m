From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] sparse, llvm: Fix SIGSEGV for extern symbols
Date: Sun, 19 Aug 2012 02:41:14 +0200
Message-ID: <20120819004114.GC2880@debian.debian>
References: <1344196054-17208-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:41944 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751134Ab2HSAlS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Aug 2012 20:41:18 -0400
Content-Disposition: inline
In-Reply-To: <1344196054-17208-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, j.neuschaefer@gmx.net, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 05, 2012 at 10:47:34PM +0300, Pekka Enberg wrote:
> Jonathan Neusch=C3=A4fer writes:
>=20
>   compiling a little real-world program with sparse-llvm, it segfault=
ed.
>   Using a tool called "delta"[1] and some bash scripting, I managed t=
o
>   reduce the code to this test case:
>=20
>     extern struct foo *foop;
>     extern void func(struct foo *f);
>     int main(int argc, char **argv) {
>         func(foop);
>     }
>=20
> The problem is that pseudo_to_value() does not know abou the extern
> symbol because Sparse never calls output_data() on it which registers
> globals with LLVMAddGlobal().
>=20
> As explained by Linus, 'extern' symbols are just names with types. Th=
ey
> don't have any value associated with them, they just have the type an=
d
> the name. Therefore we need to explicitly call LLVMAddGlobal() for
> symbols we have not encountered in pseudo_to_value().
>=20
> Reported by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Jeff Garzik <jgarzik@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Pekka Enberg <penberg@kernel.org>

This fixes the crash, thanks.

Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
