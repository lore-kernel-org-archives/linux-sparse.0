Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A332AD16
	for <linux-sparse@vger.kernel.org>; Sat, 17 Jan 2026 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768608903; cv=none; b=J7NKemjOG1F0mCpm8irgfATtTl4YH3Qni40DuukZYQM0m42K0kSl6tZet4GhzxOlUWBocnBtr2ltB7CY0Vb8rl9lOmDIZAe8UF9izW1evjgLNM21zQd0t54nFWpK3HLmMX4phS3SwlOJ3PYZpIwYHmwSHD+jT3hxn4ubUuPrtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768608903; c=relaxed/simple;
	bh=PvGhrj3J53JGX8Dgy6RpDIko+X968j99gmCT6+L/79g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajH34d+zOda+eWah4alQaOYLF8uYLH9jNavRwkqKYTD+xvySg3kWLtbXImzwfelkE0ZSL3s97yZKeJi7mlVC5RFlPY58tQR/o+weOyMWIsXIA6u3GnbygcgRXo4TkPh6IFGeEAG231zC6OgunY1tiwm6aJjabW+b1UNc2QG4RNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78d6a3c3b77so39986247b3.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 16:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768608901; x=1769213701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvGhrj3J53JGX8Dgy6RpDIko+X968j99gmCT6+L/79g=;
        b=uzNONq4YPHgypubewJonvrzCow6sMtUcE6ZkDZbXBhK5sB0MyAlvkHr6JuOJCaF69c
         yb8et5W/XEQT57q38dXULarqvnjlYM/n4D/E6oCpAVOZpoq78NYluWCej8ZTmQGz6do0
         1uILIMVu/85bjtBHGUGbH80q7Ag4maMlhJ3/BdnT/IegovJRSgtxozHUq5dHecxsPXd5
         g6elZY+pVFVl5poeGPKOLqKHCccjFmBXaZ/QdP/+kUluA2kcQSgPaBcYp7nLhRyQCW+j
         7nSDLklwjT2QggbKwwFX6ANPN6CdBE1qzr4JyDkdXm5H8Q1J7z3nsc7BGyTngh1nSRHd
         vvOg==
X-Gm-Message-State: AOJu0YwfdILz97z9N1QV21Z97yJEP4eRC537ZZfVqNKSMp4iVd72WyTl
	1MTdOsnG19cNJl4wFUuuLpQVoBPWas5rq5AH/WO9q9edXmxfX4mBreP3f4xizNEGCK6SKqVOsqw
	0DeGLY0UzxblIxtZhJStaIcanFYehQLiAnTYm+dy5zai7ddeb1M6O
X-Gm-Gg: AY/fxX5BW3KK3aHP0FxsrtMrI5PoG/9BlccbAAE9aRgBsMCbyy0rrMfm/EZWOyIgDCE
	xrsQoP5/8zsWsDUyuuYTQkuQD8YJwxdWxckPTwNMUJLRd4pF4tOvkevVxteFtVWjWU3kXgp91Rf
	U9xZK5i75hYX6p9MBMf115v0X5W1DqKTJ9SihAOrWHDvfJmmdoqnXAHFAMy0M04mCei12ZnPzDL
	xFFrmuHJiP/TZ5iuCKDhQBt9Tba+ItJchRDlRoYgvBuqjIl9KsrU4ddAjDQSpouAEEnFf7etr49
	AGCENoZHtHjrIw+k2FNX5/tCzawJjPvT1aPpi6MFv07XZakZU8P6abIlXA==
X-Received: by 2002:a05:690e:144c:b0:63f:7c9d:d378 with SMTP id
 956f58d0204a3-6490a5ef493mr6383170d50.5.1768608901599; Fri, 16 Jan 2026
 16:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020153918.812235-1-ben.dooks@codethink.co.uk>
 <20251020153918.812235-2-ben.dooks@codethink.co.uk> <CACePvbVvsAPURh+jfb2Vh8cPsOzuR2HmzuD9j5Gf6GJyD2orng@mail.gmail.com>
 <11df30dc-e1d9-4f40-a9ac-43cb1af69da0@codethink.co.uk>
In-Reply-To: <11df30dc-e1d9-4f40-a9ac-43cb1af69da0@codethink.co.uk>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 16 Jan 2026 16:14:50 -0800
X-Gm-Features: AZwV_Qj5b0jnNuI_ip37Dasi4U-80iRMVxKht8A55Jf0X_IBN0Z6jRvVAZTuIuw
Message-ID: <CACePvbWpTrKpFXLr4=vkVpDqhU7wd=RMOy4Wm1gAKhVtEv9=wQ@mail.gmail.com>
Subject: Re: [PATCH RESEND2 1/4] parse: initial parsing of __attribute__((format))
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 3:49=E2=80=AFAM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> On 01/12/2025 19:23, Chris Li wrote:
> > Hi Ben,
> >
> > Thanks for the patch and sorry for the late reply.
> >
> > Your format attribute series work applies to the sparse-dev tree fine
> > and "make check" runs fine as well. Thank you so much.
> >
> > I have some trivial coding style of feedback for you, see the comments
> > below. Mostly just nitpicks, does not impact the coding behavior. Let
> > me know if you want to update a new series or I can be lazy and just
> > apply your current series.
>
> Thank you. I've implemented most of your parse.c/symbol.h changes now.

Great.

>
> I am not actually back at work until 2nd-Jan 2026 so may not get
> all the other changes sorted.
>
No problem. I just started catching up on my backlogs from the holiday.

Chris
