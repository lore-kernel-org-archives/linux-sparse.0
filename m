Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360F2BE630
	for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096378; cv=none; b=VPN11uDdfsJg2y86XQ03/7uvnP5j92CnWYhSgWZXpOcFKMH0ZhmcLwHLGIGWw+bd424p45s9RuS3TjsLHgGsj+ZhzftiDI+J2jtUiILbKr8uRUHuqZXWmUXkscC5US5usOb7aAEBNfPEGckk35LaK+KumFhPSRZ+FJLa5bHBBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096378; c=relaxed/simple;
	bh=8pSoe1Bmi+W4NijU12aYw3XcputPGwR7O6GNCXc/aeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwqUzNn9mbthnkaEIPTqXcelJJR6SlTD6neZthCppP1hnfCNoKzHka5WYoaJx4ByF3Jyt01v7q2HL2yiXtG2bhDb5MHh5Guj4OL+MLaEZQMlNEfQ1kWLinuE9RcrEF8yRA1hWt2D127lQv00sAuFFNSYzjaKSam3eZ7xVu7ikSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hKt8NWzW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hKt8NWzW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso1448421a12.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 14:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1766096375; x=1766701175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jndt3SqYxM2jZAywVtZf3yYDl10GUxyvdAXQWbglW60=;
        b=hKt8NWzWNyraTlujpEXqx0g2ePOdKyek4W5RuvhcwbQC8bPztiGMN+1BbFQcCYAgaI
         EbleYrxhFJymdmeuxHosMhW1Opo8VzVO2rJSUqxH2zF1Agdm5mn+v9PJ5rg19MbMeeQn
         kp3TrNGr9FgnTrK4z+Ql1q4fxY9aG6MZVieQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096375; x=1766701175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jndt3SqYxM2jZAywVtZf3yYDl10GUxyvdAXQWbglW60=;
        b=o+VJHbVSGs70tCK/ljVlR0fo/EV9JbzHIcQu/dIlNgyHLaqvVqHbOkY7iFRJhygKDl
         sdiJL9YENF3YGMeRpLogzYD9S9jbOW3rmzQ0Xo3rLaD2bHBR2qbsQlmbwWpeAR2L+trS
         WrCtxLU1XGFoQWqzfriL+Qcoa2nmeleII9nsZa7K1rqfh1f8z0UuEJUS+HeP8JMfz8K+
         A7K9NEPUjy5PExj/e/1fXk2LIAo7HeiEgE/O+YHZCyZaXyDl1kIRYwZnFuMXdpT60ETf
         pwbwISGuh7X7dltQZZw0z1KiqulPmRIu6MBGJ7nUKHujLspW9jDeLzeYRztMJgBg6Dbq
         GxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6XgAJ1qD48jzgqQHhZZEoovw4/IffG5AjWe9iebv1mfUgPzHjh9SPUmdj2rXH/n/ogMwV+yj773NYbuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xHfmnnO7TgoFD80Eb2XvYDkJxf0vYfeBDwmcL1fflLEG36nE
	vuaXtadlNeA1BSiAjP6u4dSJd/3CTjIeUsgazVDdH8MZRYY5T742MXDIPOll3sZJJuJdO+GnYhY
	Ima8yvliQlA==
X-Gm-Gg: AY/fxX5XEs18hAnoPBE+a2KFeAAa8csigAPB9qC0mJi+UczZ0LHLUk182SC/pehmIKH
	N79r29tDZfz5fOO8Xk5mUJkcpvkaQIlkRXw8Sk3KON0ZW51JDxuyhcIf2ZxKt7arCshAUJKZWk8
	ss7ipWqJGBPrdoXmnojDTEamrs3ahPVZ31y2um7XKDfE4mU+ca87rv6zrYc1CD9eZqAC2jJnVnd
	zpMBMYUP6kgFn8JTUfVCN+r4YzHMlkIudESXnL42x8vtekzwHNHqWXbgQiTpD4fFhQ6KH1t7jqX
	YMakiUyFKarwGvAqmGdpTZFlGpt4HlCXcyxZLFnC6EbLpaIr1EqCi62JTg3mmTsOzG1+d9Q3cDs
	WeYX8sUtfeEzdSxNJnc1wGNzUtt5c2yO/RqB2xZEcYIqvCcxvAszcI+jrMraKoDiOAbsnofQbX6
	b2HO1845gVy5ApjC0jE1k/1QbReMNuVXkt3RvEkGNmy8YOe1Q93LShkM6qi9C7ZANOp4IR5Xo=
