Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535192D595D
	for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553098; cv=none; b=mo41Q1sVMIVymbCJPPgl7PpiWTPbZtH3pADH9uFwPMYt2Rg0w/q+wQAIi60rEfV5io9ueCz6EKP/TzkTswvQtsojrXyYgoDvXsEdA8eBsbzjL8gG8vBBGq67YfZk/4NjTuRZWSkwZQ7Qas4IR9vBcUrjWhKO44w6zmorW/UQYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553098; c=relaxed/simple;
	bh=FofrL7Y0Jhb7MJF1ei7O1UvzpUWVpMmfXL5GBqXX4lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAMFKVcAs+JmRa1RJc7gy1VB3JFtTuHMd+AMc2EdxnqNNWlv5FA8Q6cq4hEHuP/0wLME9kcuRk2FrgNyQw/B1+UV4BphDWOiXdu7M8c6TKdidX8Oqr7+rBE19w/mDjYoGTTuexIAadFhF9crYosmvzfSnNpIkKvp7eUJJei+BZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea5c8833b15so3491219276.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 07:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553095; x=1759157895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BH6vss2InO/V9HBxsP4txk8LXcv62uNkUke+L6APgx4=;
        b=WsuJAoZdifgYO5wg9LZucyF12fWZ/hQZpDXc0O495UgPnC+HkxhLhqqtH520biXZyl
         cyVdWaEBfBeIX/EDZoDtwXzWT4Gp104g1pQJlfA6a+OaFJnZ4WRo/XDjMUPYVpECNv81
         pptMiU64nXBG2Erchd7ucW57nsSA7bb0N8JM88egJcGdcDDrZYDrN2JwaxXgW0TeDTyg
         oJ7Ca2IBhLAPMawbjJKzOXfK6yeUHzCyNXrsc7sPIpLhuI67OAHAdleXMCNFICkBJSXK
         FMRAqP5+Kb8si81H4Kh3zsJwdU/K3o9uSAYnP1ARi4NQ4gdo5XHB9A9C6NKWgxbrQ4qQ
         3fEw==
X-Gm-Message-State: AOJu0YyJacAaUUizeYunWdpWgQW3gnET0wMLMHkEvwZrLMGjoFznujsv
	rQ7smQJJGfDsVdoxPje3J60IvZ0nNbMUamIRvhRmHkEeXk7VRLWjimot6r0l5dOIRUX37bBMKDY
	w9PnjEQtyN0mit9js4EsabqkBnu94B16xcn8K3P1Frg==
X-Gm-Gg: ASbGncsdxTZTCekGSQoELMBdqaNRZxc8MkqoOmsxUgjy6Sb/BcVS60JLhVwc+g54EeN
	UqfyUVQzGpJ6ty02Jp1rcum3FHoVcZOskUR7KPC5v3VZYIKIAjAu2G5Fk6biox2D4DUdLQACz5n
	4qyYHrC6CRH9JaYGgnVQggUzqpK4TixqTXVhQ7vScOVaYrFwP23q3coGYy2U0Efj3eFVPc7WvYl
	SujxA==
X-Google-Smtp-Source: AGHT+IHHqhtZoH2C1z3hO3IbPq9+cp3uxz43SbuKUlWFIkNziMcZ20bMcPNsY8xO5RN5rZRVYGV39a6ZZyd3dh8txg8=
X-Received: by 2002:a05:690c:6410:b0:737:a8b6:af3f with SMTP id
 00721157ae682-73d21b01e53mr106378827b3.3.1758553095184; Mon, 22 Sep 2025
 07:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921061337.3047616-1-mailhol@kernel.org> <CACePvbXRkT7wtc2nUttMVXWw7C5r_zLewj1fWkW=9pjAxagLkg@mail.gmail.com>
 <9d263950-f44c-42eb-b22c-a5849399f036@kernel.org>
In-Reply-To: <9d263950-f44c-42eb-b22c-a5849399f036@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Mon, 22 Sep 2025 07:58:04 -0700
X-Gm-Features: AS18NWAq0eUrwrvk2ljXwtrA7bk-rthCcZZBV12PSXES2jIZX3X0GAwG51ApH5I
Message-ID: <CACePvbWQVBNQAAreW-Mzkp8ircGtV+K=gNk39HmUC0TNDOBCwQ@mail.gmail.com>
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against zero"
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:00=E2=80=AFAM Vincent Mailhol <mailhol@kernel.org=
> wrote:
>
> On 22/09/2025 at 21:02, Chris Li wrote:
>
> (...)
>
> > Can you please add a few validation checks for  the positive and
> > negative case? You  can add it under the validation directory. With
> > validation I can quickly catch the behavior change in the future.
>
> No problem!
>
> Would something like that be OK?

I was thinking "used-to-be-signed-positive.c" and
"used-to-be-signed-negative.c".
Merging them into one file is fine as well.

If you have other positive and negative test cases, maybe it makes
sense to have positive and negative as separate files so make things
obvious. Just one each is fine in one file as well, your call.

> diff --git a/validation/used-to-be-signed.c b/validation/used-to-be-signe=
d.c
> new file mode 100644
> index 00000000..75c0ca38
> --- /dev/null
> +++ b/validation/used-to-be-signed.c
> @@ -0,0 +1,25 @@
> +void error(void);
> +int check(void);
> +
> +static void foo(unsigned int val)
> +{
> +       unsigned int ret;
> +
> +       /* Positive test case */
> +       ret =3D check();
> +       if (ret < 0)
> +               error();
> +
> +       /* Negative test case */
> +       if (val < 0 || val > 42)
> +               error();
> +}
> +
> +/*
> + * check-name: used-to-be-signed
> + *
> + * check-error-start
> +used-to-be-signed.c:10:19: warning: unsigned value that used to be signe=
d
> checked against zero?
> +used-to-be-signed.c:9:20: signed value source
> + * check-error-end
> + */
>
> Output:
>
>   $ ./test-suite used-to-be-signed.c
>     TEST    used-to-be-signed (used-to-be-signed.c)
>   OK: out of 1 tests, 1 passed, 0 failed
>
>
> Also, do you want the test in a separate patch or should I squash with pr=
evious
> patch?

Ideally the test is before patch so it can show the before and after
effect of the protagonist patch, making more test cases pass.

Chris
