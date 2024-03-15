Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E41C2B2
	for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520947; cv=none; b=WUAjTDxw27xmABaorrAKnnhgDExNZ2jIklMMst+gEDVNlldVud8eFpxVRqG8e/3aeJMPB2wd34a2dsFGg7I6vMQ+gVfOo/yjtEaoiRr1U2Sn/zNbzLyaXtErBrYA3B5YGAmuVsem6TyICkCY+L/xJQDLtgkjTG6I0iKneP1YUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520947; c=relaxed/simple;
	bh=hIwLeauctgBMp7l98Z9Pbwy1HUT5HKtfynYgMSjBHg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVmKbgYhxSTdEp6ALN9rtqIMQFU9ZsMj+RogkgNRKyUAsJeVEPdvmN6+A6NGQRVMrwgia4+1xGP0ijIVxMDY4AdWZb2QzN28KuWZKgx0BstFYDWag14AxIJwoGw+la2MdYkkIh8aQ27s0jumynWGVc0jeTZmjT88Q4lG+ZCHxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hot1eDZm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hot1eDZm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466fc8fcccso265690066b.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1710520942; x=1711125742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=am/PWCEeHNB3+7UJCgYcRSSjRqhgq8ufptHRIWrU5Kw=;
        b=hot1eDZm7ba76H0z6cOyp9dL6RNJBuOT9lv/Ffziji28AqOAjsrOAnsqUkN1ratakk
         HxjvZWdUtxTeyICmncBaKSVYm+cS4omySbTo7afLezo6sBTVnQ/WnjnCr6u9G3GYCn6D
         y6JaWwSB4/jUJBbJhqSpXqMzI7VyVbqxtsKPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520942; x=1711125742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=am/PWCEeHNB3+7UJCgYcRSSjRqhgq8ufptHRIWrU5Kw=;
        b=GQo0lZkG4Qm2+qEjamfFBD5j4GONFRYhgZQugBzESeFQPyxNyenh1jqt/0a83Ds9rz
         W4LFicjlc8pN3ynIbb/dkNZS1E3e6539zIcQfzvFcMe4P0qpNBaQZRzpLMtyMjF8vnQO
         70FyD/43QupSr+33vbLBhchRkVIsRvx9znsnhdNIYlTHc1f1o5iTX1eMIzekJU+QhrCq
         ahZ4w6Ibffo1PKdnL9p0EUf2o5gLgplLxh/0VK6CFGPPZD4WN7L13rddyedNkHcEZJjV
         A/U5V/iajQeIGHNnLCJGcPwxbYd+cSh3wiKiSR+9b/ekMl3y3cd85+SESvqOsKFp6df+
         En0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSF0tmzC6Wkux0DtTsuYVTQoFun2sy1G7q97g1rlsrvx31NRrLZ02wm6iqvkfhR7ZgRUqd8Dv9UZpy4MzxR/5obCLPVypnH5tqGFRh
X-Gm-Message-State: AOJu0YzjQJBgeOPuiQiWEnm1U7GJ1PzoMDgU7bQvfWYPHNXsGC/b6pli
	2KKfaBktznPLZsPy1hfwTCmOkuYoTYe3sAbFggcYTI05/UB4cJh3HwpL/FJQ1GtYK+1k2Q6baCJ
	SVKQ=
X-Google-Smtp-Source: AGHT+IHufLmH4AC/rW1ob1/4DUdJNgEUTAM33n8P5/P6CyaDvoG/3bfrqpw5TqzPIFIRB4+YtHPS2A==
X-Received: by 2002:a17:906:1547:b0:a45:b1d8:200c with SMTP id c7-20020a170906154700b00a45b1d8200cmr3811810ejd.14.1710520942608;
        Fri, 15 Mar 2024 09:42:22 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id bq10-20020a170906d0ca00b00a4657cad7e8sm1834012ejb.127.2024.03.15.09.42.21
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:42:22 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466c85ae5fso80411066b.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 09:42:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpXNGD6+4ddtbzpx0jhHvYZc2RuKZc3r0p0jIAUy2Ulsn9w8BpmW5a1dRuTdgXPW/c7au7qF+fgTUn8SQejvne5EjWuWizlCvl2DCJ
X-Received: by 2002:a17:906:bfc8:b0:a45:5be1:6e20 with SMTP id
 us8-20020a170906bfc800b00a455be16e20mr3108974ejb.23.1710520940765; Fri, 15
 Mar 2024 09:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303235029.555787150@linutronix.de> <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
In-Reply-To: <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 15 Mar 2024 09:42:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
Message-ID: <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 09:17, Guenter Roeck <linux@roeck-us.net> wrote:
>
> [    3.291087] RIP: 0010:rapl_cpu_online+0xf2/0x110
> [    3.291087] Code: 05 ff 8e 07 03 40 42 0f 00 48 89 43 60 e8 56 5f 12 00 8b 15 b4 84 61 02 48 8b 05 01 8f 07 03 48 c7 83 90 00 00 00 e0 84 80 b6 <48> 89 9c d0 38 01 00 00 e9 2b ff ff ff b8 f4 ff ff ff e9 47 ff ff

The code is

  mov    %rax,0x60(%rbx)
  call   0x125f5f
  mov    0x26184b4(%rip),%edx
  mov    0x3078f01(%rip),%rax
  movq   $0xffffffffb68084e0,0x90(%rbx)
  mov    %rbx,0x138(%rax,%rdx,8)                <-- trapping instruction
  jmp    <backwards>

with %rdx being some index having the value 0xffffffed (-19).

That's ENODEV.

Without line numbers (if you have debug info for that kernel, it's
good to run "scripts/decode_stacktrace.sh" on stack traces) it's hard
to really know what's up, but I strongly suspect that it's this:

        rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;

because we have

   topology_logical_die_id(cpu) ->
       (cpu_data(cpu).topo.logical_die_id)

and we have

    c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);

and topology_get_logical_id() does this:

        if (lvlid >= MAX_LOCAL_APIC)
                return -ERANGE;
        if (!test_bit(lvlid, apic_maps[at_level].map))
                return -ENODEV;

so that -ENODEV is not entirely unlikely for a UP run.

This also explains why it *used* to work - that whole thing is new to
the current merge window and came in through commit ca7e91776912
("Merge tag 'x86-apic-2024-03-10' of ...").

Thomas, over to you. I wonder if maybe all those topology macros
should just return 0 on an UP build, but that
topology_get_logical_id() thing looks a bit wrong regardless.

It really shouldn't depend on local apic data for configs that may not
*have* a local apic.

                 Linus
