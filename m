Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F451DB94F
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874369; cv=none; b=l1QA+4iTbqUFmdiBF7ygHmvevvbnZAtMqDKpwslKSvF8OBUU1n0D5LD/qpfZeg6efyP4p+/BD1HMUIgBYb3LjIRkrsm1jX/V4i315jjJojfoPr5/Gw8jWeYOmqE6sQon/Ub/aBw9RjNBj4z8T8VZ7fEhz9uhUeWkeXyQVVJ4ezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874369; c=relaxed/simple;
	bh=lM4U6ZLxdN3VnshIyoKyM2sOLvlQlZEzMP31+1XpynE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si+MGzQW2ysb+P8QJTUX/NAJWmFRHLCznMv1VWodofRF6+UTAgqaOcqgghMg/Ze53HqFAOCpkBmrSq8LO8mtnIxMjtPuMvew1spIYltqXUOTyd1XiBMkwb2LH6L8PQag0AuGyeQSNyJCPYhtMR1a21i/wq+HDeBTtWq1U01GeSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WdhrHc53; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WdhrHc53"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso193780a12.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731874365; x=1732479165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVwnG+ZIZFKobx5Kvb+VdCEhnAlm8t8yGOsPLjE743Q=;
        b=WdhrHc53OoniXL+Sn3j/jVxIgtuickWhgePamdeKKQsBZMDBU1fpm2Rz6+JCwnByUy
         xt4/uMeHHrCRrcOXtuPsCPjnEdTXoHpiDTnm5PkfwPElQuzy4NtCuJhCYIxUhelUrr+y
         ZIKjYLET5Jeno6ISDt8P0q+iou2+oFFyUauTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731874365; x=1732479165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVwnG+ZIZFKobx5Kvb+VdCEhnAlm8t8yGOsPLjE743Q=;
        b=XKQUfrBm+huehWFMrGFlM6xbM9kkMGCP3WIyMiXE5tzUhnI+KWp4y9/eKswq6uAnLK
         d7Zg6b2yFTSgcxFB1vXKvwPeKKMVXXuRuCT4x4PchVSEkSLCQ4vQ3ZLlOgDubpN1bFy5
         XcJLmCjjZsLlXLVkselvGmo3yNsIfhHHhSEXpvqWF6U5XEXezzNuA1WeGYg0/MA0H7bv
         FNmtP++6FWxHnGioQshfBKfzgyN0AIjQcasJ0KnbEY4iAe0hZAo+7FtwAXPWP/8HYhwB
         8F9kvTiNjO1x1QwDRDRQxv6oNk3wS7/z6hM9eezb70aI7KSSzujqoteqaaFZboNGAk33
         HtFg==
X-Forwarded-Encrypted: i=1; AJvYcCWxFVSnwjtyxpD3ZHoQMYe6nDodxzB92ljWNRtTzyRW1yQdPZUORnoLbi7+Y0ugyrF/7R8ZWzq0jC002e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxieL3sfv6XqTB4rrKqrnNJ7f8ASRpQqEcXustnM9AHKbFE8hsn
	1TtjGuCLsNqeHBaueQOvDE7ONRwKJfiCykyM9mhYQmRIMYi9SGpsQY170MvC8Wjumkz6QyxOnjh
	5Uu4vGw==
X-Google-Smtp-Source: AGHT+IEEJSQkcgpr3t5kaNQW0oQGOzcBMtvCY08LbcXbC4ojVYgc/7Dnsbz0tP4cF7DvSO4hwWF0ig==
X-Received: by 2002:a05:6402:26c3:b0:5cf:b860:34be with SMTP id 4fb4d7f45d1cf-5cfb860371dmr3699672a12.11.1731874365025;
        Sun, 17 Nov 2024 12:12:45 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfbe0d23e1sm791880a12.12.2024.11.17.12.12.42
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 12:12:43 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso193736a12.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 12:12:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkg1mzCtpHK02Fqmlecr2OKAP+eTD74eZA59mcXuhQHpcgi6PZO+pWD3QVOVSSawgG4Zw/Cotr0vvPwp0=@vger.kernel.org
X-Received: by 2002:a17:906:9c84:b0:a9a:eeb:b26a with SMTP id
 a640c23a62f3a-aa48185c8afmr827341266b.1.1731874362328; Sun, 17 Nov 2024
 12:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com> <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com>
In-Reply-To: <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 12:12:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
Message-ID: <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 11:23, David Laight <David.Laight@aculab.com> wrote:
>
> Since 99% will be 1,0 maybe saving the extra expansion is best anyway.
> So have is_const_zero(x) and add if_const_zero(x, if_z, if_nz) later.

Ok. So something like this seems to give us the relevant cases:

  #define __is_const_zero(x) \
        _Generic(0?(void *)(long)(x):(char *)0, char *:1, void *:0)

  #define is_const_zero(x) __is_const_zero(!!(x))
  #define is_const_true(x) __is_const_zero(!(x))
  #define is_const(x) __is_const_zero(0*!(x))

and should work with all scalar expressions that I can think of (ok,
technically 'void' is a scalar type and it obviously won't work with
that). And should work in all contexts.

It does want a comment (in addition to the comment about how NULL is
special for the ternary op that makes it work): the '(long)' cast is
so that there are no warnings for casting to 'void *' when it's *not*
a constant zero expression, and the '!' pattern is to turn pointers
and huge constants into 'int' without loss of information and without
warnings.

Compound types obviously will generate a warning. As they should.

The above looks reasonable to me, but I didn't actually test any of it
in the actual kernel build.

             Linus
