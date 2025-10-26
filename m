Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FAEACE
	for <linux-sparse@vger.kernel.org>; Sun, 26 Oct 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761437420; cv=none; b=qHQX2Az9cFMxr673/hJafzjCV3zn1Qc206YqzvzXtV2CBvjQ8Y8VML6/OJQwQPE7zYZvbOndipBV04Uv4dZq9TSFKL58dD6+rmZvBJuZKGQhpd7JEhos/D7qneo7DhZUn7X7VE8WrMUu5/Z/NL2biy4iiM8eCjS14xdQgOCo/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761437420; c=relaxed/simple;
	bh=3L2Cn0VQ9BSiyQpq+zxAO3fbOHbU9xIDiRXeuCnK2Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSdIqUSYrgWp74xrhSFzUu1Y6jreBaoN+0zYk/NJLzajrpE2/MaEoncSmn3rpWXUUaeqm4oWzCFBW1conb87TLOUpzhxcRkr93a/C1D4hD7ZescJpNlwLDP0jTFxSMBafUVKRCyqrSJ5YjJAfjWiMmRKZmxb8mElTEan6rqK8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FrHoRY/3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FrHoRY/3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b4736e043f9so644245166b.0
        for <linux-sparse@vger.kernel.org>; Sat, 25 Oct 2025 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761437416; x=1762042216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHT88HQYbjysn9AJ2rZNaLUIGndxQt+sWOeqUNyjpSk=;
        b=FrHoRY/3AkT/G2dohthlXNuEQ59OF5V8L+r6rBlAAcOG+fwjOoCXftf5a09nhcezWY
         E3VT/nmOm5FOd5+HDrRULhxACce4zfIREFI49dTSxY8OHtnkSVjXUaw2L0f2KY4A6PZo
         aFIpJPABqrH0hZ/bjdIS4rADBSGtlnALhvmNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761437416; x=1762042216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHT88HQYbjysn9AJ2rZNaLUIGndxQt+sWOeqUNyjpSk=;
        b=xH16iIrz8h2qACC49s/3yYHBM4CW+mc1MxKPOMvcGBevuqcjpiqzH5OgLWBv9KKO0b
         Ov+iILhaCLNBi/fF6OEOZtX4bBdH0SC1yyy1aEoaMkXoknaIdnADX1GJ4qQhBI8faS7e
         wCCjy7lkcOimPtyKA2UfepJy/kzppJ68LwviAkEJCdJ43P6kl1yrMSiyOefS+03UQeP0
         ilgFBfM9rEg/lGk0EewGCzjGn1tb2ByoNEuPcut9PsI/gjLGT25qc++T3YkQo+/pzqzf
         N5JeDRjL4+IMjeS06b4GFum+pmU1eCk2fBed11ksiaAObSuGPuDNUHehi8cLkhIspb2y
         sx7A==
X-Forwarded-Encrypted: i=1; AJvYcCXtX2IkmthOUWxvjoiG8NpwAgmBFNOoVSsxFMzV8HWfaPero9pLUNP6IvJs/fOjw0eohWtfhkP17Ksm4Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy7auQ4DzOAwNKgLyxVvf6lJIO9Wlv91LU48eWtBzeV6aP5O7
	oAFCV024veKyEzkZLFpDuPRpLily/LioCLiHfe8G5t1sFqSWWs8Fn01nxHCGXdgQ4yXdwfoZAvv
	F8geagw4=
X-Gm-Gg: ASbGncuxiQ5kUoTGdXV+kMxX7KmXDGPXYvcyfQd+yGKzZHqU77AkBbhIZ/sqmaxU6RI
	hUduZQ6AKStIj/r6OXJkg6cBzc5zy6p7r3TmewNjoc7WT+t7A7/C/vuheSdbBbHA7vv1RNZXfaj
	YC9Ri83cw3jOYoWmPF86qJHy/GejBc+WOrL5IxH68U2jB3DjH3pRfdQ8TwX2QEgpaii5AAqGM2i
	09fILzuI8om/sTyTcDiMPp/RlcOtCmUiGVW312YsrVWB6/2CxXfA7KhkTTrvlR+dqsEEhj8Bs4g
	NIcLVabY7hbbqQDjG9c4vg/IjhMhFs5HTtGz1MvSJ2zHHvEDw34IfYems38H0UXLzemhMdxbIzv
	LpPQ6kdznPhgaDhGdMSeUJDDJlBYC6FJ2+SiGLTy+zOeE9QCT+P+cvYoReRFtOjlC6LdZQVHWuN
	3CbveuRoBon+sF9sp3fynwZy0BHJdVkJ/U7TbueunA8lR/e0E71g113aUYvvt+
X-Google-Smtp-Source: AGHT+IFlWa1MD44//3N9Hds4otaFAISalubR6WNVZoIkQ211lFDhnFoCYbuueUiTQJWzSY5aQvfCVg==
X-Received: by 2002:a17:907:6d0f:b0:b0c:b51b:81f6 with SMTP id a640c23a62f3a-b647423c403mr3995225966b.43.1761437416369;
        Sat, 25 Oct 2025 17:10:16 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm321597266b.37.2025.10.25.17.10.15
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 17:10:15 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so7085365a12.3
        for <linux-sparse@vger.kernel.org>; Sat, 25 Oct 2025 17:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpBs07muXbWw/1u3JtM4IBmI/nC+yQdnKv5QfDJh65uJg54RLoY2rEZFTGB+uSrOyn89JZbUhVcV4Qd4k=@vger.kernel.org
X-Received: by 2002:a05:6402:a188:b0:626:8e29:8d42 with SMTP id
 4fb4d7f45d1cf-63c1f6d9471mr20649012a12.37.1761437415485; Sat, 25 Oct 2025
 17:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025211519.1616439-1-jim.cromie@gmail.com> <20251025211519.1616439-4-jim.cromie@gmail.com>
In-Reply-To: <20251025211519.1616439-4-jim.cromie@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Oct 2025 17:09:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwpTUr8keTinnPU8kTN9dpYgDtwM4wONRF_j=1gvo3MQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkB-wuhFoSsfx1tBl8BEy4xJ2x_b512DolaOIzwuqOsKKnndLl-pSrsTks
Message-ID: <CAHk-=wiwpTUr8keTinnPU8kTN9dpYgDtwM4wONRF_j=1gvo3MQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] compiler.h: add __chkp_no_side_effects() empty
 hint/assertion macro
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linuxfoundation.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Oct 2025 at 14:15, Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Allow an author to suppress these warnings on _var by adding
> '__chkp_no_side_effects(_var)' to the body of macros which trigger
> that warning.  This may reduce blowouts in CI pipelines.

How about just not doing that checkpatch thing at all if it causes problems?

Seriously, I think checkpatch often causes more problems than it
fixes. If it then causes us to write even uglier macros - and it's not
like our macros are pretty in general - it really is just causing
pain.

I think we should cut down checkpatch to things that are obvious and
real issues. Not things that then cause people to make code worse.

                 Linus
