Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006E1F6669
	for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582360; cv=none; b=rFQEVqMLKjQ2pmrs4HJzfqsNZ7nf5uvsCfvo0FGNAzoOreLMpJVcE+MJi01Y5G6zpJo4TGOIrvh11X7+THReHKlJmnSYw4DHhTe4Xw/ms7WWA6icvBRRDI06bC7xk1G5kdkkHrxthWOiHCASNcL5yJ3HvvPe1dyE9QbCrQvjTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582360; c=relaxed/simple;
	bh=gnJfNUfIqzprkALOAlcuM/+9mzsL2BoiJFz23GrDSwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6a1wct9PNkhS1AWbkAgQ+i244nilc/ajT354nkEVkXCf0/W37/vPG5qCmxeU54LrQA7qu/kTd4l5feT7hr/Fs0vlpKWmX50s/LjKbHQN4gi4aYg0tJ7sRo+wyCL+uAN7+j/G7MzA9uRBjA8u3gyfYsuD8q2GrjJCse4YR8tQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hB6xe5bp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hB6xe5bp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so4777615e9.1
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 03:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731582357; x=1732187157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ep88RfVuQ8sIoolXEmcFxWVVUvTLRRVbPvP1VZdK4xk=;
        b=hB6xe5bpiTLGYzIoCMvLmNRvHyknxw271iXPLv8dx9Hf/6GzH5+A/MJsWCqQ/bQr7e
         81Ay7DW4YFWX28zBdS70NGgkzajcxt9bgMKfKF0AiM0a7JYck2UT+NVOjAKPN/iEv82d
         ipvgvqL0ajKBnraz6uStAgoQgCosqArLxFItBLbbr2JiyAMcT3JmOJ52LDgumiPjtAHb
         rS38N3E+HXfYkvCqo9BRFToTdwVyU8ZyaOOSHlLDHudMZO1QFe9PVcPLC08oaQW7M1h1
         phqlGyecmrrd6QKGIj4BXGl40jXnaWTIGkTyD37b2yqapsUQD+4RyVa6ba6jEsUCwkna
         S9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582357; x=1732187157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep88RfVuQ8sIoolXEmcFxWVVUvTLRRVbPvP1VZdK4xk=;
        b=H0I3Lxe+OzjX4Qn6nRS3eRfr6pKnkr2i2vj4bZi8vCefalCUgNFYo54doFIexnNG0A
         V0sPeyxRF4c66MM3D5/wJoBr/I/4uTAYjdY94iUgjqqxKxA5QaeR03EOUEI8lMGEvnif
         9fs6Rv3egKaxdE6FO1AMaFve48iQ9gs/SM37ebr3wyUpsvRT5/zr3XjKi/N8yabJlwMX
         lIfaDEJAa0KRPX/nd95sP0F9Dax3FyQSGRUqpAwca2gciw9OxjZP6L0/3H42JyjGZRz4
         aHPH9eu9vFCMkAk/bZfMD0oNcO1Ll66N3auAtpHsZIvK5ToFcEjpeCcCvB57WUwEGKiJ
         UVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkL1cz0AxdVbbUs8ZD6KkgA3ITiXW5iBmowYHySUgENbVLjkaLTcZjX66q8/3t6X1ngxuCk6jEKxFpBgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPhepCKMag7W1EBc6aRmUtexqixglgiagDSp4EYtiAbcn0s6L
	iQhAl4c3NP2HPTkhRMCPZa7ebbYIvgY95v6IwUl+XpxKXWLJUS8nWQNglJY6I/E=
X-Google-Smtp-Source: AGHT+IG/aWdXKZAnmxpptIEr7aM/+ApVTS/n1BQ6I9fFkfMmPPG9s54NeiXM21wD4TXeZTi+qnj5WQ==
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id 5b1f17b1804b1-432b7501fdemr217488655e9.14.1731582357322;
        Thu, 14 Nov 2024 03:05:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fcb4sm20076195e9.23.2024.11.14.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:05:56 -0800 (PST)
Date: Thu, 14 Nov 2024 14:05:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for
 build_bug.h
Message-ID: <870a1165-6281-4ca7-9379-83fc6cccf702@stanley.mountain>
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com>
 <a2ed9ec0-4909-44bf-be11-21a22789e1d1@stanley.mountain>
 <CADGDV=XZnkOUrc=AC=D5CeOHagiTbSGd2KGK0rN1MWoSXjidCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGDV=XZnkOUrc=AC=D5CeOHagiTbSGd2KGK0rN1MWoSXjidCw@mail.gmail.com>

On Thu, Nov 14, 2024 at 12:01:42PM +0100, Philipp Reisner wrote:
> On Thu, Nov 14, 2024 at 11:40 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Thu, Nov 14, 2024 at 11:14:02AM +0100, Philipp Reisner wrote:
> > > compiler.h defines __must_be_array() and __must_be_cstr() and both
> > > expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
> > > So far compiler.h lacks to include build_bug.h.
> > >
> > > Fix compiler.h by including build_bug.h. With that compiler.h and
> > > build_bug.h depend on each other.
> > >
> > > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> > > ---
> >
> > Fixes: ec0bbef66f86 ("Compiler Attributes: homogenize __must_be_array")
> >
> > What actually breaks?  This commit is six years old.  It's weird that we're only
> > seeing build breakage now.  Or did you just notice this while reviewing the
> > code?
> >
> 
> I am working on a compilation unit that includes linux/string.h.
> Compiling it breaks when using strscp(). That is since commit
> commit 559048d156ff3391c4b793779a824c9193e20442
> Author: Kees Cook <kees@kernel.org>
> Date:   Mon Aug 5 14:43:44 2024 -0700
> 
> Of course, my trivial workaround is including build_bug.h in my
> source; it is just not the proper way to fix this.
> 

Ah, okay.  Thanks.  I thought it might have broken in tree code.

regards,
dan carpenter

