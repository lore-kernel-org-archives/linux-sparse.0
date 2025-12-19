Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC82D4B57
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766128103; cv=none; b=IazNDnqJiqbI7RW0cmFFrtETxvq6JcVve2UYCnTC/LGR1X7/3y9wNXRUOEZyaYyru+2cMAcpAgvXz4au9GtrF3bl6mt0sGCyodkmFs5tXpQ7dVeeqa2Zqy8iQHd+R4zGsoMHGoC4lY7iajVX7z8q2ACv/M1uqUi76RVBzzfd3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766128103; c=relaxed/simple;
	bh=chHA3d/r7DdTP2+uwfGEKmhVONsNEHk52FbSC3FS8p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2HKrWjt8AVu9JmOn1sziYCJXNtr39GGN/InZXpFpYDDPH5fIzKw7+ByXn/eOregs04PrsvMppLwWG52UJ8WhpQqT0SVLx1gzUcEdStN59EGBuCVg1QEH/PeCz6SYJwZj8ST3FMYDCFmw9k17CXKa/QCROSH+iTvYd5b0m4knX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zOsIxQbN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOsIxQbN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso2877905e9.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 23:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766128099; x=1766732899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAJFCYxG6tBk/5BjvMlMhhFWKmM1Im0nbCMAsTTFzMc=;
        b=zOsIxQbNWbyo2BDTEHAYEqmGQOGxHNG2ddYAmFoAsdej4tI1cRCwo8MO2edeNIwC3t
         ssqiCryE+KHhp1+7RNnfJCadukVq+xY0EIOqWnbl/G6y/YpalSoA14OXWS5S57Pi44fv
         blEDXwNfBTmoEaMhiGbwqzUWq42tY1rTno7pClEyC08QtOyiejFYdneyV+wh6smHyiVm
         1n8bFkw0YAj0sCx32pDBnRRZod5EEid7MxYdgMj7PgcRw+Bkm2xu75JLiYAecljV9iW3
         9RSaV/UPGw0mCn6dDv9wKCyci9DMXRq89OUlHlZ7xt8G+56NmBwOhnABAevYz9LzDfNE
         99RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766128099; x=1766732899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAJFCYxG6tBk/5BjvMlMhhFWKmM1Im0nbCMAsTTFzMc=;
        b=Udak+3wbPgIG1rSzwlL92LRuFXXEhlkyQsnUGBpRcZQgB2S7V/whTbjZx0QqF3ixBz
         sQAs/qj/mQ3TcyJtm3/vJ4JgiJXlGGJ59lPcC0KdstYhY4RdSD80Vw1/rCFbfJGCvHpv
         LaAo6lgTFUO/Yq8sod5EE5sXViMYhM3pNt+tcH8KBOpEaSAOkEEvGQNsDHueOnaXu8Hk
         DSOZPwOSXah2iP6g/HAUlFYew9mfCSRLjBW1nSMZj63BvNnelnWhqFS2K2kvyG+w4CmU
         9u5WWlwukRUdxDb+71WBbf3DA8aJK3s4zPke163JDAWJKJdxvr8e1jLFfx6M5aVLfYJz
         zaLw==
X-Forwarded-Encrypted: i=1; AJvYcCXHobllRNkbBof/UjnzZkmlRx/sUAAfT6jHcxlcO3cMS/d207R8sRoVVY2pjaMgPYbFUhCrOOTERbeS9UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8oA8kbvH2NUbAFhjNqH8d98rpJVvRFg32+sBEpfjR6IxljJE
	gI14qovQL+poURJKPVl5yIubTK5ATSXeSOAy4nMSPK49WqqmZrW/UIMm65nG5M4Os0U=
X-Gm-Gg: AY/fxX6QZnp+tpvV8HujI1l3/TaSFLWtAuoF5WEGS27O4MGPVqMDJxvyVCyVcQd4py0
	xdcRbLD7tJwL+y4wlYoJC3WwaXR4JwaaIQ5V9d5f7ay+LEdhNOEN4zmEz9MJl15YcfiHI+D2CXm
	bHVPNpIjsZN0HkFt49aHLEc5qcvjOE4CP1g5YeeYgpVPAag6cUEv3/qQxwxdtt/Ev0Lc0Jr2OSo
	guSw3U+b3KrUG37RbZ3G/nfjMWpfFCQjebFpMvCwMyg3So9FVREzU1NX0j4MpWL5IDQJ6FIDY8r
	wkrF/h+wBZZcMrTj+WyJils8UG8WzQ+DsMHkLb6Y6TwdKlBpPQXDPhHT/KWoxf3jjumffFajiu9
	r4L5HlKLjoCfrtUML+3FnLsRBzYWga5E8J+fNOjJOhVIR4DU4OOLTrE4w2BuWdo4sR+kGAYAD1Q
	nGFK4l4g2zdRvSdJKn
X-Google-Smtp-Source: AGHT+IE7nLrq263HAsObO9ho2ijSSwzHrCJiIV0bJrGj7M+qZEd9hC4pZGfJYlq78GqHGGWD40y0tA==
X-Received: by 2002:a05:600c:5251:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d195a425bmr13555325e9.34.1766128099504;
        Thu, 18 Dec 2025 23:08:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b749esm81591275e9.14.2025.12.18.23.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:08:19 -0800 (PST)
Date: Fri, 19 Dec 2025 10:08:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <aUT54I0fD0aqBVyw@stanley.mountain>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <20251218202644.0bd24aa8@pumpkin>
 <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
 <20251218220651.5cdde06f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218220651.5cdde06f@pumpkin>

On Thu, Dec 18, 2025 at 10:06:51PM +0000, David Laight wrote:
> On Fri, 19 Dec 2025 08:34:05 +1200
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Fri, 19 Dec 2025 at 08:26, David Laight <david.laight.linux@gmail.com> wrote:
> > >
> > > One possibility is to conditionally add _Pragma()  
> > 
> > No. That compiler warning is pure and utter garbage. I have pointed it
> > out fopr *years*, and compiler people don't get it.
> > 
> > So that warning just needs to die. It's shit. It's wrong.
> 
> True - especially for code like:
> 	if (x < 0 || x > limit)
> 		return ...
> where the code is correct even with 'accidental' conversion of a
> negative signed value to a large unsigned one.
> 
> clang seems to have a dozen similar warnings, all of which are a PITA
> for kernel code - like rejecting !(4 << 16).

In this example is 4 a literal or do we at least know that 4 is
non-zero?

I really thought I had a check for that in Smatch but I guess I
don't...

regards,
dan carpenter

