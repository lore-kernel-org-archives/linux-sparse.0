Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7A327C0F
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864563; cv=none; b=pgHEDwHc6LEZeE+XjLAb0yOYQLJxHK2caqluRtTdwhYCkPI66v9rwm+Ih5EDO6WSKvCqsUjh7pSNVIBK54pjEkSbF0LxDDrSNkdhuF2PofSz9wZ20XYz7oBwat0A0OQ3KFr1c2rz2/vSPK8k4MrdVGFAvHpFGQCV6QNJSceOlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864563; c=relaxed/simple;
	bh=BtlS6wSJg8IGw0gr6BRaw4xGKS3144GeHLLdeKwBEpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1n7dNcSNmufND9PBc2cvJNF895OBgFvPAwu+tptNz5PVc9ShNgdF7NbrB8pDh8ZyUBSG5ObPUhDGVmtTDKydARqAqvHYhUlnK5sE9g68mTWZwsJI3PFiayxpcXkguVDWETIw4iF+bjEOuEIgsGFXfDC70eaS9HEX7LLieb+ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VUW9Bsab; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VUW9Bsab"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c0d2f5fe1so7670980a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771864557; x=1772469357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCBKtilMWzwgoFtIpXr40hgkF2eGpPVWprNj6Jcon5Y=;
        b=VUW9Bsab93HOpb+9tpHSCX8C+lmyx5wJawDKXxYOqKgZIhL/dLQgvXqDCocoFZahD/
         MBNgNItzxLpSurFFqF3FjWBbrGOsTQRQvy9UYss3Xc+qza58dZau/bGnnhPxmpXhNhIv
         uFO6nV+efsxPVXzC2UStjGLxAAOSMtYmdUKgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864557; x=1772469357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCBKtilMWzwgoFtIpXr40hgkF2eGpPVWprNj6Jcon5Y=;
        b=aazGt5XVT1HAaGVEU0gSWvplNQ2BvEfMLyW+0MiYJCmOHffJtF1MArglvyBDfCbX2u
         4elLmiyRMbXRgDwwnC4zu3Ak8S2+0kejl/KpIkxo/1IHqRACwsw3gnDNynJYt1FBzkNh
         G6iWSPC1C28rgHoy1Jhum+nBsB7NzHqzKF3jFBNoIUOQ6brlXAzZlnVe2VPOnTA+sAuD
         rC2RNZ72EhvWAfhcAFTiBBSauQGGxBTUE9gM2vuMqoLqAzlrzYAaN8vJz8sUW5z0oGT/
         19p+BO2jsbSq5+j7tSXGrnaXc/eYvXixbfqBrwUmDxR2SXHm/EigDFfeOR/i9ucPJB2k
         OTTw==
X-Gm-Message-State: AOJu0YxkAO+ORO8GzoQpMTSWK0riV7xTKWQH2EMp210CjSG927PU44Lm
	x2Q8KRUv+Zp06xfO2jDiZcCckn8ptjltzDLZUE/1pa4xAGyNqWKJThAsCKKA8bwsqWNT7VW9ETd
	k6hWAdB0=
X-Gm-Gg: ATEYQzw8x+5OBEX7QezaW8dk2C7VOHddlQ5SKzWmuuiICHKeqOAwV8biwbmOMGj7823
	tPdCuI19D0rjcvVYQ/RIfE/b5vx7pa0GLEkHI1Pj+0RmgMm76z4p04/vRPZU8Tpd2zm5SFmQFs2
	MobkJYyjpnXfWRX82RwqYOZBtV+jL3FF9l7uVdCfDCuJ3QjeAGwGQyMIAD0Wg/nV/BNOCwOdlnT
	IS2eWY6sgtVcdJVaxwd6PafLTcjdz6mp3ME8HuWlYM75wvPSmBVrU8NXrbn7ttaPZ8WlG/JiNkS
	r2a4MrC9j6I5vd/9/c3K+KgWhkNT9FgefUVV/eX5aj8QPMYPv4/Jsy48ofX7WV97Pxj7juDP0lQ
	xlfRkuM6457+H892TIDTt5EBLYTb3gJ/BnphFVlWq3TpUrwbBI8wibDzVr1LUCBW4l8aihU5aRm
	2+zLKQkn74kpcZmWTN2DJ3oYOTlBr2u19vGVN+VCPpIrqWlx4B7HEJcMgbE3wOhpYZJWnxNF2S
X-Received: by 2002:a05:6402:3547:b0:65c:2af1:b7e1 with SMTP id 4fb4d7f45d1cf-65ea4f042d2mr5049846a12.25.1771864557488;
        Mon, 23 Feb 2026 08:35:57 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9aabb2sm2737139a12.8.2026.02.23.08.35.57
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:35:57 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b883c8dfb00so786740866b.1
        for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 08:35:57 -0800 (PST)
X-Received: by 2002:a17:907:3e05:b0:b8e:a1ad:36d3 with SMTP id
 a640c23a62f3a-b9081ba1f08mr678841666b.46.1771864556806; Mon, 23 Feb 2026
 08:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiDSCuKGUNdT4f9tOuohe2wZeP4MmooJAJn2Q=oyAWL4v9Lng@mail.gmail.com>
 <CAHk-=wgxgo8SugrnA4s=Pz0TPj32Ea0pdO=uU_N+-V6Y826spg@mail.gmail.com>
In-Reply-To: <CAHk-=wgxgo8SugrnA4s=Pz0TPj32Ea0pdO=uU_N+-V6Y826spg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Feb 2026 08:35:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTb01surrXakL7rgyoELuPDkqvTdh_ttNrr5rtirwopQ@mail.gmail.com>
X-Gm-Features: AaiRm53U158VqH1KYUlZvVgGiWsIaVJhPRdR77gAEdYddBNhIkTIZbBDCXeZcOM
Message-ID: <CAHk-=whTb01surrXakL7rgyoELuPDkqvTdh_ttNrr5rtirwopQ@mail.gmail.com>
Subject: Re: Sparse not supporting kzalloc_obj() and friends
To: Ricardo Ribalda <ribalda@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Chris Li <chriscli@google.com>, 
	Hans Verkuil <hverkuil@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 08:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Argh. The culprit is the use of __VA_OPT__, which apparently sparse
> never got taught.
>    [...]
> Ho humm. I guess I should look at the sparse pre-processor code,
> unless somebody already implemented __VA_OPT__ somewhere?

Actually, it looks like Al at least *looked* at doing __VA_OPT__ back
at the end of last year. In fact, just a couple of months ago I said
"I'm not sure it buys us much", but that was when I thought it was
just a standard versions of the gcc ## thing, and before I realized
how much more convenient it actually is to use.

Al? You know the pre-process.c file a *lot* better than I do, even
ignoring the fact that it's been fifteen years since I touched it. And
you presumably already had some thoughts on doing __VA_OPT__?

That said, I can also just make default_gfp() use ## after all. I
_had_ grepped for __VA_OPT__ in the kernel and decided "we already use
it", but clearly it's causing some issues.

So instead of <linux/gfp.h> doing

  #define __default_gfp(a,...) a
  #define default_gfp(...) __default_gfp(__VA_ARGS__ __VA_OPT__(,) GFP_KERNEL)

which I think is fairly straightforward and the "natural" way to do
things, the kernel can just do

  #define __default_gfp(a,b,...) b
  #define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)

instead, with a dummy empty argument to make the gcc ## trick work.
It's smaller and denser, so it's actually superior in that sense, even
if it feels a bit less natural than the __VA_OPT__ model.

Ricardo, can you verify that that trick works for you?

Al, comments?

             Linus
