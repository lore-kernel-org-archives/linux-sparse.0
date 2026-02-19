Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA414A4F9
	for <linux-sparse@vger.kernel.org>; Thu, 19 Feb 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519316; cv=pass; b=A2q4DiF7QKV+LM3mitQ4efVeN2C2BDW2XsujE+unwGSvHCMJehEkiMSBnyeIGSk5Tmvf/qmPIBdVztvls95d94CJ4UNcVnguHnDkmh0IKe7WdjvR97xCyBoRo7HkPE4T5FVFvjKgznoQpoKXeesP1WoGukp8UBtb2C98iUd22hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519316; c=relaxed/simple;
	bh=NF77huHe5rkrdzkBygha6Y5vKcZWFw7n1c1mg2d7OWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWlZAJj0IdT7D4xJmvqyKmJXaGFSqjdBn2SXOuQ7ZXMHxq0yWWkBW16+zdJn/ex6J1EbTEk4gnfbTkKsqqj8HvRZe9NWGovnuwSbM/uOnxqhDgctSbXN5eF3bQ0UIWBpcofA043eTXrBTLnZp3cXkxhL/KqTzqNV3MdvPnZpz28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgASqz3E; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgASqz3E"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65a3a1740e7so13526a12.0
        for <linux-sparse@vger.kernel.org>; Thu, 19 Feb 2026 08:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771519313; cv=none;
        d=google.com; s=arc-20240605;
        b=QaaUjeaPcMSHNwxdeqvgFxclguWkiLCGUd2A6M7YGcjHh/7UpPyOpsVvJs00EgrXn4
         xjkhUaPsiWxlM6ahwIGTzorUOz4D8NHeQWXT3WIp6OycPprET0zaTx460JW0z24zJgLQ
         3WmHQ5/2PoVH0iKMXwVbbxha6kV+c03xdfYwjJXFKBKT5cVFmuFdVsAYQWfg7HWv/U9q
         dMTBj7DdYI60MwQv35lRlk3pz4b3L98sH1CRLq1Vu0yxjncHuEHbpR3XOdSBu9V9B94+
         r/nd5faZCXHOUaKwQZuhxOPKkfcnHNMiIZPVRnpnrpfhKJteROaR3MtZvwW0L8NT9fL2
         P24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hf1LaDkijcdD11OckoGjxI5yaxmlZ2c5i9FpCf0YHmA=;
        fh=Z9xwE1ATQnrmioZ+cTsTURG7xaSpZDU5vietIVdkRAc=;
        b=a0KtRLSj+PmZDPXsVYsfzg+YTFcFcZXSs/S9VtWQYyaFCog/vdEvB8i+wXd3TYLDcd
         Tz2khRlzi5FAf8KYfmurskmMHdWvEZTHcraZxsZtsVAzWkbmgOOf5c3ebtL5VAinrA81
         W4TytOCoznLGkb6HBza/s/Ro5rLI/Sbp89HL2PdH4m88dYf9ozDs3G0b67eHbgQqotQI
         UL1bt0nz7UQkJbkLTjpdBwsTynVP9z1YHH1vroe3uCtrWxHiNBbTBeiQWcLQfsggcc0y
         bb1TeejeYOrexBtcM3FaXl68XXmSJaT+0A+pg47BBad0O1jgJ7l0T/ckU1nDhpwhAseM
         GV0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771519313; x=1772124113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf1LaDkijcdD11OckoGjxI5yaxmlZ2c5i9FpCf0YHmA=;
        b=WgASqz3EEgNugzn16VoiaRhlKMLATDAmlCWDnGVNWPECEQayGXla8VtuyMa6FOuXag
         9Wx1oiZduzyTddZpqsPqBHKqVzY5a5E2oaLJKtMcuugKLctPPwET9BOCHOv5bgAsaNcW
         l3ClsdAOQiQx9wmqKUDgw0mgsRCxUo+CS+7+eorjjCYMS8DCrLl+76h8M8P/eqde/mIf
         oWVo+ekXKlqwu6oeAarw2pTksw2tNgehl9a2xWb7mi+vbvZGo94KGWBSfHk6cG3JJEL6
         RsP7kxfJ1vtHEO14c308mLklqNs68N1mwSAGSGhKSMi5xUGNf9HAjDhLnfG5cLW/t1AP
         lK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771519313; x=1772124113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hf1LaDkijcdD11OckoGjxI5yaxmlZ2c5i9FpCf0YHmA=;
        b=RPAHogdBc3HHUykQyt89mQuRC1kPOGzZyDXxiKo/3rB6uW3JnsMbG5jSjPsCHhfsO8
         QG8dfZOGTA0UO7bhiyhJ9vi1CLKqNy5sgMfK3vnPulMbfAWz1LfaYOFyT4QrbLDI6Z5q
         bHNmjdi/6KPnZjXM5ezH9xVnGN143a42+gPojuQKHH+gCPQHOo5/Vuvez7iw/dfCu5Kp
         0QJi2t/rdFq7Haz0vXy04Qfg0KnTxFbyRiCmIhJ3lISiISCW2QviRstbSyuAsIkcCud9
         vmf/A9Lg5PJf6QWlg7+O+yGtHCYm4caArlc16wPlDwu9cnfWMkmG8cPQr0hyUq5hG7z3
         9sXA==
