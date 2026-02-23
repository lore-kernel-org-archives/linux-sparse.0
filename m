Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CA319870
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867271; cv=none; b=ASekcZDp1sdmO0qulvuaCpSOhgRLH56exyk9Af4+RDD5mPmb93udglScwhx4FmOCXJMvAT5SpA5zcU7bJiRL90K33kFuHQ4xparACIKL5VIkvBSk2z4lT7oGsI+5Mapv86moiqQSSM3Ihx5+TpVa3L8KrbNzl7cKeHIIovMtKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867271; c=relaxed/simple;
	bh=uWrv68IE2D9jaesNw4KQDp5kTDJtoDR6vsh7QzjulQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiSQqyLKE2GygVBdOZVZvaaVU/aAgqvSSpqNbTqebut7LTDrGSmgAF4U6ZbMJUZPkOPlVhOCJoOMiw8Sb02Izgx5auEyYKWR8Yfu+M5gNni9BbiXBiKM3lAxDDCnWaTqjaES0zzZg2lo27XvgC7nceXHvnpkWlzCbVGVx1DIgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aS9rM2+8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aS9rM2+8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so762932166b.1
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771867268; x=1772472068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ptDnI6Mwr5Bvkw9GccZHacUGO5wsOmVbgVOc9ZoM2M=;
        b=aS9rM2+8dJehP0yaa2nwLQn1XA6uNiOLl5EkuxQ5HtfdDCKULqW+yHo1LIHA/nEOHl
         OR4djWrY/qyPAIkwkHQKJ1l0nK3pMz9tAZQdfp6jnE4PZOyANBgncrOQZig/EC7myny6
         Wj9inGIK9T57WWPUd9QPQ9eIleFY7tfHGSeow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867268; x=1772472068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ptDnI6Mwr5Bvkw9GccZHacUGO5wsOmVbgVOc9ZoM2M=;
        b=p0TYFZ5c98rr5m3W3NAE8+HHKcGpwhPkJzV/b+WIVGJGVPra75QHX4hjvnW79WJA90
         tQ5TGxFwlt0wP0mcgeU9J1j5V2yjDqNPImjtfMQfgRmGeXucwbByvDHVq0HYo5gczFOw
         swEn624hk32bMVYkWtIbuBWMpU1FHznuag1AoFyBXqwA40jOHc58YIgyf8e2aaIfpUbU
         E2QFBIGElJbL1ArXOGLT9BMOlb7Sdp55hJE1eZ5Qz+Lazol3aUe5bYvNf+mXvO6BWKNT
         VsPRN4mZz9/GLsrvGyOmO/+8+XfOJki+3iyppAb4nVivVW7PZeccmr+Uw7wXQEcoQNtc
         btHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbMQLHAFE7p3m57jUjWamCogg4hmUsWtG/3636FPvb1DwDUc3oedYJM79dvMzC3rRa7BHKAK2LVZFocgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgcuRqwWDIwMzaYYHeCV6EYmomatSOaJWRgAFDM7i1RIkHd0o
	XvBHNRFUS9sLlu/5QHd9gygUq5Oz7WL+7jiqqfLTQQ+19L6vAiJlzcHwZy4d4WiWP2cOILTU1j2
	9AiD2Nq+N
X-Gm-Gg: AZuq6aI4Y/35ZDkKgipZvBPOxWvXfGK7Mx/v792qggqoi0B5our81vYP8BM6fD0fks9
	DBLWyCh96eL+lpjcQqdwB2DhmRjIETDYI1QzRfU8cRJPCdbcYe+bYLoTPu4DksgqwF4cQgKa35d
	Bwm9Q5OZnVrijoLQmbDgcb1p61mdF+lgzIMHqlvwyTjVJ5BHRhiWjwsaNmFYv39ynqetsJnqJeP
	umfznceHEmrjYJm3scPRsnvui1HtWliVUqNKUHyNj+6tszldioEOtkudOpYWGgDscd4le5za3/X
	tR3LUiJgUnorGKIVolshYQFBnle3rHd/ESLDnnOk2SiJg1rkQVSmzh5LsHpSTECI5kkclXI2DZ5
	xAFyU0biYIKo+veqkhRPSaAGJESUaGhtXitkp1bdar85oQgn9VjLBjTPn756obZh2iX0ceI4EHH
	Yvdd6GU8wYPwXz9uUooq5OruI4foFRrA6pfhAav4kb8khKkrNGPGn0b2TjNYjvrma9KLsPsJY=
