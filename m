Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE39A47;
	Wed,  9 Apr 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208274; cv=none; b=lsrv+u3259MbFBPgmJKE4aFC3XYqm2vn3NTQ9XyKOzqCS5POELMWwg4CuXuD1M0nzro/ScrhyTqdBLQlw4roMVu63jY0aWD3hkRkip3dBdqxfR2WegSzDz52/PGFvViX3spCMGKM0ZrYWy/CE+Y9+YqC6utVxkEjtorUVEb9VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208274; c=relaxed/simple;
	bh=jvYSZ8aMhdjHFW6CeKhNSZK93Ap3wZj+GUqNoz8y/EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phNidSQIGPPlqldXSehDDYUxn2mLmn3CNIA1l9C3rZ3TbohEKquDSRHCJ93w55z3DoRfdJD7bJmw6o2n5sgG6csfe1BCgTmEJCLPcK6gffB8WQEukzh7v00IfVOFSZNgbP1Q7rTZoLlOECXNiGTANInxN852I3xEbseoemrQksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he1dmpHS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he1dmpHS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736aaeed234so5892033b3a.0;
        Wed, 09 Apr 2025 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744208272; x=1744813072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KThXVBwzaJ6ilLkC3woszf5Kr6BjDY4KXUp9xUpqBjY=;
        b=he1dmpHS8iOj2I150p6N5Zpt9z0tb34i/dRUfCL0nQX0XkAIAW1QmIonBIqFvpqbfU
         y9vuVEb3hf95WNBW0DNo40drWZjr6T7TKHWuXG0QCSPI2sNdhcmrNggJ3Z28C1sokCJG
         LJdpOn/boI50v3FhPwadHgSXUpgIgQrVRPa4tAdvX1spzMuP8D/nQoxAbo7Phe0O3xiQ
         G6HjKdk8+QbLr/cxlwgkEgcjQSSUZn8j5RiFVcktTloEqlW8C8dTzAcfF898lhvSFwCq
         7ZOyHOPg8mbWgSUYETRUg180dOOtFfKII9A2gDSkEks4KZXntp7Fi/OChWotqYu+gnv/
         9u6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744208272; x=1744813072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KThXVBwzaJ6ilLkC3woszf5Kr6BjDY4KXUp9xUpqBjY=;
        b=umuN/8V4jv+HJFa0M/udebbDlFoUkJETGSO8n0ydQoPUdTot5G+k7Hfi8X1byKuT1T
         vSIarUE54vgR9wozJ0zo9nQ5TYscdu+z22VaOOwxNk2eTNJzug6VY1xhge0mmdWSiJfu
         K/GeNEjc53WQ+uJxkRLWpGLsAxJiIvxZPN6ezawL6gyRyf2UMX2XyLHPrcC4fHVfznZz
         tciKY5R5Vkjj96PNjTgfLfrYbpGGiKYNW7Osa8AcW6RrGnuQPArqiMsuD3/3/V98gdXr
         W558fmGtKRQQAylfND7qG9NE+yjlRFlkglYRNiU8qrnKkN3MlBSMev0pNB8P3BdaNW9A
         UPaA==
X-Forwarded-Encrypted: i=1; AJvYcCUzSn1a0SDddCFF7iBGpclFi1NPaUlsIOfsDvow9uCSQF5FwbFXjQU98yfE7YfWpdSdTHBuEtGKanoDl2yh@vger.kernel.org, AJvYcCV+iGXgsdzBL66H3TvlMxxHzwPkCBNKD5RRC4jQ0xHtLWmW0ZYxJbrfKVrpRa7cOqBZDL1Ki669EEmeX64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzARGZKF3RSMDgNeS/r54YnJ+RioKB+Woo3F9KV5rpU6/uQe4A
	IeD+sHPvjUelc0An8GfWSyf801LBpKS+74SnmX6CggFc34SC7flG
X-Gm-Gg: ASbGncs2DCCUOta04JAjxb1y5wZYW/Gv9dPYBcMFD/MhxJIVyBB3+/kEz0IhkizicqL
	AE158UdZuIJc2lXvqWpoquaZx/vNQilp8+T3e0mLjQ1X6Gk/v7SDc41CgITFGHXg6xmSHwT5hyT
	rI4Qaqsq20eqNB+m30Z27ywLaKebHGbvN2DV+LJPQfR67z8upWRz6PXChRyKM4G2tmXHW3Z3Fn/
	1DmhK12nzXN1IJtv07zZN25xrSV1de9x22OTLpQSAvTVXLq+jKLHijHw1I6zpke/DUStoP9S4qR
	QTHVSCVpFSYMI6X078Mu51xbbEHBeHuB9nxDRtj7
