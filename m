From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [RFC] evaluate: pointer arithmetics on plain void* (was: [PATCH]
 evaluate: reject post-ops on void*)
Date: Mon, 23 Jan 2012 11:32:33 +0100
Message-ID: <4F1D3741.2030604@seznam.cz>
References: <4F1C9C49.2050707@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep12.mx.upcmail.net ([62.179.121.32]:51674 "EHLO
	fep12.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2AWKcg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 23 Jan 2012 05:32:36 -0500
In-Reply-To: <4F1C9C49.2050707@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>

Hm, I was talking about post-ops only, the example showed a failing pre=
-op
=2E..both is a single case as evaluate_preop boils down to evaluate_pos=
top.

I went through evaluate.c again and I think these cases should be someh=
ow
unified (stating current state):

1. evaluate_postop:
  a. function: error ("bad argument type for ++/--")
  b. void*:    nothing, but buggy evaluation (add/sub -1)

2. evaluate_ptr_add
  a. function: warning ("arithmetics on pointers to functions")
  b. void*:    nothing, sizeof(void) implicitly considered as 1

3. evaluate_sizeof:
  a. function: warning ("expression using sizeof on a function")
  b. void:     warning ("expression using sizeof(void)")
  (c. bool:     warning ("expression using sizeof bool"))

4. evaluate_ptrsizeof:
  - ?


The original patch makes 1b. an equivalent to 1a.  The alternative
is to handle 1b. in a similar way as 2b.  Maybe both would deserve
a warning.

Still, there is at least one inconsistency: 1a. vs 2a. (error vs warnin=
g).

On 01/23/2012 12:31 AM, Jan Pokorn=FD wrote:
> Following example haven't been linearized correctly:
>=20
> 	static void *inc_ptr(void *a) {
> 		return ++a;
> 	}
>=20
> test-linearize:
>=20
> 	<entry-point>
> 	add.32      %r2 <- %arg1, $-1
> 	ret.32      %r2
>=20
> Apparently, something went wrong with -1 value to be added to the ori=
ginal
> pointer.  When void* substituted for int*, the result is as expected
> (considering 32b int):
>=20
> 	<entry-point>
> 	add.32      %r2 <- %arg1, $4
> 	ret.32      %r2
>=20
> The proposed patch turns post-ops on void* operand into an error
> (taking the same route as with function operand).
>=20
> When running check with C=3D2 on my old linux-3.0.6 configuration,
> this detected a few occurencies:
>=20
> 	drivers/scsi/scsi_proc.c:405:31: error: bad argument type for ++/--
> 	drivers/scsi/scsi_proc.c:413:23: error: bad argument type for ++/--
> 	net/bluetooth/hci_core.c:1545:29: error: bad argument type for ++/--
> 	net/bluetooth/l2cap_core.c:1825:37: error: bad argument type for ++/=
--
> 	net/bluetooth/bnep/core.c:239:13: error: bad argument type for ++/--
> 	lib/sort.c:25:27: error: bad argument type for ++/--
> 	lib/sort.c:26:27: error: bad argument type for ++/--
> 	lib/check_signature.c:21:24: error: bad argument type for ++/--
>=20
> All of them seems trivially fixable.
>=20
> Alternatively, I can turn it to emit an warning only (should be
> configurable/default?).  To be noted that GCC will only emit an warni=
ng,
> and only if -pedantic or -Wpointer-arith specified, but I consider
> it rather a convenient exception.
>=20
> When this gets clear, I'll add also the respective test-case.
>=20
> Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
> ---
>  evaluate.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/evaluate.c b/evaluate.c
> index bebe968..b6d706b 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1711,7 +1711,8 @@ static struct symbol *evaluate_postop(struct ex=
pression *expr)
>  		multiply =3D 1;
>  	} else if (class =3D=3D TYPE_PTR) {
>  		struct symbol *target =3D examine_pointer_target(ctype);
> -		if (!is_function(target))
> +		/* beside function, reject also void* (due to sizeof(void)) */
> +		if (target !=3D &void_ctype && !is_function(target))
>  			multiply =3D bits_to_bytes(target->bit_size);
>  	}
> =20

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
