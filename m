Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E881FAC38
	for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707846; cv=none; b=TECVgW58jpD218PD/QNBo2IQ5IKv+yu0O/5Egn8ziGk8wFEtt95OuMwPVm/OujoIH8n0us6UkUH8heNal5MmVeiEyH0+ZDwbc8m8WAxgoSGZypAQ+bF6QRZRRHV12j40A/cBwe5Wgy68Qedg0rSSSqjrLSfy24jbyb2Ze2hPyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707846; c=relaxed/simple;
	bh=++rspaIDD93JFFRGtou5Eosdonu6QCB/SM4PTTSRtRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKGJtKO5TNzd4F9FfUb5DuG1k9fYqNBsR0+KuTm8G1VhwaJSGgRBKua6PmYb4INxQyL1qV42Jm0FX8kN4/55GqhO7/LKva5+m9BYd1H/MeKZWhABTnjN3SExyTQ/9+uWUjtW2reNZf7hjFRT6mir/QK5F8OSa7Kh7v8/S2z8YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TpcbxkyA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TpcbxkyA"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so313833666b.3
        for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731707843; x=1732312643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdQ3EyQAXpD5NQcbeFqr7Xyxaqt0Nd5e5vguJD9yhqQ=;
        b=TpcbxkyAQuvju5fGEP3yDUF8FgO9TccR4Lpw3R1xfDkOmmugDD6iCqkXv4si6qeD5X
         0yrLG5EAQgvfTmf1NusBWFSiDCzTurS73m0bRkQwbmVPB9Tk52WMjWoD/7b3jQrlkMp7
         CBLLruupRPiSaHqJN7IkVd9LKiGthPaLtDg3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707843; x=1732312643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdQ3EyQAXpD5NQcbeFqr7Xyxaqt0Nd5e5vguJD9yhqQ=;
        b=U01f7KDcEdewMBb0L6Km2NiX6vIytAS/8iKGl5vyG+dlexfU9GjsUXqQqPfnEFQXn6
         Z6SBnBGgMHUvfVkgsCNCJw/7BwhUWoiiwhDmlZGFx9hRGYOkSDJPDqBerq7bEtaDWCD2
         dINSsir+M1D59shmk9u5VwWILHrvmHW4CAcxH5uonNtJaTXQKy6U7fOV7LQiMyMObF2W
         PcNsKKnN2s2kKvm9/42oJNmLN007A9EGGIAuMSLDwaekde+ffhuXv0YEufgwok4SQILt
         Wgl8J0G1AE67iM3m3v5ZDAs7NuVqfcsBM6sq/W+nMzJq7lha3xgjmssJRvwAkpNif3pA
         z4wg==
X-Forwarded-Encrypted: i=1; AJvYcCVbxGs94SZAm7zJBME7HSnZa6tF34WqVaAxXqzV4t7Yj14LwGEd3O41+/uRhO7m+ZGqZdUvXZ9P4l/4xes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgGaSkdCLEm8QFZddmzW2SWPMrRWVKbuL0SMiWzCuOlBXt8T8
	JWkz/syAJ0njAGTvMp10WUQxQ/mPFy0esJQLzhCEoZhbrXrFDgG69/xch6CMpwzS9+o2Dyx1RAl
	CAYA=
X-Google-Smtp-Source: AGHT+IFxV0XrbLiWDPLL86EBX4kgLWtzadrCMIDEKL5u65TuGP1bP3vI3N/itOf9OgZKMJlyiHQEUg==
X-Received: by 2002:a17:907:7b9a:b0:a99:f8e2:edec with SMTP id a640c23a62f3a-aa4834275d8mr346184566b.21.1731707842782;
        Fri, 15 Nov 2024 13:57:22 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd798sm220743566b.93.2024.11.15.13.57.20
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 13:57:21 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa4833e9c44so158172666b.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Nov 2024 13:57:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3wN4pgJUY5gydQqq5OjC2dH7qB8NgegpM/TK+lzkB4RujcaLpdy2wJSTVC/EieI//4IVS5K6uCoIoa6A=@vger.kernel.org
X-Received: by 2002:a17:906:fe01:b0:a9e:b2da:b4a3 with SMTP id
 a640c23a62f3a-aa48352b5d9mr370018366b.42.1731707840633; Fri, 15 Nov 2024
 13:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
 <20241115204602.249590-1-philipp.reisner@linbit.com>
In-Reply-To: <20241115204602.249590-1-philipp.reisner@linbit.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Nov 2024 13:57:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghAQs4eAeR7fnUwUUBUq6J_1UpQ5EWjyTW4L-JJ6LjEg@mail.gmail.com>
Message-ID: <CAHk-=wghAQs4eAeR7fnUwUUBUq6J_1UpQ5EWjyTW4L-JJ6LjEg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Kees Cook <keescook@chromium.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 12:46, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
>
> Fix that by defining __BUILD_BUG_ON_ZERO_MSG() in <linux/compiler.h>
> and using that for __must_be_array() and __must_be_cstr().

Ack, that cast to 'int' seems good too, to make sure the
__BUILD_BUG_ON_ZERO_MSG() test doesn't unintentionally change the type
of the expression it is in.

I do wonder if we actually need that "#ifdef __CHECKER__"? I think
sparse is perfectly fine with a _Static_assert(). Or does the checking
cause some other issues?

            Linus
