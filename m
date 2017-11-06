From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 33/36] build: simpler logic for quiet commands
Date: Mon, 6 Nov 2017 09:15:44 +0100
Message-ID: <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-33-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uh0TDvmSkO18Prp0QQqMLo3DOQwmMrDP3"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:60784 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdKFIPx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 03:15:53 -0500
In-Reply-To: <20171105162544.72960-33-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uh0TDvmSkO18Prp0QQqMLo3DOQwmMrDP3
Content-Type: multipart/mixed; boundary="FWwgJwaDghq5DpfHlKRMjcuVWpUI7r53O";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-sparse@vger.kernel.org
Message-ID: <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
Subject: Re: [PATCH 33/36] build: simpler logic for quiet commands
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-33-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171105162544.72960-33-luc.vanoostenryck@gmail.com>

--FWwgJwaDghq5DpfHlKRMjcuVWpUI7r53O
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Luc,

On 11/05/2017 05:25 PM, Luc Van Oostenryck wrote:
> @@ -175,10 +168,12 @@ ldflags +=3D $($(@)_LDFLAGS) $(LDFLAGS)
>  ldlibs  +=3D $($(@)_LDLIBS)  $(LDLIBS)
>  $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
>  $(PROGRAMS): % : %.o $(LIBS)
> -	$(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
> +	@echo "  LD      $@"
> +	$(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@

Is it intended that you introduce changed behaviour here? Now you get
the pretty printed output when building with V=3D1.

Best regards
Uwe


--FWwgJwaDghq5DpfHlKRMjcuVWpUI7r53O--

--uh0TDvmSkO18Prp0QQqMLo3DOQwmMrDP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAloAGjMACgkQwfwUeK3K
7AlGeAf/bgyKi0xDCDFoEEZ1TP3lSdYzYh0LgYGqwk56WdE722M+sV+Ygp3uYkoX
5wk9NhaB+fD8rJMrHSkBRY1sKBPR2/0UcgiLtViO4qohhRgSaP4szMGyWqTln55p
9Wxaurl/HR9hFpUVoUjmTE8YL0PNd1aJXMfncTK4JEYVV5ZOSqfN5ObXRPizya/R
7Oz9D/4lAiQzumnGBjx1Jj1bnU5SC3q37duKlFT50VyEP+tMot1O4jbeVFTJcvgk
cRGKVGz9mgy3Id1gra4sUuy4AJPxO1h3cq+YtpCA9HLYLjH9V00KNQf10eX8G83F
ytndjoYsA8kq4FhYQAYJP1Oj6+fQXQ==
=Obu7
-----END PGP SIGNATURE-----

--uh0TDvmSkO18Prp0QQqMLo3DOQwmMrDP3--
