Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5824EF7C
	for <linux-sparse@vger.kernel.org>; Wed, 12 Mar 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792316; cv=none; b=hJeObm4mFTD7qxIIIm38XgitYh4/0/+70WPxNMeYIYBHT5YKft6mDrUyppWp6kKc1+Dkhn/cchJrWcjxgDd+xGBZYB8i9NYTqEhjAYZ/4yW3M/a0LAcUxgUpqOGFITXQ5SbjOmxdi23JsZssoKF0rtu2HzafIzomZMKmh/cfZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792316; c=relaxed/simple;
	bh=QYF00fjMCORbkhnNzSVDhN0Jz0g2E+gmqMEgDCB82+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMDmTpMcdOAya6NJ7xdPRJyq3DPc3WOF5tYrjhU5lO1nQ3VnckPMihgKHOTjwHYWermpo95QoKoGdD+nzSUt4Ly5EimjQVP05UGVB53auzmCVlIWgqVrt7QlhLQrjGl7pdVD5kKVvuVniCuk5K+NIeiJDhadyPHeAhTmEhrsgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzdedZHC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzdedZHC"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391342fc1f6so5482234f8f.1
        for <linux-sparse@vger.kernel.org>; Wed, 12 Mar 2025 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741792312; x=1742397112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmU4RViuy6ayqujJODVreSfG22Ypmw1eWik6ZZ2/c8o=;
        b=fzdedZHCtQ8oJIPtEh5EwnaVaxZB0GRza6BXIIXjsSGoZvxYL8DkUjofJMc933Kan0
         +qz6Po0InI5HA29429EOdX0dkix4aLwJrkPhl1pb/AFk2UFy+sULPXyQ0UIkCcDgySsp
         1mQ6tI29MolavJDGQ4LITU+tQcH0DiRemWdnNN27E/nQnyJ1rF2wjtAlE7CAieQgBQBv
         sVXkW6lbpNYCgNvTWACKEl3WqBsJT+N4T2IV3n3SFftLczzIXzo77p3cv44rHAxxgus9
         jN+Bxdoe61X5llGOW/aKLglKwqN5YHtkwet+OpfjTBfupv7sjd42/8/wlvL6TRVgWwRK
         2wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792312; x=1742397112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmU4RViuy6ayqujJODVreSfG22Ypmw1eWik6ZZ2/c8o=;
        b=El4WabixdeZ69crQ+u+zkyyMWwqLqtnBlYoWB40aqqoVsNXNYr+yQTfviZ8lf2PuSa
         aT3HDl7hJJIkoHQdM1VFqlrOKJs9OsDjL78/rUgwHzHnFrdqruaWOGoAJKPDP+w2oCRj
         zVduvUCbhbl112exEliIMi1WpFoKcBrLE8SanskEvh694DXUTbBaLFOK271JmxV23r3P
         MH8L2L9j5aW5iR1MzDZ1bRs49ZuDaOLMXXXcnBnkRAE4kAAayWryWr21qeF6n4B13RAp
         HmnS1Qeb8kH8yb8UM15NZhLQmqIqk2qkIfPwY6GjmGUM9mHOmagvcI5ETmdPoukOqLzU
         CH2w==
X-Gm-Message-State: AOJu0YzEHet0kTDDspaIOMKln+PQ9eqN7DviTuQzgXdTa+l6YE4/cmLE
	uls7JGFV/Mb8VJhJlYR08LAaLtP64lbMcH/Vvszsfbf5GutN0vZeptsAsl6Y9OCQOtJw/EgLIJn
	h
X-Gm-Gg: ASbGncvDoSykALH21mTUDX9bzZJ/u9kdPJBTc/kPB3qRZ36D5H/siR1Rn3DVmVr8WJ5
	R2MD+1ti3eZaZdX7hDYmHwpPxxwtuoD5OJ4tHJHlxBMp4vB5DernqBBdwQX6cnsCh6UwwGTChlL
	lS0KsJ9BHV0d9b3RxOpRuospQi9AShCy+jEpcdiptbqGt6AqalRNQdsXnXgeaXBtm25Yg3kTHZi
	MzJOcvFa+QUXocnQ8AsDB6UqmNzkJwSJZYji7l2kZooE9A4mIVjeV8ovajD4MM7OWcI398C+ZEq
	X0DB8p1pgbU2f2+zEhxI0BLE12TJup9SjOoEIMS0YUQZ/JnhSXxQTgEWiKcZ
X-Google-Smtp-Source: AGHT+IFWgdLzQ4XSTAXTb5tRiwFjFA6Eysc+SIU5RJEXPo9lNr5iAH4wvrCg7IcT2d63u1I33Tj9rQ==
X-Received: by 2002:a05:6000:1a8e:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39132d8b37amr16876677f8f.31.1741792312565;
        Wed, 12 Mar 2025 08:11:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfba83csm21054124f8f.6.2025.03.12.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:11:52 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:11:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Edgar Khachatryan <khachatryan.edgar@student.rau.am>
Cc: linux-sparse@vger.kernel.org
Subject: Re: Issue with Setting Up Sparse
Message-ID: <aa5d1aa2-1d27-468c-b9b5-38fee37d1179@stanley.mountain>
References: <CAN1=rvLAcxNqWzRR3EjtNgqk2A3T92iREEYTJdRog3OekK4=NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN1=rvLAcxNqWzRR3EjtNgqk2A3T92iREEYTJdRog3OekK4=NA@mail.gmail.com>

On Wed, Mar 12, 2025 at 06:04:02PM +0400, Edgar Khachatryan wrote:
> My name is Edgar Khachatryan, and I am a student currently working on a
> project that involves static analysis using Sparse. I have encountered an
> issue where running Sparse with the command "sparse file.c" does not detect
> simple memory issues such as memory leaks, double frees, or use-after-free
> errors in a single file.

Sparse doesn't look for those kinds of bugs.  You're better off using
Smatch for that.

With Smatch, I've never really looked for memory leaks.  It's quite a
hard problem and I've never been able to do it in a useful way without
introducing a lot of false positives.

$ ./smatch test.c
test.c:4:18: warning: non-ANSI function declaration of function 'memory_leak'
test.c:13:18: warning: non-ANSI function declaration of function 'double_free'
test.c:23:21: warning: non-ANSI function declaration of function 'use_after_free'
test.c:33:10: warning: non-ANSI function declaration of function 'main'
test.c:20 double_free() error: double free of 'ptr'
test.c:30 use_after_free() error: dereferencing freed memory 'ptr'
$

But the other problem with Smatch is that it's only ever really used on
the kernel so user space support is proof of concept quality.  I had to
push a quick patch it to make it find the use after free bug.  I use
a different check for check_free_strict.c module for kernel code.
https://github.com/error27/smatch/commit/993d157ab147720b558f0f6293dd4acfeb0d2a18

regards,
dan carpenter
