Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3111E507;
	Sat,  7 Dec 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733575520; cv=none; b=oAp8NI4SsN/DSZpdhmSzPqm32PLzB6vmj5Vm5A1PWWMCdsanN4dHWaEhNKzJKhAUBx8OdcvPgQfCG0tvhyb/2VtlAT0iEIFGAL2GSXPPMB88iqMTqc0T7wIxaHjBrtvvfYaldKIkruoc6pYnGAsw3SeaQqITdFcwWLZRxZfhbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733575520; c=relaxed/simple;
	bh=WM9dhS+XJ8Y/DlkDR1zqqAPj4j/n4NFEAeMDfBwNaZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLu0RGhOMhgU5i2IFROuPOpG/cCmuE48jJV+HPwvQJaPtuaHwubgxnTGqihDNs+6tFmpSqSlBoUCRP2Tw9X7oKW65dh5lYFsdIVmymrw7gEH7NWZ0Rf6JGVx4gmiVXCpZe0KkpPBxyUArStCTkQmusrfIF1dPbReBD7qoyaMP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQcGFIm9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQcGFIm9"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa636f6f0efso264753666b.0;
        Sat, 07 Dec 2024 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733575517; x=1734180317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGQkzKFSDY9TmwP9AaO3pZHfF41YjBH8/yCe8njtTKs=;
        b=hQcGFIm9NpxPCVlSsqLhT9DwlD8o0LLwIZyC16qMZXlkm6lskOdBuHWQanIbm90hZf
         7McP/ytZXQP5X3UH1CDz/1XC4QH7ei46el1D1Gx6pgoiGT07wqXUfCm4UZItahg5YKNn
         rCAMDTqxxDp3yf1JjFwvjkR7mEnUQ4dXDgbl61rtwiUXiJYwsCdM99S6lTB4NypNhyqg
         nOSdULVykcDsJCKAAXskFsOLCkoHeLWaeujORG3SQBMbb+j1L0U6cs9PLsXTRTqj0Z4k
         wi1bndIE40ZBSNqt/6rV8a8iKmb85QlbKLOziL7vlGlXJRPO8jF7uv53W8IUAdDxNkzW
         Tfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733575517; x=1734180317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGQkzKFSDY9TmwP9AaO3pZHfF41YjBH8/yCe8njtTKs=;
        b=iIcWSiX7Muz42wAEwOZ/xDuMcfWO7eMkba6I0vNcE1bLZkIvM/sQnr3NlmFkAWzNg7
         UN04PKQBSh7vnm5CV+8sNDOXIR7Z4EpegFNKY2+Tp0KyCDnY8XRwgPnnkpjyST+cI9QM
         tFOc/bvAQZn20TgofklfMa50Z2W25jKwj7c9QFgZ11BXnL+HimJB9aTMSf8Xk9Gn6mfw
         RFkoGe+rtdA2DXxEympyD0pb2kONf+7z8RK+BvaXnv3G+0Zf3vwWftp9B+Q1ZhrbM7sO
         WI1tBQ6esa7K9VFd7aQK+BjyRpR3CvKvNOE4zZNcAdD1uRenopxS1xdbGDnTcKOQmknA
         S1xg==
X-Forwarded-Encrypted: i=1; AJvYcCV+RTkufRxjmTgtpPBoU2BmdsXjc+OO5xGy7eGo1nl9+Y2FtDuEJ3bZD4DQSzWPrUC8PcY0NTMdxhFo8aqA274=@vger.kernel.org, AJvYcCVvPH9tqKAEkO0cj2qaQmyu+XIEO7cpbTb8A4KGe26UIpnooSLwzMcNZxD3zFQPlhyIbrt/vZYksZKlQdPM@vger.kernel.org, AJvYcCXMnEnhn7i4zsmE1ZRPHzyJJwIQXGbIop5mhxC/nyiRcf4gFiNXyifZo5NUAZTmwDpHbvdgtYs1MAW4aSZb@vger.kernel.org
X-Gm-Message-State: AOJu0YyucdFMtO1S/92WAbvf9KDOSazLWqt9P1hNETruETx05Ni9ArA/
	MZZjc5mUH/QYLSbj73fOG7voCeWG2+rcnU0Rch4+TpgbOC0kz/Io5qp7bgjrLhciqcDwyZHP7e6
	s4NWE21jrIyTkcK2bxyd55eN759M=
X-Gm-Gg: ASbGncuPZHu7u0wOyXpd5qmM7A9ta3IfxVCShRiFgiustcrGeyJ6FapJ8N7vXjECUfo
	U3IrBOy/N9BtDS8cYUfRuPm8kvLwRfX0=
X-Google-Smtp-Source: AGHT+IFKLT/0vBLq8e4+Q9cBsFCmjYKYarCQPpvMXUHvXes9qzmJwCAEBQoHpEZanqb6oPfHlcskXKrazzFRS2f9zhw=
X-Received: by 2002:a17:907:9516:b0:aa6:1ee0:c111 with SMTP id
 a640c23a62f3a-aa63a33cbf7mr437084566b.42.1733575517044; Sat, 07 Dec 2024
 04:45:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com> <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de>
In-Reply-To: <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Sat, 7 Dec 2024 21:45:05 +0900
Message-ID: <CAMZ6RqJGqBqvgxzp5yPFY1pk0WkkwEMM34qU-dZ3kXfsnKaqEg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat. 7 Dec. 2024 at 17:39, Martin Uecker <muecker@gwdg.de> wrote:
> Am Freitag, dem 06.12.2024 um 16:26 +0900 schrieb Vincent Mailhol:
> > > On Fri. 6 Dec. 2024 at 15:40, Martin Uecker <muecker@gwdg.de> wrote:
> > > > > Am Freitag, dem 06.12.2024 um 02:25 +0000 schrieb David Laight:
> > > > > > > From: Vincent Mailhol
> > > > > > > > > Sent: 05 December 2024 15:31

(...)

> > > > > > > > > @Martin, do you agree that I remove the accreditation?
> > >
> > > So, do you agree to have the accreditation removed in compiler.h?
> > > Personally, I do not mind. I am also OK to remove you from the
> > > documentation and add you to the CREDITS file if you'd like to.
>
> Sorry, I somehow didn't read this part. Please do whatever you think is
> most appropriate (but please update my email to the new above if it
> still appears anywhere).

OK. Then I will remove the accreditation from the  compiler.h
documentation and instead add an entry in the CREDITS file in a
separate patch. I think this is the most appropriate way.

> I find it amazing how much time the Linux kernel community spends
> revising code to make it work perfectly.
>
> Still, I am wondering whether some of this time and effort should not
> be targeted at C compilers and language work to make these macro
> hacks unnecessary?

It seems to me that the long term solution to this problem are the
constexpr functions.

But the core issue is that before getting this support in Linux, we
have to wait for this to be added to the C2Y draft, then implemented
in the compilers (probably just reusing the C++ constexpr functions)
and finally wait maybe one more decade for the C2Y support to reach
the kernel. For reference the kernel supports C11 only from 2022=E2=80=A6 S=
o
maybe we will see those in the kernel around 2037? Meanwhile, we have
to deal with those hacks.


Yours sincerely,
Vincent Mailhol