X-Google-Smtp-Source: AGHT+IEqjzOKWXT7VhhRx9FOviGynhbYVdtd15ezmvCxA/VxXmTDEU2NzVGkXkyvLuWRfHdR4X5uxA==
X-Received: by 2002:a05:6402:1ed5:b0:641:966d:82ba with SMTP id 4fb4d7f45d1cf-64b8e944ef3mr774975a12.1.1766096375187;
        Thu, 18 Dec 2025 14:19:35 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b912534f2sm530914a12.15.2025.12.18.14.19.32
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 14:19:34 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso1448367a12.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 14:19:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURNIywDRSEI7FMzYUvpODUU3P4CUwM8h19fpp57x55FbEJ14YxharydwYNJFSKvPcBsy4nGUGjBuhDnUk=@vger.kernel.org
X-Received: by 2002:a17:906:4fd0:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8036fade7bmr90274566b.27.1766096371748; Thu, 18 Dec 2025
 14:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <20251218202644.0bd24aa8@pumpkin> <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
 <20251218220651.5cdde06f@pumpkin>
In-Reply-To: <20251218220651.5cdde06f@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Dec 2025 10:19:15 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjMVfu-aiQ8aNHcgsh6hYwbZCoX1B4ps2scibokO8EZ+A@mail.gmail.com>
X-Gm-Features: AQt7F2rQbkmjgbTYE3I0u5o-OP0XOCVU9BjhcXCAu035ycTBeAxGxqvP-3yEHoo
Message-ID: <CAHk-=wjMVfu-aiQ8aNHcgsh6hYwbZCoX1B4ps2scibokO8EZ+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
To: David Laight <david.laight.linux@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-kbuild@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 10:06, David Laight <david.laight.linux@gmail.com> wrote:
>
> True - especially for code like:
>         if (x < 0 || x > limit)
>                 return ...

Exactly.

And yes, sometimes the type of 'x' is obvious, and having the range
check for zero can be seen as redundant for unsigned types, but even
in that "obviously redundant" case the code is *clearer* with both the
lower and upper range checked.

And apart from being clearer, it's also then safe when somebody does
change the type for whatever reason.

And lots of types do *not* have obvious signedness. They might be
typedefs, or have other much subtler issues. Something as simple as
"char" has subtle sign behavior, and when it comes to things like
enums the signedness can also be very non-obvious.

So having both sides of a range check is *always* a good idea, even if
one side _may_ be redundant for some type-range reasons.

And there really is absolutely _no_ sane way to get rid of that broken
warning except to just disable the warning itself. All other
alternatives are actively broken - adding a Pragma only makes the code
worse and illegible, and removing the lower bounds check again only
makes the code worse.

So this is a compiler warning that actively encourages worse code. It
needs to *die*. It doesn't fix anything.

And the people who point out that it can show bugs - absolutely *ANY*
warning can do that. That doesn't make a warning good. Any code can
have bugs in it.

The sparse warning I outlined (and that Vincent wrote up and tested
and made into a proper patch) was actually showing interesting issues
in a much better way.

And that sparse warning could certainly be improved on too - I think
that one too would be better if it noticed "oh, it's a pure range
check, so let's not warn even when the code otherwise looks dodgy".

But at least it didn't warn for obviously good code like the horrid
broken type-range warning does.

                  Linus
