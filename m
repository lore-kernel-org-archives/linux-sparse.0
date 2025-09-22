Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF83208
	for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542539; cv=none; b=ll9iEE6EW22tn+ger0B7CFX6uVNbgBZcNzaa3JmbjEnAWWs+kOs0+Y4Hpd4vg2yS9CknPGaExOOCn1GxTWEGVmQVIl7ujZ5c7ySLfy9HXLseCM375puqWTwLgpDo/eA67qlWA6GpE0q/+dH1Al7OmG2qZTKFjehBop74dknpaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542539; c=relaxed/simple;
	bh=pdQ9V8UmBPKbt9LyIShwn2nTXLC+NavVJPswrsZXl4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBzHun+qaOSwJeTsHR+rprikci+9qrRopo+7FYzp0J1zCNlV1V6qc3Dv+xFVKM+Cxq/3lughtDA/8v8ulePiNDv+8rabETvEost6s8t9bk+y+I2jNAbnhpayTHasUmEen4X3oR/ZM7AjhZ6C/EOsZdlOBzfu+g0mRXuy28tXs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6051afbfso35419857b3.2
        for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 05:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758542536; x=1759147336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdTCC8fm5oPl1VS9cSNPziG1AbFTbegF4eQEeOcBk9M=;
        b=bktOV9GWlkYR/yZOat/+b1ZeP5oT31Fz080ZYZOjWBQXTDMwy6H3bDOP2FNWxmVdFc
         4srU9Vm3Hvq98e+b8aD2ON9ZgqN37VE52b4MFb0mvup9fBvjmy04DiqsdOIp12iASXXx
         WopMayRTISD+pcDrSqmbc5sL8TajhAacPVJRpOqK1GnqmuJFRb/ZR/Wb1EZnhni+dxNo
         cFFffvd5zXnInV8RL0IzA7nxz6+V7q6Spe7azd1ZdLRrXWuYQsZCWtEYYbQVBzd+CnT+
         WEto/Wk1BYHeZ7DAQ+EoC4HUe8GwUFmOgUWEFih2tccLgDel1UaIOeZjEOxFz+IqNa6T
         KB2w==
X-Gm-Message-State: AOJu0YxC4srhc9SVn7/rj7VgSoXxVnWvD2KqT3pfL8B9Ej0F4MKxy3qR
	8ljxjZQ7Tpu6oTS01jd5odkT1igWpx/Li0TmDB9v/HbjHSR8watyLjq2Bv/tz5l7pXdTH1ivCrC
	jj/BTeADERoLC4CChrj+HxX3dQ+E9LG/wwdxiFGQFNQ==
X-Gm-Gg: ASbGncsVuJyWu5I8Xt9ohVbJ4gOyo+En2oxmWxEoYFLEF3t9lVuhw7Ylqrr4kxnvTTE
	zcl+ggykiFPFYn5qdBqwxwmnLrMUFanM4v5Dw7kNLixd263TTql3LEFqoRWH5m8zboeXv2+CahH
	WNMht1NEc4RM1UbJmmYTDGfdPIaA6Y7SwRgcQ8/Qh7sU3+eNMlqghG2H4lEw6qCjOtprGueTP4U
	Ns4dQ==
X-Google-Smtp-Source: AGHT+IFQq8YDFHZ87p1iLPPU3o2XJ+UJOg9Cxz5EHWfN+q5yBpPqph3LZz7l9jKx/pidIq7PcnypE9ryenGyndYd1z0=
X-Received: by 2002:a05:690c:6282:b0:72e:13d3:fdf5 with SMTP id
 00721157ae682-73d3a52a618mr119338237b3.26.1758542536120; Mon, 22 Sep 2025
 05:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921061337.3047616-1-mailhol@kernel.org>
In-Reply-To: <20250921061337.3047616-1-mailhol@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Mon, 22 Sep 2025 05:02:05 -0700
X-Gm-Features: AS18NWBwFljkMySPKsMph6CbiwaLrFJlq8RqTnY0VRXLY9aPK7a7OuAd5pGPoSk
Message-ID: <CACePvbXRkT7wtc2nUttMVXWw7C5r_zLewj1fWkW=9pjAxagLkg@mail.gmail.com>
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against zero"
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 11:13=E2=80=AFPM Vincent Mailhol <mailhol@kernel.or=
g> wrote:
>
> Consider this first pattern:
>
>   void error(void);
>   int check(void);
>
>   void foo (void)
>   {
>         unsigned int ret;
>
>         ret =3D check();
>         if (ret < 0)
>                 error();
>   }
>
> Here, the comparison against zero is a tautology: ret, which is
> unsigned, can never be negative. Thus the compiler will remove the
> error branch causing a bug.
>
> This pattern is caught by clang and gcc's -Wtype-limits. *However*,
> that diagnostic has many lost bullets. It will also complain on some
> legitimate things such as in this second pattern:
>
>   void error(void);
>
>   void bar (unsigned int val)
>   {
>         if (val < 0 || val > 42)
>                 error();
>   }
>
> Here, the author just want to do a range check. Yes, the
>
>   val < 0
>
> comparison is a tautology, but that time, it does not result in faulty
> code when optimised out by the compiler.
>
> There is thus a need for a check that will catch the first pattern but
> that will let the second one go through. The difference between the
> two patterns is that in the first one the value returned by the
> check() function used to be signed whereas in the second one val was
> always unsigned to begin with.

Sounds like a bit heuristic but if it helps to reduce the noise level
that seems worth it.

>
> Add a check in sparse to warn if a value which used to be signed gets
> assigned to an unsigned and then gets compared against zero, either
> val < 0 or val >=3D 0.
>
> As pointed out by Linus in his original message, a few false positives
> remain, especially when many inline functions and macros get involved,
> but the level of noise is nothing in comparison to the -Wtype-limits.

Can you please add a few validation checks for  the positive and
negative case? You  can add it under the validation directory. With
validation I can quickly catch the behavior change in the future.

>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=3DwjQCbRA1UEag-1-9yn08KNNqerTj++S=
CbbW80At=3Drg5RQ@mail.gmail.com/
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Hi Chris,
>
> I saw your email in which you announced your comeback. First of all,
> I wish you a warm welcome back!
>
> Second, I would like to inaugurate your comeback with this patch. It

Thank you. I did apply the patch in my local git branch without any conflic=
t.

Waiting for your test case.

> was posted by Linus in the middle of the huge thread about the Rust
> kernel policy, so I guess it did not catch the attention it
> deserved. I have been using this locally for the last half year and it
> works fine.
>
> So, aside from a minor change as listed in below Changelog, this is
> basically a resend.
>
> As for the tags, I tagged Linus as Suggested-by and myself as the
> author. Not sure if this is the most appropriate tag, but adding
> Linus's Signed-off tag seems wrong, so this is the best tag I could
> think of. Let me know if there is any more appropriate tag.

Looks good otherwise.

Chris
