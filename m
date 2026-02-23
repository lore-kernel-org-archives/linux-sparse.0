Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB92C11F3
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869753; cv=none; b=bMTJcOegckHcVoCN896UMqKdRaa/h23Oh/HsTIlqWQOCNGtXhFPjh85uq+Or82a0uJp32+W68Mq5gc5JIgC8nks0nv11fMxjH9V8c488byRQUsbGmqYqFpZUKrovQnNSsJxgm6tyUJI6FlhgAyAp0NrFqMcgGNdwnJhUXH2Y/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869753; c=relaxed/simple;
	bh=xTiC3o8UBeWkwj/REKtj8rs4r45t4WplAnMGVsLpKtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj6OB3Go+Hgzzb6VzseJXVe1tjRHXiBgDFb6p+L/Jyva3Cwt1w3zMs4YyU0pAwehY3hvGVXr+xiq+aTq1FnNmL/1pMX1+6rH0laVsaa+LLHycz3QSpc8m4yL321+qlrecWOXENWSF+i1Vs+/BdWVy1ykC+Tw4rNt7R21yxKRick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iiq+Wjv7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iiq+Wjv7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8871718b00so743961266b.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771869749; x=1772474549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=owa/p92KaURjbxUzVmI/A0T7Vi/DPPaOBktW4rB8YKc=;
        b=Iiq+Wjv7P95jAbeedDKR40RHynJt5tSdnmD5OKrFZWzoo1EpXccy1t6GiJwJaatGvO
         AtjTDOUPLir0yTJsy1e+YEFdXc7prjbbzz71f6HsSdNtQ/65oXGkF4Tgb3DVMfDuD9xj
         z0SFgMcp1uTekGJtxCtnx879g1CrDcFK4bgws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869749; x=1772474549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owa/p92KaURjbxUzVmI/A0T7Vi/DPPaOBktW4rB8YKc=;
        b=eruNzEML7kIcc48kPWMxX1Cwfs2z4di14XQzcLDlP4doZCL50KL2NqNGsF60Jg1hEI
         h7xeUcQtut2iJE0VeQGl7UysvfdBEjp4o5EdNKP/NHNaOrB1VRmyhqrhTqxPYXbV4uOp
         yPGT9shGdz+LIT81xc9jMVUT/IW4xGxRuWOEmpDL8Jt4aGJkV/W9wR/VrAoctjnapDS1
         ievZY6GaAUylbi8hfaciF+MFDaohU3XRw2vtcyU5UydrD5lgS8rBeIhyAKd7wqgqOfn5
         RgNeSGb6zOVz0pc12NlkPfDcUUtD55Ap6YB2EqfNYgmKrFyGL3xqUPeHy4SAWO+MsopH
         tmjg==
X-Forwarded-Encrypted: i=1; AJvYcCV18TE8HtgbFD343VC/QE/xucJKgmjpG1oBfZsJ3rFfgr3/bKh+q5OlGSir5tGm2+fn5MfLsnggIJyHKJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIkEF9VXF1ZBWfGC2UWOnOUY7Wx3ktmNrxao61qrdUJLc5sO4
	MEprjMI2DsVR0S1dA5aFY4NBOcGiOaFF7BF+EHL4WyKPt6Tj2g5eXIhM+2mpWl2aHYW9+jVp+EZ
	glYzY4Xo=
X-Gm-Gg: AZuq6aKn96I4eSnso0b16ds9xdwXIkcfpeKuRhdHkWMaPQXTFiKS0cd0zwcJA9tI+AF
	yeCdNb3XNtTdYXkeeECSLPWZHdgUZjqGpqsRuHIKydJzUjPGfSoV7AGTOEGnWctHdyBVezhGRUw
	mKyZQHcQatORvBNanzfgkyVGCnm1XyKmJmqWZRrqKVzxI8zajJMtT7K7r0th6AthmtlBLAs9OXp
	43YmkPAXnza8rmZcn/wvxiuVSyJvSu5KWbX5lr/ErV+uJuQMENRpWznCCZw1DLNtFNioR4mYHlZ
	cJydkC1Z+3Cs2Nc2o81yeR7QTaKTTjo4K9fEAINEphRVInrBtM15i1lJSwW7Dv1mc2yiD40NkFR
	2yK7rH6nnpzhfCimygTrDZcIaR/NymB2QUFjegIjqdiHVTbiEpOhGjbdDUe+f4qkYgWX4mJA5s2
	ikC7pyspEfaQUKBFyRzbpXsVPdYd0oo30fud2hTXo5j/U5Nh8VqZJTV+1Q5RAkJOEzfA1Wg16M
X-Received: by 2002:a17:907:9452:b0:b88:e09b:88ac with SMTP id a640c23a62f3a-b9081b492a9mr615757166b.29.1771869749412;
        Mon, 23 Feb 2026 10:02:29 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e8d0d9sm350085266b.50.2026.02.23.10.02.27
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 10:02:29 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8871718b00so743939166b.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 10:02:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWePKdRrkS7SmIQRtVYDGM1IUjttTHq2mZxOqdb22C0wmXL0fXKg+n6wZ3sM792alhxp1nttyWBgpEOMe4=@vger.kernel.org
X-Received: by 2002:a17:907:971b:b0:b8f:bfc9:ae11 with SMTP id
 a640c23a62f3a-b9081994d58mr497647266b.8.1771869743594; Mon, 23 Feb 2026
 10:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
 <CAHk-=wgxgo8SugrnA4s=Pz0TPj32Ea0pdO=uU_N+-V6Y826spg@mail.gmail.com>
 <CAHk-=whTb01surrXakL7rgyoELuPDkqvTdh_ttNrr5rtirwopQ@mail.gmail.com> <CANiDSCsn4gctPL5ms+hCHBwFyv7wAWPCKw6Jfrk2TjMS2tNrCA@mail.gmail.com>
In-Reply-To: <CANiDSCsn4gctPL5ms+hCHBwFyv7wAWPCKw6Jfrk2TjMS2tNrCA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Feb 2026 10:02:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whii0ao=uEoNocj5H56cUa_xZ5v=Hrth3K1aN1uU3XsqA@mail.gmail.com>
X-Gm-Features: AaiRm53qnENTtDAj5Jrly9R3OZsMxgYkgrpbBWJIgd3kHLdYSvzBU4yrZ0OQ-TY
Message-ID: <CAHk-=whii0ao=uEoNocj5H56cUa_xZ5v=Hrth3K1aN1uU3XsqA@mail.gmail.com>
Subject: Re: Sparse not supporting kzalloc_obj() and friends
To: Ricardo Ribalda <ribalda@chromium.org>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, 
	Chris Li <chriscli@google.com>, Hans Verkuil <hverkuil@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 09:21, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> I tried both smatch and sparse and both work fine with your trick.
>
> I also tried to boot it with virtme... That also worked :)

Ok, I'll commit it.

What I actually wanted to do originally was the much simpler

  #define default_gfp(...) (GFP_KERNEL,##__VA_ARGS__)

but sadly it causes an endless stream of

    error: left-hand operand of comma expression has no effect
[-Werror=unused-value]

and the tricks to avoid that make the "simple" trick anything but
simple. This would seem to work:

  static inline gfp_t __attribute__((unused)) GFP_DEFAULT(void)
  { return GFP_KERNEL; }
  #define default_gfp(...) (GFP_DEFAULT(),##__VA_ARGS__)

but at that point the existing __default_gfp() macro is simpler, I feel.

Oh well. That "has not effect" was very much the *point* of that
really simple comma operator trick, but I do understand why the
warning exists.

               Linus
