Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24028322C7F
	for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606523; cv=pass; b=Xul6o+r3YkZFUS31CsvkkQoKSv8qTHp4Kv3Ryhf/4vlMmAVyx+5bbFb6g6Agk/qOdsSBztPvUOm+FKbt9PEYAoV45zz4Cl51d+IQ1SXIQtSApqScGzjGGfi2MzEydOVtrMf3B+jmyfYZH4NlKc+Epjk/MtJ4vt0T5JrOzeQg3R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606523; c=relaxed/simple;
	bh=x8FFDlF/fesOWEb5mpSebQwC7vWTQTshDMbtChx063o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSi/CrJhx3AR8Ac89H47Ut+o3gncuO0m2aZB288wvlwKGPnTdbd7BtCPa+FN5mLXNEAEgHBJ7NJQphfwzP9XDlQ49p4uJzKDT6kT3iliTIOYIayvy5M9qhtKKZv13VChYgF/NFhMVsmo+h08E/v+fvFySkmjxAKG2vY2fh8IiCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79275e61c2cso26397977b3.3
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 15:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768606517; cv=none;
        d=google.com; s=arc-20240605;
        b=XidWcJywgQZ0YoOBjX1Buybky1i3cfO38EI9iaX2iCAM7ayOgswrrBaxJF9i/7Fqff
         BLwePggXGDYY8OeWa2r6CfAIMD0ZEdfEmpzHz45cZAlRAkB8Nndz+fJ/epxG0wFT9jdG
         focsk8236PyG3qtGx4OwzLN+BvLiMKSG9xeUoXlVTI0UiSP2hrSLCQUVHhbxdVDLDMJz
         WMQYZFyfR1yw40TESdtLZNDBXkTiWtgAPyclyN3VhjMztR/5CPrF/xnTMWaAtPHEoXRt
         kCqRtJ23JQfwWJQyupODdAZRaBXXLCqoHUWdEVPQZ2RAeyHH6QE+ugRvWZtEAFS4kffo
         ByOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nVvMcHxFKWpFeIwQX6rcqpoxp4jR1OruPjaEq0/Db20=;
        fh=tD1m01T1OfFOoE5jk7/o5JN0pgwAg25Fxt1VdK9ahVE=;
        b=hnwCKN+QEGlOVeMpswSHEuNzjlpnUg8EBBccZMIV/eq6xks9HpVkZv7Y1OXXHMvMjj
         88LRufp6ETSJVnUnZqzfILUA2FkOHIPTsaCKVAxw77y/HEVzXiO3Cq4YVKTIhYZEbh1C
         WeBsi1wDyVhnRQgS89hhhI8N5AmCBRLVjCsk9XvwgJucaMhOrR/x54gbsQwJChbsHvJA
         1+6FfC/l4vaFes2RpSK9dTuWycGNvMtRpP08N7a7bTIKN+LGY/R3KGJDAEG9Ksgev+T6
         5Z4bzKJEU7MOJWuXeK7HC6aGLMF5GEH25i+xUFYvfSedYjkI/GnCgAhiLimFO5AeIGXT
         wpWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606517; x=1769211317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVvMcHxFKWpFeIwQX6rcqpoxp4jR1OruPjaEq0/Db20=;
        b=Q0NPPUenojrmMp7ddqMUCFo3GjXDksdXw12NIbbzVfWC/uyCKZ+ljHTu/UxsYl5hN2
         ozXFDIv85uvkIKL8fBzyZfzxRZMOEl9GnzavEHDZFJvdhKwj/4WJC8tcNBHykedSlCIx
         r4w2QsNIrf7vOCZ5vkX1+A4JxN82iiZP6Zql1I5XoVkDFB+GlyttmxzerpoMtT+koIp6
         Apbkv5xAv0lsP53EGkoPeU7dUwmQlCEFt8p3FKOt3/HuOFC7fq0WQSCdCG01HYE+cAds
         Gw9uZEe9CvdYixZSuwhnIMzG6kQux2dArn0dRl0g/KmNYI2fVY0Q9X6nlqFqMjCuJjpk
         HxrA==
