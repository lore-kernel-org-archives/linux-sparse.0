Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE721CA14
	for <linux-sparse@vger.kernel.org>; Mon, 17 Feb 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801662; cv=none; b=YLOUEvFLkpVaofGU1BeTIV7vowmf9kgg3anO2UYJgzUshoGvOXD6QM9Sk9Fk8Xkx+bIrm9SPHIhU/qVux2YSOhdDanS4Sf64k+bMinAE53weCra7Z/mxUf0dBm6Xy/l+qkVElIvRoJkEVOZ2PTTw4wN2ynnaAL3Qi6obiUvMF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801662; c=relaxed/simple;
	bh=DmRKIA81ischDwAmOUMnE56ItcSr1yGOCW5aJOAlBi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMV5al01JSKRDW/vWtjoU9lMCIkpfI1DohP3J4uSEQw+pBrEIv6NAjlWQTAd6KQEoJMeIa7ZRZek4SBFIgcHu/7Wiq+PQzHym1BPU7Q6bhgh3BEovyQa+omG/u7ltVAnPeLY+kGnoKWctBsCa4X9GvLORNcq0PoBpLa9gZPzTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CoFuUB7V; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoFuUB7V"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so887422066b.3
        for <linux-sparse@vger.kernel.org>; Mon, 17 Feb 2025 06:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801659; x=1740406459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NekdZXTafvfqhoDySEOcOucxcXKvkkXorz4QTbjm09c=;
        b=CoFuUB7Va2KM2WkUvr8rHHtuXRuF5vEmV4WS4i77FzWP7MPIkbCUhNusf3nGuWTISB
         YRJIYEppJQaxKFsE2ZrEovaorkE7MKt4YBJSbYKEvlYcD1431KQwn/G64vEPD7AGOg+A
         Rsa17W56HAHwpyc1aLEMA5hDmpAPWMyibFCG5ZSkve98ngBrUxRhBqjbUpLmb2tVY79a
         SFw+HgZLGii4eFm3XKDQlHfdpwdeRhSwh8jciN856MB/KfnNezsQGDFjw6LeOdNpFkft
         TNgs8ksMnP/OWMh9ZZ/uX4XXl5xalaB5fiAnjtDpbktPAPAFYHODnTzasLXLRWBIUs1Q
         y/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801659; x=1740406459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NekdZXTafvfqhoDySEOcOucxcXKvkkXorz4QTbjm09c=;
        b=HMxPWcDJN+edjWCGeeUVDJEKNiAd3iECN9vWp4BvsIKGttTgLKQ1lPgGcOq5CRWohv
         tRR5h5XZ5YIbHE8iv41EjcHRSvh8eS0Mn1PjclCGp8SSsVRVc8irJWhxhzXq1QhP8N09
         dTlHnq3Gu5cfYD/3/FjJ4RSlL3/CYvLqfVVVg6JuG0q51FVEklkt0ftC6vTfrW6qwpAv
         vcLazm+XX9kTzMRyPnUa6WxGaNdNpWheiU+o/Fvya1BRjKHvlIrExePx/McYSm9/G/hw
         yQ29gj9AnTqv1OZ1ydE4kWoWU9/patohYnLtPxuQ/jZ9a+f4D/K8fq70lu6Lt5ZX5yZK
         yPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZmwvtt5zZulL8dXIhhEk2uAXjbzOdEyR51X7OgDFXc18uPWtG4CLxitj9BIdMLB0S2s5O3KjdkZsJacU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsvnYA3G1fUf0yWildaIM9CFIPmPJjRGOyd83xkpar9kB0KOsW
	oqkw2MgbicIltneyqBrgcmEHJWHCUiKG08izB0P9jn/0qOuaj+AvFhAURjhbhLs=
X-Gm-Gg: ASbGnct9Z2Ky2p0vA6WH86GXe8i5QsMgk2BSaRL4oVQFQY5Vl8vQXVAjy6RWDuVskFa
	hNG5HR3ve8bv6doxJ2VaWVXgnprQGjZZz5VNpVcsqRB/SMj18BQF3Yx3PmdKL4Jc6wBCyqR/N5i
	TkqFBr36tyyUAqmMX4xsEbRDHM8nGU/e6z4dgcUNzY8YK9exIFRADobVZPLoLTxc2zneyB0niG7
	7WKKvGn3HSzJTh7L/1RL28nVpTLb6TCKyY+l0HqFT19wVfSPXYUmWi69K9YF5IU6G1fvU58LO1n
	WSMKJyGkAazHNbYmKpCQ
X-Google-Smtp-Source: AGHT+IFIBR3Zp7n4KLa1AEo72USiTDt41XIvlExhYbBs/eXLCwhTItsYSqPIAHweOwZVqQQcbYAUmw==
X-Received: by 2002:a17:907:780f:b0:ab7:440e:7d08 with SMTP id a640c23a62f3a-abb70bff32emr769230766b.4.1739801658666;
        Mon, 17 Feb 2025 06:14:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb8fef1332sm308806366b.69.2025.02.17.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:14:18 -0800 (PST)
Date: Mon, 17 Feb 2025 17:14:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Message-ID: <bbf51850-814a-4a30-8165-625d88f221a5@stanley.mountain>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250215172440.GS1615191@kernel.org>
 <4fbba9c0-1802-43ec-99c4-e456b38b6ffd@stanley.mountain>
 <20250217111515.GI1615191@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217111515.GI1615191@kernel.org>

On Mon, Feb 17, 2025 at 11:15:15AM +0000, Simon Horman wrote:
> So, hypothetically, Smatch could be enhanced and there wouldn't be any
> locking warnings with this patch applied?

Heh.  No.  What I meant to say was that none of this has anything to do
with Smatch.  This is all Sparse stuff.  But also I see now that my email
was wrong...

What happened is that we changed unix_sk() and that meant Sparse couldn't
parse the annotations and prints "error: undefined identifier 'other'".
The error disables Sparse checking for the file.

When we fix the error then the checking is enabled again.  The v1 patch
which changes the annotation is better than the v2 patch because then
it's 9 warnings vs 11 warnings.

The warnings are all false positives.  All old warnings are false
positives.  And again, these are all Sparse warnings, not Smatch.  Smatch
doesn't care about annotations.  Smatch has different bugs completely.
;)

regards,
dan carpenter

