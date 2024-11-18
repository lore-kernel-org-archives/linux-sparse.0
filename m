Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DEA38FAD;
	Mon, 18 Nov 2024 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731900170; cv=none; b=uBIvVNe1Jh1RsJP7jZ+pyTRSpZglvotpMWrtvzCNvWpGzo7zN0/lyOhVUJ3ohzvp6rMgqAV8tLpvmigHPpVuSAR0Z8+GRdQFUgKUxtDe8+alJ4G9lllLT3EtABrUvjXvr5QECVbfwezxchvDZ/vecfuUjDinXpPT2HTWQ2GriHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731900170; c=relaxed/simple;
	bh=sC53cOkGHR7+YkmVrEskrqrXKziin5M0XnR9WrOyk3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I416u6d1iFSHwn+ZTM97xX7IsfB1aPDomr6YXOFtjFFQ6C1tAHSvV0j3tgvpp9EntcCCMB7T3mtm6Lwonca8f+xz8fQ70r7HBlqemfcq4m9tpDyFADzS4beaaWTQRJA7gGBPSFeQFc9tO+W+VYl/SML4jVsAOfNALaLJwfJvJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SkBUnM8n; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SkBUnM8n"
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by smtp.orange.fr with ESMTPSA
	id CsLWtcegK8AEMCsLWtzcQU; Mon, 18 Nov 2024 04:22:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731900159;
	bh=7o0mjGYYkFH2VTH6NhQflV3hRk5AHYtUs4SeiX2tgvw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=SkBUnM8n1naJxdrxBOtyCDZjrxFEpPy4oM6ztcy4awKfRGsGhEznQaZnhwSRvf29F
	 KzjExeQFM8D6UTYP/APk4hfyt/FE6lpku/yxIopPy2QWvTMfU/v2xVWOjEje/hDmXB
	 3e41O6YOQnWZttNWxb/3RqJRNTA+GG9GzoZ7XxxJYVZzrnI2rPVnJ4KkWoWcx2ZGKx
	 e2rXzm1AcZMkqA3IxkTeXkL4ei4J8w0B7YnGJZaJrhqZcMSmoXU9zv++6oifKZHtI0
	 RSwMN+mRVhAstikgR9XSAmt+FCXZEHtg5YWNwpSloL2BQeiH7ujz3knrwysW2/ch8A
	 3k373NBVGMkmw==
X-ME-Helo: mail-ej1-f44.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Nov 2024 04:22:39 +0100
X-ME-IP: 209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e71401844so340850866b.3;
        Sun, 17 Nov 2024 19:22:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe+gzHEFEWSMwxE5waOXICSnTRsfgFO7/wuybfKsSK9R21HqnX01r34ywlhIaIGN7wyS+yJgLnr74kN96k@vger.kernel.org, AJvYcCVtj9ppvhaYBwzAL4cFKZNMJv+xslUTRrKSclqLXwy1vtnWyId3MMm74GjNpIe9Rq/Az6X4wDOVHZAn2is=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWFDHBklarGYkAWWD5QdP257AxiqNDU4CUjw5ytSmKZooXHTK
	A7jtj0C8PZJA1w7NSnmAhH80JmvoBOk2FkBArhtGMPSCPcxecaxbEQd7Q90oObtC/s/vngZQiU4
	XntxCmTynWYT7rlfk7SkTCQHhaKw=
X-Google-Smtp-Source: AGHT+IE4SHXGmZHvBKG+Bz77PDg2OaOZ/J9eGI7/RiKD1Tn3oe0ekNFe5yLMxq26YzU1nHskSmKUp8NQoZzWoGJDse4=
X-Received: by 2002:a17:907:9410:b0:a99:f77f:b489 with SMTP id
 a640c23a62f3a-aa483507e13mr1083384766b.43.1731900158542; Sun, 17 Nov 2024
 19:22:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com> <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com> <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
 <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com> <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
In-Reply-To: <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Mon, 18 Nov 2024 12:22:27 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
Message-ID: <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon. 18 nov. 2024 =C3=A0 07:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> The "0*!(x)" is admittedly kind of ugly, and might be prettier as
> "0&&(x)". Same number of characters, but technically one op less and
> not mixing booleans and integer ops.

I did a tree wide replacement of __is_constexpr() with is_const() and
did an allyesconfig build test. It yields a -Wint-in-bool-context
warning in GCC for both the "0*!(x)" and the "0&&(x)" each time the
expression contains non-boolean operators, for example: * or <<.

I reproduced it in godbolt here:

  https://godbolt.org/z/5Wcbvanq3

Aside from this warning, the allyesconfig build succeeded.


Yours sincerely,
Vincent Mailhol
