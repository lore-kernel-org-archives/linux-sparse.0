Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF902EC0A6
	for <linux-sparse@vger.kernel.org>; Sat, 17 Jan 2026 05:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627534; cv=pass; b=jo3vyPUnl3ZtxwjV1nvg7S9jSIG9vUBz02WBYQeHLDX+iBQWaK+dydR1W46LuWMH9xYh/4h6J9QxMEWFwx2wkks9YEI7mbeIAbE9gsj94MyGxeGuACRj44dh1356BsPKFQ4QpBBBeGyJhVsTR2gYc82KXWpp/KAtlxehOWBxTLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627534; c=relaxed/simple;
	bh=CZrcCirLycefoe4111ej2P5X3JWWdThJ4Lrv/DkUMtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS/ZVS0h8q5NB62u/4ap7TlT042BTbDIJH6yMLJfTI2YhQ6r7qpTx1+zIzdJOFtVw0ZLT1HrOaJdtCCUNovDAj1DabNrBrTNHH1YFxN7XcOD4EmaGsZz4qk4qyi+5697Cg0srD6vuyE4mrdI97tNYWIVYztUyXAkxiObZVTb9TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2VAFIcu; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2VAFIcu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a1462573caso32005ad.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 21:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768627531; cv=none;
        d=google.com; s=arc-20240605;
        b=CbuF5qIScYiRhd0M/YVaAKOTOoTo8oEB2lD9lotV2Jkagttb4RPskJ7dcGVd2Ljkzl
         zBscOcYN3DBieu2DxW9X5Yb6MbDMH3pAsqEg+eg29D0DLxwNn30kLPf19t9KApi4uxev
         clRxPYzqI35FFD6WCW22ff+GJZZQFfJZZJ4TtY+VPhiBbkDcYfOwvvQF7bMffoa/0rVB
         ENj+WxFnGqlw81gwoTv1xuNhMHkZ6B3qxArox6kLPc2yypU9xJrwG7l7a/uvi5o9MYIt
         kCLUeMxdBT33S7eS7MtbqSaayTw2qT9qvPFp7qUUntPmuV3nOFxtgj3oBswQYH2cp6bA
         HUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/fORF0SuEsYNu493Q/GuuLZlBKx1hUG12V1JDh57+A=;
        fh=1kBrrXm21BWztz3CO5ukcnKaTENerWLFKLHF69Gmd7M=;
        b=MFAUyspg7KOlbriQlerzAiaDh4I/UosrIaS2JN+AhfZI1zu+jSIbw53N+757N4qu+W
         29cN68VpQklFwl2nlHcrVVO3FsYMAunK+XturWwJe02LARTpcbR9ObmN1wV4oZaah4NV
         jNW9fqN+nx++0zJdTYD/k9N4jpRR5ipR6jn8tjw2+ICS1k9Rs4IMBENJbYLGf3iivGH8
         qHu1Ix/c2EM6vplOe9I5RCmW99SLN1/UP1SAnSTdyOj/XdpYCFFmZN82XkibXSIaDqLx
         DrGtlIeb3RCZUME0GvJctLSchRsPBe3WLULEcCaoNyukNLHSlZEhcOqZqa8kU/IA/lkA
         rMYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627531; x=1769232331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/fORF0SuEsYNu493Q/GuuLZlBKx1hUG12V1JDh57+A=;
        b=V2VAFIcuqdfhDBUraIls0pizMIFhdXvWVXIQK/9YaICSEUWVuGQnemmjuk3VIyaJfU
         I7yU/VB2tehn1hFUePeor0Myd1rwL5Cc6/QCS+iDMA6h5Sakxm1U7KQawIRK4GW01+SY
         c/nhAvz584WZGD+IfahONBbrUopSuAf9YIt7jRJYZ9+K1FjIr3Th2FGFeAdlHoSfxrub
         GF8OV+ut4bTsQxAkphsOFMTzeU2ywO9NOszR4TCY+0liQBkLftW5wS/qu+P1qbWolS3R
         nUwq8VKJ3UvDmXtTR+9PnMeIlzLJsgRBf9p4bIszJRrNQQ1WXXbjhMN0qpwJNO5oFX7M
         8RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627531; x=1769232331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/fORF0SuEsYNu493Q/GuuLZlBKx1hUG12V1JDh57+A=;
        b=PgE0MlAsyo+Rxn2T73+z7G4uBu4p8crDWIiVkqa8hpmuuf2vpttii/tVFnQnNDYZtq
         ekw3D/hkgRbshxc3qDfSj1BnOavfrvwr2guHIuCH3DrhDOOYDkK1rMJXzaWyIz9HjEUS
         spvrltSHUxWsTZs0VpJo53cLXgEYNuZvj9oM2HXNs559n6B88jiZbYlaK3b2uwT8GuW3
         fIxu8umLaEajHwR1IbSFEuHMthUXCsTcJz8LManPRdDwBfiUXADolLXYWoSxAgjEFDNf
         w8vrLnqZZqLxFkIhGJoKINTKrjglCHO54GgF9ydth6Jyxk6tNYUT+zcZMsU+qJUSH/Tg
         t7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWrjGimnFoiROdHgmwLrn4mJqkRWdVoREP7JPGX76IuTJiDPOT6pE555cehNv0rT11q9NyfotVmKGJzr9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWN4r1JdVbzeuv6vc6+sWmt+LU3WXtqZX4Qwqhxjv0bZoXgnD
	Wg3YolyrXzrNrd9ANcj33iH7vk7iP2aYekDos0C3tdoKJ0vY79GDs45g8MEWCwhxKq1IB/K30jW
	9dGD7mL1iKjNvNju6m2JWbOo43JUpDNbL2btHXJnm
