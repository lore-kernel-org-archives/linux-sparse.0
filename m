Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E22DF13B
	for <linux-sparse@vger.kernel.org>; Fri,  2 Jan 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351885; cv=none; b=USdU9fs0Skz3Zwekdrs9FsfpYOxrkIOwbn7BaO7eQv4o1yZDV6klOkPm3z2zhqsI3KX9H2ejTRfOgABRGcgONVF8tsSnkiKJRIuYwojh+LVGYqdU9IoUTr90EyTtM71QffqoIwhsDIoJFQfti+EJf3mYa564+63ur1qOJwX60C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351885; c=relaxed/simple;
	bh=wSApN7eIEmxe+ZlkFun1Wolx+BI8xxAaYv9APOnMXbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpyAz8k3ufIGIZ2WpN8+mvMMBFGlSjY5pHVWh/jEajpAyw2qpt4jqu2wdCa9h2EgkKVEJjnSFCDmBT0FX+tFG/+D4D0cU9V0vFJWgX+tYIIi0XCEBZNGkujYbV2ApVJdOIZON63A5gRu4cxIoT4V3ptOLNtgt5VDa6VgcrGhmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipCfHJYf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipCfHJYf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a097cc08d5so31194045ad.0
        for <linux-sparse@vger.kernel.org>; Fri, 02 Jan 2026 03:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767351882; x=1767956682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIDs7EpZgwjKHQTJkjqicwJWn0vuoECrubEqmgA+6vU=;
        b=ipCfHJYf8oQoFqMJ+NDl0a9F86WRdEFeyHHJECOrCJTgF9zJ/8gSfv2wupCMMIxJfj
         eku/SNf83ymrhL/SQUYtzhPbgVk4ruSA1LYT9k/bKsYW9SrdCKgZevYG4Cg9TNfQwqoS
         caWuMb+pHVQgf1AW/BKGS9coLPWn9/MleoZ1hUJ6cuzG1lK59asRwBtVKq9C43ayEBWR
         qdj7iEyYMLFOU/K0uf6CjK8jVAxXEukfQluV/1sjZCjrJvwffOAohbgoIDdSsiOO13MX
         Ie2peETA/AJYICK2qlJpeNUpGfgbkOJ95hXdXg9xP1mWPAXH/MUYeYL6CVBcOSxhjMgz
         2WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767351882; x=1767956682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIDs7EpZgwjKHQTJkjqicwJWn0vuoECrubEqmgA+6vU=;
        b=CFonSyGbyAFKI8bTsESoLVr7/eVaZyuTerQtZLA+nW/HJxV4rncxVqHvLDVa3j5AJw
         ONEj5VUTcOmGjD/7iq9t6L4Mkq6N1xFAnVflNZ4MXUH2ukjSCTD7R+cdLRjzyv8f9gkD
         9OB2nr5G02u/ic9qqJ8V5FxAOZIC2dUhqHFo5owPiRgwucDaPrAIcGTGm4VPXdh+RKTc
         62dNijZ/HRTF9wAI0TiVUb2YAz1Vsm+LMtDsko6oxU9AR7fNg1ENlsBLEr7+kRtktMW2
         9+/tt8TBke7BUMKUHGVbNCNMC/ITZXCniFZX/O2OfIE+9KQCcluimfQWyn++tE4LxLEy
         xbCw==
X-Forwarded-Encrypted: i=1; AJvYcCX6F032uikDUGCl+bc040eZz+qqNSemo+YYwobcD1MKQUeVq76MBNmB+MIcwqSYZ1XgWvE97FrVc1nM1Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqdypbY44OyxpWde09BdtB11o94G4ekMlS30jJN9L5qq22zPiL
	l6050T5DpZ/NM7T+RedCl9F7BuG4Xo0UFjF6WnrgjqMPKnWVmdym4pjwhJzl+13imVKxWSklB65
	+7fEzMDmQHn8SPMKoqPE2EyaN0mqnRcv5OCoB
X-Gm-Gg: AY/fxX7RbytRZIuXXWdo5rsyiWTjX/YqJ3cCJLjGW0nJt/eYHjU/ahCiMyCtiKFWwAz
	IPV6/1TBUPwJNuPFtYHQWxcKWgHXVwgJZ6Hf9V5nMZflSC16W6AS5zbSxBNua1GG/Lm3KwSG7FS
	X4l6Vhtj2tSumk3lGwjYIzxoyp5ljF/s2FZAYHsLjwaue6D7+N3asnioHQxiGYzB0sZMDqe18kS
	JhZgh9RH7I9rJ+uJ2kgHPFYZ2Y/UaAhDHVguKCNzA6p9+xP1qsnXQ7Ong4oB63xabblqvtPIdDZ
	YTrZgHkpK3jg3QmiSxcpmN1wWlwYPV/Ffk5yu4ieL3S1N6GDVwv/PT85BmeaNvnxX/JmSskxMgX
	dFZkOLY0TEsGm
X-Google-Smtp-Source: AGHT+IEZHP2Tt0L93hKtfLRSYNZV76m0YyhGtrMg6HK8YOKF7WDdzMO7LFlzqH2gnVcYBfD5MuH9A9W3GVedPNVkD/I=
X-Received: by 2002:a05:7301:1509:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2b05ea19892mr15172023eec.0.1767351882060; Fri, 02 Jan 2026
 03:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org> <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
In-Reply-To: <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Jan 2026 12:04:28 +0100
X-Gm-Features: AQt7F2rb7qQrF04KAinb0u8Ra4qw05S31gwaEul2jMZEj1pMA4QwOapz60W1DHs
Message-ID: <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and is_negative()
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 9:13=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> w=
rote:
>
> thanks!  I think it's a bit sad to keep code only to make some checker
> tooling happy, but for now it seems to be the right thing to do.

Perhaps a patch to add a comment explaining Vincent's findings would
be a good outcome, i.e. explaining the reason it needs to remain in
place for the moment (even a link to lore.kernel.org to this thread
would help).

Cheers,
Miguel