X-Forwarded-Encrypted: i=1; AJvYcCX7A9AASTxj2zDqg/TNOEcGyAyvfIEqIYhNVLE+VGP+AvuVW1yuMlvS0aAAu12lVV0pp47TrNfUqvkJ9Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0ELDl1yu5LDNPYNAERE6BYQYUNXcaQ9Q/8SwOE1ITeiQRfaz
	bBJnx33LWpkSyBinzgGLSwfi4j4ECqzWpFCrEfGg5vOEZBamiGiZEyRCfkEnQOD6bHjc/oCvBPb
	TBKzO47Pat81hO1C1OZmJ/BKYyXbSgezG1/g6zk2lpA==
X-Gm-Gg: AY/fxX4r3dcUn2KmdrTCvGFWkhaD8Pq5HQPOMWZorFYR7ZGwYrAkI9WpRwROLvuYmni
	pia73hqd1t/cIFuucD04kjQKfdU1h0KiAk4wBqBFBREbJr17B7tXLqM8myFQ8fuK55hyypQiw2d
	QVNipZUJXE4ZtAZ9+jc8aqNshDjPuSPqJwhj141CZw3sdoZ523GCLsKu1tBgB8FGJttm1OBnk9L
	2pLt+rr3yplxH5WHdkxUX5BufDAOP1F5d0Zvb/OLq5WT96PZfVcJTai3pNNjZBRCB4E2tciTmNK
	CeyY7ZIZ8UQL/jd3bXLarKaTI+TQAEdeVD/cZYx0rjcejVE3oze5PUntqg==
X-Received: by 2002:a05:690c:ed3:b0:78c:10d6:1e8b with SMTP id
 00721157ae682-793c66fed4cmr36954647b3.26.1768606517669; Fri, 16 Jan 2026
 15:35:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010030348.it.784-kees@kernel.org> <20251010030610.3032147-3-kees@kernel.org>
 <47a2f0c7-c25f-4734-840b-fdefc2f3c4a9@kernel.org> <aUVIlvOSvobrdrKV@stanley.mountain>
 <bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org>
In-Reply-To: <bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 16 Jan 2026 15:35:06 -0800
X-Gm-Features: AZwV_Qi7IfV4loLjy6_M4Wg9pj-bZgstydRyU-pSfKvInieL_J8lQ-37srUWiOQ
Message-ID: <CACePvbU5Pqo=bw_j8arOq16o1JBOSwPtuMZBVozy4FV7YsSLGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] module: Add compile-time check for embedded NUL characters
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Kees Cook <kees@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:59=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Dan, Daniel
>
> On 19/12/2025 13:44, Dan Carpenter wrote:
> > On Fri, Dec 19, 2025 at 01:29:21PM +0100, Matthieu Baerts wrote:
> >> net/mptcp/crypto_test.c:72:1: error: bad integer constant expression
> >> net/mptcp/crypto_test.c:72:1: error: static assertion failed: "MODULE_=
INFO(license, ...) contains embedded NUL byte"
> >> net/mptcp/crypto_test.c:73:1: error: bad integer constant expression
> >> net/mptcp/crypto_test.c:73:1: error: static assertion failed: "MODULE_=
INFO(description, ...) contains embedded NUL byte"
> >
> > There was a fix for that posted.  Let me ping them to see if anyone is
> > planning to send an actual patch.

Should I wait for the actual patch for sparse?

> >
> > https://lore.kernel.org/all/20251211175101.GA3405942@google.com/
>
> Thank you both for your reply! I didn't think about looking at the v1.
>
> I confirm that Sami's patch silences the errors on my side. Thanks!

Thanks for the report.

Chris
