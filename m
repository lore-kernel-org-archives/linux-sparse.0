Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001E41744
	for <linux-sparse@vger.kernel.org>; Sat,  2 Mar 2024 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709419776; cv=none; b=pMXc6QMVK9oj3h7mEBRtJNqjVUuTGLwZcvUjY2/OYLj2poEpTvtRnNrRH0bY8O2TI3Ocv3dOvekhSFXRCUVoVBvBKWJfGUyxA/2y2+PVuA94Le6tHIY+1NvrWpjVa286UD4LZ8jJMOROieG8O/ziMU76pZQA8l9vWf5gwHeAn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709419776; c=relaxed/simple;
	bh=yvElCY4n79Px/TYdKRnwrreP/LvNLE515QJnoH8nICI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKFS4mtxPu134sAVRpt5HGgN0nTGZso5DuilXl9pAjLXuFeflwVH+4hPk3i7DJuRQQHnuHp+8jEXJfGKg4ATrwPjhBu1iFtjJsNzUMJGOS5mcyR6b6eYOhjYqhD2OXahLxk8BIoVKj8cTKTlZNWwH3XH7YrxHfc883fbgX5NfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BXxFN3PQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BXxFN3PQ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-566df43a1f8so2240021a12.0
        for <linux-sparse@vger.kernel.org>; Sat, 02 Mar 2024 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709419773; x=1710024573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U0O313/N/H96x2BCcFEncXqBwotYwnAA6fTUaOEPtLE=;
        b=BXxFN3PQS1jC4C+k9NlDq4oCn8MW0vXg7EfcldewcYZoeCFlT+XIDXlJSfhMxwWdrL
         CSa5ST+5jbeAd9ztbquHi9JkuYjSKnTQZv6jEqeMbyrfbuOdBRtfFb/VH6Ciw/D1YWVc
         MGvcuxEdo20dsRBKxHEB7IJahcD1EXvB6zKbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709419773; x=1710024573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0O313/N/H96x2BCcFEncXqBwotYwnAA6fTUaOEPtLE=;
        b=D8diWFl+hV6L7yJDVPcNWB1Y3gIzb1Nk6orZOt4RBf/ccbeZBaYVzhUAtwKz4nWjuu
         Pt/YDJ6L7lS4k8ZwqI1OgwYwPUxx1y27agkpH7YHZ7osqFJ2GW6wThqmcugo5c1PfBVy
         JT7WLugar03FwQaz4upSZweiVLyUsB9ACO7F2lrt7O1szQmCC25Yx6f4M6TuTTDxwMiY
         YJDuWqEn4+PqZgym/2pVBqA+KPpfDUypNQ27wZYgkidv/0TNwSKdSJQT8MTu1i9gAUQM
         e/2xSoO1dZQj/QPBeugA0KTc8wfogCEndv95JMLszMZu1H34GlZFVcQi4aPY9+El/gl7
         YAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxUoY63M13mDLxlKbttY/T8GVB966kJ9hxA2RKUdlvR3m/pu4+ZtBrLGR14uiBW3Gu6swRfSk122kGch3XwEruFiQZlp5TsCTVVIvh
X-Gm-Message-State: AOJu0YyZ9Gkf6BIkK5WGTPM7F8zAq5pRozNNL696nWPKWykggbdXc28a
	KW/ZnTLhsLruT1A4A4Dy05INx4gxY1mcRo0FaGVOu0BTTgV/DFx5xsBt2KMszHfomgCoKW83g9A
	+Wy/kwg==
X-Google-Smtp-Source: AGHT+IH2K2iu1pwGgKCek1/q2fOYabZXCpSuSHknJSKzIcLMoDlKri+T9uozlmIPtPf31kTDcFa7Fg==
X-Received: by 2002:aa7:c85a:0:b0:564:7921:37c3 with SMTP id g26-20020aa7c85a000000b00564792137c3mr3574687edt.19.1709419772820;
        Sat, 02 Mar 2024 14:49:32 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402105400b0056518035195sm2961097edu.69.2024.03.02.14.49.31
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 14:49:31 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so557658766b.0
        for <linux-sparse@vger.kernel.org>; Sat, 02 Mar 2024 14:49:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXckmfv1K9Udhm21QRd62d3VoTuuilU74Sdv0IBHwJerZbWxh/HREL0gNHAs5qYbK6CGhlTlzoDcVEdquSZpue0faAYbVhSjFCUfABm
X-Received: by 2002:a17:906:3416:b0:a45:1951:acb9 with SMTP id
 c22-20020a170906341600b00a451951acb9mr52187ejb.13.1709419771531; Sat, 02 Mar
 2024 14:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx> <87le70uwf0.ffs@tglx>
In-Reply-To: <87le70uwf0.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 14:49:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
Message-ID: <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 14:00, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I had commented out both. But the real reason is the EXPORT_SYMBOL,
> which obviously wants to be EXPORT_PER_CPU_SYMBOL_GPL...

Side note: while it's nice to hear that sparse kind of got this right,
I wonder what gcc does when we start using the named address spaces
for percpu variables.

We actively make EXPORT_PER_CPU_SYMBOL_XYZ be a no-op for sparse
exactly because sparse ended up warning about the regular
EXPORT_SYMBOL, and we didn't have any "real" per-cpu export model.

So EXPORT_PER_CPU_SYMBOL_GPL() is kind of an artificial "shut up
sparse". But with __seg_gs/fs support for native percpu symbols with
gcc, I wonder if we'll hit the same thing. Or is there something that
makes gcc not warn about the named address spaces?

Because in many ways the gcc named address spaces _should_ be pretty
much equivalent to the sparse ones.

            Linus
