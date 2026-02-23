Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D332BEFF6
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863616; cv=none; b=Obrgy7yeDRCC5aZ2W2xVGMi31Nv88O12EpiaESXJnJ4mjR+TkiZpwX1nz777x0GFFId8LADTK65BffeAEL6KKwdB6xKgMJ0gXQXTYaQ2gO5MtnCwIX2EoYTZqhKgPeU+1KbgULQZJjglYCcyZCMaM/YAjm4hwiEVBZ7uVdVmKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863616; c=relaxed/simple;
	bh=UC75iuk1ZPBkLWIuHh/sQinHB8+OwKpiIoNH6qh+ysU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMQCIZ53nUNkqXBa5f4D89Nj2zIpAIPeiggycQxPN0dB/VJIHVytUe0Ffj+IZmn1SdFlqzRlC4f0FwlIrgvoysgYDJWT2adffzQIIP0PFv+krU8YK9sAM6Wn+XS/OmjwrLkX8XAB82A1vPyc6lvbTbtZpI5tenaHNh0+cY9wf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ffrvuxGw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ffrvuxGw"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65c01595276so6855409a12.1
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771863612; x=1772468412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K9HNlJebw1WcrLP8rtpTfTBxKalSPW2R+jhKj+mlvAM=;
        b=ffrvuxGwWz45ja0wZy2ZCgBFUxwF+7FYR0yuanu7YswRRIlm+JCRob+7sYPMWYjdU9
         qayXsDxInTwWrSVQSpkov7LbsbJUwstxZc6008AlZr615BYgRRbFR137j/yGUrUFZnYO
         lOlb39a6zLGPLEuVgWSjeBxwou0C3s9huYih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771863612; x=1772468412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9HNlJebw1WcrLP8rtpTfTBxKalSPW2R+jhKj+mlvAM=;
        b=Xv5lfTeo2yF3079L31ZFiAvSdfblyjQWKBQ+ly56+itNxXAtXxDxFo5qeSc3WGTy5n
         YNxtZMxtddlwdwC69Jvd7Ir+18SqnYzOdwq/VRA7pbeNQIi6JRWkO1BimbY2+7EyXAdP
         ofhb4yoaEHlJhSwo8vOreLy+g3VDu3/IkONHgPorXF87Bbk1HPOXYl/ug7xHGxJ/3aZo
         VhXqjWDscTNlJLgdChywCHGIgJyYplwiPkSg9crxS/7Qhd3FR4kJGC5PZhwX5sInkTFp
         Li6Sx7e7IaOpVlKqy1OZZFdefew58t0ENQvp/RDuLEBaBiQ6H0poyBlRhR6FyYopjXcw
         /GMA==
X-Gm-Message-State: AOJu0YwVvYgUNQPgsNkPjMaYy0WAR/ERyT7ZYmGnMuo5VlrcWLJ14JJ1
	1p47LXgSv7++JAO8x5b4UFFujIftWkJU4YkKX4C0GDgWwNQtn9yWlevgzH2yKx2/pvdDjwnzY94
	Cq0Fg90k=
X-Gm-Gg: ATEYQzz7S7Ps8hFkD7yQ/BW0EhpuU0VKvHS+DzyGstpUt/iCj0b+uKHKSRKx7Trnq09
	So+F4jajzSbmnKovSXr4gOuVOlKCTYz/vMtoHAWra4ils/TtdtAyWPnz68LW2TpPToyBCruFkxX
	6xrxGbdE+3eX3H4vgaR8BgneXgmkXF/JVvqMheLo9mm+1tqvxWiwHIzmVICu8Uvv0FBUr8osOp5
	ztYc+agwRFbBYHDU8TXcmzCwOAMIQ5KLrxEexAZBcrJHJP4hiZcoM04wRxdDalsHtiLyRyKgHMk
	GF4wnVAsj+4U2DE3hlRqMnKn7w0fhX00jG1p+x+q/m0i0OaCdSKJtLm94yD7N2lIYxxDQXSpPoX
	aIDq6A3Qv4UfHkc5Y5VSTx1/wcqDC/vtQv9lYlik6X5KJWm0MnmMHU76IlrW0yw36BylS5/KzQo
	VIZ91Qcj826MoX3I9hmm4YO8q1EOX5yNaPC9EZVPO2sGFXXg70eJNDhjT4aaWzVlp8PULd0tI0
X-Received: by 2002:a17:907:3ea7:b0:b87:728a:81ac with SMTP id a640c23a62f3a-b908196ace7mr558166766b.12.1771863612374;
        Mon, 23 Feb 2026 08:20:12 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9abf99sm2732002a12.13.2026.02.23.08.20.11
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:20:11 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so6017568a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 08:20:11 -0800 (PST)
X-Received: by 2002:a17:907:982:b0:b87:25a7:3ea0 with SMTP id
 a640c23a62f3a-b9081a4457emr580125366b.25.1771863611720; Mon, 23 Feb 2026
 08:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
In-Reply-To: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Feb 2026 08:19:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxgo8SugrnA4s=Pz0TPj32Ea0pdO=uU_N+-V6Y826spg@mail.gmail.com>
X-Gm-Features: AaiRm53T-L2TYKhQtL1RMt-5siMkYfHVSiojtCoItU1Ujl-uj2uMoR1SB1W5lZs
Message-ID: <CAHk-=wgxgo8SugrnA4s=Pz0TPj32Ea0pdO=uU_N+-V6Y826spg@mail.gmail.com>
Subject: Re: Sparse not supporting kzalloc_obj() and friends
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-sparse@vger.kernel.org, Chris Li <chriscli@google.com>, 
	Hans Verkuil <hverkuil@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 02:52, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> The culprit seems to be the new kzalloc_obj and friends.

Argh. The culprit is the use of __VA_OPT__, which apparently sparse
never got taught.

We already use __VA_OPT__ elsewhere in the kernel, but it's fairly
rare, so it apparently hasn't been noticed much. For example, btrfs
uses it, but apparently only under CONFIG_BTRFS_ASSERT

The btrfs use has a comment about _why_ the use of __VA_OPT__ is
actually needed:

 * As ##__VA_ARGS__ cannot be at the beginning of the macro the
__VA_OPT__ is needed
 * and supported since GCC 8 and Clang 12.

and that's why I used it in the new alloc_obj helpers too - not only
is it the more modern "standard C"  model, it's actually a bit more
user friendly than the traditional ## gcc trick.

Ho humm. I guess I should look at the sparse pre-processor code,
unless somebody already implemented __VA_OPT__ somewhere?

             Linus
