From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1] Adding debug option for showing the linearized instruction.
Date: Thu, 22 Feb 2007 20:28:25 -0800
Message-ID: <45DE6D69.1050705@freedesktop.org>
References: <20070210001332.GA20604@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig28DCA2287DB135DEAAFFE913"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.6] ([69.17.117.6]:43878 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750860AbXBWE3R (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 23:29:17 -0500
In-Reply-To: <20070210001332.GA20604@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28DCA2287DB135DEAAFFE913
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Looks reasonable; debug information does seem like a logical extension of=
 verbosity.

Could I get a signoff, please?

- Josh Triplett

Christopher Li wrote:
> Index: sparse/lib.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- sparse.orig/lib.c	2007-02-02 16:57:04.000000000 -0800
> +++ sparse/lib.c	2007-02-02 17:06:51.000000000 -0800
> @@ -190,6 +190,9 @@ int Waddress_space =3D 1;
>  int Wenum_mismatch =3D 1;
>  int Wdo_while =3D 1;
>  int Wuninitialized =3D 1;
> +
> +int dbg_entry;
> +
>  int preprocess_only;
>  char *include;
> =20
> @@ -237,14 +240,6 @@ static char **handle_switch_E(char *arg,
>  	return next;
>  }
> =20
> -static char **handle_switch_v(char *arg, char **next)
> -{
> -	do {
> -		verbose++;
> -	} while (*++arg =3D=3D 'v');
> -	return next;
> -}
> -
>  static char **handle_switch_I(char *arg, char **next)
>  {
>  	char *path =3D arg+1;
> @@ -352,14 +347,14 @@ enum {
>  };
> =20
> =20
> -static char **handle_switch_W(char *arg, char **next)
> +static char **handle_onoff_switch(char *arg, char **next, const struct=
 warning warnings[], int n)
>  {
>  	int flag =3D WARNING_ON;
>  	char *p =3D arg + 1;
>  	unsigned i;
> =20
>  	if (!strcmp(p, "all")) {
> -		for (i =3D 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
> +		for (i =3D 0; i < n; i++) {
>  			if (*warnings[i].flag !=3D WARNING_FORCE_OFF)
>  				*warnings[i].flag =3D WARNING_ON;
>  		}
> @@ -373,7 +368,7 @@ static char **handle_switch_W(char *arg,
>  		flag =3D WARNING_FORCE_OFF;
>  	}
> =20
> -	for (i =3D 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
> +	for (i =3D 0; i < n; i++) {
>  		if (!strcmp(p,warnings[i].name)) {
>  			*warnings[i].flag =3D flag;
>  			return next;
> @@ -381,26 +376,65 @@ static char **handle_switch_W(char *arg,
>  	}
> =20
>  	// Unknown.
> +	return NULL;
> +}
> +
> +static char **handle_switch_W(char *arg, char **next)
> +{
> +	char ** ret =3D handle_onoff_switch(arg, next, warnings, sizeof warni=
ngs/sizeof warnings[0]);
> +	if (ret)
> +		return ret;
> +
> +	// Unknown.
>  	return next;
>  }
> =20
> -static void handle_switch_W_finalize(void)
> +static struct warning debugs[] =3D {
> +	{ "entry", &dbg_entry},
> +};
> +
> +
> +static char **handle_switch_v(char *arg, char **next)
> +{
> +	char ** ret =3D handle_onoff_switch(arg, next, debugs, sizeof debugs/=
sizeof debugs[0]);
> +	if (ret)
> +		return ret;
> +
> +	// Unknown.
> +	do {
> +		verbose++;
> +	} while (*++arg =3D=3D 'v');
> +	return next;
> +}
> +
> +
> +static void handle_onoff_switch_finalize(const struct warning warnings=
[], int n)
>  {
>  	unsigned i;
> =20
> -	for (i =3D 0; i < sizeof(warnings) / sizeof(warnings[0]); i++) {
> +	for (i =3D 0; i < n; i++) {
>  		if (*warnings[i].flag =3D=3D WARNING_FORCE_OFF)
>  			*warnings[i].flag =3D WARNING_OFF;
>  	}
>  }
> =20
> +static void handle_switch_W_finalize(void)
> +{
> +	handle_onoff_switch_finalize(warnings, sizeof(warnings) / sizeof(warn=
ings[0]));
> +}
> +
> +static void handle_switch_v_finalize(void)
> +{
> +	handle_onoff_switch_finalize(debugs, sizeof(debugs) / sizeof(debugs[0=
]));
> +}
> +
>  static char **handle_switch_U(char *arg, char **next)
>  {
>  	const char *name =3D arg + 1;
>  	add_pre_buffer ("#undef %s\n", name);
>  	return next;
>  }
> -
> +=20
>  static char **handle_switch_O(char *arg, char **next)
>  {
>  	int level =3D 1;
> @@ -661,6 +695,7 @@ struct symbol_list *sparse_initialize(in
>  		add_ptr_list_notag(filelist, arg);
>  	}
>  	handle_switch_W_finalize();
> +	handle_switch_v_finalize();
> =20
>  	list =3D NULL;
>  	if (!ptr_list_empty(filelist)) {
> Index: sparse/lib.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- sparse.orig/lib.h	2007-02-02 16:57:04.000000000 -0800
> +++ sparse/lib.h	2007-02-02 17:06:51.000000000 -0800
> @@ -97,6 +97,8 @@ extern int Wcast_truncate;
>  extern int Wdo_while;
>  extern int Wuninitialized;
> =20
> +extern int dbg_entry;
> +
>  extern void declare_builtin_functions(void);
>  extern void create_builtin_stream(void);
>  extern struct symbol_list *sparse_initialize(int argc, char **argv, st=
ruct string_list **files);
> Index: sparse/sparse.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- sparse.orig/sparse.c	2007-02-02 16:57:04.000000000 -0800
> +++ sparse/sparse.c	2007-02-02 17:06:51.000000000 -0800
> @@ -264,8 +264,12 @@ static void check_symbols(struct symbol_
> =20
>  		expand_symbol(sym);
>  		ep =3D linearize_symbol(sym);
> -		if (ep)
> +		if (ep) {
> +			if (dbg_entry)
> +				show_entry(ep);
> +
>  			check_context(ep);
> +		}
>  	} END_FOR_EACH_PTR(sym);
>  }
> =20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20



--------------enig28DCA2287DB135DEAAFFE913
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3m1pGJuZRtD+evsRAhnlAJkBceF2TIanoBWE/5v/jt51zs50vQCgtwGM
vvr+fpWGJCNAi+HRCoNRX1w=
=bdoD
-----END PGP SIGNATURE-----

--------------enig28DCA2287DB135DEAAFFE913--
