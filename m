Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3802595
	for <linux-sparse@vger.kernel.org>; Sun,  8 Dec 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733623456; cv=none; b=RcB+oX9DrF9cJ8or9OCtcMo2qRITF1U4qrksmPEef4PvtskHGnR6jP9Hk3JSt/8MrWQRvVE3yLNnkup/QHvruASKUNG79mZJfnMSFN+ILkfL8M3aWJJw10hzpLPVDqHTZGi6ez4GVtsDbgViM9KpK47QGKKGURHNP9FMD8MO1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733623456; c=relaxed/simple;
	bh=IAtH1QPZVCuHz2tcdeD7lZlJGCLbl6dYQADoubFHbLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgrU8k2m1DjwTUJZAsVXtoCYvpossKXEL8fkzYJvGk9d0OIgKJ3zngDRnz4wxiI+RT3YysoeydgaCkbjsXRCwXJD6VYMjUfrAuE/CE7vJ+VWixsswXj1dnY4bjFP9lspYqQrMR5cmTv2rXmMjlVTQ5mewgjE03MvdrKwNmMnOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=drF564L7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="drF564L7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa629402b53so408611566b.3
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 18:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733623452; x=1734228252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EZjbRKhMOCLvsh/fbuGewVnDsfkV1Y6IoPuC3JohNPQ=;
        b=drF564L7Mrsfb90OePvwPlo4VvB5ERC+Bm8AKInucWy0P0Q1iZo6ICssp9t6Ud8TVc
         HQvmmdUj1Drmt6f80Hvu59RqJSBF1QC1iB8p3qkTt/Iec+VA+Esc5HAADPcrKQnBuzvR
         +Ql+6wVPabvxHQ8ZykLkE5V5htDvr18B33vPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733623452; x=1734228252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZjbRKhMOCLvsh/fbuGewVnDsfkV1Y6IoPuC3JohNPQ=;
        b=wxfRUTFXEo+g65Xux/kqfwlhhCkSD0tgsvDCwB8KPvzTPzKVPvpqauUQjCwd1mB33n
         Ll9qCm3rifc33HegCOtZ4iuANR9GknLQ/xSc7d86lG2FWxX8az73TIjlhltwXK6iBmbX
         ep4v961rOXWh9wBlbqEjws4k3y+32PgytIhzalO30CP0OpM80tEurc34UrMwOKmAHl/Z
         UZZq9H//6Rw3uF1i1s4wTwndkT2GBPyxKdSAsjoJHp1XsWrgL9am/aBeAJBOR9nmVw3y
         C0dfwVureS8RgbmAeZrIsx9QIq1xBd70cX6a2Y1IGjpouNyNaIXtpNAcagCD6J6p4Wlj
         tNmw==
X-Forwarded-Encrypted: i=1; AJvYcCWcIdXlFGaB3LWZyv/2+kESewhM3XJKatj+UitVEe5bG696ILbw2rNgdC2CRiiaiEfqK+M3BB0FnbvyAA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKVEi9m0hUjfeBcUZID0Zxv89VqLhDlzs6lkGdlTzwIKn8ajP
	Eu48RJQE+uPwaf3bw9wFvYj1wzNY74WgJuKzv9MY7bimHTF332NTvstRGDgxexDFjyiEf7lrNrm
	7IiwrCg==
X-Gm-Gg: ASbGncu3PIMWS9GMJFtLvncTY7BNvbD4/Gy3Zu7gjH8HS+NMS9U3DS0wHyFlBRGrmm5
	V2bS05rraWJ5fCKzZNa6/gGeiMGlFx3Y5C75Csmb8jawuv0oWXzZI601EtaqCBHGkgaAEC9GQf9
	JE7t6Dz2ebgfFzQbCTcOsdmpe7+7aKnMwYCMbtst5d1pX356o4eUPzHVwxSj09p0mN2/NT5RBC3
	BD3H+IIrZEljOl3fExPlL3oMZF/fFph1/GLTdWYzUiCMNrH6vsJritpy8ZSiR/alJbC08gsIdoJ
	CYGo+HXKpi3ppWCtuOHbo0Pi
X-Google-Smtp-Source: AGHT+IFVebgTtlKTL6YuTV5SYCeqhfQzBzfARffx5oDE6wSNDRPVu9pTErIGuOuoRW2nG5u000hD3Q==
X-Received: by 2002:a05:6402:3582:b0:5d2:2768:4ee9 with SMTP id 4fb4d7f45d1cf-5d3be6ac3e0mr7938665a12.15.1733623451808;
        Sat, 07 Dec 2024 18:04:11 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3casm4132730a12.53.2024.12.07.18.04.10
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 18:04:10 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso34800985e9.2
        for <linux-sparse@vger.kernel.org>; Sat, 07 Dec 2024 18:04:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTKdXtZLRvgLRys5BAly0IZuopzrpfKqI57IKfAqCAAmFCDeUbZUfEJAJFfE4/ZkS+OpFiiygu5pknqEI=@vger.kernel.org
X-Received: by 2002:a17:907:84c8:b0:aa6:2fc7:71aa with SMTP id
 a640c23a62f3a-aa63a24f1famr565813866b.55.1733623133832; Sat, 07 Dec 2024
 17:58:53 -0800 (PST)
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
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de> <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
 <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de> <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
 <9d9567dbdaf39688bbd0d240e29dec826a5931ee.camel@gwdg.de>
In-Reply-To: <9d9567dbdaf39688bbd0d240e29dec826a5931ee.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 17:58:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVGmj+nAju2XuWWD_FZHdeytRW2XX5D-L3MqDuRRciVg@mail.gmail.com>
Message-ID: <CAHk-=wgVGmj+nAju2XuWWD_FZHdeytRW2XX5D-L3MqDuRRciVg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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

On Sat, 7 Dec 2024 at 15:52, Martin Uecker <muecker@gwdg.de> wrote:
>
> Can you point me to some horror stories?

So the main issues tended to be about various static verification tools.

Ranging from things like the stackleak plugin for gcc, where handling
VLA's and alloca() (which are pretty much the same thing with
different syntax) was just very much added complexity, to perhaps
overly simplistic tools that literally just check the stack usage by
parsing "objdump --disassemble" output and then building up
approximate "this is the combined deepest stack" call chain
approximations.

And even in the *basic* infrastructure like gcc itself, VLA's simply
made -Wframe-larger-than= just simply not work.

I also have this memory of bad code generation (again, this is 5=
years ago, so take this with a pinch of salt: dim memories), where gcc
wouldn't end up re-using VLA stack slots, so VLA's made the frame
bigger for that reason or something like that.

We explicitly use "-fconserve-stack" to get gcc to reuse spill slots,
because gcc has been known to sometimes makes insanely piggish stack
frames when it just creates a spill slot for *everything*, even if the
spills aren't live at the same time (think big functions with lots of
case statements).

We also had several cases of the VLA's just being silly, when a simple
constant-sized allocation just worked fine and didn't generate
pointless extra code.

Pretty much none of the code core actually ever wanted VLA's, so the
end result was that we had these bad patterns mainly in random drivers
etc. Don't do that.

                Linus
