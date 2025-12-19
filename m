Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADC23EA88
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766127372; cv=none; b=OyUSi6RAJj6XZgle1jnwi1rldCSH5v+sGitCySQY2VO1VudP8YVbk81PgTr2RtQxcpF4YmgPWxrSgr5x69y+SVgoC8LsU26hRFSRkvjJlWcDm+8dYK4T2AXUlRF92YOgJKReeeGQrXV98eJDjKwNVnPAsSvy+KiNiuVQLE/Qolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766127372; c=relaxed/simple;
	bh=rK2YSV2LQI36XGOcBtrahoUPHaJW1KtgnbjA4zRpGec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmGo5+tjzzTtvNc+qHHQUg+GnxQQecx599fb2QPFGtLrVFi918BAWxJOVPCDwe02sqNDbYVMiXmSfLNJLYaSNRfXpkHpjcHu4Um7tMEFXwcduDVkAW1HzmGiS/Il0unImR8wdrEx/OTGO0OTIgkQJABv5qj4vtm20yPMhRHyy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dd3nINGP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dd3nINGP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so9441585e9.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2025 22:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766127369; x=1766732169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uvUrNBTPpChg3H7Mj1KDqnB8rAwuiPMf9e+Kj7W0oA=;
        b=dd3nINGPUFNwXHcCDxx7rXO/W4jLghXh6FqJGrTPs8FGVTXifVcsxy10LP11xzrncf
         5HT3ZWVSnvprhUj032EvaMSJ4eKnETDsTBY/FEmmyhnN8x/oem7lzj5uyLh3L9gS03M9
         l2mfV74L7w30Xa9zPhrd8+/Pq7ckIaGxMBsiNrxBzTFDX8f9QEiCKMlWUR4fn9BG21/7
         HCcBmuWpfW3DRuy41r3Q7dxawH8nzPS38ecpScHQpYNImmB1mmwp8JvMCNVWYyQ3z8fH
         C20hiJxRpJhafDMwjCGyi+ro8U6IZJYVS5ZAHNvVa+cJhvbmmSE1kYhTsyCtUqScF+F3
         Hhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127369; x=1766732169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uvUrNBTPpChg3H7Mj1KDqnB8rAwuiPMf9e+Kj7W0oA=;
        b=XVCh9OKYULKIuWQsLRtPT8xNME0hoPHW/WIkR0CPTh73X7zVJ1FAEZoyuwkrOFVO1W
         Kq0EOXmMli4r0vM8/cTMGtcY9rM5Lk4Yn5QESGJxm6jEtf4K87gdJabQU3LcqKmSCK9f
         vCXCjXQkGMbK2Xom1QJOqqRLygG48VMve9kC/8LegUpBpX0JGxu4rtayaYDycW6Q4Ca5
         Hy2VHk4SMFIDUT9XenfiIrNlvC1exQHR7yM6rWnuEYP6uO40ydvoSJm5RLyJKmKbAe5F
         KQ/HLgArzJK+gWChgN2ew9veVBXO8slDw1KEsZsXHOYzmB95DhmpCoyOAkivIZSV4ldL
         dAjg==
X-Forwarded-Encrypted: i=1; AJvYcCUvu1N0j17RvKAHD/4sJiGN3fY9QDUEZKF5pco/GLuGlqv+4QwyB8M8lR9hAMfYFJdXCGafXKu8dZU2Bi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQGNwBFqPHgdFVfg7FgtPiuqaPEJLgbv56STxShcHzXq0h34j
	6q0FqnVMRKUOtgDg/viwkVmaELg+l8qj1NiAt2t05Vp4CLP8ys8IWKu/ZqU5EnRI544=
X-Gm-Gg: AY/fxX4TOCPCOGUjLRVb+/KnfZ+zmIVwdseGUgUgfcLVDmDbsX4CeqO6OrhbI+3A5CT
	SF0BkS1C5qaHFvS1XoCB2P3PoqpMqCbHcnU8uJm0uuJ1yHcSPrTHd2KdrXxZf7mxW71k3zpe1G5
	CyJWtZSeEsMvtih0Jp531eN10vUwXjDUs99WiJTQjb0/pdpCDN4W/FHO2b+XNe7XW+C98p0whMM
	y0Qo5anAGVsNtoiqdtJMbhbT0wnKlIHBHahDJnNfSf65KLCHeK7Qj1uYvLfqU5YzSdlzus84QCd
	DqU9v1UwePgR/bNeeRk/0HeAuk8gYmXlbFGzS1WwndNcF7Yvo148wAEiU8NZdP34Jpn6Om4hVtC
	j8YGBb0QR0wQ/Md1ZKmiPxzQM1fhh26A9h//8d88q6dfGKrZCJY5/r0hHOs2x/JW/VgNtXYfuC0
	zhESgFG33Q4730psrK
X-Google-Smtp-Source: AGHT+IETUnYjoqlX0nTA5YutvCCmQpud7Xc95qZZjrAyjw0urEK/i2B0DG8TW5LtsWwvJaxJadbpvQ==
X-Received: by 2002:a05:600c:45cf:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-47d1954a550mr12510385e9.12.1766127368714;
        Thu, 18 Dec 2025 22:56:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a0fb5bsm30212905e9.1.2025.12.18.22.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 22:56:08 -0800 (PST)
Date: Fri, 19 Dec 2025 09:56:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <aUT3BYAT1bLCk1w9@stanley.mountain>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <20251218-remove_wtype-limits-v1-1-735417536787@kernel.org>
 <aURXpAwm-ITVlHMl@stanley.mountain>
 <480c3c06-7b3c-4150-b347-21057678f619@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480c3c06-7b3c-4150-b347-21057678f619@kernel.org>

On Thu, Dec 18, 2025 at 11:31:40PM +0100, Vincent Mailhol wrote:
> Hi Dan,
> 
> On 18/12/2025 at 20:36, Dan Carpenter wrote:
> > On Thu, Dec 18, 2025 at 07:50:01PM +0100, Vincent Mailhol wrote:
> 
> (...)
> 
> >> With this, remove gcc's -Wtype-limits. People who still want to catch
> >> incorrect comparisons between unsigned integers and zero can now use
> >> sparse instead.
> >>
> >> On a side note, clang also has a -Wtype-limits warning but:
> >>
> >>   * it is not enabled in the kernel at the moment because, contrary to
> >>     gcc, clang did not include it under -Wextra.
> >>
> >>   * it does not warn if the code results from a macro expansion. So,
> >>     if activated, it would not cause as much spam as gcc does.
> >>
> >>   * -Wtype-limits is split into four sub-warnings [3] meaning that if
> >>     it were to be activated, we could select which one to keep.
> >>
> > 
> > Sounds good.  I like your Sparse check.
> 
> Does it mean I have your Reviewed-by?
> 
> > Maybe we should enable the Sparse checking as well because it sounds
> > like they are doing a lot of things right.
> 
> I am not sure to understand what do you mean by "enable the Sparse checking"?

I meant Clang...  Sorry.  Doh.

regards,
dan carpenter


