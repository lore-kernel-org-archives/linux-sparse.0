Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272A1F9F63
	for <linux-sparse@vger.kernel.org>; Mon,  2 Dec 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131560; cv=none; b=mrfwA4/v5y92pnjby7olvOs18BjqCqfkytitkfKAgI2R1cAJ0lyKkIJFzPFdpTrBZsmpZVkhR7DTQ6qWCv1dM3CmvLmvSp38Xhlke4PIdBHnkNvtORZFTYQQW5tCEaJJ7xB84Hr5OTQiWkTfeCQrfoJz6EeamK/Ci3CLLU2THsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131560; c=relaxed/simple;
	bh=6mxr67GXj5kOILSJ1Q4R3qqL56+A0QkCVd0OEZ4aJ0c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O9rRh/mmr/2Lv//xnsn982E1JT5eLC1ES+mxxnSz0v2xlfD6dpaiYWGYJKOLNC2D8/AdZPYw1oAtE5Ln2Vc0P6K5p/EbUYWZjYZU7pWXhUZvvicv9b8WCl/YbQ6gS5pD+m4P5ae6bRNBVybbTJcRHzEvPh+bQAriwrEDIwjSzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gHoG7xpY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gHoG7xpY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-432d86a3085so32855195e9.2
        for <linux-sparse@vger.kernel.org>; Mon, 02 Dec 2024 01:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733131555; x=1733736355; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9xEJ/kUhPCLV4a4NQE3Bv/XOpAmETNr1Q9eiG6xcMA=;
        b=gHoG7xpYwrMCKkZpBMN4lIoBpxUYHMT2owuaTaA2KpcLLXx5pTmC5zhdvzB+BVWPg2
         IiEN19SPGFVa0BpdQfz3ew+213vIWbmkl5cbJADU4QyhIlUuE2CjeM3YmyqbICq/sX3Z
         DMPlFnidMFM2rEaD/CwVrKep7eu8IreWVxn3qQTjK+MnRqi7lBCGZEQzmsh9F1wlsXh5
         XlLK/UJaJ3pHjf7uKqigIUtQot6PRvYL1tPUMj69zlpxcb2o9T9l4hrBH1Mqbb2HDeiL
         XsN2mEqmN+IouSSGXEsDzGGBOdIj5Roe+L7wac9PyaIpoBlXzm2ezAB2u0wuBmYNizVw
         HWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131555; x=1733736355;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9xEJ/kUhPCLV4a4NQE3Bv/XOpAmETNr1Q9eiG6xcMA=;
        b=MvMJefEFgEDYNQofBiRzSv6acEecOMT84ggWh/0+JOC61Uz7chjFHbCTbv2nkhkSvp
         g9lOh3PSy7iH+kKcYKDPXUXUAxs3IgqhXuyBh0UW4Szc261F45KAPky6guyUGXY5H8yc
         jOCUFQd+9MgCV7FnIAOMg813K9M4cwOPlF2JrTfAtfxYIh8vrruIaE/Uk+IMSn1xUJ+f
         g3EOYTtiUvVtwpfUHssbphPQ+m8x0+mt8pPlRAxqHuUVia4gR66xw+rku1Nuledvjjc9
         BNr61P3qBn0r8c1F2b28kFX9qJE2ctpaf5ZaZxjtiEnEsiaLCdVZ2NM6KDXGJKoml/iK
         384w==
X-Gm-Message-State: AOJu0Ywi0jw3AxsehXYMW3cWJ0Ho8FToIWEgSCy717Dws2+GXiIzXVQc
	LfNlMC7x428PaE27kMED3QVQzse3o43L4iJ4H0UjP9zjuGOkGob6jo11MSDN+0O81gzu2523+JC
	5hbE=
X-Gm-Gg: ASbGncucHpr8DCKYkWeUVQ/EahwibfNqdRNt6aveTwN/BWe5nrynm5xvE86p6Eylhno
	1r21Tg9YF66TK1ONpMAqCrq7BEA3T52OCYGi4ox741KqYJxnm2Y5P3fSehPRGGiQxasaq6FKh+0
	k4BrMQhRUWK2G9VNDBgJ+jqOhhY8xjpJ8n1efvCIzh+0eFbSoIoD34c+0WxOkyZOlkEK5Kc+tX6
	A0Z8r6oPhPanTuIXJrKciTgNzeZ4JNs1uqO//PJFoAuwbNiejy5CZs44PKROPkJsePN2R3boZpQ
	9/+j
