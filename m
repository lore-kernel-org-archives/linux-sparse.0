Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3018D620;
	Wed,  4 Dec 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347246; cv=none; b=KlVY3TCz/K6AKaR/seHGG4Gj6D5m3gti8Bk3XQUFNZsThzqLEgTlsMaXXr0TmtDLboqGtSEaCCAGpWq40eEZjSiIqEhpRL0pBbmVlE/G3AjKs8qFxrZJbQ3Os0YUlut6i5kpmeQA73QxSMtxuiTiSsVxsjoU9M0OzseqeJLuDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347246; c=relaxed/simple;
	bh=DmTd11zWX81WQA+LHno3MSUDiBFXhLbTtvsyV8RhXqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiJYXntGWi+P+xJkanmEvPFRfkaDBqN7er08Xmk0/uyQ1TprteHoJFFXEgN4Fp7BVJ36R7BMpwZvp85t4RL5HYwlr9Z1PccO8Ep7lHI+o03gi+CJexG86ZivgE1qIw6l5n93/SxzC5optP1ZXEVPEap6u6qmefBXraLRcIogBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPI75q2N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPI75q2N"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso226424b3a.3;
        Wed, 04 Dec 2024 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733347244; x=1733952044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BNA1GsPxilVJChqzg/IHgUeCWNBJYbUvWL6MaZGSVcI=;
        b=EPI75q2Nm3llXQ4acTfJxCBtN1rmOOd+PLhTzz3rj/dkwQgM5O/vmMw9F4lis9mhKC
         sGjZUZWpeUKLWgCjNi2JOqxkQ0bMtirHQswoyTvuJ4fZDpSg3ia4yzhooSkB09nZuO65
         NsuCHu1VSMXb4bUhMaJaoUXIA/OrMGNfa0QtjcB9sYPgTDWi5NvBmHM63Gm71FIHzptK
         sn8Vlkm2Zh/+Evl9H0tP30w2fjcmylocG2um1nEnCwZaFai0q+lBeE6gQfIMjnWJI/lM
         Vr7Z9wmIyBdEFxqkXXYDUrUlvyPQ8OLBuarpC1koWVHW+5CsHWZVRntgjRin9aBHPyWQ
         RYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733347244; x=1733952044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNA1GsPxilVJChqzg/IHgUeCWNBJYbUvWL6MaZGSVcI=;
        b=NlgIVoX0thymfWYiveUCr+YAgUN5O/BF+QayqjZklOT0biJAf6bFxpZ/uOpbPaFaq0
         t4BwYI3rSR+4MIFN4CbFlGey3gp7+0KhMEEzy//xOrLJ+j7iAY2X3c60YcANYWzOJ4th
         qSLUN4LpOjbsKeujhT48pJEOrLz0nsxsIlLYJosjwE3ntILdOUIOK4CXC2URc8hLYZUK
         ZMZapa6bteNr+DjgYxl0IzzmjgCqF7EfIP/1KljvwBwiEio46YvXsE1osQv81arKXoOS
         EhGfwpPYnbF1qYzlitjdD+V6KNsvMSDTK3phW3zhk0LWDpZu37QHM8z2I5yojChKxCBv
         Km6w==
X-Forwarded-Encrypted: i=1; AJvYcCU7hKjLEMrm5wEIQqppYlew3GweE/TEHUiyPWS0XLtk6QG/aM8vxm+ELwKWoDngEgXAyLX+JE/5m9XEfErfRIA=@vger.kernel.org, AJvYcCXjKBzn7j9N1VEPysKMe4F76XoI604W8aR1XIYqBe8KOJ2Q5oKjIG+pKPAnFf9phrH++U/EBY+eexyGmYuC@vger.kernel.org, AJvYcCXuJ4RwMS4sJ+6t6dKsz1ROGHHBjW6oXfIGhiPaXMwqzYCGPbEis+u/LIM4YZkrC380uP6HDzG6EboH7oB+@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgz0sZoB/2zMF4+TW6RYpTemxF5ukvtwBP9wPoINInJ5NE9JK
	zwvACHuDfhi5Qm/I1sKMjWXAU6UTlf7/WIFTEsJP4/IKeInJ/A0r
