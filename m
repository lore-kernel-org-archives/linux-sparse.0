From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 17:29:37 -0700
Message-ID: <1214612977.25532.14.camel@josh-work.beaverton.ibm.com>
References: <486428D7.8080603@cowlark.com>
	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>
	 <4864C710.8000208@cowlark.com>	 <1214565644.20755.80.camel@tara.firmix.at>
	 <4864F31C.3090606@cowlark.com>	 <1214577926.20755.98.camel@tara.firmix.at>
	 <48650B35.5040505@cowlark.com>
	 <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com>
	 <486578A9.7000900@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:42910 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbYF1A3l (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 20:29:41 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5S0TeXb007185
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 20:29:40 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5S0Tdwe172832
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 18:29:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5S0TcF4005619
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 18:29:39 -0600
In-Reply-To: <486578A9.7000900@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Sat, 2008-06-28 at 00:32 +0100, David Given wrote:
> diff --git a/compile-i386.c b/compile-i386.c
> index 8526408..3bbc9c7 100644
> --- a/compile-i386.c
> +++ b/compile-i386.c
> @@ -1584,7 +1584,7 @@ static struct storage *emit_select_expr(struct
> expression *expr)
>  	/*
>  	 * Do the actual select: check the conditional for zero,
>  	 * move false over true if zero
> -	 */=20
> +	 */

Don't include whitespace changes in unrelated patches.  You have many
whitespace changes in this patch; I haven't commented on all of them.

> @@ -2040,7 +2040,7 @@ static struct symbol *evaluate_sizeof(struct
> expression *expr)
>  	if ((size < 0) || (size & 7))
>  		expression_error(expr, "cannot size expression");

This "size & 7" represents an assumption about bits_in_char as well; it
checks if the size represents an integral number of chars.  You'll need
to look for other instances of 7 as well, to catch cases like this.

> @@ -2074,7 +2074,7 @@ static struct symbol *evaluate_ptrsizeof(struct
> expression *expr)
>  	if (size & 7)
>  		size =3D 0;

Same problem here.

>  	 * storage for it..
>  	 */
>  	hash =3D find_storage_hash(pseudo, state->outputs);
> @@ -1829,8 +1829,8 @@ static void set_up_arch_entry(struct entrypoint
> *ep, struct instruction *entry)
> =20
>  			in->type =3D REG_FRAME;
>  			in->offset =3D offset;
> -		=09
> -			offset +=3D bits >> 3;
> +
> +			offset +=3D bits / bits_in_char;

=EF=BB=BF=EF=BB=BF=EF=BB=BFThe first line represents a whitespace-only =
change.

> --- a/target.c
> +++ b/target.c
> @@ -11,6 +11,8 @@ struct symbol *ssize_t_ctype =3D &int_ctype;
>   */
>  int max_alignment =3D 16;
> =20
> +int bits_in_unit =3D 8;
> +

Unused.

> @@ -483,7 +483,7 @@ static int escapechar(int first, int type,
> stream_t *stream, int *valp)
>  				int nr =3D 2;
>  				value -=3D '0';
>  				while (next >=3D '0' && next <=3D '9') {
> -					value =3D (value << 3) + (next-'0');
> +					value =3D (value*8) + (next-'0');

This does not relate to bits_per_char, and should not change.

- Josh Triplett


--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
