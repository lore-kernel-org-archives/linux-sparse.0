Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86081BBBF5;
	Tue,  6 Aug 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941225; cv=none; b=h3K4ru9T5CHBM6qkxwf/IUQTwDij3SCUQ/jOtcA0BjoJh3QO6CDGX9f7ib6ie0EhXKITcn3V1woj58D4XXi5yIDYaIHmv9zZMvC0+8E8OQmz5LOZhfYKP9EuxMBm9PExIBn4VyzznNzCsFW0IIpgohPUwWwfitHpIVgqtNoKsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941225; c=relaxed/simple;
	bh=VYIFMcmoFnEC+yzA/Q9NrdsqaxXWUOSVOa3/+7dtKFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh8eHujs0CozwfXiUrjb4Gj9NtOoht1KD67fguaC2qcy+r5klDCk74/W/hszc8dWcrPxmkLkQ5WZehhu2mpU8eyShQnrUtv0E5Y3rrGKeQGyAjv3Yj7mtuLWExl08FQWA8FUK/BizkkE7l5cDnc0uXULLesd3lygR8MjSsNxwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTS5XUc4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTS5XUc4"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710afa8d1dfso341247b3a.3;
        Tue, 06 Aug 2024 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722941223; x=1723546023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYIFMcmoFnEC+yzA/Q9NrdsqaxXWUOSVOa3/+7dtKFc=;
        b=UTS5XUc4ybjhJbFcvKzm7Ka7RROHqdKBSEKHOzTfvOcNofK649coAc+u07qd1Nihx6
         BawbM8yEi66krsrxJPmWyDJnfKcSLEUdboSEbsAk1yzmJaknyJoyfFmNFRkxVHYtZG8i
         GkP/4M7wXBJ8PPTfQNNA4zN1gZN9SISDTMNTXVaBRBzvBVqMpkZyQCzAQJih62xXUmIL
         MSjx4AmuwiUF8f2XJ903zpRkAKXZJ97MiJYp165yYxjlqxWSTJqL54+U190s6+tj+te4
         q7j6gbevpEIWrJBr+gklxfkYrwYZV3O34poLvsWNQHfQUz2/UlPnz101kUq36lSVo8yh
         SUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722941223; x=1723546023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYIFMcmoFnEC+yzA/Q9NrdsqaxXWUOSVOa3/+7dtKFc=;
        b=ZSvtcJ8ojdU/Gs+JXUaDrDtCxs7etwazpPb5G1BRFeMUdYkLmAZ10w5Rkz3OOM20jf
         FgDvFIcd+NSzX7Jp3t7lBtEPrLzuGP6XdrM7wvaBmlhzUWbHxMqKmuv/qnKJg9uHMaHe
         +yO4/VR6xTWgCm9ItTXjjpL55Rp+qMlIAagWUOGLmjVDfDz7G9XD7j5gAwoAPQhhsII3
         8mXUpWOSOTZJyN+l156c55+Lt0rp5bxm/L0PK+EfT52COJFVVH+KGggDsd/XnJfCpw6a
         5tq3kJ6jBJqJXQuOM9WzpOVgMT1BJI/2TCOWNXP3Fl0ZRw+bO21xATStYZ8BavvMsOcI
         eAhw==
X-Forwarded-Encrypted: i=1; AJvYcCUy4dCFHb23LOt88A7bPI8OcV2/dj9I+NsU3Dt+0QBjxInNHHqsAvywkNJHQaW8k5JO4SsIXwMUbpoCcM18sO+6rXV0oNtdVLngCfX9wKpJqsO4oWryyrdigcE/vPYJpRkFrAviO1BDPr3DSkgsP20LXD6MTXCMT+l3tgIm4BYYLS9lxkeetXaA29I6
X-Gm-Message-State: AOJu0YxR47Yh4/aqJEfWxDexdO+DgVvJj1IHpHaWnPRLKx6TWyd4xhBX
	hgwst2SO7gEzj9QpAU+XPQGZEdmo6/trJ0Zr10/9tWK2cGSzOplBrXWs0qCIoDY8j/BpfecEPaw
	dY92hq9L7T8HGjjjjkW3gm05goSA=
X-Google-Smtp-Source: AGHT+IF5FenssUoUMemoJIL2Bcf9TUbyZDFqw3lGBjUR6kyeAG9q0/eULHLPMdu8KMWQFGEdAEHdDhFefFrSJb1V3Vw=
X-Received: by 2002:a05:6a20:3951:b0:1c0:f2d9:a452 with SMTP id
 adf61e73a8af0-1c69955a835mr16736472637.13.1722941223180; Tue, 06 Aug 2024
 03:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805214340.work.339-kees@kernel.org>
In-Reply-To: <20240805214340.work.339-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 12:46:50 +0200
Message-ID: <CANiq72mifyQZ_13ZWYi2_cdcx9G3dOSVVtywC++6s0P_6JKAGQ@mail.gmail.com>
Subject: Re: [PATCH] string: Check for "nonstring" attribute on strscpy() arguments
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-sparse@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Bill Wendling <morbo@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 11:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> +/* Determine if an attribute has been applied to a variable. */
> +#if __has_builtin(__builtin_has_attribute)
> +#define __annotated(var, attr) __builtin_has_attribute(var, attr)
> +#else
> +#define __annotated(var, attr) (false)
> +#endif

`__annotated` is obviously best-effort given this definition, and we
do similar things elsewhere, and it has a double-underscore. However,
I wonder if this being a "query" (vs. something like an attribute) may
imply that it has a greater risk of someone thinking it will always
reply with the right answer... (if e.g. they copy-paste another use).
Perhaps there is a more explicit name to let users recall that.

Anyway, it looks sensible to me: more compile-time checking seldomly
hurts (apart from complexity in these definitions :). So:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

I also introduced a mistake on purpose and I got the expected build error, =
so:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