X-Gm-Gg: AY/fxX5GQR71WAgTJDqSBC+1ErQ5sE3O9H+37SGlbN5yX/TvEX7fsCv5bHQpjDqrn94
	0LJuSjOSlqy8Sz9xFS7Gul6PQ5+zGE8e0Vlns19NFndkk9JfWcz1P0YJLBOZeD9wQnTr+CxjOGR
	3Z9de378IPbdUzwb/93UL9UgITjoT5I0nwWsCz6ijWc24ZH+tk7Kl1m5F1GSl20+JOkxg8+UceS
	dzFaOmmGt3Kw9F8PICSIt5IvraK0dRbZ7lUORHrZPRIIKkWM1NG5YnJnVtoerJfrZabB4gU
X-Received: by 2002:a17:902:f68f:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2a728625c1fmr1522885ad.4.1768627530115; Fri, 16 Jan 2026
 21:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202601150001.sKSN644a-lkp@intel.com> <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net> <87ms2e32gw.ffs@tglx>
 <87jyxh3ike.ffs@tglx> <87ecnp2zh3.ffs@tglx>
In-Reply-To: <87ecnp2zh3.ffs@tglx>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Jan 2026 21:25:19 -0800
X-Gm-Features: AZwV_QhEVYl23HHeAVdTKHizMscT0-PEjMEvGuOECAt3jKQ4Wf6AkWw_qkg8or0
Message-ID: <CAP-5=fUDQ6NTLWVfA2B+3022D6fZjvAksKH5EJ9Agnd1Qzvobw@mail.gmail.com>
Subject: Re: [PATCH] compiler: Use __typeof_unqual__() for __unqual_scalar_typeof()
To: Thomas Gleixner <tglx@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, sparse@chrisli.org, 
	linux-sparse@vger.kernel.org, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:18=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> The recent changes to get_unaligned() resulted in a new sparse warning:
>
>    net/rds/ib_cm.c:96:35: sparse: sparse: incorrect type in argument 1 (d=
ifferent modifiers) @@     expected void * @@     got restricted __be64 con=
st * @@
>    net/rds/ib_cm.c:96:35: sparse:     expected void *
>    net/rds/ib_cm.c:96:35: sparse:     got restricted __be64 const *
>
> The updated get_unaligned_t() uses __unqual_scalar_typeof() to get an
> unqualified type. This works correctly for the compilers, but fails for
> sparse when the data type is __be64 (or any other __beNN variant).
>
> On sparse runs (C=3D[12]) __beNN types are annotated with
> __attribute__((bitwise)).
>
> That annotation allows sparse to detect incompatible operations on __beNN
> variables, but it also prevents sparse from evaluating the _Generic() in
> __unqual_scalar_typeof() and map __beNN to a unqualified scalar type, so =
it
> ends up with the default, i.e. the original qualified type of a 'const
> __beNN' pointer. That then ends up as the first pointer argument to
> builtin_memcpy(), which obviously causes the above sparse warnings.
>
> The sparse git tree supports typeof_unqual() now, which allows to use it
> instead of the _Generic() based __unqual_scalar_typeof(). With that spars=
e
> correctly evaluates the unqualified type and keeps the __beNN logic intac=
t.