X-Received: by 2002:a17:907:a43:b0:b90:a99:6ab5 with SMTP id a640c23a62f3a-b90819947dcmr595635566b.7.1771867268211;
        Mon, 23 Feb 2026 09:21:08 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e8d0d9sm346530666b.50.2026.02.23.09.21.06
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:21:07 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so8305272a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 09:21:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURa62u8M9Qw952VJnwiqIy7ICh/GQycUkpu6zUXnU+TYFMpJNz1vW9z7cEHwFjH2bWuHsb8HKfUyNpRNE=@vger.kernel.org
X-Received: by 2002:a17:906:f590:b0:b8e:d4ed:5ef2 with SMTP id
 a640c23a62f3a-b9081c0e1b9mr670862066b.58.1771867266177; Mon, 23 Feb 2026
 09:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
 <CAHk-=wgxgo8SugrnA4s=Pz0TPj32Ea0pdO=uU_N+-V6Y826spg@mail.gmail.com> <CAHk-=whTb01surrXakL7rgyoELuPDkqvTdh_ttNrr5rtirwopQ@mail.gmail.com>
In-Reply-To: <CAHk-=whTb01surrXakL7rgyoELuPDkqvTdh_ttNrr5rtirwopQ@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Feb 2026 18:20:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCsn4gctPL5ms+hCHBwFyv7wAWPCKw6Jfrk2TjMS2tNrCA@mail.gmail.com>
X-Gm-Features: AaiRm51nGJa8_hN65cekZcR6YgewOv3k7EnPDW74317XfJNtEdPdFj3ausg4Dmw
Message-ID: <CANiDSCsn4gctPL5ms+hCHBwFyv7wAWPCKw6Jfrk2TjMS2tNrCA@mail.gmail.com>
Subject: Re: Sparse not supporting kzalloc_obj() and friends
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, 
	Chris Li <chriscli@google.com>, Hans Verkuil <hverkuil@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus

On Mon, 23 Feb 2026 at 17:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 23 Feb 2026 at 08:19, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Argh. The culprit is the use of __VA_OPT__, which apparently sparse
> > never got taught.
> >    [...]
> > Ho humm. I guess I should look at the sparse pre-processor code,
> > unless somebody already implemented __VA_OPT__ somewhere?
>
> Actually, it looks like Al at least *looked* at doing __VA_OPT__ back
> at the end of last year. In fact, just a couple of months ago I said
> "I'm not sure it buys us much", but that was when I thought it was
> just a standard versions of the gcc ## thing, and before I realized
> how much more convenient it actually is to use.
>
> Al? You know the pre-process.c file a *lot* better than I do, even
> ignoring the fact that it's been fifteen years since I touched it. And
> you presumably already had some thoughts on doing __VA_OPT__?
>
> That said, I can also just make default_gfp() use ## after all. I
> _had_ grepped for __VA_OPT__ in the kernel and decided "we already use
> it", but clearly it's causing some issues.
>
> So instead of <linux/gfp.h> doing
>
>   #define __default_gfp(a,...) a
>   #define default_gfp(...) __default_gfp(__VA_ARGS__ __VA_OPT__(,) GFP_KERNEL)
>
> which I think is fairly straightforward and the "natural" way to do
> things, the kernel can just do
>
>   #define __default_gfp(a,b,...) b
>   #define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
>
> instead, with a dummy empty argument to make the gcc ## trick work.
> It's smaller and denser, so it's actually superior in that sense, even
> if it feels a bit less natural than the __VA_OPT__ model.
>
> Ricardo, can you verify that that trick works for you?

I tried both smatch and sparse and both work fine with your trick.

I also tried to boot it with virtme... That also worked :)

I will try to retrofit your hack into media-ci until it lands in rc.

Thanks


>
> Al, comments?
>
>              Linus



-- 
Ricardo Ribalda
