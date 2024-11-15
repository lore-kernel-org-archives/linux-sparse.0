Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D462022DA
	for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707913; cv=none; b=d7A9FNDOK5E9bvm++mcZEWkZ6d4Oam037JWphviUJgPaLgpvCe7qlWWh0dzrhXJCdGJzAkSAwyUyfmVs4gSkaNzRWP3v6i0F/Cr9rY5+FBn9VoUoyYxjYWXLoHEXF59wZcZJunQtIkgFbyqc1o0u3BU9tWvLBd/37Z7m47vgcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707913; c=relaxed/simple;
	bh=g4WTLpGaO43c1cY/RMUGBtFzSuXgKas7YywAQYBkRWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTXKJ9VCSzFxTNB1o19Z/Y4WOPwor0CqWDu72R/s3IerbAeU/8qOgL+BW/P1OMy7jGKzHTde48Plzt58rsRM3fuizGfYeo46kGYzgXbBYMmHTBI3Pt8qZBMKPixjVL3Z9Rw0AZ9NApCRE5nJmA/V7P36M7QPR3k5sGQCYf3kDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R4AoMegB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R4AoMegB"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso31791a12.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 13:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731707909; x=1732312709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wYVDpD8Nh4uJBmCvYiP2LN/4+G5l094gMFhZFvM168=;
        b=R4AoMegB6KLw/hNgmipXMYrVf0lRmVLYFL0cwPRZI9yVkp4CBWLkqs9A6yyTxBHK5j
         H2cAn773rLhfKiYOPe8YlzFhV6ZFfH0zTpenhQEKcBtr2Qr/Ng4A0nEF+Mv5wVCVOIRl
         afuhTRnCN7w7JNkbRotJyDCBLNWXL+FRQhTQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707909; x=1732312709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wYVDpD8Nh4uJBmCvYiP2LN/4+G5l094gMFhZFvM168=;
        b=teTctmw8nLp4zAOQq1eA+4TttJvPuZOsSa02h+jvtX3ugb6O/DcSEn7Hui0URYyh+9
         uc9hbHOHWcmmnJYHBCptqkXu5bSxL3iBhP6+++GSk7reSzkk6CxihGcfISw7ETEFL79/
         3QgnKgVd+yXY4+48JyX6/DulptakebHoyo7UZp239Pposlzr5inzv2VACeEQ8oI5vFZn
         ot8Bw3LWIwtoINfcuPsDD5QPpIJUPrCgNgYqYl/du6YKiJAYUd89OdNX0DeC6ZnTBK5F
         c+gUuQi8mbSs/hIynDYIyRA5N8yZoQjKHh9gpJhelEG7aDH2Q3FM+dH6zIrc9osURA9G
         QH8w==
X-Forwarded-Encrypted: i=1; AJvYcCUx3peSaYKZYPK3BiwwAck1ag9dl+KhUemLDqHdAuG1PT1sJz/l9qgBshGOkJh+Y7ERbNLM5NR4BdWr4MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzkJC1vBTltlA8pc8+xBIUQHwqTseM7qbWjztti6dx6WLzjfC
	qchHwmGABfpPHpXY5QCXD2698xXoGUv77qAxeR8He1YpaXaHDTU7bM1KNF4KvjpkU79N76gH1jY
	6yNM=
X-Google-Smtp-Source: AGHT+IHTjKG6WOxUaGLMQgweAawEIkVlwbR0yX59vY+w6nPmhMP/90IaFbioOo/hDam1FlB0fEVPcw==
X-Received: by 2002:a17:907:1b2a:b0:a9e:c947:9855 with SMTP id a640c23a62f3a-aa483528658mr418570566b.48.1731707908938;
        Fri, 15 Nov 2024 13:58:28 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5696fsm219220166b.77.2024.11.15.13.58.27
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 13:58:28 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf8593ca4bso39126a12.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 13:58:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxuiFhS7z9qpXSgaWFZw1MvK9vlQPTh6RDuLYqO/oVcX2Nz//s/cZBscgTsj7k3Eoz0T+q+TGPTV69ACE=@vger.kernel.org
X-Received: by 2002:a17:907:9344:b0:a9e:8612:f201 with SMTP id
 a640c23a62f3a-aa483555dd8mr383253266b.59.1731707907350; Fri, 15 Nov 2024
 13:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
 <20241115204602.249590-1-philipp.reisner@linbit.com> <202411151247.280F316C83@keescook>
In-Reply-To: <202411151247.280F316C83@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Nov 2024 13:58:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3vaB7kaU9q3+0jEtBDWMbT9EhRnJ+sPdxL9v0vdwSjA@mail.gmail.com>
Message-ID: <CAHk-=wh3vaB7kaU9q3+0jEtBDWMbT9EhRnJ+sPdxL9v0vdwSjA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
To: Kees Cook <kees@kernel.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 12:48, Kees Cook <kees@kernel.org> wrote:
>
> Linus, do you want a PR for this, or will you apply it directly?

Well, I'm certainly not applying it this late for 6.12 - who knows
what compiler issues it can trigger - and for the merge window I will
have forgotten it.

So put it in your tree and have it go through linux-next to see that
it's ok. It *looks* fine to me, but...

            Linus
