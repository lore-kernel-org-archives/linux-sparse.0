From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 5] Adding the NULL pointer checker.
Date: Sat, 27 Jan 2007 00:20:53 -0800
Message-ID: <45BB0B65.7060403@freedesktop.org>
References: <20070117023918.GF962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41EEDC462E39A3E0F388E1D6"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:43679 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbXA0IVH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Jan 2007 03:21:07 -0500
In-Reply-To: <20070117023918.GF962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41EEDC462E39A3E0F388E1D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Somehow I managed to compose and not send these comments; sorry.

Christopher Li wrote:
> This patch add the kmalloc null pointer checking. It also
> try to track the double free as well. It knows a few kmalloc like
> functions and kfree etc.

Overall, this patch looks good, and I really like the idea of doing mallo=
c
checking with Sparse.  I have a few comments, interspersed below.

The main issue, however: I can't seem to get it to generate any warnings.=

I've tried running it on the following program, and it produces nothing:

#include <stdlib.h>
int main(int argc, char *argv[])
{
	int *i =3D malloc(sizeof(int));
	return *i;
}

Shouldn't this program provoke some warnings?  And could you supply some
test code which does provoke warnings?

Also, you need a new warning switch to control each of these two checks.

> The interrupt checking is just a toy. Without cross function checking,
> it is way too many false positive.=20

I don't mind including it in an early stage, defaulting to off.

> --- sparse.orig/checker.h	2007-01-16 11:13:28.000000000 -0800
> +++ sparse/checker.h	2007-01-16 11:57:29.000000000 -0800
> @@ -0,0 +1,108 @@
> +#ifndef _CHECKER_H_
> +#define _CHECKER_H_
> +
> +struct blob {
> +	int len;

size_t len, please.

> +	unsigned char data[0];
> +};
[...]
> --- sparse.orig/expand.c	2007-01-16 11:13:18.000000000 -0800
> +++ sparse/expand.c	2007-01-16 11:13:28.000000000 -0800
> @@ -29,8 +29,8 @@
>  /* Random cost numbers */
>  #define SIDE_EFFECTS 10000	/* The expression has side effects */
>  #define UNSAFE 100		/* The expression may be "infinitely costly" due t=
o exceptions */
> -#define SELECT_COST 20		/* Cut-off for turning a conditional into a se=
lect */
> -#define BRANCH_COST 10		/* Cost of a conditional branch */
> +#define SELECT_COST 0		/* Cut-off for turning a conditional into a sel=
ect */
> +#define BRANCH_COST 0		/* Cost of a conditional branch */

OK, I *think* that won't cause any harm.

