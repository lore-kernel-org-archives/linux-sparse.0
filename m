Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372C27510E
	for <linux-sparse@vger.kernel.org>; Tue, 21 Oct 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030294; cv=none; b=f9HPTMaGWjJErLIXkXkinc8W6a8hmlIZJa1u1OtncyYl0hRqYPmKIDnWp/IUarbeLmiHTBEQGwD3U3C24oXgzdZqpqklpPVLX9cPUwOuEiZqrig98v8R/8PfNQ9r0n4MEteeYOW63wFF2+NzQN9JyavKREckcxxDY7wC8XRbasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030294; c=relaxed/simple;
	bh=8Uh+5NgTc8yuhaa81sUe2C0fpkyyWOZnaAIiWlSZTjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKMVlnqLhXkuHHvbK5rbASmlZvwRK913ib7sdhRBYotU8FJJUjZ25dAXgxPDv62O26XY/l/JYIcdqsvLLRB7hh4EXDk0VE+LyTEAemvD+Qb7xdfldmk8dB+cNjH95jcG1JwWVgXffCztZUvTJ8Ml8/71HyNl36B1yjt+csc7gZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63bcfcb800aso5634175d50.0
        for <linux-sparse@vger.kernel.org>; Tue, 21 Oct 2025 00:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030291; x=1761635091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbOLMKnyI776gxnbzu2uhCjDzJJVpcONytqUm8JwmcE=;
        b=JeQ22jn/gpVSYVdCO65abICNTz99ahu6MoBVA5mruMbz/EV8FAB1O4Bs7XlxGi8Pod
         CdlPvF5Lw3swpKcNVfPzZsW8+Pl8CJikHBD+f9aAbBmf9qie0pQV9O0DquBGIymopbrA
         Wrq5ATvNfX5GzQDQdyuDV04+GiFoCplx5yBQ8teyB2tMBpSl8LLldwk1RevzTKUyyqgW
         /0mqTMA96n0zlAmVIN5yQDmk876WcRjeeT7Md61RZPsRIzt+/udB+mYBz2H2oQPSn6uo
         VbBTEYHM/T7xHNq9jxq76us8AO1LMQLe1mnO5iX7JiCespFeaA3Dlm9MJOfnrRlvgaBM
         zyHg==
X-Gm-Message-State: AOJu0Yz3jls9w3N37ihxFnO/e4XzxdH5vKcGPZuUlPES20DnZeqHZ6LK
	53iW/AGOLIzb2oFnimiA3sjZQpJR3CvuSs4t4aGYwMnByqns9rJrb69aOv6ghNbmgNXUzPKFf3I
	uLwYUartbcCRO6s2d248xsCL4rK75mDCmp7Aq2lYbAQ==
X-Gm-Gg: ASbGnctCWqYWhR7aGY3ZA4fJ4DUG5GobJGp5MeqHXo9uIxjwVfTLOBzzCVsJRH1zNOy
	V3C7i3pEVJ3HAyodSTtD/LQjKy7eDHFgQU6Egd2+d1TJ2KX47onzKyALCgks6rYevW9UvQWBZ18
	ISwXRIQpYZi8mIoTYEMBO1lxqzM3MekTTNxW3nn90P79NgaLIZVGnucTZ8dkNeXM6XXgtcgmwgh
	UobRdPc4h/ia07UTHV3pc711ZBoATdfukMuv/RLNaXNUPbhUUKHQLCoUEJIxJmf/pjK9g==
X-Google-Smtp-Source: AGHT+IEZ1bLuadrKI3fzMubWo6eLAjyQ6Dxr4ACtosCxOnWHiaDFMMQKDmtcxFdSXpFL5Zju6OGc3WgXdQVg1F9TtVI=
X-Received: by 2002:a05:690e:1244:b0:63e:2d17:6a5d with SMTP id
 956f58d0204a3-63e2d17713emr7359735d50.33.1761030290904; Tue, 21 Oct 2025
 00:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFULd4ZV6OiDZF8zknddrxPRTD5vhSQE6nEux4dr+2p1A7N6uA@mail.gmail.com>
In-Reply-To: <CAFULd4ZV6OiDZF8zknddrxPRTD5vhSQE6nEux4dr+2p1A7N6uA@mail.gmail.com>
From: Chris Li <sparse@chrisli.org>
Date: Tue, 21 Oct 2025 00:04:40 -0700
X-Gm-Features: AS18NWA9bYmyq2ROXCu3wiuJkjIXzJS7dhIqb0gbKtS5wIiAIgXN0tJqWxDmTzc
Message-ID: <CACePvbU_NNkQVP9tMuu5vzcBsCApKV9+viWCEO6drwg3WhzVJg@mail.gmail.com>
Subject: Re: typeof() preserves address space information
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Changyuan Lyu <changyuan.lv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:31=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> The following testcase:
>
> --cut here--
> #ifdef __CHECKER__
> # define __seg_gs        __attribute__((address_space(__seg_gs)))
> # define __seg_fs        __attribute__((address_space(__seg_fs)))
> #endif
>
> #define __read(var) (*(volatile typeof(var) *)&(var))
>
> extern int __seg_gs m;
> int foo (void);
>
> int foo (void)
> {
>   return __read (m);
> }
> --cut here--
>
> compiles with GCC (15+) without warnings, but sparse warns:
>
> _.c:13:10: warning: cast removes address space '__seg_gs' of expression
>
> typeof () operator should preserve all qualifiers (const, volatile,
> __seg_gs, etc). OTOH, typeof_unqual () operator strips all qualifiers
> and returns unqualified type of what typeof () returns. Please see
> notes of [1].

Hi Uros, thanks for the detailed report.

Anyone interested in turning the above test case into a  validation
check? We can mark that test case as "known to fail" right now. We can
then give it to some sparse new comers as warm up projects to make
some failure test cases pass.

Chris