X-Google-Smtp-Source: AGHT+IEL1tMHNRrWhJwpZeYaODoLOFhswpokFgzoUy1CtNvr3Vefwyp7IVKaja0L6JCsk0C5krdIQA==
X-Received: by 2002:a05:6a00:230d:b0:736:53c5:33ba with SMTP id d2e1a72fcca58-73bae529ef9mr3619390b3a.16.1744208272155;
        Wed, 09 Apr 2025 07:17:52 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e383a3sm1400270b3a.92.2025.04.09.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:17:51 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:17:49 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Subject: Re: [PATCH v2] build_bug.h: more user friendly error messages in
 BUILD_BUG_ON_ZERO()
Message-ID: <Z_aBjSP4WB062Ii9@yury>
References: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
 <202504070945.BAC93C0@keescook>
 <9dc6f94e-c739-4fdf-8e43-4386d35e02e5@wanadoo.fr>
 <202504081202.7CA5DBE@keescook>
 <4c01c2a6-5271-41e4-8013-836e59aeae6d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c01c2a6-5271-41e4-8013-836e59aeae6d@wanadoo.fr>

On Wed, Apr 09, 2025 at 09:26:41PM +0900, Vincent Mailhol wrote:
> +To: Yury Norov
> 
> On 09/04/2025 at 04:03, Kees Cook wrote:
> > On Tue, Apr 08, 2025 at 10:23:53PM +0900, Vincent Mailhol wrote:
> >> On 08/04/2025 at 01:46, Kees Cook wrote:
> >>> On Sat, Mar 29, 2025 at 01:48:50AM +0900, Vincent Mailhol wrote:
> >>>> __BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
> >>>> do a static assertions in expressions. The direct benefit is to
> >>>> provide a meaningful error message instead of the cryptic negative
> >>>> bitfield size error message currently returned by BUILD_BUG_ON_ZERO():
> >>>>
> >>>>   ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
> >>>>      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >>>>         |                                                   ^
> >>>>
> >>>> Get rid of BUILD_BUG_ON_ZERO()'s bitfield size hack. Instead rely on
> >>>> __BUILD_BUG_ON_ZERO_MSG() which in turn relies on C11's
> >>>> _Static_assert().
> >>>>
> >>>> Use some macro magic, similarly to static_assert(), to either use an
> >>>> optional error message provided by the user or, when omitted, to
> >>>> produce a default error message by stringifying the tested
> >>>> expression. With this, for example:
> >>>>
> >>>>   BUILD_BUG_ON_ZERO(1 > 0)
> >>>>
> >>>> would now throw:
> >>>>
> >>>>   ./include/linux/compiler.h:197:62: error: static assertion failed: "1 > 0 is true"
> >>>
> >>> This is so much easier to read! Thanks for this. :)
> >>>
> >>> If no one else snags it, I can take this via the hardening tree for
> >>> -next once -rc2 is released.
> >>
> >> I discussed about this with Andrew by DM.
> >>
> >> Andrew can pick it up but for the next-next release. That is to say,
> >> wait for [1] to be merged in v6.16 and then take it to target the v6.17
> >> merge windows.
> >>
> >> If you can take it in your hardening-next tree and have it merged in
> >> v6.16, then this is convenient for me.
> >>
> >> Just make sure that you send it to Linus after Yury's bitmap-for-next
> >> get merged: https://github.com/norov/linux/commits/bitmap-for-next/
> > 
> > Could this land via Yury's tree?
> 
> Hi Yury,
> 
> I have this patch:
> 
> https://lore.kernel.org/all/20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr/
> 
> which depends on commit b88937277df ("drm/i915: Convert REG_GENMASK*()
> to fixed-width GENMASK_U*()") in your bitmap-for-next tree.
> 
> I discussed this with Andrew (by DM) and Kees. Because of the
> dependency, it would be convenient if this patch went through your tree.
> 
> What do you think?

Sure, I can merge it. Please everyone send your tags before the end of
week.

Thanks,
Yury
