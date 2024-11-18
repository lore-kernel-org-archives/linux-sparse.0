Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752717C98;
	Mon, 18 Nov 2024 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892449; cv=none; b=uJt1hAJ6qinTqotD5MKs6HUUD7LX22oPcyQz9Xcl1pagB73y0LKejMG4IITjDjU8a7iV+mYJuJnSGox+r0a9kbXN+mdANV69HcAiXyTGRIdBIq/L6dr3tk4/GdMeFiGOpNSXp7jLO/T5Cijs9GfnfgRXTh9S8FO32K5vTVmFdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892449; c=relaxed/simple;
	bh=4ZMLJCVy/aoq9DIA9uP07dc8w+LSQyxdE+F5jrjjUNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m88SyvOa7BoeCpSTC0S8DbvG6fP5W2jF+4JIBS53WYEJoPkOuOoOnZu0HetStSue5y8QRIRf3BCWBm7aROqfiyGmipy96UlA1nOq7uQxgkmIbxHOLsXjdPaQtbY6/CfaMFVeZittZpnb076MWCh0krFlO0p5iPr+plTmO3YvLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FJ9CZyTi; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FJ9CZyTi"
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by smtp.orange.fr with ESMTPSA
	id CqK0t3TZzYfukCqK0tSRXU; Mon, 18 Nov 2024 02:12:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731892376;
	bh=L1cFjkIJnjw2UAI+Ur2ODuSLgRJnnxHdTo4U+W2Jjm4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=FJ9CZyTiTLhFe80i/+35nTdON0zcXDExvNW3vRLrEtAtkZSL5NXYwp1CsB9YEBJA2
	 kuT0zrBKidmcIDdHpWxnwUKxOXZdo+SuA2RHWnaE6UOE/4lF2eOBPqxHndeh87D+nl
	 gWFInbboJD4DFzb5ewejm2+0Slmkf7Yu6WKlj1S4FCBURdPNSN53y5KQtEB4VTr62O
	 9UbBeKvcKeeUyeP9H5sTSq2LipamfZiAO8J9pKUUsNW2DKlNXN6izigxTSPt2m6Dob
	 yD+V05zs4+Lmyh3GP1y77WPTdjnLpPvqWRHrBMBZGIOhmsW6849idokVq/H37QzP05
	 Q3O1iyMxyBDfg==
X-ME-Helo: mail-ej1-f41.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Nov 2024 02:12:56 +0100
X-ME-IP: 209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so226129166b.0;
        Sun, 17 Nov 2024 17:12:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsV2G3MiNCucxkYUY/RroAg1Tk/QiPxusR9CMG92FsId8nje7sDd85KNKqzVq7888tD8HfWeMLGF73fbiz@vger.kernel.org, AJvYcCXU5kld1RRv9qzGtwqYpVRL/+90kHmYdICWoTIVHxU9z2leQENtLnv33R6+M/8AuqTPkFwwI3SE6LterxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZYib7UPsUXxwaAgIF2vBI8Hhlp05iISBzAp10CDcqwPwK1sY
	Ncb3yWsljhHk/1F0ShLeUB8lWz9AWeCM5TB3V0n9DXYQIVEubxpqkuYb31b9fGIcJ/rmW6Q64PQ
	vI39n8IUNSJx+NyKfEndcLQjNWy8=
X-Google-Smtp-Source: AGHT+IElNVp6xmNeOiR8a9a5DsY3V2dKL9+7JrjmVDvOZ6L990BBEgkn7kf+kw149Zoxn5Q0HW5dBnispYITnnOARYc=
X-Received: by 2002:a17:907:1b17:b0:aa2:ea74:917d with SMTP id
 a640c23a62f3a-aa48347db9amr947009766b.30.1731892376174; Sun, 17 Nov 2024
 17:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-6-mailhol.vincent@wanadoo.fr> <8bf9eb4434104a3b960d52bd1d38caea@AcuMS.aculab.com>
In-Reply-To: <8bf9eb4434104a3b960d52bd1d38caea@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Mon, 18 Nov 2024 10:12:45 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJwSf9L8sSA78uaizdqNDa__Xz7WY+g5yNgs62Sx-WUog@mail.gmail.com>
Message-ID: <CAMZ6RqJwSf9L8sSA78uaizdqNDa__Xz7WY+g5yNgs62Sx-WUog@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon. 18 Nov. 2024 at 02:24, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 13 November 2024 17:19
> >
> > In GENMASK_INPUT_CHECK(),
> >
> >   __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)
> >
> > is the exact expansion of:
> >
> >   const_true((l) > (h))
> >
> > Apply const_true() to simplify GENMASK_INPUT_CHECK().
>
> Wouldn't statically_true() give better coverage ?
> I wouldn't have though that GENMASK() got used anywhere where a constant
> integer expression was needed.
>
> More interesting would be to get it to pass a W=1 build for
> any place where 'l' is 0u.

Are you referring to -Wtype-limits? If yes, this warning was moved to
W=2. I suggested in the past to add a cast to silence this warning,
but got rejected:

  https://lore.kernel.org/lkml/CAHk-=whvGWbpsTa538CvQ9e=VF+m8WPQmES2y6-=0=-64uGkgg@mail.gmail.com/

Yours sincerely,
Vincent Mailhol
