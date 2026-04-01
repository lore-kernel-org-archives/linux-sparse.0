Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A352477E28
	for <linux-sparse@vger.kernel.org>; Wed,  1 Apr 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060338; cv=none; b=D+fVxprlwUIP4kC3RQO5EcqIqOje2ddNU1TD0dMfE+xD61S8MVAp4PdhGnLkLfNq/7RGNcOy6K7nDVcBICpZiZc6rW/s63Emh9b9MA6z855QiY0/bPRk8kPS8xfgxcMkgO7qUsRNq7LAAFFgslm6FYME4FJNTZZy+o0fqF++/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060338; c=relaxed/simple;
	bh=Zkjry0wXt8ttreUibtbPCgI1iNgouxa0f3ACaicXj0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI6GlEHp0hkAl+S18uwDcZS3SD0Ey9eSq9AgEBaSCRNAA7LCpkKBR1XOJBGwopAajycT0uy1jzG7BeDxnLjpYMFg7McRZ5uKOI+DsePaURUO4gm/T65RbgSDyoPdOsQAqVDSyqzhhnWYAhAaavpwBkmup3FA5s+LAi8y9Q/6nLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P4nxA8Ln; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P4nxA8Ln"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9a0762ed5fso205767766b.1
        for <linux-sparse@vger.kernel.org>; Wed, 01 Apr 2026 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775060333; x=1775665133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f7LDTRDni6/GcHPHynYSlTRbKbLzK3TFU+NdFW4RUCk=;
        b=P4nxA8LncdnrkWd+iIYhRirHXu3bCEW6c/t2PPKlznBgIUOjDddrq3gOFs9z5tvhH5
         FE50qhChnQ9HvjT4z6PChhGKZEL4PC7+OcS8XYBEtrLncfqA9d8Os8XnV2BzjtrjKFbd
         cUuc1rmVCjZBFRn0dtPFMIVQP+8+XI0AsL5nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060333; x=1775665133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7LDTRDni6/GcHPHynYSlTRbKbLzK3TFU+NdFW4RUCk=;
        b=TG0oxckLh9nAAu+m2G/CWfyRk0oQeqJhfzDK2lWxLP0pO1Pp9Qbn3jEj5rMhnO9bkH
         Y9AnbmYd98OU0AV1HDov2ahrLx+POxWNqwgPnujeJ5gLRX7S8vt+I47wGI4WmawhgtDx
         zp25+rwcTVMoZWiivRSc7sLB8z2AV/iXblnPJoKVpDS1h5zLBEcEx0hnXNreJj9MoLmc
         S1OSc+b6l1rk/EXnMAXs70aaz9LqSrUbtYAGSGtfpR98MyHfxekgIP8th4yTCzAcYwj6
         dZ/8XIBYiXx/MJnZqXhCEvrH64ecMO+PBDfCLqiaVtDhp2p4XlrsauoNICld+bMsR9SK
         +kRg==
X-Forwarded-Encrypted: i=1; AJvYcCUiODSkvtoeThi/q062mj56OdMGoCkpKXtMNuUM2e5TFwrXampcmVYqy87o9Ksrfq+Iy+h7RLrsrpytr1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxigaA2Q2b0mnuobAmi3ta2NPXagiBTMaDZxwBI3rfklMZMNPEe
	toJ+UqNkRlWVsJTjxtkVIm4aef5tWG3VhFn97Kj+yODnzM19lcRwY3YFkKxVc/iojhoIyZa8Y6f
	BUYae8l+YZA==
X-Gm-Gg: ATEYQzxGjscbqPbGeHlqjue3ainfOb+NETQXyDP+6nrhKMFt/yGQd6d/BoCEicVeo/8
	CahiCOxkttiky50be50fVET6r/jrN1f4ggr8w1bap60YTL5kCe4wHJn69BuGMOOaagz5YY78aZ/
	yZ4tmm3I0nDdE5h4nymqzeupRMCP72BBwRyPUWqvJRISyltunW0tib1nzESXF31udXqjkh3wWrX
	f4xQbraC6x/eQ653WfUtT0Uo/6+EWSOd4J8tfWDTqOWbdmoETnHuCk9OnnNKMjjQoD11+9Kggc2
	vXYRjqr4AbwkIk5rPor12Z8pTKraPasJ9zhT2vuqEMXnXuIYwpqL6S8/+1TwR0Xr5UZd2tlHCYB
	L0ZLp4ydMKvV61RyXMEBywfoGNeOvohAqziAX0hbKrck2H6v9/0BwxmFQSFrtrfUVWA3seINC7r
	YX00IgRAquvrMhU+ye1qiVRpya2S/XbcIcQYvVujKMGfvOGBFmS7rZIuGg7QSE2yGGpGBD9DMW
X-Received: by 2002:a17:907:2d94:b0:b98:284b:53b with SMTP id a640c23a62f3a-b9c158eee2cmr241335766b.14.1775060332782;
        Wed, 01 Apr 2026 09:18:52 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff128bsm2613766b.53.2026.04.01.09.18.51
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:18:52 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66bd4e0560fso1612309a12.0
        for <linux-sparse@vger.kernel.org>; Wed, 01 Apr 2026 09:18:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRtc8SP4nDwCq9Rtczd7OPa0EMoakOood9c5QuLz9MNDBc0rURHQoKeKIdvtazijvuAPypJvC9gCagxY4=@vger.kernel.org
X-Received: by 2002:a17:907:3cc6:b0:b9b:51ac:cc1f with SMTP id
 a640c23a62f3a-b9be859d480mr500232266b.19.1775060331591; Wed, 01 Apr 2026
 09:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072731.GA3093958@ZenIV> <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV> <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV> <20260331080631.GA1328137@ZenIV> <20260401103919.GA2063236@ZenIV>
In-Reply-To: <20260401103919.GA2063236@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Apr 2026 09:18:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC+8jX=t9NsF3uG_=BoLDNG7q0+FCm4ZrQDFdirWaasA@mail.gmail.com>
X-Gm-Features: AQROBzCnJ2BIiMKDDZHBFW2YkIZkaOJ5QMtqF7CRtkU49t6w-7Zj8g0VlY0bVbA
Message-ID: <CAHk-=whC+8jX=t9NsF3uG_=BoLDNG7q0+FCm4ZrQDFdirWaasA@mail.gmail.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: chriscli@google.com, linux-sparse@vger.kernel.org, 
	dan.carpenter@linaro.org, ben.dooks@codethink.co.uk, rf@opensource.cirrus.com, 
	Eric Zhang <zxh@xh-zhang.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 03:35, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Sigh...  whitespace handling (6/6) had been too convoluted and ended
> up with breakage due to a missed case.

I'm impressed that you are trying to get this right, even though
clearly nobody really will ever be able to depend on it.

I suspect this part of the patch is more likely to actually be
something that somebody may actually want some day:

  +// We ought to add __builtin_strcmp() support to constant expressions;
  +// what's more, "foo"[0] should also be recognized as one...
  +// Sloppy length check for now...

because yeah, we've actually depended on the compiler just figuring
some of those kinds of build-time optimizations out before to remove
dead code etc.

            Linus
