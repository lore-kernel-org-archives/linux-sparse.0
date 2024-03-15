Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6014A81
	for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710545011; cv=none; b=O/zdIkh8s/112eVWwAW0lBDfoWQ3LK/OU+0JH7oQVrL2n1CNzE0rDA8UF2+qekz4J2kzscPuSt1XOpRxIzPSqAH8qu3M6SG+wCjY6PukC60VoeLeFyvHbNIUOrmH8JaSjldNC/fQvy4cRbz2K6rT0SKmTxNHyxSGSPV6dt73nOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710545011; c=relaxed/simple;
	bh=sytlPHzECdx/TQnD3Z0Odvtgw7GxrNRoLcw66cnO0n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD/ZV20QTcJcRLEh1WQWzCEqEHEphVbAsz9zXOkHUFkv3zlJn8DkQEk9F5TBD1bki6zvcKBmibrJNUycgoQ4wuU53KoXrxIx/rlhM1rWAqiAxJlgqh5P2ar6f2RCoa2R1yGz3HOh49P66Fwa7PM3kWJ2fAKASdwHS6tQi7dfuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaPbdIQP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaPbdIQP"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bde3d197so2597406e87.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1710545006; x=1711149806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Md0NRsaNOOwAL+jub1moMYrNKunx652Xm1e//iAuX8U=;
        b=PaPbdIQPRFOUY4nCtg40+NoIFL1U7vLk82l+a7I2sXjBINk2jd+pfILFeMtwehYcBj
         mk+JeE5m3JpQBRZOEf2Pdx1W+wabAQ1WCPF++ygfS0M4YxMmdlqsqHuwzxXn311AgC5z
         x40h1q0dFqd/VZgn79pjDwQkfic//HZqpUTYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710545006; x=1711149806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md0NRsaNOOwAL+jub1moMYrNKunx652Xm1e//iAuX8U=;
        b=h+KByZgQjByszuEdwxCqeUsjrRFiYuLmrF0NohTNUkoyQ6fR4757U3IXkT+2X1pUOG
         iqWFBt4puoLR7G/E9AXD49z3gjCk3noRoV/C7AaQ8Hg5435DqNmSFFCSGC2trc0ISyJ4
         iTLWfPnxPoFSZyrNWyc3jSnhoHXoznUZSUTAy+gGZIx7u+hIilRTRmN7ZcSWKJ9gp+fV
         3IijbRocX6IE9os97a8xB5o06AFTxrztwxjsKb/FtkvOw4PGY2MjleEexJ4Y38iGTIjf
         T/k2R3JzwP1wOMf4TDZ5pM6d/ZjP+kg1u5cpQOYuVw34bZIgcLaCrsGVnOh2XT4rMYKr
         boPA==
X-Forwarded-Encrypted: i=1; AJvYcCUkCREghdq+Bz6a0hdOg8XgMrKxZMaQ3RoWmLzLZQV7oKYT2uk3TU/2BGwSzksti+9ftZq1dLt8/K1Ok7JhWMpgIUbxDicHFmI5x+dH
X-Gm-Message-State: AOJu0Yx0qmzroqNUOktRlyeorrXrk8hlilhNhXjf7BA1PdPZ7G2n1IY3
	pUmiSovv5lYyr/uZXbF+OUZA8XDtubme1dS3+aYawTxt7UpbDdPJNaXNtKvGPVPjvSPRWEm4ehW
	yAwBLUw==
X-Google-Smtp-Source: AGHT+IG+MOvdApx1EGzpGc9qPiomM+82hTbT9SOS+TJVw391dj6rdinZSEW/SmKnx/h2oJtOoTjt7Q==
X-Received: by 2002:a19:5e5b:0:b0:513:da24:19ff with SMTP id z27-20020a195e5b000000b00513da2419ffmr2347124lfi.38.1710545006521;
        Fri, 15 Mar 2024 16:23:26 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id x7-20020a19f607000000b00513d3cb2c34sm621127lfe.185.2024.03.15.16.23.25
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 16:23:25 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512bde3d197so2597385e87.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 16:23:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXrRNkEgYNq5hlJDEs5LUQpJjUIN74mRcZV85XkOSPy+X/SNtDbbBXQDyamtFoxC309lIkLcRV2T4g+8++B9Giq0Wy59gvC2ojceIQ
X-Received: by 2002:a19:5f45:0:b0:512:ed8e:97ce with SMTP id
 a5-20020a195f45000000b00512ed8e97cemr3783714lfj.16.1710545005123; Fri, 15 Mar
 2024 16:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303235029.555787150@linutronix.de> <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net> <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
In-Reply-To: <87o7bfjeae.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 15 Mar 2024 16:23:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
Message-ID: <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 15:55, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Not really. The problem is that a SMP build can run on a UP machine w/o
> APIC or command line disables the APIC and will run into the exactly
> same problem. The only case where we know that it is impossible is when
> APIC support is disabled, which is silly but topic for a different
> discussion.

Oh, I agree - that was why I said that it shouldn't depend on a local
APIC on machines that may not even have one.

That "may not even have one" can still be a static option - we
technically allow 32-bit UP kernel to not enable X86_UP_APIC, although
it might be time to drop that option.

> So the proper thing to do is to check for num_possible_cpus() == 1 in
> that function.

I think that's _one_ proper thing. I still think that the deeper
problem is that it still looks at local apic rules even when those
rules are completely nonsensical.

For example, that MAX_LOCAL_APIC range test may not matter simply
because it's testing a constant value, but it still smells entirely
wrong to even check for that, when the system doesn't necessarily have
one.

So I think your patch may fix the immediate bug, but I think it's
still just a band-aid.

Either we should just make all machines look like they have the proper
local apic mappings, or we shouldn't look at any local apic rules AT
ALL.

So I'd rather see those apic_maps[] just be properly filled in.

> Sure you can argue that we could avoid it for SMP=n builds completely,
> but I think the right thing to do is to aim for removing CONFIG_SMP and
> make the UP build a subset of a generic SMP capable build which has
> CONFIG_NR_CPUS=1, i.e. num_possible_cpus() = 1. Why?

I wouldn't be entirely opposed to just doing that. UP has become
fairly irrelevant.

That said, UP is *not* entirely irrelevant on other architectures, and
if we drop UP support on x86, we'll be effectively dropping a lot of
coverage testing. The number of people who do cross-compilers is
pretty small.

End result: I'd *much* rather get rid of X86_UP_APIC and the "nolapic"
kernel command line, and say "even UP has to have a local APIC".

We already require a Pentium-class CPU, so in practice we already
require that local APIC setup. And yes, machines existed where it
could be turned off, but I don't think that is relevant any more.

Put another way: I think "UP config for wider build testing" is a
_lot_ more relevant than "no LAPIC support".

             Linus
