Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF48F9D6
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731866434; cv=none; b=qpMIB0C4/w3YWzg+lkuJ+Geeozv69Xi0vdVLTOTxm5mPBFvi4ByUP0MMhnumSDEmMYPSz9jot13PNC/hYBm1q7y+LlQ0TOG0z5tDPz5mrumHgn7IIorvETtJPgnpOFn/lyAPypPYmQTcP/RztsQITI+0MD598InVGNAiBC0X+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731866434; c=relaxed/simple;
	bh=n2Xyi5WHYcPb+hdFFb7K38+N6EDWPh0aIcGkFbPwbfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/ceOW8DxTAaxenJtNX1XfJ2YvFzNygThb1PLGHUzRhCV5aoZG9/qJG+LFlU6puCX35Kw6OPBHpsQUBsg772sjN0+atenDSobagIOF8zL9QpjrI6azJj7UGhZbtKy3k1cH0KdsgPYaGw7lSdYGAt+cHQkY4URoEqABzjQwnGa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FmjQcQ4Y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FmjQcQ4Y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so4542048a12.1
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 10:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731866430; x=1732471230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62JPUB8FB2DzJFTl+6XHcOGfr7T+tH1N1vjbK06wZWY=;
        b=FmjQcQ4Y1wDJ9/JYwYYM/jIQof3SXVfXCE0n/pgLSOZPkXo/TXl54Tq/9gyovd2+OS
         3fgEqXWRR9wU7dIJRVycH+2nfP1lhp6Ljq2v/ePok8xdcmNrK8BCq5vPsrpGdeN361GZ
         kaU7AYgT/Rd066fLezDfqHRyUhae+EJZLJC+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731866430; x=1732471230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62JPUB8FB2DzJFTl+6XHcOGfr7T+tH1N1vjbK06wZWY=;
        b=fqzvTLOnc80r89JVFNAa9FRm6A/52Li0UynldBSpxdQMv9b6F9Mt3L1sLHayih9iNx
         EzN7p95z81MyJBLbS2mrMPh6nY+lRYpT6n+VPCkI58YZ9ddcvwRiivSDo3ZzluU5fPxj
         jWcHmYbta1SRpk4RX/YxC/Z6xrmkqdq16ZFq+ZKOVBS1TxHNKtc4vpFRgcBkJ7UwCshz
         m5R2VNsR4u7AGs1qdsoNTox7q1EiluCVg6xh277bMFz5mRKk+QOpWBl69OeolYezXs1I
         uOnyt+73ICt1Hn4a7rdVvQ5lWj7dG7wA2wrfJkHM9xkpX8ZlyrZbyHRgznrR9tsI3PFi
         F2ew==
X-Forwarded-Encrypted: i=1; AJvYcCVRsbG6kaSYyFL14A1Rq6uEvtQSOXp4rItHlxkHl3l80YnNYJi2A8XyoeQrjBz7mDV/ENOS7d+Q9E8wz5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6nzOfMPGFD/qTOQ5A7XseY2zC6Qffj9u3nTZ6N1ukXfjLi/d
	+2zXwZRyC7+9+YcF/kgicq/EpSN+58UedX7az+Hx86gQuyTAapvw8sdCE/esY1Qc5g4XfJaMKxS
	orQ0pkQ==
X-Google-Smtp-Source: AGHT+IETzasBQwFfYBNGgbGqMIj9UQlm8UKKzM1jeQPHruffGTCWI0PUFcMdd6UBOsDcbwYizgjU1w==
X-Received: by 2002:a05:6402:35c4:b0:5cf:95c4:ff1 with SMTP id 4fb4d7f45d1cf-5cf95c411f8mr6711789a12.24.1731866429940;
        Sun, 17 Nov 2024 10:00:29 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfc9804412sm256109a12.86.2024.11.17.10.00.29
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 10:00:29 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a68480164so516314166b.3
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 10:00:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnYu3kRPVbnLm7HgWcjJOumTRHf9nTfb6BWWbtCSqcQqfAY5VGV9HWnnmuew+WfzNxiXDeT5+TYPf/eWY=@vger.kernel.org
X-Received: by 2002:a17:906:fe41:b0:a9a:7899:eb87 with SMTP id
 a640c23a62f3a-aa48342678fmr916901066b.13.1731866429032; Sun, 17 Nov 2024
 10:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
In-Reply-To: <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 10:00:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
Message-ID: <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 09:42, David Laight <David.Laight@aculab.com> wrote:
>
> #define const_true(x) __if_constexpr(x, x, 0)

No, let's not do this "double expansion" thing again.

If we actually want to make things smarter, the trick to use is to
know that only a constant _zero_ turns into a void pointer (aka NULL).

IOW, something like this:

   /*
    * iff 'x' is a non-zero constant integer expression,
    * then '!(x)' will be a zero constant integer expression,
    * and casting that to 'void *' will result in a NULL
    * pointer. Otherwise casting it to 'void *' will be just
    * a regular 'void *'.
    *
    * The type of '0 ? NULL : (char *)' is 'char *'
    * The type of '0 ? (void *) : (char *) is 'void *'
    */
    #define const_true(x) \
        _Generic(0 ? (void *)((long)!(x)) : (char *)0, char *: 1, void *: 0)

should work, and doesn't do any double expansion of complex arguments.

           Linus
