Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA861FC8
	for <linux-sparse@vger.kernel.org>; Sat,  3 Jan 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767459713; cv=none; b=KRdLbmJjuEWRgTUVRFIWCQ+avQrZ4oa4r3gPSo6wD0RxQ42KoPUbeOeXSg+4qtPL44z9soCt15L0qaj3brPbHKcXJk++rNd2GUDwlAxiZ8PGCSTcdvjP1Xx28H8agIqqtiyxuGCVHlHWH+ARgtWMR4rmOuMyk4IOEVaYGD6+hk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767459713; c=relaxed/simple;
	bh=KQXl8jGs3GODk15tB6KTtrgOeAb6Hys26tY1ny9AYdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxJGtWmp52B2Sg7EmH3R4TOzR9pjITtuztG88CtKS3kFJalvTolziK+mF9TNZySZZ9bmK+amOmM5bRexinhVwQReoB1G0aej3t/zZFZY64roxkT3/lHFr9cqNGoLx9PaNNqw4oNQ7h9t9rQYXyDg62GhBThjBj6hA0gotFT/e1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9Cget1S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9Cget1S"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so138339625e9.2
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jan 2026 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767459709; x=1768064509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHSQMnJBQHG3fEabcx1jHr7yPb3RERixhfZ5sKkWzqY=;
        b=O9Cget1SxzflOyoG1iBj4tgeldJE8YEv+KCX/Po0HJ5CjxayvO5ZpmNW3teQ0qYoGp
         Mhgzx7wb53SdYQTHxLiyCXeRNd9TCYn/BtVvHVIQx9kaCd49JhuG0ztiudTYv7QjEGN1
         CgpT1i8bIeNPIoj9zDuMftOMgJ5UFx1oiZWH1c9LC2kqI1kQnURHDQPAPCBrwX5bTHkm
         vXEkYDhDCsCZ1ArZTs+a0y4gY2BYAMifW5QJUP9q3eoVRY6y3aDljX3v9JxK7S6LlLnS
         agYbSMbNTXAlpQnMn9yGLzIenQjT0k9MCqA8g5+hiOJLFtfHVa2hjin0LA9KmHsvp+ZX
         qqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767459709; x=1768064509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHSQMnJBQHG3fEabcx1jHr7yPb3RERixhfZ5sKkWzqY=;
        b=nzN1NXh+aC3WK57sDecDSzvcykEskGCB9rAUavH0/xIew8201fDHZA9AmEP2gqypfs
         fhwRDErjn1lh14XUWWd7J595KUQphIbKx5xrk/IwD3ARM5Bgt8rBo8SPuQKssR2kH12I
         jubm4/s/hpRkNWdyzRRilbBB/DJ1jKmLfV5qYvTBlmc1+IPShekWkSKLxYxlRLtVLL4S
         d1sD8Fh80OZSqwplotN1N3A6Z8/0WT4eMIB2HZciZPaNJOoJ3zhpy2MP2js44tkdyBIA
         SGloRagZcDkiDtzpv6c4bNCHeBDvZHPMXz8fnKeFgKclSQjHh+91lr2UpRRxCPTQoEx3
         BaVw==
X-Forwarded-Encrypted: i=1; AJvYcCXd73dqjaW8wUAORypEeC4MAVnUQsFm7BDGxiBJwBgLFyzlREGb8g4Ot6+oHVArotCYsWGrl1jeb6s+Y/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBM2SdAMOPsD+gskl2JhZks040Z4eNsccHalzWwMv4DoeOk27
	JAKTVxDD6Nyqb4sShp5NdRylksNkkWooHj4pgIQcDPX1NKFYNi06vli1k5LRSBPjv8w=
X-Gm-Gg: AY/fxX5LhXIC7pX6xmd9Chd7XtVgjSPG/7RuoDSQkKrvgi+eLSQBsXsybVlWhjgbl+j
	+iLboPWLdpULiMDUCI4/8paiS8YXYe2tOstM3Dg8s0mHOvsCWLHxPLlKxqMzfEXXvWV1Bp7080L
	e8Xbp/oOXdwHvEdlMe4Zbve0qzXDfWgg2HQ+yfaVAC1VOKKUc5a1ZYk/Yf+SstDnEQTnPezk5YY
	bmXK2alN3CsPvN1zByWp8RRb3Mwn4gZgoxQrYgLCjPLYKjYM9FStXqY+pjtudzT8HfzezaQSpP9
	5WunOrjE1p5U6fkKUTOY20po+I16IoLOtOtS3gn4q/zP8cMYg1RXnYVw3R18xeO4rV3tX70wJXK
	H81hxndp9TWjwa2tUofyMOJb9p5Acg3n8ZL73xzi1kr9KJpwoOO+dl8KDiDeT383XcEi3ZRZwhI
	gFmAzIjqtvINx45VMx
X-Google-Smtp-Source: AGHT+IH76r9upX5LgpHZ/fOST6gsEDX5p5oGk436/qE1kT4SAaRLVvV1SuOGoIs6C86iZ8FylfCo5w==
X-Received: by 2002:a05:6000:2c0f:b0:431:54c:6f0 with SMTP id ffacd0b85a97d-4324e4c739emr61327273f8f.4.1767459708384;
        Sat, 03 Jan 2026 09:01:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm82459187f8f.19.2026.01.03.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 09:01:47 -0800 (PST)
Date: Sat, 3 Jan 2026 19:56:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] overflow: Update is_non_negative() and is_negative()
 comment
Message-ID: <aVlKTculhgJzuZJy@stanley.mountain>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
 <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
 <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>

On Sat, Jan 03, 2026 at 12:10:45PM +0100, Vincent Mailhol wrote:
> On 03/01/2026 at 11:02, Dan Carpenter wrote:
> > Thanks Randy, for sending this to me.  I'm on the sparse list, but
> > I've been on vacation and haven't caught up with my email. 
> 
> Welcome back, hope you enjoyed your holidays!
> 
> >I can easily silence this in Smatch.
> 
> Thanks. I ran this locally, I can confirm that this silences the
> warning. So:
> 
> Tested-by: Vincent Mailhol <mailhol@kernel.org>
> 
> > diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
> > index bfeb3261f91d..ac3e650704ce 100644
> > --- a/check_unsigned_lt_zero.c
> > +++ b/check_unsigned_lt_zero.c
> > @@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
> >  	    strcmp(macro, "STRTO_H") == 0 ||
> >  	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
> >  	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
> > -	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
> > +	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
> > +	    strcmp(macro, "check_shl_overflow") == 0)
> 
> But, for the long term, wouldn't it better to just ignore all the code
> coming from macro extensions instead of maintaining this allow-list?
> 

Of course, that idea occured to me, but so far the allow list is not
very burdensome to maintain.  I maybe should disable it for all
macros unless the --spammy option is used...

regards,
dan carpenter

