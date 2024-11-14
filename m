Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186361F9431
	for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582118; cv=none; b=h1bzMK+YLKjlVeIj6MnHyqtM5XNhhAu+1YRhXxo6n7Fy5yszwZnEJdHfaq1QYP47G5jLsgmhurwAE/7ySSwYloLI+0YYyyNrgfkEo0DbV+rYpKzrDK4N/78cH9Dh5gqJ1YQ2j+6IEM7DzE6s6YGKdeyMZ40vtQWquEOtAL/+bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582118; c=relaxed/simple;
	bh=qPAWrOr3vWkhHjcu1uXtnkQY76pnDl93bawx4pmiu0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS28aIn1TD/7nYprdewEXPkmEPcRWbLcZ5WaPEQBygXlC0qStwnV/vBGXmqLdIkWjMF1YU1cOtSnnjk1ZWjfZSqwuKTp9+TB3EcwoSJRiy0s7t+lCtr+JOS6x/tO4XYRpEMpm4W6HiImsVA6HT4NBOmckfeOnqik/4v549qafQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=sGu/artx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="sGu/artx"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so3644041fa.1
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731582114; x=1732186914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CdykCz3hdWH3Ou+T064c0ieZUNSSG/qvO70CTuEaX8=;
        b=sGu/artx82Uc4HbQrRIWH41EGrewjPjLkRtfjFY8/Zs/Ii5pVNIVxivucgWD0vWzgW
         TW0FKzOBM/LtUZeezlLYCkcqUrMTxfhna7ufN3QvRNp4Ur/oVzFpSig3jU838t1A8Lso
         KIitRq5q89QkARZdNjohM8XKXA3bbeUx5Bf9fA+xuZw4+NNYL1HfZp234iI0VFDhXdc9
         UVyyumMdSPQdTVpWdtKw5AM9IS8F5BiUz3PCebFVu4ITvyMmxRJpzD6Ubhm/xXPKseZF
         zJzf66Ord6J/1gX+7HLDsgEsAKbHCOEEF4C7D3yhtczJF5Wli1GjrQ66Yo1eZN6WMzq/
         OXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582114; x=1732186914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CdykCz3hdWH3Ou+T064c0ieZUNSSG/qvO70CTuEaX8=;
        b=unkEUSomJwo9yRoPJb2WRFzOgdYLODbgoF8SS50/tylJ67P/2ggpEKibhQhPh6OXW9
         +1MEDj+RVrshnJVxmGkE7LA1UvI2c8sTT5CK9jDJd8i0XTOWuo2SrPrkaXueufm2caff
         38BNWJtBkAHOOm9iiMKfG0Z4fpJejJoBVzHysP+EDBahkydyXWK5HuAc4pt5im/ZVXQ8
         lWXMskORGs3KZZCTHk8xrukZv3RgnAK8UyifBRuHlVFb6PHJNWar9hUgHl1PvMilOPwl
         B480gIF6rFVOjSljFtZeqZcp1q/kLMrIaWL1Nn8jGi4WlrP59OrU711yKCcqerIlYJr+
         EqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvIG3pRNrwnbYlebLa2sVWRg14OtFGATo42GCt39Jz1cEgf0fAwyqHU9rB4eHmxPiOElpqY7/DzI7jOLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MdEkU51bAbGeG1Bn/gS4rC1p19c3JgUfP9BFOLFrhDxxhete
	f5sVr8n7/Zvs9gnJKVdT6WtA0NPLpAmqRJ/r2jZi1BLuApBgT8Ys607OtyhpTiL8GVpn6NMrLH/
	3c72mKgN+NVCUcpTJpZAis4rcFurEmgtCH2I9cp9IXwym7WUrA28=
X-Google-Smtp-Source: AGHT+IGbi3VDPOzkHrrfqdZNWFsbgtu7/DdTzRf299ddEfxUAeB7GKsHAUYjFDrm8Gxf3Em1QMcHxhiQGuJ9zjk/uJo=
X-Received: by 2002:a05:651c:1589:b0:2fc:a347:6d87 with SMTP id
 38308e7fff4ca-2ff20162111mr119380801fa.13.1731582114230; Thu, 14 Nov 2024
 03:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com> <a2ed9ec0-4909-44bf-be11-21a22789e1d1@stanley.mountain>
In-Reply-To: <a2ed9ec0-4909-44bf-be11-21a22789e1d1@stanley.mountain>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 14 Nov 2024 12:01:42 +0100
Message-ID: <CADGDV=XZnkOUrc=AC=D5CeOHagiTbSGd2KGK0rN1MWoSXjidCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:40=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Thu, Nov 14, 2024 at 11:14:02AM +0100, Philipp Reisner wrote:
> > compiler.h defines __must_be_array() and __must_be_cstr() and both
> > expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
> > So far compiler.h lacks to include build_bug.h.
> >
> > Fix compiler.h by including build_bug.h. With that compiler.h and
> > build_bug.h depend on each other.
> >
> > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> > ---
>
> Fixes: ec0bbef66f86 ("Compiler Attributes: homogenize __must_be_array")
>
> What actually breaks?  This commit is six years old.  It's weird that we'=
re only
> seeing build breakage now.  Or did you just notice this while reviewing t=
he
> code?
>

I am working on a compilation unit that includes linux/string.h.
Compiling it breaks when using strscp(). That is since commit
commit 559048d156ff3391c4b793779a824c9193e20442
Author: Kees Cook <kees@kernel.org>
Date:   Mon Aug 5 14:43:44 2024 -0700

Of course, my trivial workaround is including build_bug.h in my
source; it is just not the proper way to fix this.

best regards,
 Phil
