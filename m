Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3538488;
	Fri, 23 Aug 2024 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371449; cv=none; b=G4cb+PyUkpFZ1nB8kzp/OkTU1YhWiS9CK8eUw+HUJUqp3yr1A04byuYitq0XKNGzvQ4KHALVXuvNfeMbqZNTMENnnNdmU1dwtAaSU7nb5RvCRke7sdjmpfN9V+uSJmJofrghd93FENiPi6uOTjYa/UsXOMPe4DQ67zw7uMBV7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371449; c=relaxed/simple;
	bh=d1RmSg+pZiyUSkvTppKDhWCAqCi7WQkLhQlgan+A8/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeNJC9xN8+JehjKT6CEJ1ZJymU9Cp/tKDkZvPs1kh1YEgt24Jl0rRWu3MqPd1u/Kfx84pJyOXkaoyIPAUERW/Xl26J0cndsDdajPNSyKSJcCSCpvBwQnTrCVRPOOppdvAAmGhddGzzPf2nZ0qjhGR+h8N9XbXVGZPxNHHsUCJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgpGbe4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgpGbe4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218F5C32782;
	Fri, 23 Aug 2024 00:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371449;
	bh=d1RmSg+pZiyUSkvTppKDhWCAqCi7WQkLhQlgan+A8/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgpGbe4uQqi/w4yJc6MgDLLeqX8P77dSmuEvji1/3yZwLxT1WGUZ2MRlBxLdIBulA
	 UdU+X/wwOYMLl74i+S2lWSlDKLC2nHD8NVvYSy4n8ELYikPW4BqshuRi1tqxlGcnc+
	 udeVklItjOwkSA4FE9/PMpUfqIN5ZH18yFi3VJn5jM2Ctdi3iTnmaYp38jgS9iXjIy
	 ZX+vJQG2umAM2u6NThiTc9GhW5TuSO63rzKHBQbNegn20DWNkOuoTns/BB2KcD7Kr0
	 zW351l7IUdD8SuIDyeJ91zwfEDgzJJx/I3CdncSWlOrc6GobrwO2ybUT0VdmqqXe7/
	 QJ7XsPO73q5DQ==
Date: Thu, 22 Aug 2024 17:04:08 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>,
	linux-sparse@vger.kernel.org, linux-hardening@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] string: Check for "nonstring" attribute on strscpy()
 arguments
Message-ID: <202408221701.62773B4E1@keescook>
References: <20240805214340.work.339-kees@kernel.org>
 <1724c53c-5a02-4816-a688-cae18db443d2@intel.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724c53c-5a02-4816-a688-cae18db443d2@intel.com>

On Tue, Aug 06, 2024 at 12:29:30PM +0200, Przemek Kitszel wrote:
> On 8/5/24 23:43, Kees Cook wrote:
> > GCC already checks for arguments that are marked with the "nonstring"[1]
> > attribute when used on standard C String API functions (e.g. strcpy). Gain
> > this compile-time checking also for the kernel's primary string copying
> > function, strscpy().
> > 
> > Note that Clang has neither "nonstring" nor __builtin_has_attribute().
> > 
> > Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> 
> 
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 9edace076ddb..95b3fc308f4f 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -76,12 +76,16 @@ ssize_t sized_strscpy(char *, const char *, size_t);
> >    * known size.
> >    */
> >   #define __strscpy0(dst, src, ...)	\
> > -	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> > -#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
> > +	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +	\
> > +				__must_be_cstr(dst) + __must_be_cstr(src))
> > +#define __strscpy1(dst, src, size)	\
> > +	sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
> >   #define __strscpy_pad0(dst, src, ...)	\
> > -	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
> > -#define __strscpy_pad1(dst, src, size)	sized_strscpy_pad(dst, src, size)
> > +	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +	\
> > +				    __must_be_cstr(dst) + __must_be_cstr(src))
> > +#define __strscpy_pad1(dst, src, size)	\
> > +	sized_strscpy_pad(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
> 
> any way to avoid the usual caveat of repeating macro argument?
> 
> a variant of BUILD_BUG that is checking argument and otherwise pasting
> it would nail it, but I didn't pondered how to implement such

The use of __must_be_cstr() shouldn't cause side-effects, so from what I
can tell this is all okay. And since BUILD_BUG_ON_ZERO() resolves to a
constant expression, it shouldn't change the processing of the "size"
argument in the strscpy internals...

-- 
Kees Cook
