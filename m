Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A14A28
	for <linux-sparse@vger.kernel.org>; Sat, 16 Mar 2024 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710552214; cv=none; b=OOD6WonoId+1hxglhNuWE17IzAyPMQjO5VtcL1kR79H7AW4LwP7IIfeN8GEz3R/v5gQynztnu6aaR5rkE4BENbK/OivBvXp9kUcRaiFpxDpZg4wUHuONFbYNyuu89+ck0vQY8bnjNk4erfdLzyaJOAvYHAFppQljZX4snuw78p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710552214; c=relaxed/simple;
	bh=zrk0mlljUXq6JrTr3qaP5fW3ShetdUZodGHSY6f3a6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+lmu7QCCoxICXTswlNmx16wswiE9If5BPSkU1Fq5yLqeyj02gNSX7QQPLQMRnDII45XbcWGKk7Ca0hOTddwS8u35N2nTFoitp82O958zQv8gazcbqedBop3BmSKyTnxEd5Cq7SHAYy+eEikvuSgt/ZPoOCdYT8vRvvXytPpLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9ojlGze; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9ojlGze"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d212f818so2980449e87.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1710552210; x=1711157010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=69cI/hdQb0CMrhhOHzUcjMzxCnMmxWubP/uXkL4m1gc=;
        b=N9ojlGze6DfF2yy0ie+4jvUiWOhTWE2Emqd5XhR5TRA75MiQdbNH7q+5hA8SoxY5EY
         0HMxoeFwtvPUxIQZYskqqOifKTqSTC1gj0MB64uJ4feEXCR58C4EMsvrj2OQM8bdSBVD
         CKZxyPE3h/9jWpI8OnjkINJZPcUucz7MDNQA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710552210; x=1711157010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69cI/hdQb0CMrhhOHzUcjMzxCnMmxWubP/uXkL4m1gc=;
        b=c8KuZMi9+5PoW1RXJayRKJ+A7lOr73mWd1Q6jVW1VdB9u1XZWxZR4oRKYNHib11sOS
         50f0ZoFczf7ABKv9OEjxcsXryfC70pNc+eVW3+CphS1cR5p3pBeWHhFSyWWCJ3cInDDd
         7SvmKVgkNKBV5LJ/ynP8ipEjSsgNgkPlHr3r/PZfGe40jlK33Xc2EMSkbz1Kxf4oRZ6J
         Zl2P3wUj0Hoy+SZY3o0vXiQHVwjqgRzPnITEDIhxNcROxIL6RCE0L224qgZRwD9X5cF2
         ZLvPem18mWZtdAIucgDF+tsH6rl3PRmVSGeg3xiRwpvUrZ/IK3COSkcGOWviGCAd/E27
         CWYA==
X-Forwarded-Encrypted: i=1; AJvYcCWt69KNICDUMBxzbm9taBGSVrRQvVsc6q/kxT6gAZMjvI3xMucVNghLsljRECHrgyPyRjusve4gAAuIPjksYgFSxDs4hScUsm+6ey/A
X-Gm-Message-State: AOJu0YzsX+0BAs4Mjk7Vwa9P2NnU/GrqIM9OdYiRVa8cdzD9Q35154rC
	IwPoe1uEcFkkT1fFd2vwXoYob38cPNj1SjV50IYQanISV2qT9Y3Mf35hFjglgq/Ebl6Isd906Rc
	wETT/VA==
X-Google-Smtp-Source: AGHT+IEm1VKwPzE15O2yNlhNxcThijArMnWsU8SYuWEoXSxq3CvuTouR+AjiEyvqqCRI0s4xDsCp8g==
X-Received: by 2002:ac2:5ec3:0:b0:513:dcc9:50dc with SMTP id d3-20020ac25ec3000000b00513dcc950dcmr1366775lfq.47.1710552210368;
        Fri, 15 Mar 2024 18:23:30 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id gf9-20020a170906e20900b00a46a27794f6sm205247ejb.123.2024.03.15.18.23.29
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 18:23:29 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5689ebef670so3100573a12.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Mar 2024 18:23:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgqsh41mjzwEvdKoY+KQPkVq3qQUlkOsKwnbOVHLkOyQUE57yOwe8IJs09YieU+38wM6qRezITZqdQZTMFaHyVwbM4cTFJqrc47coK
X-Received: by 2002:a17:906:3654:b0:a46:9711:4f04 with SMTP id
 r20-20020a170906365400b00a4697114f04mr1417533ejb.13.1710552209212; Fri, 15
 Mar 2024 18:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303235029.555787150@linutronix.de> <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net> <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx> <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx>
In-Reply-To: <877ci3j80k.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 15 Mar 2024 18:23:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg50AGnzhmOK0TNqDN99T3dWd747h3y-ZFuv4bNZ4Q0tw@mail.gmail.com>
Message-ID: <CAHk-=wg50AGnzhmOK0TNqDN99T3dWd747h3y-ZFuv4bNZ4Q0tw@mail.gmail.com>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 18:11, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> You wish. We still support 486 and some of the still produced 486 clones
> do not have a local APIC.

Ouch. I was _sure_ we had dropped i486 support too due to cmpxchg8b.

But apparently that was just a discussion, and my wishful thinking,
and we never actually followed through.

         Linus
