Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9B1EC000
	for <linux-sparse@vger.kernel.org>; Tue,  3 Sep 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398126; cv=none; b=uojGxPF0iDdU+Khflvaa5D+Vh24KcB7HozbDy11dUb4sXokqQ6ziwDegrayveHVK2lkFOncOuNBH7MkDhK4fib/rS18y0/8ghJmvAh4iNcaIu8WarOF5b3GZWs97LVSVFjETaSPgRLG3JhweCwriDDLYe24zK/oiiyojizZRh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398126; c=relaxed/simple;
	bh=VzkHPVRUAdxGEDQH3hgp2U925w1iXPxabGAkC9rReog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td4u+U9rCRxqt8qHQYjjS7b4WZdyWnla8tBOx3wa4+/1sjdy+gWi9osodgT3LQJa4FOBa2cukjepGrUCQPHqtyBNnDR6wloGwaVFEYoKzBelbUGHbphS7j2V50X3EPDgw5rO1b63T/jsiRf07N3msBJLKX/fdSLDsrbvUuNkRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rfVWVP+7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rfVWVP+7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso33067395e9.3
        for <linux-sparse@vger.kernel.org>; Tue, 03 Sep 2024 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725398121; x=1726002921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzkHPVRUAdxGEDQH3hgp2U925w1iXPxabGAkC9rReog=;
        b=rfVWVP+7l+cJ+BeIoc5LuyTA5SZ752HrQ5ntx5wIIAQWZc7OnNtaWoMJwrpCnA4PIC
         dMe1hKN+hFAWnY2Qng77cd36d7MsyPAgJn3N5a6x4Y3IntZn9rtNwb1CmgS/yQQakWfK
         dmGMPyW4ew4J9IwnS3ytcLCSZyuEVL/oyjUEYgZVHZQV9PiKzLTzuMPNXn+kHHlIE3TB
         yt3yneM/5QjWPF0/EtRRrkSoEgDGngKykqkA6VNEuqfDNYJW0gN8YLW1sjuNNBZa2bSD
         uHU/U4iGowceIrtzHvKQe1KZlvW8eVyUyc1IWG5twMLIwpz+/DADftWrAsCHO6shoWa2
         pyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398121; x=1726002921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzkHPVRUAdxGEDQH3hgp2U925w1iXPxabGAkC9rReog=;
        b=G+xiXsp2k97zVMolLDYRFhdSilwVNWJi0HdBzDn6T6GTfhG1SX6RWbIbsjPAutaWES
         6mvM7OTaim7zeLpxA9/Mpk8kj/9PK2ZDnmmJZchgjy4CsBoM3htvRjRKiOhBkKFf2f4g
         4e/kmNm423uGAD3TlpsrZuRi8OJ3jtKANfa4TMU3Z6p9mDj/NL9B9t5BHY4xC8LmTHAR
         d6tGCAFZYq4GfOemXm6+uZ/oPpgM+83SgbGV2BeRiM9GOs8fXDcleG4LMCQuFHSMioiK
         RWH/Z5UQa8CciVaz492ruvw7M5oBOtf61m40bWbIIMiiPsUgFEj12XsoVExnTh4hBRUB
         Scwg==
X-Gm-Message-State: AOJu0YzJi/CZKLU6w1DDt1xxBP4oxKT5vXRGALYyeTC7YnNxYl3X7Iwp
	64o13aDehpD/HU8+t60z2Zc5VI5iL22Tl7T+PFQIq5uLryyuviZ/x2IUHevlGqItlYPmGqsK8De
	W
X-Google-Smtp-Source: AGHT+IEoy2wGCCisayAkfEpFgH10fuCipUnH0AsQA5jHDgC8LNNuwqhmVtOmxc7+V3g5LAtlL9WwkQ==
X-Received: by 2002:a05:600c:4689:b0:428:29d:4b59 with SMTP id 5b1f17b1804b1-42c8de87c08mr15184785e9.20.1725398121085;
        Tue, 03 Sep 2024 14:15:21 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baa08d9f9sm207091685e9.32.2024.09.03.14.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:15:20 -0700 (PDT)
Date: Tue, 3 Sep 2024 23:15:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-sparse@vger.kernel.org
Cc: wuruilong <wuruilong@loongson.cn>
Subject: Re: [ Patch 001 ] feature: add support for loongarch
Message-ID: <zdaqtziz6ubedttclybzgoso7b4q6jqma73om77pldkspkygif@xmqbwhzsgoqf>
References: <c35dc58e-444f-0809-67cc-113d6b4b29be@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjdohm755vo3xew2"
Content-Disposition: inline
In-Reply-To: <c35dc58e-444f-0809-67cc-113d6b4b29be@loongson.cn>


--pjdohm755vo3xew2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:47:23AM +0800, wuruilong wrote:
> =A0 sparse compiles incorrectly on loongarch, the attached patch compiles
> successfully after local testing.

This patch has some relevance to Debian because currently sparse doesn't
compile for loongson and so also the packages that depend on sparse
cannot be built.

I'd like to cherry-pick this patch, but would have a better feeling to
do so if it was applied already.

With my innocent knowledge the patch looks ok, but I don't feel very
qualified.

FTR: There is a Debian bug report (https://bugs.debian.org/1071605) with
this patch.

Best regards
Uwe

--pjdohm755vo3xew2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXfGMACgkQj4D7WH0S
/k4HMggAu+byHNs73/h0qVJbWpznMTcJTO9ShBK6/p0BQv3kfsFddbFGlslhgKcI
DXifx3hlTX28WqTsdbj1KoUvIWPvV6JbRV63AB5sO1pMy7Tu47kPhJYxjyRIiabS
2a7tEFVAqdbyTdlYGTUIujZf0UTbyEeO6W4J9RhUrqk2h3IWzwVWJHAaqiEw53en
vXL4Ot+i/KUZAaBHJrJ6wHo4mjEHXPOJGEX3ZtvjAu4vkVhlFJbi7LMx2DJFC0Hq
xurG3apdhz+pctaWoQ0NBh9MhLth2FYtOyRa6Ksx7rxqVT1MrCpiEXgezNNVZSIZ
x1d+LFD4F7FrrVDzcjCAhLCGUoY5KQ==
=xa3/
-----END PGP SIGNATURE-----

--pjdohm755vo3xew2--
