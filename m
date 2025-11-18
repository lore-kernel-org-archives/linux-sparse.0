Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332534EF0E
	for <linux-sparse@vger.kernel.org>; Tue, 18 Nov 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464367; cv=none; b=vB8lxESzEXfC+ObhDg1tx1iLGYj44wDlmVqWSZy936SI6NzCD/vW/DtYN5TjpjCGXGo/0ngkk9EaZrs/5uaxLy8zleA8RuzGxNkiUt3vs0fkofHE3mrp+CU1F8SkI6SaG6iySDkEetYLNp217HcjOQ4XSQOz7DIJrkaPTlRcd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464367; c=relaxed/simple;
	bh=i6lbhix54NtXiCqFogXdt77BRh2XSm8EWpD+D35DjjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qez7se3kgsaUY3u/zd94nOTezJ239gDWldMAMF/dNGUTt11FZG/0LM7FybmbE2g9arUdmVh2tXeQOgSk68lfAaMcEkEwQcH2Gv2bNioyYVsk9SgJDqCVFE6glIjeAfIgttKWR50ZQ/xKcL40Cb82N6KTa8JfZRke2MeREc47n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pzz3GATR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pzz3GATR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47790b080e4so21412455e9.3
        for <linux-sparse@vger.kernel.org>; Tue, 18 Nov 2025 03:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763464363; x=1764069163; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhoMY9Jf4YGdaL7bJ5wIql34p/BsK8KGgkZKyPM4Rsg=;
        b=Pzz3GATRjszGlcWz9J/fClsBtiVef8JwHHZijZhbyyFe3QXm6K7Lkb9Pt1NstJzNw7
         cDxwGHNOFyLRhWHqUVkrJ8ahRfSQNAWEE3TzWqv1ScaE6PlANAQxhK44OjqKVCts5K3F
         yHUys3k4eOG9eW9lHNIVmJKJKyDR5elDm83DIoliDC/CKH7c/zL8vPbLuopALo+aArQP
         l/6r4jvmei8erCJxt5UrxP5fQ9GPxTBFCmuYX4VyUo9IcXvdOX5dGOVw5i/+Bqmly2vc
         Dynpw+XJ7uSZYOhihB0DcS32LogHlBPALdG2ciIsMXA7+viZV5NS7G+s+A99/D+fFLL6
         +b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763464363; x=1764069163;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhoMY9Jf4YGdaL7bJ5wIql34p/BsK8KGgkZKyPM4Rsg=;
        b=PEyyEJiP8HL97aQqzpkm+SVHPTC5n71VkmerhNyuAlJDwxS7k0dvp9/tOOylWaJ5mF
         z89cDvTj2p81EIaxF4nfUkUq3COiUhLOsVah9CGwNBs2XGFeE3a7zSuXmAdmCLfJ25ye
         Dl27n8lOOKhP6MHfO5crsfulr/+MppUSUvZwpmINCrWcdmf8dF7g1M9Sze/UQzfpAJI3
         rN2LgEr5TvBf3REFglSXrYE/y9PRScNaCZ9ZyoYK8Wex6XJ6hTE95PcKZSNdnV1aB1+K
         SxqjKxddlBPiX66IBqWMEVd3RsZOPkBFQYutjplnU+XcVqGomEQOiq8ei7kvyvTNZbUI
         wBQg==
X-Gm-Message-State: AOJu0Yzzy9mw8H7tO0xZYV/Qs1TxsQIWfg5qmFUTVkOMrTxy9BsOI83Z
	ObGdkhEcr/J+gWx1JFUfiEo4RFCNGtLGxvaBLxxFjbIawI9QDfrfuMKLBWMogeKLSa3g8uNR80P
	lsKz3
X-Gm-Gg: ASbGnct1CYWrToTny5ou+U30ZYkPrXojLbego1fMo3Pq3D92UT8OC2fLh9UhmQtlO9o
	ujEZ8VtMIOdhCZcK5Lr73GuEYolgsMZrX2GmLFF5UKCbSneYfUZFDRV+xfO6lpBvT7g5tetdaWa
	NtuPbQQuj1soygfM9cPLAoHovTFZuQZMihLnxSsc/STCJU87hye9vka2z8syNooV0UJPscazjmc
	Ens6b4jZxOvD27en1c+Y5Oq4OI1fgMegSRJRZo5OdRikJzwl9AyiTS0ogtG14lVt3MbH8lU+uc5
	qwvYssSQ2zAz7/xk+fwoyFK93hx3nLRKj+42t2P5XBKywltwjJ8RDDjup9mT6O5uY76sG0OaRPI
	aGxv9AZoC6Dg626x2kIMcK7l4rat72D2mze8eBqfw4LZXS/xa+1+zRw6ZAmGvY3cLqfgs0H6YYr
	G6NHYYacGpiOSHtAhT
X-Google-Smtp-Source: AGHT+IEv4b+/0yRiI5h+LJhtQpb/4AaYrOYfcRpmxdOUD/8AVgVmjl9I8pSMb5yugW0vY8rHyzdlkQ==
X-Received: by 2002:a05:600c:c177:b0:471:13dd:baef with SMTP id 5b1f17b1804b1-4778fea3048mr160465645e9.26.1763464363075;
        Tue, 18 Nov 2025 03:12:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53e982d6sm31755175f8f.21.2025.11.18.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 03:12:42 -0800 (PST)
Date: Tue, 18 Nov 2025 14:12:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux-sparse@vger.kernel.org
Cc: Toomas Soome <tsoome@me.com>
Subject: __builtin_unreachable() and MOD_NORETURN
Message-ID: <aRxUoX3dbVdyZiEK@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I think it would be handy if the __builtin_unreachable() function
were marked as a MOD_NORETURN.  I'm not positive other people want that?
Also I looked at how to implement it and I didn't see an easy way to do
it.

regards,
dan carpenter
