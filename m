Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F9BA49;
	Mon, 14 Apr 2025 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667709; cv=none; b=pHG0fnlaAKvM6/mRiDcV9/BJnbf7nDG4EmDR8FIV6XlktN0jt9Px+fkeBsnR2sPbaFptwhniTCHoylGdjeG+AGeCT6fTm+jbBr5y4a34NF6y4EJS6JdfOoXkxrpJQzld3pXNrvLhJ2sGJ+2XfnOnb3ZgGJxSaPys7CcRI8fzUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667709; c=relaxed/simple;
	bh=UqAYOWQ6kGQiSUNje9U4+XOQ+zGRPWh690T2+df52Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrFOFOjbUVmZsOgbyTQyQqFMGZsAlfLey8jKMPfOveTu1sda8weGEy6Ch6JLdnUu3NkaU52EJkogFRLYrmsRH+5vfq0D+VId/1+EnyZHPj9pZa2jj/hsBaagd2oJhDIFM6tF+PR2QVOzJyY4IKmCpnHGGaMiT17dZCWQfy7p+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8RxN2SF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8RxN2SF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227a8cdd241so58365395ad.3;
        Mon, 14 Apr 2025 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744667707; x=1745272507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxvqPuQ+tS3HGn/CC22dBP/Y+3vRBJ6xyIjz09EqFlk=;
        b=C8RxN2SF5niHoZaVZgLTwqC4qkdbGiGk0DlADLJXV8N44aWHeJPLXgYTQs3vBlq6Eq
         QLsA7mUcmGZFWbJMuVb0VBFF1kQSiAodwV4bpocqydKPrzxUFFH4aYro7wD+fYDZ2dum
         wXKhzi3UHmOdM4hFLz3ka5502RfryIynNqiiA7UjNZoQWIPv+WIJkRoywqznzv9C1zrY
         lO/3ReNReuRE0HTAnlvDSuKt+QJdK44JP00WfkkPJebQROtPoSOF77EFoDDIQleHwfCo
         dnsiuEC3HTH2pTABltX6L0D7xI2JtxqQehpLJ62WC9kF/zWZ9422C0EaQBF9TkjBm/p+
         1+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667707; x=1745272507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxvqPuQ+tS3HGn/CC22dBP/Y+3vRBJ6xyIjz09EqFlk=;
        b=TfelVYeGaqD14FTISsqdoluSMvSrINXf0rUFGxnnv+S3t2LpWnbgOqj8Rf4DbuGmO4
         AEaRwsibcMt1YR/AKn7NGKpFwlk+rx/2Yuc2dVj4HY00BZRcZZhFtJmYXAvLzIodOyzL
         UVxFyRQkNo+pplm8caLAVldGjiYZLqn3voOg10Hm+xe6RZshzGZ5FtZgK1fNWtypqrvo
         BURYBdF2ocsqT/mWkvogiJ4tRSvzyyaAXown2QQI5SMS9eivTnWdw8gD22MBAgqT0lMh
         ZRTT+SWZvqUW0p5nTyUJXEMrxAmSTHrUY34+hjg1ogUfQ648Q58q2ItG/poPibvwMVB0
         1p3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGJzYGfoU7NL8IDkH5MdToWoxo+kUcOTsV7l6XiMEnH1GuO5RO4/SUaQxMqmw4Sk5HqJl7cXLCwFog4nY=@vger.kernel.org, AJvYcCWbHOeEx6WSR5vuvGxVUY8XqkYO+ozNWpWPIA4jYh74cifVuP82rUsZTFQH9qFA6uBJBuD8HpBAo5UlIoiT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6krr/XmhMTfatdNErU80bxf5uoI5akG0C+Az8OFqAhJ/dzHOc
	R4erCtp1j9eWn+t0B2tjOh+Yvla2djHb42pRynF0ngVjxwrlmddv
X-Gm-Gg: ASbGncvUBlEHAMAWhGsDfIyi6+QL1HzxImt9aztAMc2NgHiFbSHFhvqdL9TF0xSICQf
	CpKRHDhRUMll9I7rwNtGja83AAVscU7I8e3QOSFZHmlwbFlCMKxDbzUgYoEWQDm4cZSZdezfnZW
	Vh8ZDwxbR+F1D56rDUoRAjV1/1oXdOxMQ6nfb9kU2rNBf+KT9p6LKwcteWUFAmOC1EWGjoz+B0Q
	GXsoNk65H/DRDsXWZvOhB06Rt1V+kRJBdT9ELFA/7WqquDzo64xasZP3TtFd3Z9sF94plksEV8o
	gNuwXBeaCF/wftrhv31BwN05/xrZjkhAJD9S77JC
X-Google-Smtp-Source: AGHT+IGp276xZ6J4CV/O9at2jw2W7J0cc+sGrfb5Ml/dZwSKvy7k6cWhfkcnelfpAHhMHAqIxlOHaQ==
X-Received: by 2002:a17:903:2984:b0:21f:1549:a55a with SMTP id d9443c01a7336-22bea495416mr210774125ad.1.1744667706974;
        Mon, 14 Apr 2025 14:55:06 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6825sm104015025ad.193.2025.04.14.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:55:06 -0700 (PDT)
Date: Mon, 14 Apr 2025 17:55:03 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Subject: Re: [PATCH v2] build_bug.h: more user friendly error messages in
 BUILD_BUG_ON_ZERO()
Message-ID: <Z_2EN7OYrXF4gb9G@yury>
References: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
 <202504070945.BAC93C0@keescook>
 <9dc6f94e-c739-4fdf-8e43-4386d35e02e5@wanadoo.fr>
 <202504081202.7CA5DBE@keescook>
 <4c01c2a6-5271-41e4-8013-836e59aeae6d@wanadoo.fr>
 <Z_aBjSP4WB062Ii9@yury>
 <202504090914.BC7A6BD89@keescook>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504090914.BC7A6BD89@keescook>

> > > Hi Yury,
> > > 
> > > I have this patch:
> > > 
> > > https://lore.kernel.org/all/20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr/
> > > 
> > > which depends on commit b88937277df ("drm/i915: Convert REG_GENMASK*()
> > > to fixed-width GENMASK_U*()") in your bitmap-for-next tree.
> > > 
> > > I discussed this with Andrew (by DM) and Kees. Because of the
> > > dependency, it would be convenient if this patch went through your tree.
> > > 
> > > What do you think?
> > 
> > Sure, I can merge it. Please everyone send your tags before the end of
> > week.
> 
> Thanks!
> 
> Reviewed-by: Kees Cook <kees@kernel.org>

Applied, thanks!

Thanks,
Yury
