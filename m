Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51D33BBB2
	for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141317; cv=none; b=kz46mjGeWBQVEK0w/xhbZI0RakaUpUGhFM0I5ONLFA2fKfNfb0V7merNto4tLduQtSeeZLTp4Ho5AiggImjmBnZagtf3pi4C2kWblH5A6E+LfX8/1YN1E+WWRH2sa6UcJXhSdI8gZCzdkvTaw8DMdEHAFGub0nWt6IOnCIX+nP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141317; c=relaxed/simple;
	bh=0BQJjPCgi1Ks2wufI3U7irPuueJ3BznprLLd2GrrZ84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ygds/kKjlv8OoV1TsQ5B1298sHm1zT3S84TQtHJRsDQfJbcs/WxpRYnv77r30BOZ5V3YGlD7tIzzBdSfVqtqwUCDfrR6I7vKlCrduwj32FsxAWEfMkWgm0RlC0y1PW0PwQioL8WQk/4MBFyA9Coy7hRhBZ6yuR8PAooJ6TA76os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TEJ9waIg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TEJ9waIg"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso3868863a12.2
        for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763141313; x=1763746113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iHdilhx9M0Sn5mPxaXisVhxNAxMfQTLffsrPcjjnXqc=;
        b=TEJ9waIgLzERVE8zl2zorN6cngl52YHVBHML88m0/s7YR+Kk93qt/rwwfrv9Xy25yu
         haBjtY2GNiw52LL/kOIhSh1tTHL1eLDqMlSV1NyasyTdnsapMqu9Cky+3pOcmDcZJSPU
         mtH0+FBUT7PGHFq2O2KdRDjo89q/rHlflBChA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141313; x=1763746113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHdilhx9M0Sn5mPxaXisVhxNAxMfQTLffsrPcjjnXqc=;
        b=J6DuxxvhZ8uw4t0ZXcfqI3+Wp9UpUgQCxuW2KOng9q91cl3mhwoEF2Mmjhz/VdY1pz
         7P8947prp3WRyhPuIecUS2RK0gZyeqLz9BBraedZOl70e7tKMQb79sFmQSSOUMkrTyW8
         piKwTjsgBqBszKDCwtN8j4HuKAV6hAjm0z8sVDS+VUBJwTOC+9DCTaqjS4DpqCXab4yZ
         iObcuCaN6kjsY4Qrrp3GpIj4f3p/+ifetAzVR3istkbi8KSgboPbYxXqP+8NTrT/63Rp
         HBPbainMvDxvlOnjVWYH+19nmCb2NijhJKi5A8AJZ1gkTAle9F4aTSBaTP53PFZMjuvB
         WXXw==
X-Forwarded-Encrypted: i=1; AJvYcCWm3ilriEzpw6ijy3L+f8ThIiQC3fhXfrXHskt1QLPobBIVEg0yXKo5j4kUdqOiNDLMwnbBJ8djOvm/Iqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh586HTB//koduphqOdVy6sigrwEREAD0/yBitznJu0pSIIk0G
	zzexdp8KYyuHI2WZiZ6wYDwVxvK/OinIllDBq3FjTRD0C/uD3iV4DwQBy4qY91uiyeMAwFdPe8p
	/LBKxmFU=
X-Gm-Gg: ASbGncuF5HnJXOPM2b3559l/6ZDqgzJpaYK9g1DrXGtECUBVBBQ24J2MBahwGmXz0Ki
	GEIEMZZ+mFk+DAy/zIJwyckfzZZH17B68ORFd9ch751W5Cld5VTVTPTzSYPlt/DDUw1pV0afyrG
	qml7JyTYXl1xW/kQfzKhulaZcaNrpnzm7CkKDb7kz+k1egMebKyEMJSK1EEMQeU3Maqay6hMjTO
	8QR8Jkoy87aMt3nh3l2IxvzB4evmZmwkT7P4Ja4eQG1qzhumD5bt2pJT7QfhcNTGj/sUhKqcHo3
	a7XfilXQMvbUTnhuHUg0hBrPagNpHeynv0Jrxm7Xpr9gKZpCK9Xbp+7J5mO2yVQgZ31tgrDuhpQ
	GnNrs+WVZZvlDH1kGEHNERTsMR2bX1z7Ej6H55oBc39Mfa66pYZ44Rr80vflV28VIzvboJOY4PE
	foJtN7+Oj9x26slZZQTTlAsXISBCDo+1+uZqEUw8BtMZ66976zZw==
X-Google-Smtp-Source: AGHT+IGrG5/83kIChe8dBVIky1haGOoA1bYjXTX8X6wCLbWwR6HxOWJ+aW6BF3+qsjC7zrEJ0E2vtQ==
X-Received: by 2002:a05:6402:2115:b0:640:ef03:82c9 with SMTP id 4fb4d7f45d1cf-64350e1fa2cmr3187231a12.11.1763141313448;
        Fri, 14 Nov 2025 09:28:33 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b2615sm4044527a12.32.2025.11.14.09.28.31
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 09:28:31 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b736cd741c1so152928666b.0
        for <linux-sparse@vger.kernel.org>; Fri, 14 Nov 2025 09:28:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMXyJGIZtuInD1d9Bxr6rlj8Df2zxM6N9zSvZ/B4HDXzTazRvrgJmFlBUjDo31zZ5s4+vCTnNP6vUKL5I=@vger.kernel.org
X-Received: by 2002:a17:906:f597:b0:b73:42e3:e70f with SMTP id
 a640c23a62f3a-b73677ee9f3mr379951266b.6.1763141311414; Fri, 14 Nov 2025
 09:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114055249.1517520-1-hch@lst.de> <20251114055249.1517520-3-hch@lst.de>
 <20251114170402.GJ196370@frogsfrogsfrogs>
In-Reply-To: <20251114170402.GJ196370@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Nov 2025 09:28:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmYntzyDUOjmoyKR_oyzg9Gddnda447KioykKi3FmzDQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnPyaNFGJboMfVt9LBmNURVdE-jeW-JZAYBUC12bhugNENatC7jxLidgNM
Message-ID: <CAHk-=whmYntzyDUOjmoyKR_oyzg9Gddnda447KioykKi3FmzDQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] xfs: move some code out of xfs_iget_recycle
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, 
	linux-sparse@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 09:06, Darrick J. Wong <djwong@kernel.org> wrote:
>
> I wonder, does sparse get confused by rcu_read_lock having been taken by
> the caller but unlocked here?

I think we'll sunset all the sparse lock context checks - they were
never very good, but they were "all we had".  It was useful in limited
and simpler places (because the sparse logic itself was limited and
simple), but it never worked well for anything more complex.

Now that clang is about to get context checking, and doing it much
more properly, the half-arsed sparse complaints should be ignored in
favor of just trying to make clang understand things well enough.

Put another way: don't worry about sparse.

                Linus
