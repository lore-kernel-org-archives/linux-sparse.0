Received: from out.smtpout.orange.fr (out-17.smtpout.orange.fr [193.252.22.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797128F5;
	Sat,  7 Dec 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536971; cv=none; b=bxcVT75nR8wKNL8L2LF1/Y3+PRKjTVvtbXSuwnf17TThc44r/dQ2lcYYQtJSfZ4J+bEPhDbGJAzzvwzgGuHFMRwQhhURU3k9VRPNoZSsfLdTb+SCekCPBGbVyIBOv2k1mQQX3vyde86S9i7onkCQJWVXl7X7WeRVNvE1bM3HjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536971; c=relaxed/simple;
	bh=M3tRBIMiUGbNOtYs/WiqckLr+eGNBUTYriamxyCBEEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcxHpODIXGrX6rRFI1Ksi77t4BzW4WCLbZiF6d9YyTjWiOR1+ZWLLepHVgLIMLdd6ZVz16Yiykfdufd75o7udTfGleP1tFDr/SnhU6vhdBSIk4KD/sYZHeX4Uow+dx7mNwzRRsT5VSG7uQQoFTade5r55uAEPGJZKMjA+WWWL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=efBNFOkY; arc=none smtp.client-ip=193.252.22.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="efBNFOkY"
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by smtp.orange.fr with ESMTPSA
	id Jk9XtkHz401M2Jk9Yt7ejV; Sat, 07 Dec 2024 03:02:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733536960;
	bh=1FRoHoQWpZzbjWYvjotIUGh9Pf5+Jx2FZlKpO4hH6NM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=efBNFOkY+cV8avqyYvv/XZTk9CSlCAOtxOTVoZW0Mm6G5Ejy9p8h9RAHZ3RXeCxVZ
	 DQ33if63YUgMnR5r76sYSUXmjhocTon9aKksjsrLDbJPIiYcqJ7E8cbNdLtLkpNwFU
	 1gv5RO/PHzdTeu94CyIONg036fSEPyBCEwKxhFuzXDWS3mK9iuz7KELjJV6CpZDlgW
	 jP3hyBr8+1NdVpp2R9hx7uVuGKI66YUtDcBn07plPG0WbCHtMKIMETuk+HjeP7WeEq
	 Ls/lvYaQzVW3Ysyw8FJrWHjvo7i7QwVENBI4H/On82OOYxpf6iVHac96DPf7xs8HtD
	 gfZS8i8M2AwLg==
X-ME-Helo: mail-ej1-f53.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Dec 2024 03:02:40 +0100
X-ME-IP: 209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa503cced42so371719866b.3;
        Fri, 06 Dec 2024 18:02:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHRGWUejAM917mjPVNhIKO6iGDF0g54NU+87ZchYsZTy0U/pnSIaNQ3t3ix3WIylE4jkX9iImd9xQixgpe@vger.kernel.org, AJvYcCW4rKkreCdeZkxsHNzlN91Ng7bNawxj4vPa2O8UUXmYFRSZ58UpGlpP25QxzPVCYxAWAOFlf+HbcmbzIZ+b7yk=@vger.kernel.org, AJvYcCXgIxalHTYmJoly1hq+cMYeACt7kXWUSVbUTYKxVBTp9kqGb+zyCGjdfymyYIYwWVWwbiTqF5AN1b86/hHL@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeWCYdm7jHevU/OL8gDyEwMozVSUUxJTe2wo9aHgte/m5r3m2
	lobpc5AQJwaqOLDZR4KcAe4oIttiDlVYTFM90xgl0l4xZBtrLXx5j1iAo0oA5KzsBWfzf0AmKPf
	U1FLz2a34wO3L0kEe4eprpOucRSA=
X-Google-Smtp-Source: AGHT+IFYWIvr/wb1ttWAqU3XdgmdbVRXgljv2wGXYHxZGru+z8zfXAuY4J7uLgYbwqJhFyewdEilCwKv6EaVf4E+2bE=
X-Received: by 2002:a17:907:270f:b0:a9e:b5d0:e5c with SMTP id
 a640c23a62f3a-aa5f7f6f2f8mr768523566b.61.1733414207483; Thu, 05 Dec 2024
 07:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-8-4e4cbaecc216@wanadoo.fr> <6597979088eb4ee7b98cfb99815a402e@AcuMS.aculab.com>
In-Reply-To: <6597979088eb4ee7b98cfb99815a402e@AcuMS.aculab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 6 Dec 2024 00:56:35 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+XhOb+yn5A1dHD=qkbB1_FQXMA7_ydBB4nPTSnys3jkA@mail.gmail.com>
Message-ID: <CAMZ6Rq+XhOb+yn5A1dHD=qkbB1_FQXMA7_ydBB4nPTSnys3jkA@mail.gmail.com>
Subject: Re: [PATCH 08/10] drm/i915/reg: replace __is_const_expr() by
 is_const_true() or is_const()
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
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
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu. 5 Dec 2024 at 04:00, David Laight <David.Laight@aculab.com> wrote:
> From: Vincent Mailhol
> > Sent: 02 December 2024 17:34
> >
> > Most of the use of __is_const_expr() in i915_reg_defs.h are just to
> > test whether an expression is known to be true. Because those checks
> > are all done in a BUILD_BUG_ON_ZERO(), replace those with
> > is_const_true().
>
> Another place that could use statically_true() and BUILD_BUG_ON_MSG().

Here also, BUILD_BUG_ON_MSG() is not suitable because it does not
return a value.

__BUILD_BUG_ON_ZERO_MSG() could be used; but there is less benefit to
do this at a driver scope. In this i915_reg_defs.h,
BUILD_BUG_ON_ZERO() is used 20 times. Adding an error message each
time will just make things ugly.

If we want more readable error messages here, the solution for me is
just to redefine BUILD_BUG_ON_ZERO() to print a more meaningful error
message by default. But this is not the scope of this series. I sent a
separate patch for this:

  https://lore.kernel.org/all/20241205151316.1480255-2-mailhol.vincent@wanadoo.fr/

Concerning statically_true() instead of is_const_true(), let me test,
and if this works, then I will replace these in v2.


Yours sincerely,
Vincent Mailhol
