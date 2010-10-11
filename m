From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: including sparse headers in C++ code
Date: Mon, 11 Oct 2010 16:37:07 -0700
Message-ID: <20101011233706.GA10991@feather>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
 <20101009205930.GA4684@feather>
 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
 <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42288 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab0JKXhP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 19:37:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tue, Oct 12, 2010 at 12:33:32AM +0200, Tomas Klacko wrote:
> On Sat, Oct 9, 2010 at 11:46 PM, Christopher Li <sparse@chrisli.org> =
wrote:
> > On Sat, Oct 9, 2010 at 1:59 PM, Josh Triplett <josh@joshtriplett.or=
g> wrote:
> >> It seems reasonable to avoid the use of C++ keywords in Sparse *he=
aders*
> >> (though unnecessary in *source*). =C2=A0Looks like this will prima=
rily cause
> >> pain due to "enum namespace" and the various places using it. =C2=A0=
Seems
> >> easy enough to change those all to "ns". =C2=A0"new" mostly seems =
to get used
> >> as a parameter name or local variable name; for the former we coul=
d omit
> >> it, and for the latter we could trivially call it something more
> >> specific like "newlist" or "newptr".
> >>
> >> So, I'd tend to guess "patches welcome" (again, for headers only, =
plus
> >> minimal corresponding source changes when required). =C2=A0I would=
n't
> >> anticipate other Sparse developers objecting strongly, but if they=
 do
> >> your mail seems like the right way to find out. =C2=A0The various =
reasons
> >> given for *not* making the Linux kernel headers compatible don't s=
eem to
> >> apply here, though.
> >
> > Well said. I don't expect sparse to compile in the C++ mode. Making
> > sparse header usable in C++ seems reasonable to me.
>=20
> Great. I am posting my current status (as a patch) so that you can co=
mment on it
> and that I can refine it further.

> --- a/c2xml.c
> +++ b/c2xml.c
> @@ -128,7 +128,7 @@ static void examine_modifiers(struct symbol *sym,
> xmlNodePtr node)
>=20
>  	int i;
>=20
> -	if (sym->namespace !=3D NS_SYMBOL)
> +	if (sym->Namespace !=3D NS_SYMBOL)

How about "ns"?

> --- a/compile-i386.c
> +++ b/compile-i386.c
> @@ -332,9 +332,9 @@ busy:
>  	return 1;
>  }
>=20
> -static struct storage *get_reg(struct regclass *class)
> +static struct storage *get_reg(struct regclass *Class)

Just call it "regclass".

> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -357,7 +357,7 @@ static inline int classify_type(struct symbol
> *type, struct symbol **base)
>  	return type_class[type->type];
>  }
>=20
> -#define is_int(class) ((class & (TYPE_NUM | TYPE_FLOAT)) =3D=3D TYPE=
_NUM)
> +#define is_int(Class) ((Class & (TYPE_NUM | TYPE_FLOAT)) =3D=3D TYPE=
_NUM)

"c" or "cls"?

> --- a/expression.c
> +++ b/expression.c
> @@ -118,7 +118,7 @@ static struct token *parse_type(struct token
> *token, struct expression **tree)
>  	struct symbol *sym;
>  	*tree =3D alloc_expression(token->pos, EXPR_TYPE);
>  	(*tree)->flags =3D Int_const_expr; /* sic */
> -	token =3D typename(token, &sym, NULL);
> +	token =3D Typename(token, &sym, NULL);

"type_name"?

> --- a/lib.h
> +++ b/lib.h
> @@ -120,6 +120,10 @@ extern int Wdeclarationafterstatement;
>  extern int dbg_entry;
>  extern int dbg_dead;
>=20
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +

> @@ -162,33 +170,41 @@ static inline void free_instruction_list(struct
> instruction_list **head)
>  	free_ptr_list((struct ptr_list **)head);
>  }
>=20
> -static inline struct instruction * delete_last_instruction(struct
> instruction_list **head)
> +static inline struct instruction * delete_last_instruction(
> +        struct instruction_list **head)

Huh?  I don't see a change here, just formatting (and what looks like
whitespace damage).

>  {
> -	return undo_ptr_list_last((struct ptr_list **)head);
> +	return (struct instruction *)undo_ptr_list_last(
> +                (struct ptr_list **)head);
>  }

Wow.  I had to double-check this because I couldn't quite believe C++
had that degree of dain bramage, but sure enough:

/tmp$ cat test.c
extern void *pv(void);

int *pi(void)
{
    return pv();
}
/tmp$ gcc -c test.c -o /dev/null
/tmp$ g++ -c test.c -o /dev/null
test.c: In function =E2=80=98int* pi()=E2=80=99:
test.c:5: error: invalid conversion from =E2=80=98void*=E2=80=99 to =E2=
=80=98int*=E2=80=99
(1) /tmp$


I can understand C++ having stronger typechecking, but void pointers
*exist* for this purpose.  *Really* debatable whether Sparse should wor=
k
around this.  Avoiding keywords, sure, but casting void pointers
everywhere?  People *remove* these kinds of casts from C programs as a
cleanup.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
