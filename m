Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136732D0CE
	for <linux-sparse@vger.kernel.org>; Mon,  1 Dec 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602660; cv=none; b=uXBGttchwkTaqdn2Li206g1ymrewoB7lPOUzvbuDsE1TQ7jJB7wmIsazwfxSCII0VxkuME4KS8zrvYOrBj0hD+PRkWzWph/IwqKcqKYy6ojysjiovqEEvb8OEkbLuEtmOFl6s7pjlv8gqbPI29bqi1n8anputsNKqnskoMJdngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602660; c=relaxed/simple;
	bh=cY9bItRKV7MeQ3fzDvvUnE/5TDLFdE1LprSC6atyqEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIGgH+e2TuOdki2rJvsJ7gBy3XrdEpP+JB6mqkzdwSfg/8lbPYgQYb/9Pgtc6paSu188ScgK8tqNf/gSxSVkg6jaV2+pEGIsBGrH+UFIt/M+h9b59Zjk0OYrt2sYR4R1lkeWnorTqDTIptNaX8zx1xHmZeUsij7hxR1dI2GSsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-642fcb9c16aso3395431d50.1
        for <linux-sparse@vger.kernel.org>; Mon, 01 Dec 2025 07:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764602656; x=1765207456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17bIyn0p3iDPeQSWq2I5zGPQQ5/UYUoRemVY1Guzd1M=;
        b=VeQJb8p2E/gr6s6R/rMkF/Eb888WVYFTg7A9LY1AHlVzjEUJg3m+MugZNBZ4jyS8eN
         0cEugiOLsrvglpcvm2dEnLo1eI01JzT6Vy67wgHwFzB/3ljy9TKkgE+FQryq3GrritSb
         jtuOklWN52QqpoldS8tLE6JR21OAkJFfZDp88nR7zVu4YQCb6vjXBL3fUPedy2Klj06f
         Psi0yTpAyg3ZB5nPYGYSao5GxL1laK9H/KxvcsDQTBO6B7qaKXFRRHywQYFUy0+3wSMV
         qpIPM2uRCDwWjmpqaRBn8uR1gK8VnF+u6wIzk4Bc0XwPHw2bNl/UG+2aUCQqmoKQP9ks
         OhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTI5Jd+z4VXRcMyyjIhGAVZDesZuCyCKJkHL8eBe0bNOkU2v7q4SMz8GQSIk5Q0z1AoIp0+mFck/lbycs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hqcNwkWHnOB0a9WB6oyBs/5IOhYrUx9r+hCeSHR4JwZyKZmV
	2Dj/lLhx5NMP9KxuvOvuwf9p8OpStaldTFQLwBDHc8jjE1MPJSfaJUGhd/5ypBbqVfZ4pfl8tYf
	aM07Vg6snVESa/TNlu8QeUJKqGQaL/vYD5iABTO+d9A==
X-Gm-Gg: ASbGncveR4yHAu5rbVg/+PiCqVLvG9wd5UJmHKGVc/uMG+3p6QLHbbbrRv5aRdknSX0
	WVGb80oYntw694tzZlTOR5jVif+HhfsZVngQVCJjNLzQKh7vKiypvXcfmlOFl3wMCtvLKNeyAhe
	ySBTgeKxTeS9F0rW4TdSPGJp8sK4xt67IPQaGS7Vylks5iUa1Qi3PBpLtGmpniXaQwvc7LWNGTY
	xVxXX7ACnQIGKQ+C0hOwq9qQkB42wGErFDQA1YulPGB/wYbhOq+Q3kbcSZh5zVVsa+n8HAgcLRb
	34v8b1uxF8ePr63oymw69mXcfmUs
X-Google-Smtp-Source: AGHT+IGJcLi766kaUx/+ryPFGP3QH+q1D+JrCmgQ08c9S+BqT9ge41Lqw0U3q/l7V4SU1FDZ/JuSylL6qV6oz8oP9fE=
X-Received: by 2002:a05:690c:6c0c:b0:78a:722f:a7c9 with SMTP id
 00721157ae682-78ab6f496eemr390066037b3.47.1764602656191; Mon, 01 Dec 2025
 07:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQDF2Ila2-LNmllC@stanley.mountain>
In-Reply-To: <aQDF2Ila2-LNmllC@stanley.mountain>
From: Chris Li <sparse@chrisli.org>
Date: Mon, 1 Dec 2025 19:24:05 +0400
X-Gm-Features: AWmQ_bkT-_LLy5FdXkvpOVpXotrcp1eIDyBWHd7QyWlqBol4jh5cOzAPRwA4pEg
Message-ID: <CACePvbWG5iOtCRLRwtfHRSWt2sU65GZ72QDRHaS=p0PnUmh42Q@mail.gmail.com>
Subject: Re: [PATCH] validation: add check for typeof() and address spaces
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:32=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The typeof() key word should preserve the address space and
> typeof_unqual() should not.  Add a check to verify this works as
> expected.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to sparse-dev.

Chris

> ---
>  validation/typeof-as.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 validation/typeof-as.c
>
> diff --git a/validation/typeof-as.c b/validation/typeof-as.c
> new file mode 100644
> index 000000000000..563685281d92
> --- /dev/null
> +++ b/validation/typeof-as.c
> @@ -0,0 +1,32 @@
> +#define __seg_gs               __attribute__((address_space(__seg_gs)))
> +static int __seg_gs m;
> +
> +static int __seg_gs bad_manual (void)
> +{
> +       return (*(int *)&m);
> +}
> +
> +static int __seg_gs good_manual (void)
> +{
> +       return (*(int __seg_gs *)&m);
> +}
> +
> +static int bad_typeof (void)
> +{
> +       return (*(typeof_unqual(m) *)&m);
> +}
> +
> +static int __seg_gs good_typeof (void)
> +{
> +       return (*(volatile typeof(m) *)&m);
> +}
> +
> +/*
> + * check-name: typeof address space
> + * check-command: ./sparse typeof-as.c
> + *
> + * check-error-start
> +typeof-as.c:6:19: warning: cast removes address space '__seg_gs' of expr=
ession
> +typeof-as.c:16:19: warning: cast removes address space '__seg_gs' of exp=
ression
> + * check-error-end
> + */
> --
> 2.51.0
>