X-Google-Smtp-Source: AGHT+IFp5ayivS0s1d11wGzmQxjcS/jMbWZxPbJSWUm9EDAw+LCn4IL/WiVUIk4+tA9ZBuqesArWXg==
X-Received: by 2002:a05:6000:1887:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-385ee403053mr3480386f8f.3.1733131555077;
        Mon, 02 Dec 2024 01:25:55 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e940fef3sm5603774f8f.42.2024.12.02.01.25.54
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:25:54 -0800 (PST)
Date: Mon, 2 Dec 2024 10:25:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-sparse@vger.kernel.org
Subject: sparse reports "different lock contexts for basic block" when using
 guard syntax
Message-ID: <xc3xx56vvesaen7r2c3q5thmrjva7zcfq5habasejlyn7vnpbj@jxsfprt5gfa4>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3lsfgxv2aanl5a7r"
Content-Disposition: inline


--3lsfgxv2aanl5a7r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: sparse reports "different lock contexts for basic block" when using
 guard syntax
MIME-Version: 1.0

Hello,

on Linux v6.13-rc1 I get:

	$ armmake C=3D1 drivers/pwm/pwm-gpio.o
	...
	  CC [M]  drivers/pwm/pwm-gpio.o
	  CHECK   /home/uwe/gsrc/linux/drivers/pwm/pwm-gpio.c
	drivers/pwm/pwm-gpio.c:98:9: warning: context imbalance in 'pwm_gpio_timer=
' - wrong count at exit
	drivers/pwm/pwm-gpio.c:101:12: warning: context imbalance in 'pwm_gpio_app=
ly' - different lock contexts for basic block
	drivers/pwm/pwm-gpio.c:166:9: warning: context imbalance in 'pwm_gpio_get_=
state' - wrong count at exit

with

	$ sparse --version
	0.6.4 (Debian: 0.6.4-4+b1)

but also on sparse/main.

Trying to understand what sparse wants to tell me, I tried the following
change and the 2nd warning goes away:

diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
index 9f8884ac7504..d811b1f71c92 100644
--- a/drivers/pwm/pwm-gpio.c
+++ b/drivers/pwm/pwm-gpio.c
@@ -103,6 +103,7 @@ static int pwm_gpio_apply(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 {
 	struct pwm_gpio *gpwm =3D pwmchip_get_drvdata(chip);
 	bool invert =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
+	unsigned long flags;
=20
 	if (state->duty_cycle && state->duty_cycle < hrtimer_resolution)
 		return -EINVAL;
@@ -125,7 +126,7 @@ static int pwm_gpio_apply(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 			return ret;
 	}
=20
-	guard(spinlock_irqsave)(&gpwm->lock);
+	spin_lock_irqsave(&gpwm->lock, flags);
=20
 	if (!state->enabled) {
 		pwm_gpio_round(&gpwm->state, state);
@@ -148,6 +149,7 @@ static int pwm_gpio_apply(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 				      HRTIMER_MODE_REL);
 	}
=20
+	spin_unlock_irqrestore(&gpwm->lock, flags);
 	return 0;
 }
=20

But unless I'm mistaken the new code in pwm-gpio.c is equivalent, so
maybe sparse doesn't understand the guard syntax?

Any hints?

Best regards
Uwe

--3lsfgxv2aanl5a7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdNfR0ACgkQj4D7WH0S
/k5pjggAoqM7d071x2sac1CeS9ES/8Jk/ZRpHidiEdLuftrmDccOFfLfmki5X9Za
o+yaB6yAvuGKhcNpYX56NCdFl8lzS6wSS80l1BzqcuqBSD8f9fmrKR6SlPeoUO/W
wCCd9eLnEGPjNPC24juV1IE4JaD/LwW5nc0hd/4kshLFNXS8HE2F04mGCQBmWfEV
kxgoKT80Rma83xtRh/B4pcd9ZFcduBZfFLjJSRccp/KMsz/yFVmRdvRolh1jseLZ
HtkZtLM8uhs4ZAGNEFH0pq1FRkCpXxoudnEKxo4txjxZ1cQQCJbZnT/5Ue8+Swyg
WH/B1cS1ATtgh5Y3jz76lxVEG7juCA==
=i54m
-----END PGP SIGNATURE-----

--3lsfgxv2aanl5a7r--