X-Gm-Gg: ASbGncvnfp2jpwGV1+uhuFGdabE6Zr9tF27Bqb8Rxp5GFREU8bBS83QeA0M746HbFNQ
	IyYrXDCGsPMj4qlKKre+2hatUETZwfoaUQm4dEtHqgrAmrSKNvtWxH3bBQTG1U0ExRSVkN8aKzI
	WhUTpEnbE7INRwEdlBHkVOXXx5mnMCiLlHUouFMvThDkuV7zemRIHPJeHS0+6vFAj4ogaAXZrsm
	11QZmHimm6mG8jkNvlOzErYdmBL9lYDHqbdsJau4zrH5EuSDg==
X-Google-Smtp-Source: AGHT+IFEmSUNzGrT5DnfoRZVH+SQ2pUXxmGmw+aJzGPI7oEZwncOxNonhADpq7F5PtDa6Cd2EgQG5g==
X-Received: by 2002:a05:6a00:3022:b0:725:9202:6731 with SMTP id d2e1a72fcca58-72592026879mr4620300b3a.13.1733347244177;
        Wed, 04 Dec 2024 13:20:44 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7258b2e79d3sm2235622b3a.67.2024.12.04.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 13:20:43 -0800 (PST)
Date: Wed, 4 Dec 2024 13:20:39 -0800
From: Yury Norov <yury.norov@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Message-ID: <Z1DHp34fyyhtLEV0@yury-ThinkPad>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>

> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index a2a56a50dd85227a4fdc62236a2710ca37c5ba52..30ce06df4153cfdc0fad9bc7bffab9097f8b0450 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -316,6 +316,47 @@ static inline void *offset_to_ptr(const int *off)
> >  #define statically_true(x) (__builtin_constant_p(x) && (x))
> >  #define statically_false(x) (__builtin_constant_p(x) && (x) == 0)
> > 
> > +/*
> > + * Whether x is the integer constant expression 0 or something else.
> > + *
> > + * Details:
> > + *   - The C11 standard defines in §6.3.2.3.3
> > + *       (void *)<integer constant expression with the value 0>
> > + *     as a null pointer constant (c.f. the NULL macro).
> > + *   - If x evaluates to the integer constant expression 0,
> > + *       (void *)(x)
> > + *     is a null pointer constant. Else, it is a void * expression.
> > + *   - In a ternary expression:
> > + *       condition ? operand1 : operand2
> > + *     if one of the two operands is of type void * and the other one
> > + *     some other pointer type, the C11 standard defines in §6.5.15.6
> > + *     the resulting type as below:
> > + *       if one operand is a null pointer constant, the result has the
> > + *       type of the other operand; otherwise [...] the result type is
> > + *       a pointer to an appropriately qualified version of void.
> > + *   - As such, in
> > + *       0 ? (void *)(x) : (char *)0
> > + *     if x is the integer constant expression 0, operand1 is a null
> > + *     pointer constant and the resulting type is that of operand2:
> > + *     char *. If x is anything else, the type is void *.
> > + *   - The (long) cast silences a compiler warning for when x is not 0.
> > + *   - Finally, the _Generic() dispatches the resulting type into a
> > + *     Boolean.
> 
> The comment is absolutely excessive.

I like this comment. Particularly I like the references to the standard
followed by a step-by-step explanation of how the macro is built.

> I'm sure I managed about 2 lines in one of the patches I did.

Sorry, don't understand this.

Thanks,
Yury

> > + *
> > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> 
> IIRC Martin has agreed in the past that the accreditation can
> be removed - especially since it refers to the 'sizeof (void)' trick.
> 
> > + */
> > +#define __is_const_zero(x) \
> > +	_Generic(0 ? (void *)(long)(x) : (char *)0, char *: 1, void *: 0)
> > +
> > +/*
> > + * Returns a constant expression while determining if its argument is a
> > + * constant expression, most importantly without evaluating the argument.
> 
> You need to differentiate between a 'constant integer expression'
> and a 'compile time constant'.
>  
> > + *
> > + * If getting a constant expression is not relevant to you, use the more
> > + * powerful __builtin_constant_p() instead.
> 
> __builtin_constant_p() is not 'more powerful' it is testing for
> something different.
> 
> 	David
> 
> > + */
> > +#define is_const(x) __is_const_zero(0 * (x))
> > +
> >  /*
> >   * This is needed in functions which generate the stack canary, see
> >   * arch/x86/kernel/smpboot.c::start_secondary() for an example.
> > 
> > --
> > 2.45.2
> > 
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
