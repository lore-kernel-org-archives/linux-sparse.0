Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C2283CB5
	for <linux-sparse@vger.kernel.org>; Wed, 25 Feb 2026 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003123; cv=pass; b=RtAQa4EqQz+VRikXI2DnMuzdO2mIpGuhz2yiAqkpFrK+DsWZHK1dsUrHb5Bkh2Rn5ntacXHbDHXyuUO+jOe2/u0RhhdHpnw1tzOSZwUEJxtyKi1AFxLbxA5NaEdoS/TCqYeXN2TpCy4iasjdlOnqZNUIXfAE2A+jL1WezjdOS08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003123; c=relaxed/simple;
	bh=pe0jpxuiSkdni6+jSOApAvg05DYj1UIgiaGM7KE0dHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csIte9Hn5sg6o9vXNnNWzHiXMf02sJ+JHlUhnvA72IlSDlzOkLqaf7kbf2AhHCh5ZoVz+/CvNyE508wE1WtM5N3TAPnufvbsPW1Bp/IpxP2DNI+MdQ3iy/s6JHnaq+H1J1NrzYj7zcVRsfXHXjsXdH9ogpQjghUhvYf8jPq9cis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ada2c30a1so5491833d50.0
        for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 23:05:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772003121; cv=none;
        d=google.com; s=arc-20240605;
        b=e1c82AS9T6EgA7QSou/gWUDASVbqVlJL1AIKcdvHz2kI3XNxqmk4+jzCnG6HwIC7ZO
         4Dg1RZQI7MuHUJ9KRXKKuIZ4S1hmftlnkDtzb02Xedjsr1wveIpNiA7Hya6n0bSUCXB0
         7SPvh834Za6n7WM0hlKaPVH1fjwharoPIUjvNesLUo1I270KCxg12fef0iS11GaExkOW
         50h5YADK3zE+zvoImN5Pd7wXR8bPzVTBX7pY2IE/c31uOVqdV+vD8xcqbR77cKxqUu1T
         EtYw7uY7ygywWK66UNVIwz3zt7HrOCBtXNIVyF9NrkhiAOvALcQg8y5HKvqtxH2O8rqX
         VyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=M7bpX0ZYJ8iww9TNZov/i08mhzAsYNiJZ6pcgmoRo3c=;
        fh=d73D4LfdMcCjclwg9LZDM44noheRNvM5wvtPQ/riARw=;
        b=Qwt07SqU6w9xrPptv/BXiKAFvRcmSWEV6BAu2eyHRRN8dR8EVoPnR2DiqOJmiYNW/R
         mf+HX2FXUgTCtcNhN48tVml6AVTsaeN7bfqr9OQwx1AcsxLbGjHLNuSLjKWjm1R3Jyr4
         WU8pIbHwUrtdAaGCKPGl352EeNuZakYPmhWsJ1hulJj7CmSdQ8otf8/UfEC7pnqY7WZy
         Ao4/Tx9jw6kQMvQjHVeEcoDfMp00yb98AWNzeripqLS3//BStd4Hxm5THdQtCK3fWd9b
         5h6+sznJDKRfKScFfT6B0BtC5t3e+viNurpn5jUzjTMX09LIFnbwtMy28ix0O8a6I0+c
         H7QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772003121; x=1772607921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7bpX0ZYJ8iww9TNZov/i08mhzAsYNiJZ6pcgmoRo3c=;
        b=rDn6lRTgoTIEeJd+5D47WKWCjfefJwu3bLWqle7cS1I9yEZVWBt1PySMGSYClaFfiN
         LCOYtZR06ZDx7iFXGLdB8OWr1y1G8Rgj1uXY8CHz4Y461egpWEu1vt3hG19XkVFTkm9U
         X5UfeH/iNUINvS9EOoGGwIJ38UAO4AHTV22FV4vWGCY5Knc8FBVa9Z6e1GOUzxNZb5dy
         YGlXEUNchSDmSyzK3h0ZNclCCwVnKWgmi1Vo5IHhpakwtuJwY1enPD+4t6Yqo4HiCKsf
         SIjseK/noII5RziYcLaeruO2BTBUb89z+P6Rh+3IHUStmsLYRqgik0pBsB+RkkKmMGKr
         ZfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA84wPZ/og5nGLAHAc+whCT/LdP89FeFAleCCHqYbcdjL5h3jAu5ZWTpLqsGQ5yAROKQjXKCWSBlar13o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFB6pkw21O4/0n1svrKMSAgqx6ZnN86X2YS29AMi1lfaqALBPr
	aqjEN2vk9YNuOGFfQV0GbG8zTzNsUnYN7/mjMs3qCTMG8b0EDmfQ1POe062Pd+1begdtDYeYBxo
	2r4lR20qhdOcyPLvJBaBSfAXWRRgx1NeftjvDPc7sGg==
