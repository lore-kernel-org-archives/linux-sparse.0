Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974C1474B9
	for <linux-sparse@vger.kernel.org>; Wed,  4 Sep 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442368; cv=none; b=P9kw5ve3vxaaKyNZi6UEiyQxsnI75AwNHmoy4aTWnGPYTlvkzTVPR8XQQukDiMPqP21caLVss24dFOk4et2lKfNSE6GqNn6f/UANHWHWRDeuVvqQAmGRHSY6v690Z13OlbdS4zZ+suafd2NhWe15x0PP5BKPDidnfVOPcPjL3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442368; c=relaxed/simple;
	bh=gimOdVwp1Xz1x3UbQgMtGD5h/owsBcpjuxu/rOwMnko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW0zGMUKFgn8yed8Evov60YntvGBKQZYYivB4ItIvliUu36QILPeSBUDj6Q+gTEz+38+O3UU4CnvxEiATVrrW4vKIqZC+RAm9yMemBkbO3HIyWMnj0IqU7YsaJOzrvLXy2u5zny5zJ3zhOFzT4dhQzyHeWyfryCcxnI9Y/LBOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IX3tnRt+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX3tnRt+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374ba78f192so3136820f8f.3
        for <linux-sparse@vger.kernel.org>; Wed, 04 Sep 2024 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725442365; x=1726047165; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zm29GhwLf0AEedmMnZT2MBIOSstLsAgrcDByf/wFiuE=;
        b=IX3tnRt+fyN0CfJnJgcEmnoqgrzUpztRWEzuyo1TL5kqJeqhzKuVUpQOKekNOYyOZI
         ukUjffnipprnYVQUMjafrzaEBiKOb9iNtVis/7ieDvEKR3d3aFOLfvvOAvDKAx4djxfG
         bZD9j3xhwr9rZ+DODZiEi5K5iHaJjMYcYWQlUEO3Kece/xGd5xCN/Ex4mPb0S3VdTk7k
         23G8yVu1frzN73HS4RSk/AA52v/Vd7is4Ow9LjmybbemGUT+KeZWVdwt8SbLwhhEDoVJ
         OyWDqKpfjlOzTLNMRVKPkieL1QueYOV709+ZO3LUd0pENWUZrH4LURI2Elt4ztKKTmhy
         +y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725442365; x=1726047165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zm29GhwLf0AEedmMnZT2MBIOSstLsAgrcDByf/wFiuE=;
        b=aH0DqQ79Q/F3UDJtTAURkA0yUmItX2u73vBDPUrnxkSgOC/vI0TzN5rm+mnFZOOFAs
         NMUGYqSPBMFUEcKmXBq+EOPOBzEWpbAHU2ioM6ZB+uRWYeVf6E7BBwkbQctl5vf1Y87A
         RlYwbs5WQk8WfW7cC+gVz3Y8Z40XCI6zHJ5hOPBZXPn45/jqgv6nnpKkjpQKToBQ2U9E
         f560i+ecRGIyrzmRMxIeQBZqmaP0N+LywYUm7WArSKqzCas8qa7ZmaiC/eE7KEPHUQye
         JBSODLvLz3R9QTTbVtkjKix3Rjxv8IuTYZwz4XL+xZrDWwMSOSkV+XHGydp5U3RjAQc/
         T0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjuBy3eb+HJSo1+qCw0cwvJhpmYYZKuXuwFJ1j+Uum1FlSVZwmUZldJNxJAna2rTdzWyEKpMjvHmVNOyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgvpo4uoyk+nQtvCa21clqtIpJn5kIFtZoR+i+m30giP1hen5
	+67P62kyVO7q4RIuqZTpPl42VXmnC8ndYRf4uWbms9JAJyWRAGKUJ1RMu2VUPy0=
X-Google-Smtp-Source: AGHT+IG+09Grygrs65wmvs4jnFoAsbISQggYfdVaWlq7IOfhEO0R/JTqEMfn91JbZ5AwK7HpWodPJg==
X-Received: by 2002:adf:ffc6:0:b0:374:c075:ff34 with SMTP id ffacd0b85a97d-376dea47229mr2234875f8f.38.1725442364542;
        Wed, 04 Sep 2024 02:32:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374caf10f37sm7750791f8f.28.2024.09.04.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:32:44 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:32:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
Cc: wuruilong <wuruilong@loongson.cn>, linux-sparse@vger.kernel.org
Subject: Re: [ Patch 001 ] feature: add support for loongarch
Message-ID: <be45dda2-e0be-4a13-aca7-e44ed6016fa7@stanley.mountain>
References: <c35dc58e-444f-0809-67cc-113d6b4b29be@loongson.cn>
 <f687e64e-d653-46a3-a302-68aa4a021215@stanley.mountain>
 <b973fec7-7722-45b4-91df-c540a6e91c9d@debian.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b973fec7-7722-45b4-91df-c540a6e91c9d@debian.org>

On Wed, Sep 04, 2024 at 11:21:45AM +0200, Uwe Kleine-König wrote:
> Hello Dan,
> 
> On 9/4/24 07:39, Dan Carpenter wrote:
> > On Fri, May 24, 2024 at 10:47:23AM +0800, wuruilong wrote:
> > > +const struct target target_loongarch64 = {
> > > +	.mach = MACH_LOONGARCH64,
> > > +	.bitness = ARCH_LP64,
> > > +
> > > +	.big_endian = 0,
> > 
> > No need to initialize things to zero.
> 
> While your concern is technically correct, mentioning it explicitly for a
> human reader is still nice IMHO.

The only reason I mentioned any of this is because the unsigned_char thing is
probably a bug.  Otherwise, I don't go around nit-picking these types of things.
I don't have strong feelings about this.

regards,
dan carpenter

