Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD3199EB6
	for <linux-sparse@vger.kernel.org>; Fri, 14 Jun 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371740; cv=none; b=J9MDbNumnFafzeLNtGzbZk4K1BujHYumPOhIJqt65bJ4zDQv7LgR4d35uhvfNF0GX2jy2FKtEvGwO1Z7srYHGQ/nwUBS/1Mq/qwinHGUcLgRUCgq6jWwErpWCRXBbjweUQIZRsJPVgcuaa/J2KGdnN1d85LjjrEvSq5zaE73sBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371740; c=relaxed/simple;
	bh=VgPLVV+rWJY1/4ggiTDotX1RclssqWGF4A2bfPcMHMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDuy+cXLdoZ47GwwZ/P3mAxoXds5HL5SGP0G8K4NzwLo+ESxSpt9ToPWOp/Vy80+KVwJdNEC6R1sACtZzUuH17pmXMf62+bnJIh16v5QJDn8eFtVT0gomQSx63BoMX4/AgmNkD1LHK+OXLTA+CMibIJpiq78K1HZ2X6GquCYLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLI6ivKo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLI6ivKo"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so1988665f8f.1
        for <linux-sparse@vger.kernel.org>; Fri, 14 Jun 2024 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718371736; x=1718976536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEMNF56withKPeocU2VwLEQo/3Awb8CaeGLcfj7+MKs=;
        b=ZLI6ivKoKHra9a9X4xtjaHDu9tFByLn4lVDs5jIF/3pedJD2Sq1E+XBse2DQxg/7k7
         Qdo+yqOKZcDSuetzX5zdBKStBNFn3MEBrKtsQvE8d7Vw2cVT5+iLUQIq5tXzKmTBFWBJ
         UGpQLAP/0AaZzb7OyTfcsxpmvzp1DehrWsFedR1cyrGhtaoSHnvgYLa54bNWf4xIEMZh
         c2RtMO1RlfipPqFJjl9abpvCg9xSEoupi/oZSl8yK6+ZtU9PqrScN7ta7icGaVd119Va
         ACRTX/5B/5tcX6gpxoWxzMrOCjhxFsX/EzzKFsZujnS1yhIH8d7+KR6eAqYIQdT2yuOM
         XhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718371736; x=1718976536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEMNF56withKPeocU2VwLEQo/3Awb8CaeGLcfj7+MKs=;
        b=hjqWpxMQPOJQ6GDaAfRUAYOJlFT7R+rmIZjagzjvS+ppNQAyc+nKobob9mKc+wSZfa
         SdLy5JnElz6LGCUDzs465mnwT72Yrt1WPkswM+6JbwA3hDLu+uXiNYRuSEDtmYp7s7Kt
         tp+XqAPFqbGMIg6Fw1pXgYisUeKL40HCTdhHG42YELPgFufp81O1IYIPGWLtX00A3s2O
         n6UljG7CZwWl7LTCSCwY3JYpLqXv4o0Zir3uQOoCbX2yLAG/uF5RONusSytTmBfO7DEs
         QK5d2l2MyBC9uNhP4CjIstj8jScF3rKpAHzVGi4bgAnvfuPsXF5gJ4il5qMkZAETusoL
         jP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjuAdnYrIuoDEU3g8HbCF/fYC8LijHU8XaZE7Wa+N2vWCE66EcdtPpUDBTXcDg3iePp7ZDBYPthRXQshS8HmH++/TFD4zlRqKkgWQ+
X-Gm-Message-State: AOJu0Yzd32wg1UKIRGMD38FoOwrPrjhTTPjJA53sTE/6WPmNX8Ie4cmO
	CoY59mcj6ADDDgQrNQMMRXvSHppZUyF09qaci/WXSQMkQUvV3yNJdTylM4+XulA=
X-Google-Smtp-Source: AGHT+IEFBwl3wR8gDYlbOGuM7VvKD2Eb/JCNcdEsfhZrpHBLeC7TmMrK/7vrQHX7qtx+2sHMnhu6bw==
X-Received: by 2002:a5d:51c8:0:b0:35f:a0c:7cf2 with SMTP id ffacd0b85a97d-3607a77fa42mr1958155f8f.51.1718371736404;
        Fri, 14 Jun 2024 06:28:56 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2271sm4403695f8f.85.2024.06.14.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:28:56 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:28:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: j.granados@samsung.com
Cc: smatch@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] sentinel_ctltable: Add a check for sentinel elements in
 ctl_table arrays
Message-ID: <b8162eb2-eeb2-44e0-9f3f-13af426a8a53@moroto.mountain>
References: <20240614-master-v1-1-c652f5aa15fb@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-master-v1-1-c652f5aa15fb@samsung.com>

On Fri, Jun 14, 2024 at 02:29:41PM +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> Added a new check named check_sentinel_ctltable that prints a warning
> when a sentinel element is detected in a ctl_table struct array.
> Sentinels marking the end of a ctl_table array where completely removed
> from the linux kernel in [1]. We add this warning to avoid cases where a
> sentinel gets added by mistake.
> 
> [1] https://lore.kernel.org/20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---

Applied, thanks!

regards,
dan carpenter