X-Gm-Gg: ATEYQzytI6phOdldUHvXwE7vG+l4BLWyaPRfBXI69SLAuVcbIoqz8d2leUYAqn4TJYN
	oqkC/6B5z6xREmTTN++G+6/iC8urJIZ+EbsyaTlus6hGLrl8JBBN+IVUf0kHOrQHVPz9GyKyT2X
	yyhZt6NFlaH/rgd28gusxFOcVX28wo828geCvxpOH17Nhmvt1qB0FFfSh/HdpOUsHmT3gVd/BfF
	Ol9dBaWGwkwOsmLkLlXTmGlIUrovQCLZlkoxD44vlSZiZRxH0+zxwbRnsf07kfoSYu+v4EeM90V
	yoNH1zWMFnefAQmysxWDcoyBx6X5rh9KUFobbw==
X-Received: by 2002:a53:d20e:0:b0:649:63ec:f351 with SMTP id
 956f58d0204a3-64c78e5a697mr9081687d50.74.1772003121515; Tue, 24 Feb 2026
 23:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771930766.git.dan.carpenter@linaro.org>
 <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
 <CACePvbUjNQUZWcTK-59p09RJAjZZs+z8HuYmkfeTXWBsOKBEfw@mail.gmail.com> <20260225033639.GA2924820@ZenIV>
In-Reply-To: <20260225033639.GA2924820@ZenIV>
From: Chris Li <sparse@chrisli.org>
Date: Tue, 24 Feb 2026 23:05:10 -0800
X-Gm-Features: AaiRm50JMXsQbgFrymMt_TSoWHMmCw6bNpc6yvGarbQJCG7epmkhnNesyG6Nv_s
Message-ID: <CACePvbVbw4w41vo-6-M2quz4oGG=HkZTW9wwvZp5hr+egEvnRw@mail.gmail.com>
Subject: Re: [PATCH] sparse: add support for __VA_OPT__
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-sparse@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ricardo Ribalda <ribalda@chromium.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Xuanhao Zhang <zxh@xh-zhang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"

On Tue, Feb 24, 2026 at 7:34=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, Feb 24, 2026 at 06:39:57PM -0800, Chris Li wrote:
>
> > > I guess if you wanted instead of a comma then you could have an empty
> > > __VA_OPT__() or you could pass random things like __VA_OPT__(a b c). =
 I
> > > don't know why you would do that.  In this case, "a" is a macro argum=
ent
> > > so that has to be expanded out.
>
> <sarcasm>
> Then perhaps reading the standard might prove enlightening - possibly
> due to examples that might be in there, or seeing the actual description
> of semantics?  https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3220.pdf
> is there and searching for __VA_OPT__ would immediately get you this:
>
> #define SDEF(sname, ...) S sname __VA_OPT__(=3D { __VA_ARGS__ })
> SDEF(foo); // replaced by S foo;
> SDEF(bar, 1, 2); // replaced by S bar =3D { 1, 2 };
>
> Would that answer your question?
> </sarcasm>
>
> > One idea is to add an expand function expand___VA_OPT__, similar to
> > expand_has_feature(). Register it in the dynamic expand macro array.
> > That way you get the collect_arguments() for free and it behaves just
> > like a builtin macro expansion. Just duplicate the collected arg list
> > to the current token, if  there are extra arguments.
>
> Sorry, no go; for one thing, #__VA_OPT__() won't be dealt with that way,

Ah, thanks for the great insight. I did not read the spec and trusted
the gcc behavior instead. I just learn from you that that gcc is buggy
in this regard.
Never mind my bad idea.

> for another there's fun with foo ## __VA_OPT__(arg) (argument is expanded
> *and* subjected to ## - yes, it's possible now).

That is very tricky.  I just took a look at the "6.10.5.1" regarding
__VA_OPT__(). I don't have a good solution yet.

> I have something resembling a workable approach, but there's nasty corner
> case when you mix it with the side effects; that's impossible in standard
> C, but gcc has the sodding __COUNTER__ thing and _that_ makes life really
> interesting.
>
> If there's __VA_OPT__ in the body, we want to expand vararg whether it
> occurs in the body or not.
>
> We want to expand each argument that is present in the body.
>
> Question: should we expand an argument that occurs *only* under __VA_OPT_=
_?
> Note that "expand and discard" is *not* a no-op - expansion of __COUNTER_=
_
> will have visible side effects.  What's more, gcc and clang diverge there=
.
>
> Another kind of side effect is possible in standard C: argument substitut=
ion
> might fail when attempted.  And gcc is arguably broken there - see
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D123325 for fun details.
> clang handles that one sanely...
>
> I got stalled waiting for gcc folks to respond, then sidetracked to other
> stuff.  I'll resurrect that stuff later this week.

Lookin forward to your solutions.

Chris
