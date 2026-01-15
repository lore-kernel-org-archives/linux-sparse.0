Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBE272813
	for <linux-sparse@vger.kernel.org>; Thu, 15 Jan 2026 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518254; cv=none; b=cs+scaD6x8r8zCl1IbLl/PDc1WyXantdce/jIB4simBoIkMOR9hNS8lqZXfkA3lqW9likSO2scvilA+8VckuRuizKJgBBrPHZRE38HCZO2MybNfivcjeZ12vGTWDd04mU0eUsiHMl3JWlCU2ytNjl7UOvVazGVo/ROh3yWmdmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518254; c=relaxed/simple;
	bh=UKeLioYzPnHlRtnVkz73uBvJRRuLfWkSqJS2LiyPy80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEFtmHl58GW41d5laEEIxVYxXNOTfRAf/ylpZEi7Nmvx+8ecrOWbd9W0PjOLaeDBRFO7SdbAgEN/qGWdUxLcVNILYjqxUewbTiFDDpBKdsX1lFs2yr4SJBPo6OFXHqfPtU7QWv6qQYgf/iEETKtd1cB49cs/afgykKISsYJ8i3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VgJ55p7X; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VgJ55p7X"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8712507269so226775566b.3
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jan 2026 15:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768518250; x=1769123050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YCM4bPzGgqlPRnwheHJYnfrDP545iFoeNWZUdd6VUGM=;
        b=VgJ55p7X0B3nA7p5wc24KZfZtu/jtHT4Q1AV6Y58k+T79HxaXeXB5rfZ+e4G4Ys/4J
         fhmntXF6WbX/kDI0T9p19DKeSvW5pHowSdhx9/Lt/vXSBtJrZ+kyDXVU9Fmg1qaph0Cy
         lETc4bggOjyIMXZ2LwHq8C/1YkAerLbtZPBoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768518250; x=1769123050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCM4bPzGgqlPRnwheHJYnfrDP545iFoeNWZUdd6VUGM=;
        b=YCxB4n373XgcR8+sVLAq0nBcARkcPACm+muSEJ2XON7fRFVrSmDj7zvHfDwOiPp5PP
         1rzpBY+MhYfCFteFSBBk0lKP/syS0uUy/A9pFcG43uvdRRAzTmQOBPhKLKkJNN14fA87
         moltSl/zpR38Fw/IJ0m4Rm1axqQszXUN64RbIVKy1ja5HPE85F8gN9Vybv0XD4+6UEG8
         SX1YfZ+ogz9l8ZvT8O7AcQn0994Yj0CtaJWuuaR+GHnIdhsbJFitdxYiRWXH4ZKMfAxC
         Tb/dSyh2c9ODPJ7NmCw53x1N0D3kTZxkjO1DkR46uXzhHULWRMlgKNIjF23Ak27BR2uH
         KkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIbgCFIMXGaLR/KOyZYHB29lvE3ffMRyBReZDYBxqZSNgqcHsFOU0vaf5IU1wEHBo0J3s1UCGehQW2yBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeMQKgyomS54H/gaiu1Gerd8L4lLTYGYm4qivHExewsdPh4FI
	bEtN7xtN0JoGVdRWT1S03MS8i5NDvD4f/Aevyh6yAY0Uoe22DPJ1mvH4iO59t/7Wt9snj2prCgA
	QAJtbaZM=
X-Gm-Gg: AY/fxX68twdwSaQ/WHIoKCpU8NmBqfVLEm1PC6eeSXlHIRpCoJcBu4d0zwyEODjJeSY
	G+9wCgS0Q2qQTffR6Ev+M6jBSNcOKzoQO8CIB8/dbYFxp88ESOvr7tYkOHgt+J8I7aR7DYJT95d
	gaM7583fz3UJSWrhzslqtw9I5DxBlqG1kUm33stLcttAlYsGNznt6k6xdTRw5vlv5g4fWx9gBo2
	gsKdjaZ1y4u/WZ/IxJIZlKEMjo9HDCkAX/OoDnsViBTtXIhApfuuwlk2OuUBuSaKCWiQALCyI8g
	9WsNAsRDtsxzq9Yjlv5S/vYcwPrC8qCUJMcZZs+CjK2o+lRYCjBxqIofhc6/5nsoDph/TLADs7j
	fu9vcNWpYeccrQowepT6a7go0fIJK5Nbf6XoqLACWe5rsp33z7+wqG/5DOZ755rxe+ou2usoZ+N
	Hu03OlVQtm7DyQxjtZhPV25+tUuDhPTa2/TEO5G6D6D9rK5Mzr75EFhZ+GoaI3
X-Received: by 2002:a17:907:a893:b0:b80:3fff:3369 with SMTP id a640c23a62f3a-b8792feb1c9mr115304666b.48.1768518250564;
        Thu, 15 Jan 2026 15:04:10 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795168b9bsm63546666b.16.2026.01.15.15.04.09
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 15:04:10 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8712507269so226773166b.3
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jan 2026 15:04:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCPsAp4sDqsaZVVl51gcuEaosjEAGLRSkks9AM4UImlBaU44PMVeCiWTfVAfSFHzi3kONSdIJ1c781XAc=@vger.kernel.org
X-Received: by 2002:a17:907:3cc6:b0:b7a:1bde:1222 with SMTP id
 a640c23a62f3a-b879302925fmr112454066b.63.1768518249777; Thu, 15 Jan 2026
 15:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202601150001.sKSN644a-lkp@intel.com> <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net> <CAHk-=wg9pxiKm3kcZ0XQrFvz6fFek_A1WGqRh9yeghx3pE2d3w@mail.gmail.com>
 <20260115213054.GF831050@noisy.programming.kicks-ass.net>
In-Reply-To: <20260115213054.GF831050@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Jan 2026 15:03:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXxY4NTZW8rcrXqx3h=j+t2445VWccbpywXYdoL_V0qA@mail.gmail.com>
X-Gm-Features: AZwV_Qgb2cPmulKcG-0SmsL8XUnWkV4E_WXCc_ECD2IgNdR3k5Eh2cWxxhGFxQ8
Message-ID: <CAHk-=wgXxY4NTZW8rcrXqx3h=j+t2445VWccbpywXYdoL_V0qA@mail.gmail.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	sparse@chrisli.org, linux-sparse@vger.kernel.org, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 13:31, Peter Zijlstra <peterz@infradead.org> wrote:
>
> GCC-14 :-/ The GCC-8.4 one was the function return value trick.

Right you are. And yeah, us moving on to gcc-14 as a minimum version
is not imminent.

Still, while we can't force it, lots of distros are on gcc-15, so
while we'd have the _Generic() macro as a fallback for older versions,
at least most developers would hopefully get the nice clean modern
__typeof_unqual__ thing...

           Linus
