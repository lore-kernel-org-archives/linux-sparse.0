Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B71D61B7
	for <linux-sparse@vger.kernel.org>; Tue, 21 Oct 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031372; cv=none; b=PavggrlupEMiHKjTq1QsijMIVOfT7C7foP5eYWhQJvjry3U9SzPgi+mTE8LwMPoygHKloWhaas7FvxLYfJUxxqSmBQjnNqGNOSqQ4pz1mzJPvzFpg1gBscIQtZOPLRI3Z7R9ytlQsQIPb7/2NFnQifAkpHNg843RUZBuSt6lpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031372; c=relaxed/simple;
	bh=899Ke38dil4UcCx7Jiy3pPJVrOSnhatuC5LJcaWc3gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CldGJMnycrM0RIErSg7I2TI8CUQTiQTxgWEO0W0GghVq4+tf1WdGac9LsYU98bgwTm6HrVYkM+UUAjEQ7JUl3kRoWBe4JBy+NuJqG8kaGBOET8oZDEEwXnt2vA9YaSTGH0XzHe+uqg7MEZpqQHM1GVWESdRejong1LKvVEY9vho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-781421f5be6so64790277b3.0
        for <linux-sparse@vger.kernel.org>; Tue, 21 Oct 2025 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031369; x=1761636169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Xtgq3HlztPhoWtNZbRC9IMO52uJVq+vrbbHWF/4F8w=;
        b=NKX6CYauMjhSBGRLY6ENCcC18omOZHEeHV0nILJByToGv3CTML/EWCkehgFFIHgadt
         w/Ac6IUmGs4z9AMQ7caU+VRSWZkb+/wSf1s3iLiM173X+oO/7+75YGjMMa28PlHUVJTd
         +Amf8NrFVICG09944zVKzvro4+P9fPBYlLGSAXwu5YNIHbV/FxmIuZTcv6Q12e7LkZug
         LaJalRq1UvP+As1FylEFR+4/OEsyvhUuLqM39Kvw5QXERiyIWXfNCrQxfNX5gAEtUflB
         GqE/FMPc+tS+959VMuDMtti5YixIzvoNYiJzGk8toJdtXfjhcgtUucPqsSOCNo+wW/wf
         foLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlYLhncHgpcUnRuzWNJO8k8b5WpUMf5VDLJ4gXQACttVkZVWlAl8IVsc9cheltg2UjerPnIvB0UEM5mAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNf49WGC662kyTG8tpZj3jHdvjqllVjm7DXVxX40cQHqonBIN
	FbCMUkZhpEiwQ5H/8AHRxNwKwNTXQkK8rhfzch6ewwWv6jzfwAngKUZDl4ANCRu4/37fBTPAR7j
	saOpMPi+L8IpSkBixwCPGdXo1/SlVCrIRbaGfzfCIjw==
X-Gm-Gg: ASbGncttBV5RtCDIdLxDyqCCDEL0uVwfRHDCPE9kVdU4w4Y179fO+S8E5slhDG9GdzW
	u6n9hP+Z56U3Z1ryCjZ6XDDAPOs0PLqnTpylA7mvrU9xkxQ2FutYMQfjQacgrJWBtTbdJ2zrz6i
	0DbKq/GmDQZfzZUUDoozYqdGPMZmkw2yDoTXOen5AJrlYbsjua+9N9t1qvF/yn3MmDGbthODhT2
	szbXL1jShysZadwc70gOnGn6BZuJy7tJCHSqKwcTtJRwHb8VQ2GoSdia9G+9oOsQduRSw==
X-Google-Smtp-Source: AGHT+IFkl563lNRBBw9+33MJXnJNY7ivHLo+RIIpSyN3oqX3ofvIno+q1LUo4pSzFoXJmIShSYFXy1QYr4T9PyThmc4=
X-Received: by 2002:a05:690e:4012:b0:63e:2b9b:82dc with SMTP id
 956f58d0204a3-63e2b9b83d7mr7866010d50.16.1761031369591; Tue, 21 Oct 2025
 00:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPNfUShPJ3zaAeYp@stanley.mountain>
In-Reply-To: <aPNfUShPJ3zaAeYp@stanley.mountain>
From: Chris Li <sparse@chrisli.org>
Date: Tue, 21 Oct 2025 00:22:38 -0700
X-Gm-Features: AS18NWDtppG8rZKn-xDKDO5irNLFtVcNUzdXL211yd61nYbEBDGtTYFSRK3QvvM
Message-ID: <CACePvbXdMNTp1cO=ORLv3C824McNP2xdOmtNXK2KkoCd=F82og@mail.gmail.com>
Subject: Re: [PATCH] symbol: preserve address space qualifiers with typeof()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 2:36=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> When we're parsing typeof(var) we then preserve the address space
> qualifiers as well.  Otherwise it leads to warnings like this:
>
> "warning: cast removes address space '__seg_gs' of expression"
>
> Reported-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks.

I just apply it on sparse-dev tips, it applies without conflicts.

However it seems "make check" has 67 tests failed now rather than 65
known failures.
There are two more test cases that failed with this patch:

KO: out of 902 tests, 835 passed, 67 failed
65 of them are known to fail
2 tests were disabled
make: *** [Makefile:285: check] Error 1

Maybe some test cases need to be updated as well? I haven't debugged
the details of the new failure yet.

While we are at it, can we add Uros' reporting case as a validator
check as well?

After fixing the new test failure, I can apply this patch to
sparse-dev. If the validation check patch shows up in the sparse
mailing list. I will move the validation check before this patch.

Chris

> ---
>  symbol.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/symbol.c b/symbol.c
> index 6a39e5487c17..301a6ed225d2 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -552,6 +552,7 @@ static struct symbol *examine_pointer_type(struct sym=
bol *sym)
>  static struct symbol *examine_typeof_helper(struct symbol *sym, bool qua=
l)
>  {
>         struct symbol *base =3D evaluate_expression(sym->initializer);
> +       struct ident *as =3D base->ctype.as;
>         unsigned long mod =3D 0;
>
>         if (!base)
> @@ -567,6 +568,8 @@ static struct symbol *examine_typeof_helper(struct sy=
mbol *sym, bool qual)
>         sym->type =3D SYM_NODE;
>         sym->ctype.modifiers =3D mod;
>         sym->ctype.base_type =3D base;
> +       if (qual)
> +               sym->ctype.as =3D as;
>         return examine_node_type(sym);
>  }
>
> --
> 2.51.0
>
>
