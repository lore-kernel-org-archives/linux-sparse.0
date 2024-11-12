Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B174218D9C
	for <linux-sparse@vger.kernel.org>; Tue, 12 Nov 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441821; cv=none; b=rpm+gmaGZ+eNm3Cl29u1A4OJNByFp07nreJ1uN7lrXk9K8FibC3/E/kc0kCMPhc0OS4/sXO93qmdgP8BEpOF1w22utZKOTiwUvwDCgqhJZ12pf5MNQQ6mOwth6MQbF1JoKLaeVoNLTPyS3scONX+Jie3BG5hUM/Kyhd+DxDz7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441821; c=relaxed/simple;
	bh=xrP6+FGE2fwqgOYkUpIVQ5whv+1GBy2TTVi6q8Xo+Wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVltieax/aktV99OEcv2wwwbx7+WR3MAcUGT0kQRB7TP6KJhqSeVtty6K6DR9TKz2PB3nZyuRYAd1rptDk4paFGEANPMRgoB6HD701o8H6aNRAWM+kt4jyILcc4VK1RvN2x2PKStWk+bA8N/qCbj4UoSlA27B8dNGHS0S25g1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=IDqYPjp5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IDqYPjp5"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso976744866b.1
        for <linux-sparse@vger.kernel.org>; Tue, 12 Nov 2024 12:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1731441817; x=1732046617; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucvXhHsK+I+uJFEbTUTgZDfG36LwLVhXYuwztsDoTzg=;
        b=IDqYPjp5JkJnabzBQjEnLtazW3ZwvWmdFMxLKxR4BzHRHBIVxWh9pBXn/UtGOW+F+0
         4Yjqqy/I0os5ExnLw2NxXzxtBcpeXbOmiuujEabh4j3tXNi5lYbQTdsLV7Dx5zcaE82r
         dQmZ49wICGPSFmvJcsNWYf/5AdoxnaxvuagMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441817; x=1732046617;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucvXhHsK+I+uJFEbTUTgZDfG36LwLVhXYuwztsDoTzg=;
        b=wsoWHrjkUsC2h+SqiQ6HAg+eSbyotdmxfoKTCxcaRTcyqjDqPswXRTvLrfM6ut5Czm
         JbhN67tDuVoUlTpBF+DVCtuSI9PtDoJTmUL/grdqwEqQw5Vc4Oiul3AYdgIvWBCJmbAJ
         5SBuPxIMqIBJkDTKx1LH0QVNi9oMc7GmVwLqvda+F28LV8B74JGvLp6O8UHYwx1QRizW
         Q5WGLZqLQwdtRauGaGrTnInjPxD/Ycc/WOOFDSPpyHcQ0fq7z7YtPrN+EGi65HlAgurX
         5goqblsrbANEc9e3DUgX2PZKQH5QvIVpUI0Dga/kuegFO5wQAEnXBvum1TseTgqEdgXA
         KLFw==
X-Forwarded-Encrypted: i=1; AJvYcCV0in1QGtXndYkB9iemtM9pCuiW0ENnHiRai+pgEnA3pxpMXJnluCtzzGTBXdI+v6qYDj9dtk31JtQ1nwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAL1EuyJ4XoXLjU1aYqvTRQ+jRdSpLh6czEW8sIZHinEsMcOJ
	uT+E9akaw0PnhVFyROL0dShUdmV6pKe+KTSG40HqdHO6ZavMlbFOq458mzkBD6g=
X-Google-Smtp-Source: AGHT+IEfm/HYhyCqDsIA0pNxgclgk5pS0Iwj7opt28zFm1yUmMwGW468e0PwLXcdMCNdjBqBgUzgOw==
X-Received: by 2002:a17:906:c10f:b0:a9a:8028:45d8 with SMTP id a640c23a62f3a-a9eefe9bb73mr1840741266b.7.1731441817489;
        Tue, 12 Nov 2024 12:03:37 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c18sm764625366b.121.2024.11.12.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:03:36 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Yury Norov
 <yury.norov@gmail.com>,  Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-sparse@vger.kernel.org,  Rikard
 Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] compiler.h: add _static_assert()
In-Reply-To: <20241112190840.601378-5-mailhol.vincent@wanadoo.fr> (Vincent
	Mailhol's message of "Wed, 13 Nov 2024 04:08:39 +0900")
References: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
	<20241112190840.601378-5-mailhol.vincent@wanadoo.fr>
Date: Tue, 12 Nov 2024 21:03:44 +0100
Message-ID: <8734jwnrrz.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 13 2024, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

>
> Declare a new _statically_true() macro which, by making use of the
> __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
> constant expression.

Looks sane, but $subject needs s/_static_assert/_statically_true/. And
to be completely pedantic, macros are defined, not declared.
>
>   - above examples, and a bit more:
>
>       https://godbolt.org/z/zzqM1ajPj
>
>   - a proof that statically_true() does better constant folding than _statically_true()
>
>       https://godbolt.org/z/vK6KK4hMG

At least the second of these might be good to refer to in the commit
message itself.

Rasmus
