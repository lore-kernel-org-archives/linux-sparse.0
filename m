Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47D23B0
	for <linux-sparse@vger.kernel.org>; Sun,  6 Oct 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728173236; cv=none; b=Lhx2AqVVrcvV8y1G+4bAJkjdXy7SjlzyblZgcsLj94bxDixyi3vBz7GUCGXVhD7w7qabNf0UWo56zSIzTq6QY0ZumbWEBqC+bSW2UaGnEHXpXtOv6VhREdoV7YrjdfceoTKZe0a8CIpTjOLAw9sJd/olizcNrNP5y+1vT7W697U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728173236; c=relaxed/simple;
	bh=7PhV7mSmrjXdm322I5AhDI6uiC32DXT2Ek81VrbJ7rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCtsOTYBSqK5xeQCmROA7iOFR5LTk0beg0vf5mnxmlIw+M75sL3d8aO0/+o+UFcB4uWhJAuJcsFYjMo4ooB/HJOcc9n1+zbZCirXxwKFvUNWWY2gdxaelklqICKctU84mJ4TLEfF9aNcLuYr1oYCqtcR2nDQb4VHLnVbjbhfiuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FUI1oMMx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FUI1oMMx"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso3904915a12.3
        for <linux-sparse@vger.kernel.org>; Sat, 05 Oct 2024 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728173229; x=1728778029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwWtZnU6O3CUnR/7Ge8+NpuQOrJwSLSqT8+8zcDG8JI=;
        b=FUI1oMMxEy269ovQ1qzSn5sSnnf8EqLFk9vdOf2xrAruwD/a6GijmxZyTz5Uc7ajdj
         NTnY8/MiyFCMTs3NLg6pEUj3dNk7U2rR5rCec2Rq3cGTggGI4kl4i4ELgsgU84F1rnYR
         MnyApxvPYUpMnqPxi9S5HGaKgss5iZFCpYjEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728173229; x=1728778029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwWtZnU6O3CUnR/7Ge8+NpuQOrJwSLSqT8+8zcDG8JI=;
        b=tkUM2pWqWbCIY8kY4jz9PTGrurvFghyen/Aj8THiHzyqqQ6ck1FfVrqQELnBaOsvy/
         82knQLY1ngivHzeii9BIKJjNpdks0f7Y5tCIXU6i0W1y0xX3FoXlfG/lQRI04cZa0qCw
         Jx+1+o9vW+0JQ3D/SvHzS9b/pX/KqL8/XU8vjJMCSjYn4weLyIddN8+HIoGxvPVkBoVA
         4+ripP8bClxl9HZwBgwyvxdEq/wwjIrDcoNoBdGIJLKMZXDqcsF0D3tHKyCNEMIcvht1
         SUPY9+aidWDcJLfxNucCxar6yNmq1+6JOCTZ6elJuxlFTQApzBqv7TLrabHBcVuEpHrY
         97tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn8s4jVjv2HLqwn2ZpGsa9RiNn+XJ7umZIqZQbnFr3kukNUY8O2KcGfqPk7WMuWQF/Fse0Cz7Lm8V8RUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvecKGoNWDD/I6+zkWRgoOpmR6fPerfXv28Y+Rthks995OeP7i
	1/1tB3+JCXlHEhdyL87MAEI4dARSLTfm1OwiumH4NT1yHLF/37xiM36jsuUpVZ9zQqpH+CErhsj
	zDcO0Bg==
X-Google-Smtp-Source: AGHT+IGKXUoBxQqRXTpPbVQQd3KjZkMTc0sU+Nxo2wftPPEu3XaLnICyFlBsTh/kkb8mfNwsUaEriw==
X-Received: by 2002:a17:907:3f89:b0:a99:4879:ec2d with SMTP id a640c23a62f3a-a994879ed0dmr97927366b.5.1728173229571;
        Sat, 05 Oct 2024 17:07:09 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e783d86sm188290566b.136.2024.10.05.17.07.09
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 17:07:09 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c8a2579d94so3924780a12.0
        for <linux-sparse@vger.kernel.org>; Sat, 05 Oct 2024 17:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXESO5dPCrE7eVNupvx3XQxl6Ou2L5HiUQhiPHQ/NkrkG/7B9u/QVfAB7dyenZOCn9bIWn7J/MKMCNDf4A=@vger.kernel.org
X-Received: by 2002:a17:907:9693:b0:a99:3d93:c8bc with SMTP id
 a640c23a62f3a-a993d93cc22mr339286866b.13.1728172818387; Sat, 05 Oct 2024
 17:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
 <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com> <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
 <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
In-Reply-To: <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 17:00:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
Message-ID: <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 16:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Sadly, that is not correct; neither gcc nor clang uses lea:

Looking around, this may be intentional. At least according to Agner,
several cores do better at "mov immediate" compared to "lea".

Eg a RIP-relative LEA on Zen 2 gets a throughput of two per cycle, but
a "MOV r,i" gets four. That got fixed in Zen 3 and later, but
apparently Intel had similar issues (Ivy Bridge: 1 LEA per cycle, vs 3
"mov i,r". Haswell is 1:4).

Of course, Agner's tables are good, but not necessarily always the
whole story. There are other instruction tables on the internet (eg
uops.info) with possibly more info.

And in reality, I would expect it to be a complete non-issue with any
OoO engine and real code, because you are very seldom ALU limited
particularly when there aren't any data dependencies.

But a RIP-relative LEA does seem to put a *bit* more pressure on the
core resources, so the compilers are may be right to pick a "mov".

               Linus
