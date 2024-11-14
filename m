Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529271990C4
	for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609651; cv=none; b=bFLeMy/fWbpOYPfdvn+QpVn6hB4NUtnqfmUknXMSJpVzzLtWK+FOr3fYRTrOo/MmGqNr6kv0TP+udD33nx4LhGn78Mj48mRLBnPod/+8JY/frwVVl0iifSyx6+7juX0v9r9rdEny9rOYXw4iSU80AwEGm7zfLrzImNUpg5BgbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609651; c=relaxed/simple;
	bh=yQga4oATU7BAhTeiJXrO0GYPE/pnGSUj4/FtYK7YdnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnZ3GFbPT+yuTudRiPmjuIy74aV63ggTRiwcqYuu3GrbxrdtjE/EBLDZqET2jJBnG2KYcpFCPv/JMhTuacXR9SjRuDS7+ylVhKdLSdFPa7Q42+gyTFD/pQrbXf+n1glxdxyZv/I4d/M6DZXczGMST2dV+EWZrXbP+kAfifJZFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IxcF9nUw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IxcF9nUw"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ef275b980so165803066b.0
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 10:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731609647; x=1732214447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IVKKcMuTV29ZR/6oylMMphkdu4mxNTAVjAxFHNzjeW0=;
        b=IxcF9nUwEFeOu/2p3TqxhuYekPKKQvlFMtrHhkaEBXbwL5utnrTqJUGLdeldrxpoqq
         EN60B9p0D3L8o0UmPQ1Q6214DPu8i4FAObSzIbIlc6244vYMzWTtviQPuEIE0LsokeWy
         G3OvbK38ItmNAFuG4dr5RR1HRb1qqPrsaav7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609647; x=1732214447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVKKcMuTV29ZR/6oylMMphkdu4mxNTAVjAxFHNzjeW0=;
        b=XxBkaELYQW53f1Q+835egbSXZTXEt4YpjowTN7lWZ2o71JCX/rOBzfhsEO/zyoLxxQ
         CvH7yveQfwMmhS3ANlx1hfFf34wzIoN8q2UXY9BNdQj/eskhjGLVn0YbBlFJoSSGvCAs
         3gIMO5OTKypZMxEembRO2G4x0T3N1bEgRw4iXjrkkcFt4cH2vbg+HFx1RiYB1+slJo3d
         lfmyVKDfjH1iztx3FLZFCV6qchfWEPpdSxXXCRZieiO4kCyEgjyoMkSx1fO7B3Jp2CY+
         6lSRW14IkbWWxSVinpDcuVTmLv+DkS6NogH0V8hwdnMzy9anwA2MER+5pEgq8sau3EWV
         Ac4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9Tg313Gto+mnhG61eTTGtGNF8jZp0ARhz553vkDyC/0PusICPB4fqz1Cmb3BeKqoYXmHBw+sR7r7Cmyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJsJng4ovGTi3JzeKNtky9J07a9bK7rG5FYwxeciwLSRF4X4k
	+C3kp6r7/vpmUfeNM++9wtr4dwJXEBe/fiypzu5gfB8aRo292CM979RbJh6BGWdWEASOn68SKeA
	e0fD3uQ==
X-Google-Smtp-Source: AGHT+IEmxjsXXkrwlAY57Fy5p1bvuhDyzeHud14UGiVkzjRKGQP314JvQKbMj69pW7up+livhyG0Nw==
X-Received: by 2002:a17:907:a05:b0:a99:f0d0:4ce3 with SMTP id a640c23a62f3a-aa1f8058899mr727522766b.17.1731609647414;
        Thu, 14 Nov 2024 10:40:47 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e00172dsm91622866b.120.2024.11.14.10.40.46
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:40:46 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso189380966b.2
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 10:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwKMI5YMhibFdjW3tLfD8KQL1WoxcIwDsnMXwUmz7rq6JbHbVXXgPge/MkLebkGNa7rOXjuqYHHvSHMz0=@vger.kernel.org
X-Received: by 2002:a17:907:368d:b0:a99:f861:ebd with SMTP id
 a640c23a62f3a-aa1f8055032mr767816766b.14.1731609646162; Thu, 14 Nov 2024
 10:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com> <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
 <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
In-Reply-To: <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 10:40:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
Message-ID: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Philipp Reisner <philipp.reisner@linbit.com>, Kees Cook <keescook@chromium.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 10:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There's probably some trick I'm missing, but yeah, it looks like we
> need our BUILD_BUG_ON_ZERO() thing with that crazy bitfield hack.

.. and right after sending that, I figured out the trick.

You can use 'static_assert()' inside a type definition.

So the way to turn it into an expression is to just use the same
'sizeof(empty struct)' trick that we use for BUILD_BUG_ON_ZERO:

    #define Static_assert(a,msg) \
        sizeof(struct{_Static_assert(a,msg);})

works as a way to make _Static_assert() be an expression. What a horrid hack.

I don't know if this is worth it, but it does at least have the
advantage of having a message, so that the error case can explain
itself rather than get that odd

 "negative width in bit-field"

error message.

I dunno.

                Linus
