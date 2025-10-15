Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6D2D7DDE
	for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541254; cv=none; b=MeRC1nnD7zgeHJHC7eKuPHfZ7gVJUifvuSWOkLHvR6cRVAOU/WoqMLKwSFAYK/o23y505nNOKQpZFUfqVLsEp7rG9mq++fMAoLgl+nW9/T16pufm5nU/GKWl12SY0zZOyhftK1eCv2couUG/evTd58t11Ci7/4RGEWZsFOpNUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541254; c=relaxed/simple;
	bh=vIIalLX2jBXQDzgelXcqDB6pZDhnjKni+zOmpg1Apt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkzaqhSc8PHZoM7RA6zvJ2numu7PSVS2H1igMUz4SZBjzdP8BCz5H/w2gjGiBs66ke62zpZyXaO0Uv29ynp+pIKsaDGKqMkbCT9o5gHL9GWrQcxoOiwUgn6STlvTvZDWWykvsRSLadNQ4SzrzAHd6W59xEW+uv8NTVut7lD+4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RegBc7LT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RegBc7LT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1226218166b.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2025 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760541250; x=1761146050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PznC/nuL3306rXw8EmSWxaCJn0QKZKxL1qK91E1ce2s=;
        b=RegBc7LTxyjTHoDLltWjJ+ghnSk85VlL6Pu7CKf3ej8jTrJ5CxU239YnMZxNDlV/Yh
         mK42a5Kq09LsFIweD7vDvgOtj0D89PRn42rAIawo4OdnU3wiQ/zNQXuWVQ2bnM+0DYF+
         uauK7SXtAV5F1pLS948w7JfqqcHEvYMzUghr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541250; x=1761146050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PznC/nuL3306rXw8EmSWxaCJn0QKZKxL1qK91E1ce2s=;
        b=Ee6mi/eZN6GqICOGRJAKKUHiahxysgagELh+Vr9ESnu+8MGygtrlS62hzPUA34+AXX
         JO2351f8uryhAPi08KVSFjMSN6KsH7yh3JzZ2fzdxC9g0wGF6fuVulY9z1/N4L/1yBlN
         XN/mGLc11o4GBLBne3XE9cg6xd301duZccGU+A01E+MTdB0VPpDpUlYbReRPE0g3iggv
         9BjC4JlT1I0TJbt7WFrK0jX33Mhn7etSw+HBM8fjUSLqJRii2jNC32eIfk61D/2OHIsd
         VTktHWvQ7u9+Tg4Mr8uNE2eiQIn6Cg9PHZYFNeP8HUG5JypGEVqnsFJg396HAOlDqFMv
         QPlA==
X-Gm-Message-State: AOJu0YwBq5IMw9mju3UnONPQ6wKbGcDKw4NlPLMO+KGI7NQF3MxsTdki
	WSNHWLSsnGNnojIEOb/PxEHjxqZ5NchXSi0biQTfIkZezqwUXIEzYwXE6bI5pEamAhwX3YG2d1w
	swG7YV4Y=
X-Gm-Gg: ASbGncsULqKoq5NNsXlBBU99MKDAaagvacZ65AvyN7CZ3Zfaj3N2RdLiuq9QZcSEsxt
	jAgVpMCWizqAPdbg9bhygeYZclR6bnKo1El9NnfuFIZvP96jDc2UVccvp29/guhT2Ta5zx2V2uw
	rF2jrj1kWq82s/MZAR2hTYdG/b6niGmBDtbD+3oGYtViKPi18sxj+TuuEj4Cs5uGmVWgaytseR2
	ru2kqMqbydKFjDW9LUG/++EL4Cy4fsR5cDbq2R/C7hC4sxI/P4xKK9CsS+duzHLe55SD2n/ahRb
	gnNvSgpjGmCSVdX2H9hb2FJqfxCG5VlZ/KuWTlt6p8URT/reV6W8Wf3CHc8+INyja/as5qWvQTU
	hWw+NFVISLtqANtYvW0ihDLnc6sGiHluWp5ZxYsmLnm8XzzzrcMirKyvAlB22IiqjNdR23EG8p0
	cN9uhepeah0NOqWY/kGg37UgAleQ==
X-Google-Smtp-Source: AGHT+IHLc8h2TAdOCAVoM1nytdExGpYZS77DJW6qYSbfOP2n9twhM2t2Y5sAAXllzS9/Pxwe1CKdNA==
X-Received: by 2002:a17:907:934a:b0:b48:730:dbb3 with SMTP id a640c23a62f3a-b50ac1cc3eemr3184988366b.32.1760541250088;
        Wed, 15 Oct 2025 08:14:10 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb9b5f552sm250684666b.20.2025.10.15.08.14.07
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 08:14:08 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so10662050a12.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Oct 2025 08:14:07 -0700 (PDT)
X-Received: by 2002:a05:6402:84d:b0:618:528b:7f9b with SMTP id
 4fb4d7f45d1cf-639d5c514a7mr24205812a12.31.1760541247570; Wed, 15 Oct 2025
 08:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aO-cvXncl7dbnP_J@stanley.mountain>
In-Reply-To: <aO-cvXncl7dbnP_J@stanley.mountain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Oct 2025 08:13:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKcf_dP0_7yTqL+JKc03mhFgqFHkN7jXLUrOy=WjWZUA@mail.gmail.com>
X-Gm-Features: AS18NWDdPlEEBZ1MVYFnkl3KJ8oytP--YOd7-XiMvlSP6Blf7tJGYJvbcV6IMuA
Message-ID: <CAHk-=wgKcf_dP0_7yTqL+JKc03mhFgqFHkN7jXLUrOy=WjWZUA@mail.gmail.com>
Subject: Re: [PATCH] builtin: implement __builtin_strlen() for constants
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-sparse@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
	Kees Cook <kees@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 06:09, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> People are adding compile time asserts to check whether strings are
> the expected length.  In GCC and Clang strlen("foo") is expanded at
> compile time so this works, but in Sparse it triggers a "bad constant
> expression" warning.  Implement expand_strlen() to handle string
> literals.

Ack.

Except it's not quite right.

Try this:

    int i(void)
    {
        return __builtin_strlen("hello\0hi");
    }

and you'll see that it returns 8, even though the correct string length is 5.

So you should add a

    #include <string.h>

at the top, and do something like

-       expr->value = arg->string->length - 1;
+       expr->value = strlen(arg->string->data);

in there instead, because constant strings can have embedded NUL characters.

           Linus
