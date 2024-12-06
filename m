Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532D13D516
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511622; cv=none; b=Nf5QPnBvvxjF97TfA/k9+5qYJoFVNpSKuZz/RLvJE4ofpQum0JMkolT3HJzMBes3JT1iGP9S37XxPU42D9oGCBoerIs6Ws3fB72g+AhuxCe2/S6NI6ewO85YKYOVvImV7b2pc+q2x+2nDSWTTkVPAfk6JY4LWX4BD71QwdQAzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511622; c=relaxed/simple;
	bh=uWEIYj04jJcQVEnaMjzH0epqUyK8EmgQnn9LnSnYd+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sx1A1aUQdxzj2eB45fbXfHzO3SOADTwrTuMVgjrA6vhOTQB8c1bGgh3USp+avBHOwN5N9QprZyG2re8XcoDrt5rlm1ZRAC56rCNPSObVA7osEmoNxvAJr40SwdPjg6mvWFkRPF6rOM30zYuOx1xRDNZaFkgc1uOUGBebrrv8P18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cDLGCQrH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cDLGCQrH"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e274f149fso2823813e87.1
        for <linux-sparse@vger.kernel.org>; Fri, 06 Dec 2024 11:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733511619; x=1734116419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGtbOaTCTsAvyUDr9a4PNqlmY0QlpNlNkPLsZ0+zYxc=;
        b=cDLGCQrHmS5Wl91F56Qle2VLB2XoIz35IlWl9uWy943+eU3zvOMdjvHTRFpnlS/+vP
         Qk4rXB45nzoCKkKNrGgcqY+ANziVxTzlibFq5K9NybgRiP+2/fIhKEcIrrssI4L/AyBI
         YPcTDjaE6qO7qgti/4VtyLizGj7lPVQG87740=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511619; x=1734116419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGtbOaTCTsAvyUDr9a4PNqlmY0QlpNlNkPLsZ0+zYxc=;
        b=gFpX6/DVUywWf8sazFq48tSKimy/FL8cDhq5IQCLPL9jDIwVefDHPi1NUK5DVuivR9
         0i7XrQlS4kmmXm3TXU/rqGaR7u1Ii2jHuhyXYCubZCy6ZWT/0Iq0OfcuiRk3nIZNF5Sl
         roMomeAJHCL/ILW/PgtsbbBmGRcXBiJvsYadnwIqKPtTJkzFiJWZklozVZ9nY646pLLd
         1bNxbxV0jLwES/yKKahiNYxOTXElfdaoX0VSQ7au4yUbyUFnUM4HbxzUNJg57V8CTW1c
         9zv/uv02zdcXSuFxzqu+1evyFdZSECO6StU+DlK18NtxFE0QlscJ1x5AHvSeaYI0qa+S
         FUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNpfogpaefczI9mpplSFIBI2x7qUst4kOxTkrP/r+xHgG4DhbIL3T55PLhcUHJHZHqFgHA0JDurqc4UyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAaNhp+PV98qZtG4GSqtD61v4ZqzadHZPxoewOXTgoFC2e1n3O
	ucDHIO4FmsKHVH5QCG5bJbeoWOsDT+V1Lv/US+V731QZeeN2rsoGiozRShM3zEdekHWoiCP9HLz
	SQ3Pw1A==
X-Gm-Gg: ASbGncv//QF9yZWroL5Pl4EXYaCJ9V+lB+78XXXirtFrwPotuYiqnuZynQNHuMTxqVa
	PzHp6bbYjFt28/91ACM/piaCl74inhUBnS2L/dPI7bI1RFmnHYFMjOZCLMA11kptwwmfDOnQSAR
	xkkAv7xwyV6skrDiHpwOzwjW68KAze/Hap52XLaygGQr7Ptrc07tGEigtcVMW+LhlFlngVw1tp9
	iaHoS/FlH4boanja1uigk56DudkZbhCoJhZL/+6KVzYayrBBYzVvfqMN4V5QHziFA5CoAvP+8Z9
	B4fZKOWH6PP+4T6RC/WKYj1ZvSpN
X-Google-Smtp-Source: AGHT+IGL2euRcVmmjLYgGjoNqnAfkWDlOZgXo3x78K/A6t6q8htWFlhQhqTkeuRtrOKELHoGzFqIgA==
X-Received: by 2002:a05:6512:3d27:b0:53e:2a05:57a1 with SMTP id 2adb3069b0e04-53e2c2ac761mr2851560e87.8.1733511618609;
        Fri, 06 Dec 2024 11:00:18 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c1fc5sm585743e87.199.2024.12.06.11.00.16
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:00:17 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso26096371fa.2
        for <linux-sparse@vger.kernel.org>; Fri, 06 Dec 2024 11:00:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1M3Z4peqIC/DqX862eL0Ur5OxmKBzwwk6bIGjJRuX562c1tH3HwXUV7TGnweCMHRMh2ZXh7pzQpkXgas=@vger.kernel.org
X-Received: by 2002:a17:906:1ba2:b0:aa5:451c:ce1e with SMTP id
 a640c23a62f3a-aa63a0aa48amr290776466b.32.1733511169269; Fri, 06 Dec 2024
 10:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 10:52:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
Message-ID: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, uecker@tugraz.at
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 10:31, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > causes issues when 'x' is not an integer expression (think
> > "is_const(NULL)" or "is_const(1 == 2)".
>
> But 1 == 2 already has an integer type as proven by:

Yeah, I was confused about exactly what triggers that odd
'-Wint-in-bool-context'.

It's not about some actual bool type, it's literally a random
collection of integer operations used with logical ops.

So it's things like "!(var<<2)" that generate that warning, because
some compiler person at some point went "maybe that left shift should
have been just a comparison instead '<'".

But it turns out that "(var <<2)?0:0" _also_ triggers that warning.

End result: I have *no* idea how to shut that crazy warning up for
this case, if we want to have some generic macro that says "is this
constant". Because it damn well is perfectly sane to ask "is (a << 3)
a constant expression".

How very annoying.

This may be a case of "we just need to disable that incorrect compiler
warning". Or does anybody see a workaround?

             Linus

              Linus
