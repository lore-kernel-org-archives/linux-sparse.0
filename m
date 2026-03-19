Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD101E0DD8
	for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2026 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893257; cv=none; b=fPa3Mq37GFDQN31xgKsMU+7xv6PI5g/3jb5vc0QsUXjLZjl1nkoXI3eWCoEbxiPGYY6F+LSjoEPUwekfDWNJXjgh9CMrQxTcJot48JJcS4GZV+DKsDy6HhAJck37hxoV4WkcWsUdBn3d2SfQTf4PwD+VY7eH1+3Jv4ye9gL0Rx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893257; c=relaxed/simple;
	bh=kH91fdMz9l5Da6pMko+6cg8l/kRSPNCrhTtc6Ih7hM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqA/CyywK04eFn55eN775Tv+uzKbIKHI+Hk2tUtWS+QwgQ4vPfwIDkRSy/Hy9wN5mg7TLwaJ+sAXrGwrtfu3D2Y9lj/kZIbsyPPd3mVN31cOXy3c6C4wQqg/njnJVd+jSoP/fxhUi9X6FpSDnFrnquIN9RY+weGngwnZXTLzFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C3LvBWQJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C3LvBWQJ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b97a0f18a3aso71304466b.1
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2026 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773893254; x=1774498054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JjcPpUmjKHQvpNpDRW+JjEMCzimtOzsOEh2iUaqv5I=;
        b=C3LvBWQJfgFs34KsJulybm7nl9S94OvBUbOoPSjX+8vXAl1O15XlNx5UqAnxm++Wnd
         LpniZKyxGveH3nsBDBA1YiNeHRwJRUZXjGtSw+l8oDuSY0odO5P/MwRZUCNYBdnfpkAE
         cHQoTHnyfG1fJBpo2Of199m2sS9Dx4SiXqMlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893254; x=1774498054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JjcPpUmjKHQvpNpDRW+JjEMCzimtOzsOEh2iUaqv5I=;
        b=F53SFK8qDsDQDIVNAb87CdJ33ty6Pk/nSHsy21rOAWOK33VywqwMoc6DE27KsUkD6v
         BvuyF92z5nRzRmgrQTyZGR7iYbEvzvFA193iLZCzOeE63RjraAxN/a/41FpYY+ShZTql
         5gP06rBpaIc1deEPvg1DyHRU56b+naTL0zv7dHQpECtafSKPwHsFLTA58hppvQIxQjBG
         IsG2HSDjGt+3kiAjm6TOj/sCM8IqvGRXZzjSceGtC/ZL796eB85+HdH5wd2WWRhDAGZd
         apnxF8J6u64sUGMa1Yy2fnoi9E68BcJ2cTJteTTcKJlLDKWjRgyGsJLD0pR8lzlQHK/3
         Lw4w==
X-Forwarded-Encrypted: i=1; AJvYcCX1xsjHL6bXFySoc5CaHOWpTF/OSFbrQ3O39juAM6F51raQ1kkLS0Rm+dqT9qvw6rFtCLFPsEJUEa0xUzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySxTp+gBPecgHW8FRie4N3F6RZ4wXLNcH0Ke/IR6CqvrQ9u0yy
	4BoN8Qt4fqyA/PVKiIaDXYL1pohHtwUN+lzokZO6+81V+BWkd32dIs0VIeeSJuSThqWkmdToqHG
	CN1QgCzo=
X-Gm-Gg: ATEYQzy9BSTxbxRz0boqMUbv63SW4MtBfSx/FRpN9t6yxnQJzN/Rb/KplaBWLaRrh4N
	YrfgZCFpQe8tE2rSC76OPtErZlQonz1qx6lVXcnuvb6Cz2Y7kt9/snfA9aki2AX9SHmrBcHUFV5
	JP/9zv5LFMywMRMccSjIWHOHdi1GvODVGofNQNm7MBfOhXZVaH7Zvp4RprS49Z9dBPTNkXAl4Tx
	pG7GunBjyPlvPMblv+0+U0PRtIwEstLFxSD8axtYAOZ6gGOZ37rjcIKYylRRYVkbZ1vhvPreDig
	H0WkDr8VmwzUdOsy2TUGdj3V1llckE4UiftlvG24Defu5yJ4RSWLnruPnfrVrhZmwKP/mDnQnPt
	P3UXxMDKBminswti48A7IBY8P9vp/ez5q7aFyTTN586ZXRqSgEbbM0nD2cFV5r50Qyk7kdtM92+
	8xZ18ZP2/wRRt4HWuFp8BqtHeOjWHVPsgygsm27iQiy4g7sFDTgilUv6Ie8tvMBp0HnIOmBuYp
X-Received: by 2002:a17:907:9346:b0:b97:93be:3c6a with SMTP id a640c23a62f3a-b97f4a3dc76mr361140566b.36.1773893254197;
        Wed, 18 Mar 2026 21:07:34 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f1751cfesm366624266b.63.2026.03.18.21.07.33
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 21:07:33 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b980c65b97aso62212866b.0
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2026 21:07:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfvXNdzhjeOcYYbd2HMfkdC2IPqyu8OnArH7Ul0zlhIBNnTnQpx4NOEb3UzIbsJMf0IPtmfIA959wrA+I=@vger.kernel.org
X-Received: by 2002:a17:907:a07:b0:b97:b19a:1e63 with SMTP id
 a640c23a62f3a-b97f4a3dbbamr377490766b.33.1773893253454; Wed, 18 Mar 2026
 21:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072731.GA3093958@ZenIV> <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV> <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV> <CAHk-=wghBU1bB6E889nv5fg+40b4_n5WnA0h3bVh32EKw0zE2w@mail.gmail.com>
 <20260319035324.GG3836593@ZenIV>
In-Reply-To: <20260319035324.GG3836593@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Mar 2026 21:07:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7zNVQ0k1o_3cgGiCdcpYFCvbZ2O3ZLQW-q2xXqusmww@mail.gmail.com>
X-Gm-Features: AaiRm51_LeOygfp-EF7wCXKk7bSG2QQyA_sfmPPKfqY38mMQn90Y3vJbgLGvg04
Message-ID: <CAHk-=wh7zNVQ0k1o_3cgGiCdcpYFCvbZ2O3ZLQW-q2xXqusmww@mail.gmail.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Zhang <zxh@xh-zhang.com>, linux-sparse@vger.kernel.org, 
	dan.carpenter@linaro.org, chriscli@google.com, ben.dooks@codethink.co.uk, 
	rf@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 20:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Speaking of rants: gcc code generation in general and around bitfields.

Yeah. gcc handling of bitfields is a disaster. I made a gcc bugzilla
about some of this many years ago (almost exactly 15 years ago):

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=48696

and things haven't really improved much since, afaik.

I suggested at the time that gcc should stop doing bitfields
internally, and translate it all into shifts and masks and then doing
all the normal optimizations on those. But that's not what it does -
gcc keeps it as a "bitfield access" way too long in the optimization
phases, and then does a really bad job of optimizing it all.

And yes, I made that bugzilla entry due to sparse, and that 'struct pos'.

Because it really triggers all kinds of horrendous gcc behavior.

I looked at clang at one point, and iirc it generated *much* better
code, because I think it does tth esmart thing, which is to get rid of
the notion of bitfields as quickly as possible, and then doing just
regular integer optimizations.

(And the real problem with gcc is really that "byte write followed by
word read", which is horribly horribly expensive because it causes a
pipeline stall. So even when the code looks small, it's really really
bad. Clang actually generates more instructions for the test-case in
that bugzilla, but the code is ten times faster because it doesn't
stall the pipeline)

            Linus
