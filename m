Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87571F37C1
	for <linux-sparse@vger.kernel.org>; Wed,  8 Jan 2025 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359869; cv=none; b=kUuXd7bY9SGxRyuTE09sMqrJGmHJs8nFJtraELJiTXlkEYIKDSd0JvoUA9M0ux0a41vbOx7AnUYNjXhRJc//3BwI3X2IY/j5rSWwBERGDKzFl88GPXnj7t3hK0vAIipUebp175A7iskv6pSIQ9zbopmomdfkmxnVC+sEn3a7sRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359869; c=relaxed/simple;
	bh=yRlykbKSn5jYsW8wxQz5WQX3Mpwcq2FfRltURMyGjwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbIZif3r8uccQD3TDbp+p6Qf3p/pJJciTSRyc5kr0sF6abAyXWgABhmzsHfdkjxVsfws5lSijdJK4zqbCvum+pK3xe0qL3drA6yU4UxlL0Gu6emByRcrLIglgHUS4wPsRTiLR/eE22oOB04+HVEiz0i5zRsLupz5fvPps6iUCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gndXhtlZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gndXhtlZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso23711766b.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jan 2025 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736359866; x=1736964666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4L1kpXD4CvIKxF3DPmBbxJe2C0jfudiA06dORui5cI=;
        b=gndXhtlZegR0I9OVouy7athat+bGF3qv+HfIEbE2iNgvMZrfMOWtc/7fuziiSD8/3u
         RaNI9iyhwouHGymQXn+i3W6CyHbC9V+BYy4v5ipaSj141dOxNZDiWxQKMmBRetD+eKvu
         gjzNwXEAUuVu3jBURfPOo9WYwijbcdBD1yTrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359866; x=1736964666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4L1kpXD4CvIKxF3DPmBbxJe2C0jfudiA06dORui5cI=;
        b=w8cPax3Db/lipW08FWfpl2r9RZutrm4FpYiACPI0q54QCSp2NpdQS9+TGsTNAVPHsZ
         H6J+1GtKGOLf0W+4BHefcnWTQqku4N+Q0cdlxleA6kdFOMDxz/nt+46nwQeE2wDh5rdP
         mBq6UuL1DUL6cH0Oo0ILjqXTSBC6fLqvZrAhWx4+k1CBizmhZv0G/nK+lXgC2+jVG1QU
         XY+/08nSs//H/773BdCo6V9lh2W523UgCMd4FPINkcNb6meP4Yu58ozgYxCU8rU/1hqf
         y0eGeELKKzLb7vt1fYcqzSrJWauOxa6plXtlGQY9QYEi9YHbzyGNLMzTMvHMq2WK78uP
         gUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpXR6uIR/pvHiYZ5nsRxMgHEnNBulBdGHM/C5SFCMcJIK7mx1HmdHL9vkcy3lTosLQ9scEfeFyMZw0To=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYavUT5AHXAVNU5AmVgRTsXbcaEdHHzs41+aoave95UyRglXp
	1e8vZgBxRX/N6KbMuiA3jrXsYrGjDjI1S1NS0QOyUFLO77P1/94H6OsjjNXJKJO0z7W+XXf/2Q7
	3c/S9lQ==
X-Gm-Gg: ASbGncu+hCGoZmAmjdhbt7FynNoXHDrTJGvOipuXsK9D3AXh+92qmdWbHZ2hEUEIR8q
	NpEzpaevRluoyoxKZXQP0uDy4f+h1XR3G8iL78kmaz7M2Sv+nyo1QegW/PbZ3dwzQmKrewsEoNB
	s3H/o0Uyh9G0OPDd/OymGBUw8LIkqrEa9pLfKJoOm/jxLSxlcrxpreXC07s+ZYTsC28fn9O6tAR
	hSN7As4s75g74sb6p6QV7ePFe0FkfElWI+3UAIpOBaZKMQh9u0AZQFArpCt5ph1N3ZZVmlNZPKr
	QyCqK0/xvTxVCBr2HCC6la7rxJoJNTU=
X-Google-Smtp-Source: AGHT+IFS5EQSFTEYxv0+xVi3206fLMTRaYtHWb/wcO1AH/4vXPwYI3WZv8Grbz9A8xVsbJwERVM/ow==
X-Received: by 2002:a17:907:97ce:b0:aac:2128:c89e with SMTP id a640c23a62f3a-ab2abdc0a39mr363598166b.43.1736359865944;
        Wed, 08 Jan 2025 10:11:05 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae71desm2500876366b.89.2025.01.08.10.11.05
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 10:11:05 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so21549266b.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jan 2025 10:11:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWL0Mc9TVko/gSU/mRotYmdY/3ywShftv85nTuMsB7PZViBBC0MsrHp39losT5Od3IdHhPVVJcD118AMI=@vger.kernel.org
X-Received: by 2002:a17:907:1c93:b0:aae:8692:902b with SMTP id
 a640c23a62f3a-ab2ab748eeamr327286666b.31.1736359864937; Wed, 08 Jan 2025
 10:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501030516.uZrwnuQQ-lkp@intel.com> <CAMuHMdW-DYPp_2nAaBdvgoa6Yr9et2cNS_260H-9H_CT4yEasw@mail.gmail.com>
 <CAHk-=wj4tYCytRshQGkWSNmZS=59PtKEUpG7f4Sy_46n+WYtXw@mail.gmail.com> <CAMuHMdVLQ2z=U1YJ18GsnJcej2mwGg02GVtKQLQKr0yNtA-7Hg@mail.gmail.com>
In-Reply-To: <CAMuHMdVLQ2z=U1YJ18GsnJcej2mwGg02GVtKQLQKr0yNtA-7Hg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Jan 2025 10:10:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmhoFfty4GoAnN6u1K2EsjhWkoS767fa-+Lsf1Ya6A+w@mail.gmail.com>
X-Gm-Features: AbW1kvaDHAgFTamUSR1ieUMfa_7UpkwDHNwGJjelV-I2cxYJy3aNc-RISQlIhjU
Message-ID: <CAHk-=whmhoFfty4GoAnN6u1K2EsjhWkoS767fa-+Lsf1Ya6A+w@mail.gmail.com>
Subject: Re: [geert-m68k:master 2/2] lib/muldi3.c:53:28: sparse: sparse: asm
 output is not an lvalue
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kernel test robot <lkp@intel.com>, Greg Ungerer <gerg@linux-m68k.org>, oe-kbuild-all@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 06:19, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> That leaves us with the "not addressable" sparse error.

Hmm. That one is actually a sparse mis-feature.

Sparse sees that

          "dmi" ((USItype)(v))

input, and the 'm' makes it go "it's a memory location" and that makes
sparse go "it must be addressable".

But for asm inputs, it just means that the compiler should *put* the
thing in memory to be an input.

And this is hidden on x86, because sparse recognizes "r" for register,
and says "if it can be either a register or memory, I don't require
memory". So there's various x86 inline asm that does something like

        "rm" (0)

and sparse won't complain about the zero not being addressable.

But in your case, just making the inputs lvalues will fix the sparse
problem, so I guess that's the right thing to do. I sadly don't see
sparse being fixed because we don't have a maintainer..

                 Linus
