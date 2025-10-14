Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BDF212572
	for <linux-sparse@vger.kernel.org>; Tue, 14 Oct 2025 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427551; cv=none; b=p8jShVnY1ImheajWQSBMgfy65srYwDP5Y5SsD1VKypkEzd2690gnQOWulQTM2BswkJt4RndqbT7kqSoO9tm0OvKraH5/hlDpn6ve0Imwa8qXQs9aKDOtLeDGjE13ITR6qpFFGGOT++GMeGvA6qkdW9ckpD8D/NeMRconrQFZhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427551; c=relaxed/simple;
	bh=Ld+pgq8lK1bSy6k5x9WjVuw0wKJS1W2kLijY2IVY1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm+9CnNXkiEeyPAky1sc8Wj9PxI4LOfpBHtVQ+icUTbeRBsAERwJ+uG7Pc8TB7/7qa/bL3UPwfiHrQA5D0A4mtkwMoVhxdaPdeP9/1Mia1vDnlRzstQphZa19GJV+RKfSsXUvkqpv/ij2IfIVVkI9kEIBQTrs98Q9ifJVUmYO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2AFEFOI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2AFEFOI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso29832775e9.0
        for <linux-sparse@vger.kernel.org>; Tue, 14 Oct 2025 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760427548; x=1761032348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InUgEugYD7X+Bwui6uuPDTdStKnV66TZBV3pv+azoJk=;
        b=y2AFEFOI0blaLzg3CvjYXBxOUunwyXUTxNQCehRq3IvnQ3YnQG5Pknk9GtZspusv87
         1VLqqo/xKEDznBUg+HSPj+RmUHl+COrr7Q+oPfEpV6sWor2q2PE0KdKqZlDlVf5J2lWb
         qWVu2ow74dBKrFP/wF7wRdhGS29sUQHLCMFzGbmyX21mjqjeJb46wowEreYLKzudVkKv
         /ixsA67KnN2ls8irrDyGAqaAwmrGXaDsQ9MKEhbSfkojZoytdlMH37gtYcoLB5dCUhZo
         tAWz4P2mwUiJvuBexW82sp4/Tz9p04HOh0/iesOd0teslGZgnAPkdyfP8BdjcFScNJMi
         /8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427548; x=1761032348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InUgEugYD7X+Bwui6uuPDTdStKnV66TZBV3pv+azoJk=;
        b=PbSEovd42EBjdW782pd9odxQwWj+0qLMjPbAHRw2B5G2NtQGWtwXhAk5k1MCYkNNQb
         vl5WdrD5sYiplqcsNuKLImjWeoaUNIqq40eptGShCI349a7aD7HKWr1Ghjlaiyp3w2as
         7IK4GiHmWgcbT94JuejkJd/l9he6A9j51YN9RLQol19jVG8p5IC8VlyPA3EX4luI2geR
         8dCcs8HJcufVQDic2HWKLS3G8hweENWDaPThjfQRHItFN/V1NOeAOrzbMR3OY2jdLF66
         nFKj5zUuUoPDg7s0fT8g+PBuy414QVpNWBCVTgQ8rq6Whjj4KzZ7MnTK89x7aPpmLLkc
         +kYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPnf3lCYZZrzCks8ay8u9ZrD749Vqaxb34MvytJlr2JrCv/MkBMo/MFimX1kv5QdsCvUw/t2kGDkLHIQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kakbmaimbywrMwA9qHAL99+VcYSw/LUk+2xnDhv9tN2OVjKV
	CfhleIzQf4QQeHJtzo24hP7lM3oBZDLwflsrvaaPMaevG0ZltV7IbjYsFcJLEHrRcWg=
X-Gm-Gg: ASbGncvwKMCLWqQRJaDiA2218XoUI8uR5R4tEmVztBxFsWpsyTGzKG1Km5PRlQFQpM/
	0QnWGkB2yfTDy87O2GukSfYzg8+wPM0g+wyK7COy3CryNyDw89G89gV3S2zd/0Kb6ckCleuqA+T
	YG/oXvY9vjj/rsufRCOnHtd6PvOZ9nfPorxGbjjAN9F/thYmNgcW9Yxr2U4VGkbc1OVZJKsL0GV
	/c14E0VuaR4bQMxwhm6Efuanv288MFkvjzJsv0eV1w1Me8Y23KqPnZ2OiHF63tVsvqZCWva8oUp
	3wicQIY006zzg52bPia8FeCNvUoQkaN37hfzw2Hsws82RCfyFpJf/1IOOGe/xoZVjP4M6o3FKeY
	RIAno5eIPWQnPfajYc4BW7RFG91es2FigRrc1jD0a+ZnWdw+JHwn/NsjH+4P7yw==
X-Google-Smtp-Source: AGHT+IH0WnL/z4Q9t6vYT9gMXeiLVnMC5/njbjvHlxoLaTL5J6kLGyTz5/h2/DGje/5eUoRZWTT3sQ==
X-Received: by 2002:a05:600c:1395:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-46fa9a9efaamr159825925e9.9.1760427547722;
        Tue, 14 Oct 2025 00:39:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb489af92sm243104035e9.17.2025.10.14.00.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:39:07 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:39:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: Chris Li <cli@chrisli.org>, linux-sparse@vger.kernel.org
Subject: Re: [PATCH smatch] smdb.py : Clarify <function> comes before <type>
 in info option
Message-ID: <aO3-FxBcjuwxe6bQ@stanley.mountain>
References: <CAO=gReG3L4S90RZDTg+kx8M7jH7dG-AHKEnKJaq0OJLRfYQxug@mail.gmail.com>
 <CACePvbUdWi0eGR79KFurZwEx-wEKGQJ-+gdse4hVNu-FMWVgvQ@mail.gmail.com>
 <CAO=gReFB+iUq1ZBdwWsZfqtEGosmmmcraze7gC=T=ZERDT8tNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO=gReFB+iUq1ZBdwWsZfqtEGosmmmcraze7gC=T=ZERDT8tNA@mail.gmail.com>

On Fri, Oct 10, 2025 at 03:19:39AM -0700, Amit Dhingra wrote:
> On Thu, Oct 09, 2025 at 10:33:06PM -0700, Chris Li wrote:
> > This patch is for Dan to apply on smatch, right?
> >
> Yes, this is for Smatch.
> My apologies if the list is the incorrect place to send smatch patches.
> 

The Smatch mailing list is smatch@vger.kernel.org, but I'm on this list
as well so I can take it this time.  Applied.  Thanks.

regards,
dan carpenter


