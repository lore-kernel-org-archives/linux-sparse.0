Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C03C6FA82
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Sep 2022 18:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiIZSFX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIZSE5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Sep 2022 14:04:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20415703
        for <linux-sparse@vger.kernel.org>; Mon, 26 Sep 2022 10:49:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d11so6909527pll.8
        for <linux-sparse@vger.kernel.org>; Mon, 26 Sep 2022 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2ghx9soVNRgMuce/k3rtlZFlzNNavxdxcyGC2lzjes8=;
        b=GC57hiZQZgYOn4cuzXIko936K811D1jk++Lxi45rCq4gzvQsowln0lx4woHxaOWEVd
         wfGNpgIHsJ5oU+cBNwjXnighAUrEiz8tArdSIJMCEA0xhvMNJXe+8x3aNlvwSe7YtsWQ
         o5Ry+Le31Z/jZDbhByABzglVRuwvuBarWx6vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2ghx9soVNRgMuce/k3rtlZFlzNNavxdxcyGC2lzjes8=;
        b=GxVb/kg8NLgbR/aQAceeGdCB1Uw4kRuMttRqsAu0gzQ3ikwU5+XX1Nnu+8RZOjPrg0
         OBB9oGGYjs8FlF/bCI+mOIgbQ7m8n7la2Zp0EWdY+MXhS9VHzsY/YG/ccSa9LdS0/3DO
         SEUhJS2UCbsbzY7IacJwWFz+wg8Dv4bapKkxxd79KJasiD8tAz/EbSoT/2Rzo3D5smA9
         k9doQshHgoxLidqHxYvv3zCwq3LHoRhuGMe94vwctyJbphUQhexh4GUuzNA4CCF5BwNd
         v2nNFzbJJmd+DFKyW8oK66MW09+wkl6VSxSHHPAzMPKuyrh9BnI7ytgLT+KnjxGuYSIf
         qL9Q==
X-Gm-Message-State: ACrzQf1ZB7KidqYma/SOQ+AudPP1BmV4W40ioSvKS9pNzdlsawelQvgC
        Hu7j6If7rOnn8YustlANOv73gg==
X-Google-Smtp-Source: AMsMyM7Nl4pXzVNRXTYRj9D3jmUhFFcCnnFwsDwyHyeCGsBtAIOaH1U38Aj3lxSoVvM4vDCHi8Fwsg==
X-Received: by 2002:a17:90b:3b43:b0:202:d053:d305 with SMTP id ot3-20020a17090b3b4300b00202d053d305mr26417901pjb.229.1664214554768;
        Mon, 26 Sep 2022 10:49:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x125-20020a628683000000b0054087e1aea4sm12829374pfd.15.2022.09.26.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:49:14 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:49:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH v11.5] overflow: Introduce overflows_type() and
 __castable_to_type()
Message-ID: <202209261045.3EAEE773E9@keescook>
References: <20220926003743.409911-1-keescook@chromium.org>
 <06a907d2-e976-ed8a-bfff-277c835d9ab2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a907d2-e976-ed8a-bfff-277c835d9ab2@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Sep 26, 2022 at 06:57:53PM +0300, Gwan-gyeong Mun wrote:
