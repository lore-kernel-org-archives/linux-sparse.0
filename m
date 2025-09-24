Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA45C141
	for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697645; cv=none; b=KYh5IrKwSahKVigBx8KWGWj2xRyxmseBKXWSzYxb1YW8K2sbQYvd7ZfodSJ0wIrECiIeyx2nNjkLvFrnWy5av/o5FRVR3HlqOXz+7H9OCMuGyxHKLrTpLcieIpY7wIZqugyTGqmPVMxSn7dvlAPRudz8zYtKrEFc7Edq8fMMLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697645; c=relaxed/simple;
	bh=5CtuuEckH5FSDvhfpZSIokTQPyq3lCRhCSS70wsv+lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXa2tOVJz4i7qAz8TxoR+OxMreQ7T1BnlWaTnrQzR9dRSUzhGMXmKq9pCb9sTjhxlY+wLKRXgAS5UUY0/O+1AD4POM0BWRZ+Vi3o6anMkBxuijx7u5UY/YM+Np6xGtl8O2wqBbgN65SA/1ygqzDEW+oyDSLfvAeLWaJyiffF2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-eb3671a7db4so832994276.0
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 00:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758697642; x=1759302442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lIug4PyeL/l/YSgqdOmNvEJ+vHG2xfoUd0jpJw1VXM=;
        b=CCoq0evK650IBS3YaMGAa30Xbtpxz6svu+/3nEJh0yZ/Mpbg5K+rqunoKXaiODGpig
         u2+TgHdUFEzaOzkNxtdcfwvNhms7dv9r1trHudrEzAevu+FyktR+QSd0Ia5OrLiHoj06
         +Q7G/CAth1IAhRBSaE3tTpr+2XopU+1OKq5CdLrV244o7LwNOMXAzihKnjqzgLjuSWcJ
         TDVdVkk8S/clXBABttcz3SHXLSzmaxlMb+mV0nF8phOrWQrJOSomgS0Xs1X/FIAuv634
         z4jptPl7HjtoDdZdTrLVnVolUGHtBxucePgjnNYTunUx+9svDkADFRRbE6WGOAlQIH9c
         EdCw==
X-Forwarded-Encrypted: i=1; AJvYcCX06e1RXTrvdQ8CGq3FQ17sSW+p2rXUBtU/34YC11nCm05LYuxsrPH+WnfuB04NQPgqUcZ139IIoOA4FpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfk1QikotLtFyZ9H/JYuNjpfz5dMXYsaZONNc/e1Jkw+3azXc7
	VkQPyRIhjnX3vrG9xkHrWgBZS3tEZvW/m8N4fRpwc5gdL9v65IqPpe5btJZUPtFUp/qgSSpqCnh
	yt6Vaz0raq1e/8CFbY0YY+B16NVAmauepjFdkm01ofg==
X-Gm-Gg: ASbGnctP+xUao7YzldVqDbBurMtMGek10gmEM1psEhr8r9TkVIAXWDUKRlC4rLarsTi
	ayUt/a7+x2r7V7Ys1HVynUruw6XIxfXTYK4hlc9MIrwt5tNOIzA8ZlmiuWvByxQM9I5WTkvIbuj
	o8QtRYdH8k1dDssiegutv8ayTTJ0jQdmb28SJAYqVE1clsmKvB8RC1PmBYrPFwGO6OJfcuDnWyl
	67aDg==
X-Google-Smtp-Source: AGHT+IFe/ii/eABng4KHNpeOA/WZ0qiCd2T/xoS9VBW7zRepGpg/4aVgNRdZng0845i2wvXIeB4Wmr/SKCy+42SA/oo=
X-Received: by 2002:a05:6902:18cb:b0:ea5:b8a8:9b4b with SMTP id
 3f1490d57ef6-eb372e0e612mr997102276.19.1758697642130; Wed, 24 Sep 2025
 00:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921061337.3047616-1-mailhol@kernel.org> <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
 <CACePvbVYFNANx8pi9v85FHMGU3rtN4zOmnqSe-Et=s8ngh0Ltw@mail.gmail.com> <CAHk-=wgnre70y_EFdwMbxLcd3zzihFqFrDEVed7+P7cpUU74WA@mail.gmail.com>
In-Reply-To: <CAHk-=wgnre70y_EFdwMbxLcd3zzihFqFrDEVed7+P7cpUU74WA@mail.gmail.com>
From: Chris Li <sparse@chrisli.org>
Date: Wed, 24 Sep 2025 00:07:10 -0700
X-Gm-Features: AS18NWAzSge0mYmtNicTJI4wzAUUjgzCv8auYl_CLB47ce_A22sH9AlNUvm3H7s
Message-ID: <CACePvbUKV2rkYLeoQO9bWCon2qFkmKWGuh_NqvTccn=XZz7usw@mail.gmail.com>
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against zero"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:17=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 22 Sept 2025 at 05:10, Chris Li <sparse@chrisli.org> wrote:
> >
> > On Sun, Sep 21, 2025 at 8:16=E2=80=AFAM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > That's why I had added that
> > >
> > >         info(def->pos, "signed value source");
> >
> > Do you want such a line in the final patch as well? Seems worth it.
>
> Oh, absolutely. Some of the cases it reported were really hard to
> understand without it.
>
> If it ends up being noisy, there could possibly be some heuristic like
> "if the source is very close to the use that triggers it, don't bother
> talking about it", but that would be a later tweak.

Vincent, can you add the above info() line suggested by Linus as
incremental or full patches?

I will try out the patch folding on sparse-dev.

Chris