> --- sparse.orig/sparse.c	2007-01-16 11:13:18.000000000 -0800
> +++ sparse/sparse.c	2007-01-16 11:13:28.000000000 -0800
>  };
[...]
>  static void check_call_instruction(struct instruction *insn)
>  {
>  	pseudo_t fn =3D insn->func;
> -	struct ident *ident;
> -	static const struct checkfn check_fn[] =3D {
> +	static const struct checkfn *entry, check_fn[] =3D {
>  		{ &memset_ident, check_memset },
>  		{ &memcpy_ident, check_memcpy },
>  		{ &copy_to_user_ident, check_ctu },
>  		{ &copy_from_user_ident, check_cfu },
> +		{ NULL },
>  	};
> -	int i;
> =20
>  	if (fn->type !=3D PSEUDO_SYM)
>  		return;
> -	ident =3D fn->sym->ident;
> -	if (!ident)
> -		return;
> -	for (i =3D 0; i < sizeof(check_fn)/sizeof(struct checkfn) ; i++) {
> -		if (check_fn[i].id !=3D ident)
> -			continue;
> -		check_fn[i].check(insn);
> -		break;
> -	}
> +	entry =3D match_function(check_fn, fn->sym);
> +	if (entry)
> +		entry->check(insn);
>  }

Why this change, to use a NULL-terminated iteration rather than a counted=

iteration?  I don't see the benefit.

> @@ -211,14 +213,19 @@ enum opcode {
> =20
>  	/* Needed to translate SSA back to normal form */
>  	OP_COPY,
> +	OP_LAST,
>  };

Hmmm...

> --- sparse.orig/check-interrupt.c	2007-01-16 11:13:28.000000000 -0800
> +++ sparse/check-interrupt.c	2007-01-16 11:13:28.000000000 -0800
[...]
> +enum {
> +	OP_CLI =3D OP_LAST,
> +	OP_STI,
> +	OP_RESTORE,
> +};

Ouch.  This will break if anything else attempts to extend the opcode lis=
t
in the same way.

Have you considered attempting to express interrupts as another form of
context?  Now that the basic framework for multiple types of context exis=
ts,
perhaps you could treat interrupts as another kind of context?

> +static inline void scan_interrupt_insn(struct entrypoint *ep)
> +{
> +	struct basic_block *bb;
> +	struct instruction *insn;
> +
> +	FOR_EACH_PTR(ep->bbs, bb) {
> +		struct bb_state *bbs =3D bb->state;
> +		FOR_EACH_PTR(bb->insns, insn) {
> +			if (!insn->bb)
> +				continue;
> +			if (insn->opcode =3D=3D OP_RET) {
> +				add_instruction(&bbs->insns, insn);
> +				continue;
> +			}
> +			else if (insn->opcode !=3D OP_ASM)
> +				continue;
> +			if (!strcmp(insn->string, "cli"))
> +				add_instruction(&bbs->insns, checker_instruction(insn, OP_CLI, NUL=
L));
> +			else if (!strcmp(insn->string, "sti"))
> +				add_instruction(&bbs->insns, checker_instruction(insn, OP_STI, NUL=
L));
> +			else if (!strcmp(insn->string, "pushl %0 ; popfl"))
> +				add_instruction(&bbs->insns, checker_instruction(insn, OP_RESTORE,=
 NULL));

Ouch.  x86-specific, and specific to the exact strings from the Linux inl=
ine
assembly.

We really need the metalanguage part of Engler's paper that you reference=
d.
This kind of thing seems reasonable for random scripts written to check
particular problems and interpreted by Sparse, but not for code going int=
o
Sparse itself.

Also, modifying the instructions in bbs seems like it would conflict with=
 the
use of other checkers, due to the enum collision described above.

[...]
> +enum {
> +	OP_DEF_PTR =3D OP_LAST,
> +	OP_USE_PTR,
> +	OP_FREE_PTR
> +};

Same problem as above.

> +static inline void execute_pointer_usage(struct instruction *insn)
> +{
> +	if (reg_state(insn->src) & PTR_NULL)
> +		warning(insn->pos, "funcion %s possible using NULL pointer",
> +			show_ident(insn->bb->ep->name->ident));

s/funcion/function/; s/possible/possibly/.

> +	if (reg_state(insn->src) & PTR_FREE)
> +		warning(insn->pos, "funcion %s possible using pointer after free",
> +			show_ident(insn->bb->ep->name->ident));

Likewise.


> +static inline void execute_pointer_free(struct instruction *insn)
> +{
> +	if (reg_state(insn->src) & PTR_FREE)
> +		warning(insn->pos, "funcion %s possible double free pointer",
> +			show_ident(insn->bb->ep->name->ident));

Likewise.

> +	if (bbs->branch) {
> +		struct instruction *br =3D bbs->branch;
> +		unsigned char orig =3D reg_state(br->cond);
> +		check_bb_cond(br->bb_true, br->cond, orig & ~PTR_NULL);
> +		check_bb_cond(br->bb_false, br->cond, orig & ~PTR_NOTNULL);

*Awesome*.

Something like this might work for conditional locking primitives, too.

> +void init_check_null_ptr(void)
> +{
> +	static const char *malloc_name[] =3D {
> +		"malloc",
> +		"__kmalloc",
> +		"__kmalloc_node",
> +		"__kzalloc",
> +		"kmem_cache_alloc",
> +		"kmem_cache_zalloc",
> +		"kmem_cache_alloc_node",
> +		"vmalloc",
> +		"vmalloc_user",
> +		"vmalloc_node",
> +		"vmalloc_32",
> +		"vmalloc_32_user",
> +		"__vmalloc",
> +		NULL,
> +	};
> +	static const char *free_name[] =3D {
> +		"free",
> +		"kfree",
> +		"kmem_cache_free",
> +		"vfree",
> +		NULL,
> +	};

Idea for future work (not for this patch): we might want to make sure tha=
t
memory allocated with a given malloc gets freed with a given free.

> +	static const char *noret[] =3D {
> +		"panic",
> +		NULL,
> +	};

We already have __attribute__((noreturn)); please use that rather than
matching against a list here.

- Josh Triplett


--------------enig41EEDC462E39A3E0F388E1D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuwttGJuZRtD+evsRAgZsAJ48qwJoImhRVVlRqb1OXyGhUGfQAwCfQwaQ
eUSEJMC7+vFrQ3q1qzR4XrM=
=70hJ
-----END PGP SIGNATURE-----

--------------enig41EEDC462E39A3E0F388E1D6--