> 
> 
> On 9/26/22 3:37 AM, Kees Cook wrote:
> > Add overflows_type() to test if a variable or constant value would
> > overflow another variable or type. This can be used as a constant
> > expression for static_assert() (which requires a constant
> > expression[1][2]) when used on constant values. This must be constructed
> > manually, since __builtin_add_overflow() does not produce a constant
> > expression[3].
> > 
> > Additionally adds __castable_to_type(), similar to __same_type(), for
> > checking if a constant value will fit in a given type (i.e. it could
> > be cast to the type without overflow).
> > 
> > Add unit tests for overflows_type(), __same_type(), and
> > __castable_to_type() to the existing KUnit "overflow" test.
> > 
> > [1] https://en.cppreference.com/w/c/language/_Static_assert
> > [2] C11 standard (ISO/IEC 9899:2011): 6.7.10 Static assertions
> > [3] https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html
> >      6.56 Built-in Functions to Perform Arithmetic with Overflow Checking
> >      Built-in Function: bool __builtin_add_overflow (type1 a, type2 b,
> >                                                      type3 *res)
> > 
> > Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Tom Rix <trix@redhat.com>
> > Cc: Daniel Latypov <dlatypov@google.com>
> > Cc: Vitor Massaru Iha <vitor@massaru.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Cc: llvm@lists.linux.dev
> > Co-developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   include/linux/compiler.h |   1 +
> >   include/linux/overflow.h |  48 +++++
> >   lib/overflow_kunit.c     | 393 ++++++++++++++++++++++++++++++++++++++-
> >   3 files changed, 441 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 7713d7bcdaea..c631107e93b1 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -244,6 +244,7 @@ static inline void *offset_to_ptr(const int *off)
> >    * bool and also pointer types.
> >    */
> >   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
> > +#define is_unsigned_type(type) (!is_signed_type(type))
> >   /*
> >    * This is needed in functions which generate the stack canary, see
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 19dfdd74835e..c8cbeae5f4f8 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -127,6 +127,54 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >   	(*_d >> _to_shift) != _a);					\
> >   }))
> > +#define __overflows_type_constexpr(x, T) (			\
> > +	is_unsigned_type(typeof(x)) ?				\
> > +		(x) > type_max(typeof(T)) ? 1 : 0		\
> > +	: is_unsigned_type(typeof(T)) ?				\
> > +		(x) < 0 || (x) > type_max(typeof(T)) ? 1 : 0	\
> > +		: (x) < type_min(typeof(T)) ||			\
> > +		  (x) > type_max(typeof(T)) ? 1 : 0 )
> > +
> > +#define __overflows_type(x, T)		({	\
> > +	typeof(T) v = 0;			\
> > +	check_add_overflow((x), v, &v);		\
> > +})
> > +
> > +/**
> > + * overflows_type - helper for checking the overflows between value, variables,
> > + *		    or data type
> > + *
> > + * @n: source constant value or variable to be checked
> > + * @T: destination variable or data type proposed to store @x
> > + *
> > + * Compares the @x expression for whether or not it can safely fit in
> > + * the storage of the type in @T. @x and @T can have different types.
> > + * If @x is a conxtant expression, this will also resolve to a constant
> > + * expression.
> > + *
> > + * Returns: true if overflow can occur, false otherwise.
> > + */
> > +#define overflows_type(n, T)					\
> > +	__builtin_choose_expr(__is_constexpr(n),		\
> > +			      __overflows_type_constexpr(n, T),	\
> > +			      __overflows_type(n, T))
> > +
> > +/**
> > + * __castable_to_type - like __same_type(), but also allows for casted literals
> > + *
> > + * @n: variable or constant value
> > + * @T: data type or variable
> > + *
> > + * Unlike the __same_type() macro, this allows a constant value as the
> > + * first argument. If this value would not overflow into an assignment
> > + * of the second argument's type, it returns true. Otherwise, this falls
> > + * back to __same_type().
> > + */
> > +#define __castable_to_type(n, T)					\
> > +	__builtin_choose_expr(__is_constexpr(n),			\
> > +			      !__overflows_type_constexpr(n, T),	\
> > +			      __same_type(n, T))
> > +
> This name is fine, but I prefer the __same_typable you suggested as a
> comment in the previous patch better, what do you think?
> ( __castable_to_type(n, T); The macro name seems to handle if type casting
> is possible to the second argument type from the first argument variable. )

I changed this name because "typable" isn't a familiar name for someone
reading all of this for the first time. What's really happening is a
check if _casting_ will result in an overflow. And when I named it just
"__castable_type" it sounded like a declaration rather than a test. But
perhaps it should lose the "__" prefix, and just be "castable_to_type"?
Or even more verbose as "can_cast_to_type()" ?

As for argument order, it seemed best to keep the order the same as with
overflows_type(). I think that makes all of these macros a bit easier to
read/review/understand for others.

-- 
Kees Cook