Wow, that's painful. Congratulations on finding the root case.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> The downside is that this requires a top of tree sparse build and an old
> sparse version will emit a metric ton of incomprehensible error messages
> before it dies with a segfault.
>
> Therefore implement a sanity check which validates that the checker is
> available and capable of handling typeof_unqual(). Emit a warning if not =
so
> the user can take informed action.
>
> [ tglx: Move the evaluation of USE_TYPEOF_UNQUAL to compiler_types.h so i=
t is
>         set before use and implement the sanity checker ]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601150001.sKSN644a-lkp@i=
ntel.com/
> ---
>  Makefile                       |    8 ++++++++
>  include/linux/compiler.h       |   10 ----------
>  include/linux/compiler_types.h |   11 +++++++++++
>  scripts/checker-valid.sh       |   19 +++++++++++++++++++
>  4 files changed, 38 insertions(+), 10 deletions(-)
>
> --- a/Makefile
> +++ b/Makefile
> @@ -1178,6 +1178,14 @@ ifdef CONFIG_CC_IS_CLANG
>  KBUILD_USERLDFLAGS +=3D --ld-path=3D$(LD)
>  endif
>
> +# Validate the checker is available and functional
> +ifneq ($(KBUILD_CHECKSRC), 0)
> +  ifneq ($(shell $(srctree)/scripts/checker-valid.sh $(CHECK)), 1)
> +    $(warning C=3D$(KBUILD_CHECKSRC) specified, but $(CHECK) is not avai=
lable or not up to date)
> +    KBUILD_CHECKSRC =3D 0
> +  endif
> +endif
> +
>  # make the checker run with the right architecture
>  CHECKFLAGS +=3D --arch=3D$(ARCH)
>
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -231,16 +231,6 @@ void ftrace_likely_update(struct ftrace_
>                                 "must be non-C-string (not NUL-terminated=
)")
>
>  /*
> - * Use __typeof_unqual__() when available.
> - *
> - * XXX: Remove test for __CHECKER__ once
> - * sparse learns about __typeof_unqual__().
> - */
> -#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> -# define USE_TYPEOF_UNQUAL 1
> -#endif
> -
> -/*
>   * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
>   * operator when available, to return an unqualified type of the exp.
>   */
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -562,6 +562,13 @@ struct ftrace_likely_data {
>  #define asm_inline asm
>  #endif
>
> +/*
> + * Use __typeof_unqual__() when available.
> + */
> +#if CC_HAS_TYPEOF_UNQUAL || defined(__CHECKER__)
> +# define USE_TYPEOF_UNQUAL 1
> +#endif
> +
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof=
(b))
>
> @@ -569,6 +576,7 @@ struct ftrace_likely_data {
>   * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leavi=
ng
>   *                            non-scalar types unchanged.
>   */
> +#ifndef USE_TYPEOF_UNQUAL
>  /*
>   * Prefer C11 _Generic for better compile-times and simpler code. Note: =
'char'
>   * is not type-compatible with 'signed char', and we define a separate c=
ase.
> @@ -586,6 +594,9 @@ struct ftrace_likely_data {
>                          __scalar_type_to_expr_cases(long),             \
>                          __scalar_type_to_expr_cases(long long),        \
>                          default: (x)))
> +#else
> +#define __unqual_scalar_typeof(x) __typeof_unqual__(x)
> +#endif
>
>  /* Is this type a native word size -- useful for atomic operations */
>  #define __native_word(t) \
> --- /dev/null
> +++ b/scripts/checker-valid.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh -eu
> +# SPDX-License-Identifier: GPL-2.0
> +
> +[ ! -x "$(command -v "$1")" ] && exit 1
> +
> +tmp_file=3D$(mktemp)
> +trap "rm -f $tmp_file" EXIT
> +
> +cat << EOF >$tmp_file
> +static inline int u(const int *q)
> +{
> +       __typeof_unqual__(*q) v =3D *q;
> +       return v;
> +}
> +EOF
> +
> +# sparse happily exits with 0 on error so validate
> +# there is none on stderr. Use awk as grep is a pain with sh -e
> +$1 $tmp_file 2>&1 | awk -v c=3D1 '/error/{c=3D0}END{print c}'