X-Forwarded-Encrypted: i=1; AJvYcCXbRMIG5vd25AB3FXmFwjorqjdv7Aeq+dyOhrT76KZBpOKqDJibL9XDbtRD0Dw7kOvciByVn5+ydk+7i/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkWfES6v+VnBD46W3FhyGuUmLk1Ak7Cywlu56aebx5DHxrBqC
	n8jgs0Gi+w0QxXzOPGeTKSEheVUlP6kRpCMMYv+RURpKn6FCwGQXKH5Albr5pvBYSnVbHLJkM7m
	Kl+yn5ZxYqGlwp7n9L5gH395yXb216Erolv/n644w
X-Gm-Gg: AZuq6aJke3pswHY+RaopYuWiDc7r4dUJR5/tTBUSA7Y6qluJrpGO0YVF+gisLm6OV/b
	imObzR5i/mTM5rB4B5rcPmGQeKgiaeYr7ytpiyNqqnpe3IiBzi8c1G7mCNgZCjs+ZvqCR2uNqlm
	oc8qAVu0Nudo7yg83TCI/Aj2iIec/Q+QrxYlH3BQkD16XcWpPMTMj2c6lDvsXRT/saLnVRzHcwP
	0WGYjnO4iqq4So5jA2l0DLpF/wCx28dBHjCEmM8gsevjNM6ojOaDn2k/xTJXs2D7+CIohxOo0D2
	9FsK
X-Received: by 2002:aa7:d3cb:0:b0:659:477f:1b2e with SMTP id
 4fb4d7f45d1cf-65e4b20063fmr29312a12.1.1771519312806; Thu, 19 Feb 2026
 08:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
In-Reply-To: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 19 Feb 2026 08:41:16 -0800
X-Gm-Features: AaiRm50ztl1YAKf4o4yq5SO0KUP9Egu2t60RMIfKV9RIEvHT-22XzAxle8jkPbs
Message-ID: <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant expression
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Chris Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Feb 19, 2026 at 8:11=E2=80=AFAM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
> From: Daniel Gomez <da.gomez@samsung.com>
>
> Commit ae83f3b72621 ("module: Add compile-time check for embedded
> NUL characters") in the Linux kernel added static assert checks for
> __builtin_strlen() inside MODULE_INFO() macros. But sparse does not mark
> the result as CEF_SET_ICE during evaluation, making these assertions
> fail with:
>
>     error: static assertion failed: "MODULE_INFO(...) contains embedded
>     NUL byte"
>
> Fix by marking __builtin_strlen() as an integer constant expression at
> eval time. This matches other builtins like __builtin_constant_p() or
> __builtin_safe_p().
>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> Discussion:
> https://lore.kernel.org/all/aTc9s210am0YqMV4@agluck-desk3/

It looks like Al had a more complete fix for this issue, but I guess
it never ended up in the sparse repo?

https://lore.kernel.org/all/aUV7kyjxlijuy5sC@agluck-desk3/

Sami
