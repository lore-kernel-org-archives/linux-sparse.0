Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F251E633C
	for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090069; cv=none; b=VQs4f3R+OviyYR7lw6D4THG3DSLvlywN4lX0BnqUZgJiq7H++GEDqPU7GclCZhz3nLcFCmwG8RP1Pp2gWvn24cjwJGJucRWxEte/sWABSivrsY7Wk/c1qR+jRKluz/NBHSr+K04m2YrX9Lsh0S2OsRyPRNcs4iHDl0bnogZxUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090069; c=relaxed/simple;
	bh=+RowUUrYtzXa4i9REDNRtB7NHjBBJv9ASqbqnaOrOgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY6obUzlG1OjX3Il9zag6Gk2XPINRYVLnZqp0rvAv3zLsSauTL7HWQ78Qu/T8JJhmE1wi7GibX46hkF1DAcQzVlm5HHvLgYM2ZUc4hLguJOC5hhiA7kbgTmJB6Hzzm0QmIDEpdFWSo7MNRnVCIE+5oM3BN6qXhRvHDuiGDbruoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CgyZHU05; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CgyZHU05"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6496a8dc5a7so1382875a12.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 12:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1766090065; x=1766694865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AFdyme3OdkfY6SG6LYuzpXFnNfm347qWal7RaQqaQwE=;
        b=CgyZHU05l25N27acnHZtfkZVBEvKvS/fVJf4q4x9DRMcLn13Mhsfl596PTBiNmykcj
         abxOev4kCvY76mEtdU4SIiwkCbm/2cus42Y9W8KyUiSYpIMAf4uMjYnSqlhO4metoDF+
         x7IcMWpxgZVj5IGwd4PnfqExgZUeBaIo9pk1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766090065; x=1766694865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFdyme3OdkfY6SG6LYuzpXFnNfm347qWal7RaQqaQwE=;
        b=hapfcXmRjxHUysKVGtMA6YlQY3h9FM/HRdBk0AhhRT0j5QxVByehbUv7jxW9g2H5GE
         k5f8HL6lPFHA2hFh9lFA4j344RseQIpeHX+B/HSD8xAVTHmJJJ2ws2gJTen9Z57xMIEX
         1VP7Zq+aItbGek6+CBcN/YBkUZwxlgwECzQmh05YvtVTwC4UYf+Hjm5rRMftCiFJh9+c
         ggwY4nLFIX7A+TWZxPfDvfiphURYqtH4G1Cla+pa4zlkmuM1CPprTYrD4WjLN1FUe8UE
         UHJAGWOSuEwNv40CWUu5pkvj0zr+bCvB2SyjzCeLXEVRlmvWQA5NBK7Zr2j91pO2sE4B
         /RLA==
X-Forwarded-Encrypted: i=1; AJvYcCV+8GKE+xdnyUvxk86cB2X9OJhJLooxxGXyEzNTQaapusBA3rM6G8JjUwEAkr9x05iMB/yVp4LDd6j+XLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMv2Xlit71syIe1pG6A/iWIuk++N9JlDJnzTmSkqgbKWpUZk/8
	8+utHsW9DQXVRXeXSw1Gla1hDANpkYmL7lRBYlpnrsZ8fbkGZAJgVk6Lug+ZOSgV9DKjskoYLko
	qXheAvhU7YQ==
X-Gm-Gg: AY/fxX4eBeSvuhMyX1Egi07o7o/arMLufknYsobaByIx0P3VVICiec5f+A3mcRaelgM
	N2HC9HCNRTIDk5INuo1v5Gutw7pn9mBFs1Pej1YjFiiUDbzIHk0mcEQRFE0iwckXD2h9e13XIMp
	26yvWECQN9beip6dnti5MROY4mmbIbJBcURTB4f4M5sgevGWMadJA6Mbf9U0V8Bxg/0Fxl95toJ
	tKLWVhwiQ1nMHZP0r3phsPfj465D1VkNFBdId6ReqopGkDjWPZTbH0uUoHfBKGSif1bGM+mhAnK
	wjsZub5Dac1lbob/nRhXKU7iQ7ls6/CbbTq/BlyFhpbrEKJ5i1zPLYWVkV9DBADRZN2S/ankLu6
	AwGXvWQHqzUBwIxIW/kIgTPFadb4nBibN5ZNn9YbS1SP2bhJtRlO/GpXzVF9QgzD0iuiaJTs2Tk
	61ZS7eFDTAMYH/wSbesUFYD+AIzOn5MeX4ee5mMpYuMw63DKlCidq4IsoN9+Ug
X-Google-Smtp-Source: AGHT+IFMUZ0lhYW6Rt+109g89lMftlSydHwHmld8gPibusYHIzH8s7rq8w6hKHMapToxH2OFYBtXxQ==
X-Received: by 2002:a05:6402:1ec8:b0:647:532f:8efc with SMTP id 4fb4d7f45d1cf-64b8ec8f844mr669347a12.33.1766090065526;
        Thu, 18 Dec 2025 12:34:25 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a4eesm322297a12.24.2025.12.18.12.34.22
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 12:34:25 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6496a8dc5a7so1382795a12.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 12:34:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAYGVmOYMf+iBqdVEHI5ueOH1fwWXGSWsa1UEuDbH4IclQ2ZgPDMrUpWuNxM7auzSnZ8FHe+NeTqpmYlU=@vger.kernel.org
X-Received: by 2002:a05:6402:1ec8:b0:647:532f:8efc with SMTP id
 4fb4d7f45d1cf-64b8ec8f844mr669213a12.33.1766090062459; Thu, 18 Dec 2025
 12:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org> <20251218202644.0bd24aa8@pumpkin>
In-Reply-To: <20251218202644.0bd24aa8@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Dec 2025 08:34:05 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
X-Gm-Features: AQt7F2qOKBa-zo7QJgMQveUGo5xuaKkhNSphimTCrBEi3RG5l67qg5BeTDIQqhM
Message-ID: <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
To: David Laight <david.laight.linux@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-kbuild@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 08:26, David Laight <david.laight.linux@gmail.com> wrote:
>
> One possibility is to conditionally add _Pragma()

No. That compiler warning is pure and utter garbage. I have pointed it
out fopr *years*, and compiler people don't get it.

So that warning just needs to die. It's shit. It's wrong.

The sparse patch points out that this *can* be done correctly if you a
compiler person doesn't have their head up their arse.

(And no, I'm not claiming the sparse patch is perfect. I'm only
claiming the sparse patch is _much_ better. Bit tt could be better
still, and there could be other valid cases that could be warned for).

The "warn on type limits" is idiotic. It expects programmers to have
to always track what the exact type limits are, instead of just
writing safe and obvious code, and it warns about *good* code and.

It's exactly the *wrong* kind of thing to warn about.

               Linus
